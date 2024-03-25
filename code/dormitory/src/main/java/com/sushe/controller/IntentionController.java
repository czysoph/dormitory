package com.sushe.controller;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.Exchange;
import com.sushe.entity.Intention;
import com.sushe.entity.Room;
import com.sushe.entity.User;
import com.sushe.service.IntentionService;
import com.sushe.service.RoomService;
import com.sushe.service.UserService;
import com.sushe.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * @author  
 * @date
 */
@RestController
@RequestMapping("/intention")
public class IntentionController {

    @Autowired
    private IntentionService intentionService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private UserService userService;

    @PostMapping("create")
    public Result create(@RequestBody Intention intention){
        int flag = intentionService.create(intention);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @GetMapping("delete")
    public Result delete(String ids){
        int flag = intentionService.delete(ids);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    /**
     * 后勤人员更新自选宿舍申请状态
     * @param intention
     * @return
     */
    @PostMapping("update")
    public Result update(@RequestBody Intention intention){
        if(intentionService.detail(intention.getId()).getInteStatus() == 0){
            int flag = 0;
            if(intention.getInteStatus() == 1){ //审核通过
                User user = new User();
                user.setId(intention.getStuId());
                user.setRoomId(intention.getRoomId());
                int f1 = userService.updateSelective(user);  //更改用户信息
                int f2 = roomService.capacityMinusOne(intention.getRoomId());   //更改房间信息
                if(f1>0 && f2 >0){
                    flag = intentionService.updateSelective(intention);
                }else{
                    return Result.fail("修改失败！");
                }
            }else if(intention.getInteStatus() == 2){//审核不通过
                flag = intentionService.updateSelective(intention);
            }
            if(flag>0){
                return Result.ok();
            }else{
                return Result.fail("修改失败！!");
            }
        }else{
            return Result.fail("已审核，无法再次审核！!");
        }
    }

    @GetMapping("detail")
    public Intention detail(Integer id){
        return intentionService.detail(id);
    }

    /**
     * 后勤人员查询全部申请
     * @param intention
     * @return
     */
    @PostMapping("query")
    public Map<String,Object> query(@RequestBody  Intention intention){
        PageInfo<Intention> pageInfo = intentionService.query(intention);
        pageInfo.getList().forEach(entity->{
            entity.setUser(userService.detail(entity.getStuId()));
        });
        return Result.ok(pageInfo);
    }

    /**
     * 学生查询申请,并显示同一宿舍的申请人数
     * @param intention
     * @return
     */
    @PostMapping("query_student")
    public Map<String,Object> queryGender(@RequestBody  Intention intention,HttpServletRequest request){
        User param = (User)request.getAttribute("user");        // 获取前端发起请求的用户信息
        PageInfo<Intention> pageInfo = intentionService.query(intention);
        pageInfo.getList().forEach(entity->{
            entity.setUser(userService.detail(entity.getStuId()));
            entity.setRoom(roomService.detail(entity.getRoomId()));
            entity.setApplicationNum(intentionService.queryApplicationAmount(entity.getRoomId()));  //申请人数
        });
        return Result.ok(pageInfo);
    }

    /**
     * 学生查询判断是否已有宿舍或者已有申请
     * @param request
     * @return
     */
    @PostMapping("/query_intention")
    public Result query(HttpServletRequest request){
        User param = (User)request.getAttribute("user");        // 获取前端发起请求的用户信息
        System.out.println(param.getId());
        User student = userService.detail(param.getId());
        if(student.getRoomId() != null && student.getRoomId() != 0){
            return Result.fail("已有宿舍，无法自选宿舍！");
        }else{
            Intention intention = new Intention();
            intention.setStuId(param.getId());
            PageInfo<Intention> pageInfo = intentionService.query(intention);
            if(pageInfo.getList() != null && pageInfo.getList().size()>0){
                if(pageInfo.getList().get(0).getInteStatus()==2){//审核不通过可以再次申请一次
                    return Result.ok();
                }else{
                    return Result.fail("已有申请,无法再次申请！");
                }

            }else{
                return Result.ok();
            }
        }

    }

    /**
     * 查询学生的申请
     * @param intention
     * @param request
     * @return
     */
    @PostMapping("query_myself")
    public Map<String, Object> queryMyself(@RequestBody Intention intention, HttpServletRequest request){
        User param = (User)request.getAttribute("user");

        intention.setStuId(param.getId());
        PageInfo<Intention> pageInfo = intentionService.query(intention);
        pageInfo.getList().forEach(entity->{
            entity.setUser(userService.detail(entity.getStuId()));
//            entity.setBuilding(buildingService.detail(entity.getBuildingId()));
//            entity.setRoom(roomService.detail(entity.getRoomId()));
        });
        return Result.ok(pageInfo);
    }

    /**
     * 学生创建自选宿舍申请
     * @param intention
     * @param request
     * @return
     */
    @PostMapping("stu_create")
    public Result stuCreate(@RequestBody Intention intention, HttpServletRequest request){
        if(intention.getRoomId() == null){
            return Result.fail("未选择宿舍号！");
        }
        Room room = roomService.detail(intention.getRoomId());
        if(intentionService.queryApplicationAmount(intention.getRoomId())<room.getFreeCapacity()){  //判断申请人数是否已满
            User param = (User)request.getAttribute("user");                // 获取发起当前操作的用户信息

            User student = new User();
            student.setId(param.getId());                                      // 构造一个新的学生用户，并通过前端传入的用户信息为TA的ID赋值

            PageInfo<User> pageInfo = userService.query(student);              // 将查询到的该学生信息封装为pageInfo信息

            if (pageInfo.getList() != null && pageInfo.getList().size()>0){
                User user = pageInfo.getList().get(0);                         // 将pageInfo中数据赋值给user

                intention.setStuId(user.getId());
                intention.setInteDate(new Date());
                intention.setInteStatus(0);

                int flag= intentionService.create(intention);
                if(flag>0){
                    return Result.ok();
                }else{
                    return Result.fail("申请失败!");
                }
            }else {
                return Result.fail("操作失败!");
            }

        }else{
            return Result.fail("该宿舍申请已满或者无空床位！");
        }
    }

    /**
     * 查询同一宿舍的申请人数
     * @param roomId
     * @return
     */
//    @GetMapping("query_application_amount")
//    public Integer queryApplicationAmount(Integer roomId){
//        Integer applicationAmount = intentionService.queryApplicationAmount(roomId);
//        return applicationAmount;
//    }


}
