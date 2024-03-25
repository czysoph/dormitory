package com.sushe.mapper;

import java.util.List;
import com.sushe.entity.Room;
import org.apache.ibatis.annotations.Param;

public interface RoomMapper {

	public int create(Room room);

	public int delete(Integer id);

	public int deleteByBuildingId(@Param("buildingId") Integer buildingId);

	public int update(Room room);

	public int updateSelective(Room room);

	public int capacityPlusOne(Integer id);

	public int capacityMinusOne(Integer id);

	public List<Room> query(Room room);

	public List<Room> queryFreeRoom(Room room);

	public List<Room> queryRid(Room room);

	public Room detail(Integer id);

	public int count(Room room);

	public int buildingTotalStudentBedAmount(Integer buildingId);

	public int queryTotalStuBed(Integer buildingId);

	public List<Integer> queryEachStuRoomId(Integer buildingId);

	public int queryEachStuRoomFreeBedAmount(Integer roomId);



}