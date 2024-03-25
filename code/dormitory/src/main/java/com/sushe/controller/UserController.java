package com.sushe.controller;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.Room;
import com.sushe.entity.User;
import com.sushe.service.RoomService;
import com.sushe.service.UserService;
import com.sushe.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;


/**
 * @author  
 * @date
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoomService roomService;

    @PostMapping("create")
    public Result create(@RequestBody User user){       // 映射到Json对象
        User u = userService.detail(user.getId());
        if(u == null){//用户编号不能重复
            int flag = userService.create(user);       //添加用户
            if(flag>0){
                return Result.ok("添加成功！");
            }else {
                return Result.fail();
            }
        }else{
            return Result.fail("已有该用户编号！");
        }
    }

    @GetMapping("delete")
    public Result delete(String ids){
        int flag = userService.delete(ids);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    /**
     * 后勤中心更新用户
     * @param param
     * @return
     */
    @PostMapping("update")
    public Result update(@RequestBody User param){
        int flag = userService.updateSelective(param);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    /**
     * 用户修改个人信息
     * @param param
     * @return
     */
    @PostMapping("update_info")
    public Result updateInfo(@RequestBody User param){
        int flag = userService.updateSelective(param);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @GetMapping("detail")
    public User detail(Integer id){
        return userService.detail(id);
    }

    @PostMapping("query")
    public Map<String,Object> query(@RequestBody User user){            // @RequestBody:将json格式的数据转为java对象
        PageInfo<User> pageInfo = userService.query(user);
        return Result.ok(pageInfo);
    }

    @PostMapping("/forget_password")
    public Result forgetPwd(@RequestBody User param){

        System.out.println(param.getVerifyCode());
        List<User> list = userService.queryEmail(param.getEmail());
        if (list == null || list.size() == 0) {
            return Result.fail("用户不存在");
        }
        if (list.size() > 1) {
            return Result.fail("邮箱填写出错");
        }

        User user = list.get(0);
        System.out.println(user.getVerifyCode());

        if (user.getVerifyCode().equals(param.getVerifyCode())) {
            User u = new User();
            u.setId(user.getId());
            u.setUserPwd(param.getUserPwd());   //设置新密码
            int flag = userService.updateSelective(u);        // 相同则修改密码
            if (flag > 0) {
                return Result.ok("更新成功");
            } else {
                return Result.fail("更新失败");
            }
        }else {
            return Result.fail("操作失败，验证码错误！");
        }
    }

}
