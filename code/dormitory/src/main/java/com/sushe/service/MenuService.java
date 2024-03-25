package com.sushe.service;

import com.sushe.entity.Menu;
import com.sushe.mapper.MenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author  
 * @date
 */
@Service
public class MenuService {

    @Autowired
    private MenuMapper menuMapper;

    // 根据用户的角色查询菜单
    public List<Menu> query(Integer userId){
        return menuMapper.query(userId);
    }

}
