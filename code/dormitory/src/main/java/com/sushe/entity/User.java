package com.sushe.entity;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.validator.constraints.Length;
import com.sushe.utils.Entity;
import java.util.Date;
import java.util.List;


/**
 * @author  
 * @date
 * @description 用户信息
 */
public class User extends Entity{

	private Integer id;
	private String oldPwd;	//	在修改密码时验证旧密码正确
	private String userPwd;
	private String userName;
	private Integer gender;			// 用户性别：女=0；男=1
	private String email;
	private Integer roomId;
	private Integer userType;		// 角色类型：学生=0；宿舍管理员=1；后勤中心=2

	private Building building;
	private Room room;

	private String verifyCode; //验证码

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public String getVerifyCode() {
		return verifyCode;
	}

	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOldPwd() {
		return oldPwd;
	}

	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}

	@JsonIgnore						// 返回Json时不显示密码
	public String getUserPwd() {
		return userPwd;
	}

	@JsonProperty					// 提交时能够使用
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}

	public Integer getUserType() {
		return userType;
	}

	public Building getBuilding() {
		return building;
	}

	public void setBuilding(Building building) {
		this.building = building;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

	public User() {
	}

//	public User(Integer id, String userPwd, String userName, Integer gender, String email, Integer roomId, Integer userType) {
//		this.id = id;
//		this.userPwd = userPwd;
//		this.userName = userName;
//		this.gender = gender;
//		this.email = email;
//		this.roomId = roomId;
//		this.userType = userType;
//	}

	public User(Integer id, String oldPwd, String userPwd, String userName, Integer gender, String email, Integer roomId, Integer userType, String verifyCode) {
		this.id = id;
		this.oldPwd = oldPwd;
		this.userPwd = userPwd;
		this.userName = userName;
		this.gender = gender;
		this.email = email;
		this.roomId = roomId;
		this.userType = userType;
		this.verifyCode = verifyCode;
	}
}