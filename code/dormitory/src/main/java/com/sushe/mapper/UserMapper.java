package com.sushe.mapper;

import java.util.List;
import java.util.Map;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	public int create(User user);

	public int delete(Integer id);

	public int update(User user);

	public int updateSelective(User user);

	public List<User> query(User user);

	public List<User> queryEmail(@Param("email") String email);

	public User detail(Integer id);

	public int count(User user);

	public User login(@Param("id") Integer id, @Param("userPwd") String userPwd, @Param("userType") Integer userType);

	public int queryLiverAmount(Integer roomId);

	public int buildingActualStudentAmount(Integer buildingId);
}