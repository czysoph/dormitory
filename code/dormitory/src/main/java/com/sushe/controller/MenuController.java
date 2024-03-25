package com.sushe.controller;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.Intention;
import com.sushe.entity.Menu;
import com.sushe.entity.User;
import com.sushe.service.MenuService;
import com.sushe.service.UserService;
import com.sushe.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * @author  
 * @date
 */
@RestController
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;
    @Autowired
    private UserService userService;

    @GetMapping("/query")
    public Result query(HttpServletRequest request){
        User param = (User) request.getAttribute("user");

        List<Menu> menus = menuService.query(param.getId());
//        for (int i=0;i<menus.size();i++){
//            System.out.println(i+":"+menus.get(i).getTitle());
//        }

        List<Menu> MenuList = new ArrayList<>();

        User user = userService.detail(param.getId());
        if(user.getUserType() == 0){    //  学生
            if(user.getRoomId() == null || user.getRoomId() ==0 ){    //  新生无宿舍
                for (Menu menu : menus) {
                    if (menu.getNewStu() == 1){
                        MenuList.add(menu);
                    }
                }
                return Result.ok(MenuList);
            }else{
                menus.remove(4);
                return Result.ok(menus);
            }
        }else{
            return Result.ok(menus);
        }


    }
}
