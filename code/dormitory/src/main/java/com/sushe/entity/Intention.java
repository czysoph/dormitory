package com.sushe.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import com.sushe.utils.Entity;
import java.util.Date;


/**
 * @author
 * @date
 */
public class Intention extends Entity{

	private Integer id;
	private Integer stuId;
	private Integer roomId;
	private String inteContent;
	private Date inteDate;
	private Integer inteStatus;

	private User user;
	private Room room;
	private Integer applicationNum;	//同一宿舍的申请人数

	public Intention() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getStuId() {
		return stuId;
	}

	public void setStuId(Integer stuId) {
		this.stuId = stuId;
	}

	public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}

	public String getInteContent() {
		return inteContent;
	}

	public void setInteContent(String inteContent) {
		this.inteContent = inteContent;
	}

	public Date getInteDate() {
		return inteDate;
	}

	public void setInteDate(Date inteDate) {
		this.inteDate = inteDate;
	}

	public Integer getInteStatus() {
		return inteStatus;
	}

	public void setInteStatus(Integer inteStatus) {
		this.inteStatus = inteStatus;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}

	public Integer getApplicationNum() {
		return applicationNum;
	}

	public void setApplicationNum(Integer applicationNum) {
		this.applicationNum = applicationNum;
	}

	public Intention(Integer id, Integer stuId, Integer roomId, String inteContent, Date inteDate, Integer inteStatus) {
		this.id = id;
		this.stuId = stuId;
		this.roomId = roomId;
		this.inteContent = inteContent;
		this.inteDate = inteDate;
		this.inteStatus = inteStatus;
	}
}