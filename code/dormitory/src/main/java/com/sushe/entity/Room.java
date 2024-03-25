package com.sushe.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import com.sushe.utils.Entity;

/**
 * @author  
 * @date
 */
public class Room extends Entity{

	/**
	 * 房间编号：由楼宇号和门牌号组成
	 */
	private Integer id;

	private Integer buildingId;	//楼宇号

	private Integer brand;	//门牌号

	private Integer floor;	//楼层
	/**
	 * 房间容量：无人间=0；一人间=1；二人间=2；四人间=4；六人间=6
	 */
	private Integer roomCapacity;
	/**
	 * 空床位数
	 */
	private Integer freeCapacity;

	private Building building;

	private Integer buildGender;	//住宿性别

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getBuildingId() {
		return buildingId;
	}

	public void setBuildingId(Integer buildingId) {
		this.buildingId = buildingId;
	}

	public Integer getBrand() {
		return brand;
	}

	public void setBrand(Integer brand) {
		this.brand = brand;
	}

	public Integer getFloor() {
		return floor;
	}

	public void setFloor(Integer floor) {
		this.floor = floor;
	}

	public Integer getRoomCapacity() {
		return roomCapacity;
	}

	public void setRoomCapacity(Integer roomCapacity) {
		this.roomCapacity = roomCapacity;
	}

	public Integer getFreeCapacity() {
		return freeCapacity;
	}

	public void setFreeCapacity(Integer freeCapacity) {
		this.freeCapacity = freeCapacity;
	}

	public Building getBuilding() {
		return building;
	}

	public void setBuilding(Building building) {
		this.building = building;
	}

	public Integer getBuildGender() {
		return buildGender;
	}

	public void setBuildGender(Integer buildGender) {
		this.buildGender = buildGender;
	}
}