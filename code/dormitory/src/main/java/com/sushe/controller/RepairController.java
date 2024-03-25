package com.sushe.controller;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.Repair;
import com.sushe.entity.Room;
import com.sushe.entity.User;
import com.sushe.service.BuildingService;
import com.sushe.service.RepairService;
import com.sushe.service.RoomService;
import com.sushe.service.UserService;
import com.sushe.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * @author  
 * @date
 */
@RestController
@RequestMapping("/repair")
public class RepairController {

    @Autowired
    private RepairService repairService;
    @Autowired
    private UserService userService;
    @Autowired
    private BuildingService buildingService;
    @Autowired
    private RoomService roomService;

    @PostMapping("create")
    public Result create(@RequestBody Repair repair){
        int flag = repairService.create(repair);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @GetMapping("delete")
    public Result delete(String ids){
        int flag = repairService.delete(ids);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @PostMapping("update")
    public Result update(@RequestBody Repair repair){
        int flag = repairService.updateSelective(repair);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @GetMapping("detail")
    public Repair detail(Integer id){
        return repairService.detail(id);
    }

    @PostMapping("query")
    public Map<String,Object> query(@RequestBody  Repair repair, HttpServletRequest request){

        User param = (User)request.getAttribute("user");
        int userId = param.getId();     // 1. 获取该宿管员Id

        //System.out.println("宿管员ID：" + userId);
        int buildingId = buildingService.queryDomersBuilding(userId);
        System.out.println("楼栋：" +buildingId);

        repair.setBuildingId(buildingId);

        PageInfo<Repair> pageInfo = repairService.queryDid(repair);


        pageInfo.getList().forEach(entity->{

            User user = userService.detail(entity.getStuId());
            Room room = roomService.detail(user.getRoomId());              // 通过user房间ID获取room信息

            entity.setBuildingId(room.getBuildingId());                      // 将“通过room获取到的楼栋id”赋值给repair的楼栋id
            entity.setUser(userService.detail(entity.getStuId()));
            entity.setBuilding(buildingService.detail(entity.getBuildingId()));
            entity.setRoom(roomService.detail(user.getRoomId()));
        });
        return Result.ok(pageInfo);
    }



    @PostMapping("query_my_room")
    // HttpServletRequest传入发起请求的用户信息
    public Map<String,Object> queryMyRoom(@RequestBody Repair repair, HttpServletRequest request){

        User param = (User)request.getAttribute("user");        // 获取前端发起请求的用户信息
        repair.setStuId(param.getId());                 // 按学生学号去查自己发起的报修

        PageInfo<Repair> pageInfo = repairService.query(repair);
        pageInfo.getList().forEach(entity->{

            User user = userService.detail(entity.getStuId());
            Room room = roomService.detail(user.getRoomId());              // 通过user房间ID获取room信息

            entity.setUser(userService.detail(entity.getStuId()));
            entity.setBuilding(buildingService.detail(room.getBuildingId()));
            entity.setRoom(roomService.detail(user.getRoomId()));
        });
        return Result.ok(pageInfo);
    }

    @PostMapping("stu_create")
    public Result stuCreate(@RequestBody Repair repair, HttpServletRequest request){
        User param = (User)request.getAttribute("user");                // 获取发起当前操作的用户信息

        User student = new User();
        student.setId(param.getId());                                      // 构造一个新的学生用户，并通过前端传入的用户信息为TA的ID赋值

        PageInfo<User> pageInfo = userService.query(student);              // 将查询到的该学生信息封装为pageInfo信息

        if (pageInfo.getList() != null && pageInfo.getList().size()>0){
            User user = pageInfo.getList().get(0);                         // 将pageInfo中数据赋值给user
            Room room = roomService.detail(user.getRoomId());              // 通过user房间ID获取room信息

            //repair.setBuildingId(room.getBuildingId());                    // 将“通过room获取到的楼栋id”赋值给repair的楼栋id
            repair.setRoomId(user.getRoomId());                            // 将“通过user获取到的房间id”赋值给repair的房间id
            repair.setStuId(param.getId());                                // 将“从前端获取到的用户id”赋值给repair的学生id
            repair.setRepStatus(0);                                        // 将维修状态置0(等待维修)
            repair.setRepDate(new Date());                                 // 将维修申报时间设定为现在

            int flag = repairService.create(repair);                       // 将上述信息打包后插入数据库
            if(flag>0){
                return Result.ok();
            }else{
                return Result.fail();
            }
        }else {
            return Result.fail("操作失败，没有该学生的相关宿舍信息");
        }
    }

}
