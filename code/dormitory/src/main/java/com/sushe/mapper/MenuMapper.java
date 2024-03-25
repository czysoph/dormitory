package com.sushe.mapper;

import com.sushe.entity.Menu;

import java.util.List;



public interface MenuMapper {

    // 根据用户的角色查询菜单
    public List<Menu> query(Integer userId);
}
