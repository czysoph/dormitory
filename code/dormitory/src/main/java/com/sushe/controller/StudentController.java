package com.sushe.controller;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.*;
import com.sushe.service.BuildingService;
import com.sushe.service.IntentionService;
import com.sushe.service.RoomService;
import com.sushe.service.UserService;
import com.sushe.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * @author  
 * @date
 */
@RestController
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private UserService userService;
    @Autowired
    private BuildingService buildingService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private IntentionService intentionService;

    @GetMapping("/info")
    public Result info(HttpServletRequest request){
        User param = (User)request.getAttribute("user");        // 获取前端发起请求的用户信息
        User student = userService.detail(param.getId());
        if(student.getRoomId()!=null){
            student.setRoom(roomService.detail(student.getRoomId()));
            student.setBuilding(buildingService.detail(student.getRoom().getBuildingId()));
        }
        return Result.ok(student);
    }

    @PostMapping("/change_password")
    public Result changePwd(@RequestBody User user,HttpServletRequest request){
        User param = (User)request.getAttribute("user");        // 获取前端发起请求的用户信息
        User changePwd = new User();
        changePwd.setId(param.getId());
        PageInfo<User> pageInfo = userService.query(changePwd);              // 将查询到的该用户信息封装为pageInfo信息

        if (pageInfo.getList() != null && pageInfo.getList().size()>0){
            User u = pageInfo.getList().get(0);                         // 将pageInfo中数据赋值给user
            if(user.getOldPwd().equals(u.getUserPwd())) {                 //验证用户填写的旧密码和数据库存储的密码是否相同

                changePwd.setUserPwd(user.getUserPwd());                //设置新密码
                int flag = userService.updateSelective(changePwd);        // 相同则修改密码
                if(flag>0){
                    return Result.ok();
                }else{
                    return Result.fail();
                }

            }else{
                return Result.fail("操作失败，旧密码错误！");
            }

        }else {
            return Result.fail("操作失败，找不到该用户！");
        }

    }
}
