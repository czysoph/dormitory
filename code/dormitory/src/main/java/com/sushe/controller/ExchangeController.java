package com.sushe.controller;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.*;
import com.sushe.service.BuildingService;
import com.sushe.service.ExchangeService;
import com.sushe.service.RoomService;
import com.sushe.service.UserService;
import com.sushe.service.IntentionService;
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
@RequestMapping("/exchange")
public class ExchangeController {

    @Autowired
    private ExchangeService exchangeService;
    @Autowired
    private UserService userService;
    @Autowired
    private BuildingService buildingService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private IntentionService intentionService;

    /*
    **创建退换申请
     */
    @PostMapping("create")
    public Result create(@RequestBody Exchange exchange){
        int flag = exchangeService.create(exchange);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    /*
    **删除退换申请
     */
    @GetMapping("delete")
    public Result delete(String ids){
        int flag = exchangeService.delete(ids);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    /*
     **有选择更新退换信息
     */
    @PostMapping("update")
    public Result update(@RequestBody Exchange exchange){
        int flag = exchangeService.updateSelective(exchange);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }


    /*
     **退寝
     */
    @PostMapping("updateOut")
    public Result updateOut(@RequestBody Exchange exchange){

        int flag = exchangeService.updateOut(exchange);

        int stuId = (exchangeService.detail(exchange.getId())).getStuId();

        flag += intentionService.deleteStu(stuId);

        System.out.println(stuId);

        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    /*
     **调换宿舍
     */
    @PostMapping("updateEX")
    public Result updateEX(@RequestBody Exchange exchange){

        int flag = exchangeService.updateEX(exchange);

        flag += roomService.capacityMinusOne(exchange.getRoomId());

        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    /*
     **获取指定ID的详细退换信息
     */
    @GetMapping("detail")
    public Exchange detail(Integer id){
        return exchangeService.detail(id);
    }

    /*
     **后勤管理员查询所有申请
     */
    @PostMapping("query")
    public Map<String,Object> query(@RequestBody  Exchange exchange){
        PageInfo<Exchange> pageInfo = exchangeService.query(exchange);
        pageInfo.getList().forEach(entity->{

            User user = userService.detail(entity.getStuId());
            Room room = roomService.detail(user.getRoomId());              // 通过user房间ID获取room信息

            entity.setUser(userService.detail(entity.getStuId()));
            entity.setBuilding(buildingService.detail(room.getBuildingId()));
            entity.setRoom(roomService.detail(user.getRoomId()));
        });

        return Result.ok(pageInfo);
    }

    /*
     **学生查询自己的申请
     */
    @PostMapping("query_myself")
    public Map<String, Object> queryMyself(@RequestBody Exchange exchange, HttpServletRequest request){
        User param = (User)request.getAttribute("user");

        exchange.setStuId(param.getId());
        PageInfo<Exchange> pageInfo = exchangeService.query(exchange);
        pageInfo.getList().forEach(entity->{

            User user = userService.detail(entity.getStuId());
            Room room = roomService.detail(user.getRoomId());              // 通过user房间ID获取room信息

            entity.setUser(userService.detail(entity.getStuId()));
            entity.setBuilding(buildingService.detail(room.getBuildingId()));
            entity.setRoom(roomService.detail(user.getRoomId()));
        });
        return Result.ok(pageInfo);
    }

    /*
     **学生申请退换宿舍或退寝信息
     */
    @PostMapping("stu_create")
    public Result stuCreate(@RequestBody Exchange exchange, HttpServletRequest request){
        User param = (User)request.getAttribute("user");                // 获取发起当前操作的用户信息

        User student = new User();
        student.setId(param.getId());                                      // 构造一个新的学生用户，并通过前端传入的用户信息为TA的ID赋值

        PageInfo<User> pageInfo = userService.query(student);              // 将查询到的该学生信息封装为pageInfo信息

        if (pageInfo.getList() != null && pageInfo.getList().size()>0){
            User user = pageInfo.getList().get(0);                         // 将pageInfo中数据赋值给user
            Room room = roomService.detail(user.getRoomId());              // 通过user房间ID获取room信息

            exchange.setRoomId(user.getRoomId());                            // 将“通过user获取到的房间id”赋值给exchange的房间id
            exchange.setStuId(param.getId());                                // 将“从前端获取到的用户id”赋值给exchange的学生id
            exchange.setExStatus(0);                                         // 将调换状态置0(等待审核)
            exchange.setExDate(new Date());                                 // 将调换申报时间设定为现在

            int flag = exchangeService.create(exchange);                       // 将上述信息打包后插入数据库
            if(flag>0){
                return Result.ok();
            }else{
                return Result.fail();
            }
        }else {
            return Result.fail("操作失败，缺少该学生相关宿舍信息");
        }
    }


}
