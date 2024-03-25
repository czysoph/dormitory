package com.sushe.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import com.sushe.utils.Entity;
import java.util.Date;


/**
 * @author  
 * @date
 * @description 楼栋信息
 */
public class Building extends Entity{

	private Integer id;
	private String buildingName;		// 楼栋名
	private Integer floorNum;			// 楼层数
	private Integer roomNum;			// 每层房间数
	private Integer roomCapacity;		// 房间床位数
	private Integer buildMoney;			// 宿舍费
	private Integer buildGender;		// 此栋楼居住学生性别：女生=0；男生=1
	private Integer managerId;			// 管理员ID

	/**
	 * @imp 关联到用户实体
	 * @susheTag 楼栋->根据楼栋表管理员ID，查用户表对应的管理员名字
	 */
	private User user;

	private Integer freeStuBed;			// 空床位数量（学生床）


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getBuildingName() {
		return buildingName;
	}

	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}

	public Integer getFloorNum() {
		return floorNum;
	}

	public void setFloorNum(Integer floorNum) {
		this.floorNum = floorNum;
	}

	public Integer getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(Integer roomNum) {
		this.roomNum = roomNum;
	}

	public Integer getRoomCapacity() {
		return roomCapacity;
	}

	public void setRoomCapacity(Integer roomCapacity) {
		this.roomCapacity = roomCapacity;
	}

	public Integer getBuildMoney() {
		return buildMoney;
	}

	public void setBuildMoney(Integer buildMoney) {
		this.buildMoney = buildMoney;
	}

	public Integer getBuildGender() {
		return buildGender;
	}

	public void setBuildGender(Integer buildGender) {
		this.buildGender = buildGender;
	}

	public Integer getManagerId() {
		return managerId;
	}

	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}


	public Integer getFreeStuBed() {
		return freeStuBed;
	}

	public void setFreeStuBed(Integer freeStuBed) {
		this.freeStuBed = freeStuBed;
	}
}