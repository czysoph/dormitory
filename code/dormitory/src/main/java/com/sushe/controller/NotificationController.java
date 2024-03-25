package com.sushe.controller;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.*;
import com.sushe.service.BuildingService;
import com.sushe.service.NotificationService;
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
@RequestMapping("/notification")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;
    @Autowired
    private UserService userService;
    @Autowired
    private BuildingService buildingService;
    @Autowired
    private RoomService roomService;


    @PostMapping("create")
    public Result create(@RequestBody Notification notification){
        int flag = notificationService.create(notification);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @GetMapping("delete")
    public Result delete(String ids){
        int flag = notificationService.delete(ids);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @PostMapping("update")
    public Result update(@RequestBody Notification notification){
        int flag = notificationService.updateSelective(notification);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @GetMapping("detail")
    public Notification detail(Integer id){
        return notificationService.detail(id);
    }

    @PostMapping("query")
    public Map<String,Object> query(@RequestBody  Notification notification){
        PageInfo<Notification> pageInfo = notificationService.query(notification);
        return Result.ok(pageInfo);
    }

    @PostMapping("query_myself")
    public Map<String, Object> queryMyself(@RequestBody Notification notification, HttpServletRequest request){
        User param = (User)request.getAttribute("user");

        notification.setUserId(param.getId());
        PageInfo<Notification> pageInfo = notificationService.query(notification);
        pageInfo.getList().forEach(entity->{
            entity.setUser(userService.detail(entity.getUserId()));
        });
        return Result.ok(pageInfo);
    }

    @PostMapping("dormer_create")
    public Result domerCreate(@RequestBody Notification notification, HttpServletRequest request){
        User param = (User)request.getAttribute("user");                // 获取发起当前操作的用户信息

        User domer1 = new User();
        domer1.setId(param.getId());                                      // 构造一个新的用户，并通过前端传入的用户信息为TA的ID赋值

        PageInfo<User> pageInfo = userService.query(domer1);              // 将查询到的该用户信息封装为pageInfo信息

        if (pageInfo.getList() != null && pageInfo.getList().size()>0){
            User user = pageInfo.getList().get(0);                         // 将pageInfo中数据赋值给user

            Room room = roomService.detail(user.getRoomId());
            Building building = buildingService.detail(room.getBuildingId());
            notification.setUserId(user.getId());
            notification.setNotiRange(building.getId());
            notification.setNotiDate(new Date());                                 // 将调换申报时间设定为现在

            int flag = notificationService.create(notification);                       // 将上述信息打包后插入数据库
            if(flag>0){
                return Result.ok();
            }else{
                return Result.fail();
            }
        }else {
            return Result.fail("操作失败，缺少该学生相关宿舍信息");
        }
    }

    // 查询学生所在楼栋的所有通知
    @PostMapping("query_my_building")
    public Map<String, Object> queryMyBuilding(HttpServletRequest request){
        User param = (User)request.getAttribute("user");

        User user1 = userService.detail(param.getId());     // 1. 用获取到的请求参数构造一个用户

        Room room = roomService.detail(user1.getRoomId());  // 获取该用户的房间信息
        System.out.println(room.getBuildingId());
        int buildingId = room.getBuildingId();       // 获取该用户的楼栋ID
        System.out.println("楼栋号："+buildingId);

        PageInfo<Notification> pageInfo = notificationService.queryMyBuilding(buildingId);  // 通过楼栋ID查询该楼通知

        System.out.println(pageInfo);
        return Result.ok(pageInfo);
    }

}
