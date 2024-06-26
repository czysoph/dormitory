package com.sushe.service;

import com.sushe.mapper.RoomMapper;
import com.sushe.entity.Room;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;


/**
 * @author  
 * @date
 */
@Service
public class RoomService {

    @Autowired
    private RoomMapper roomMapper;

    public int create(Room room) {
        return roomMapper.create(room);
    }

    public int delete(String ids) {
        String[] arr = ids.split(",");
        int row = 0;
        for (String s : arr) {
            if(!StringUtils.isEmpty(s)){
                roomMapper.delete(Integer.parseInt(s));
            row++;
            }
        }
        return row;
    }

    public int delete(Integer id) {
        return roomMapper.delete(id);
    }

    public int deleteByBuildingId(Integer id) {
        return roomMapper.deleteByBuildingId(id);
    }

    public int update(Room room) {
        return roomMapper.update(room);
    }

    public int updateSelective(Room room) {
        return roomMapper.updateSelective(room);
    }

    public PageInfo<Room> query(Room room) {
        if(room != null && room.getPage() != null){
            PageHelper.startPage(room.getPage(),room.getLimit());
        }
        return new PageInfo<Room>(roomMapper.query(room));
    }

    public PageInfo<Room> queryFreeRoom(Room room) {
        if(room != null && room.getPage() != null){
            PageHelper.startPage(room.getPage(),room.getLimit());
        }
        return new PageInfo<Room>(roomMapper.queryFreeRoom(room));
    }

    public PageInfo<Room> queryRid(Room room) {
        if(room != null && room.getPage() != null){
            PageHelper.startPage(room.getPage(),room.getLimit());
        }
        return new PageInfo<Room>(roomMapper.queryRid(room));
    }

    public Room detail(Integer id) {
        return roomMapper.detail(id);
    }

    public int count(Room room) {
        return roomMapper.count(room);
    }

    public int capacityPlusOne(Integer id){
        return roomMapper.capacityPlusOne(id);
    }

    public int capacityMinusOne(Integer id){
        return roomMapper.capacityMinusOne(id);
    }

    public int buildingTotalStudentBedAmount(Integer buildingId){
        return roomMapper.buildingTotalStudentBedAmount(buildingId);
    }

    // 查询某栋楼的学生床位总数
    public int queryTotalStuBed(Integer buildingId){
        return roomMapper.queryTotalStuBed(buildingId);
    }


//    public int queryTotalStuRoom(Integer buildingId){
//        return roomMapper.queryTotalStuRoom(buildingId);
//    }

    public List<Integer> queryEachStuRoomId(Integer buildingId){
        return roomMapper.queryEachStuRoomId(buildingId);
    }

    public int queryEachStuRoomFreeBedAmount(Integer roomId){
        return roomMapper.queryEachStuRoomFreeBedAmount(roomId);
    }
}
