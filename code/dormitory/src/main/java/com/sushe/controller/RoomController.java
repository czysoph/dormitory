package com.sushe.controller;

import com.github.pagehelper.PageInfo;
import com.sushe.entity.Building;
import com.sushe.entity.Room;
import com.sushe.entity.User;
import com.sushe.service.BuildingService;
import com.sushe.service.RoomService;
import com.sushe.service.UserService;
import com.sushe.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * @author  
 * @date
 */
@RestController
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;
    @Autowired
    private UserService userService;
    @Autowired
    private BuildingService buildingService;

    @PostMapping("create")
    public Result create(@RequestBody Room room){
        int flag = roomService.create(room);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @GetMapping("delete")
    public Result delete(String ids){
        int flag = roomService.delete(ids);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @PostMapping("update")
    public Result update(@RequestBody Room room){
        int StuNum = userService.queryLiverAmount(room.getId());    //该房间的入住人数
        if(StuNum<room.getRoomCapacity()){  //如果入住人数小于要修改的床位数，可以修改；否则不能修改
            int flag = roomService.updateSelective(room);
            if(flag>0){
                return Result.ok();
            }else{
                return Result.fail();
            }
        }else{
            return Result.fail("入住人数大于总床位数，无法更新！");
        }

    }

    @GetMapping("detail")
    public Room detail(Integer id){
        return roomService.detail(id);
    }

    @PostMapping("query")
    public Map<String,Object> query(@RequestBody  Room room){
        PageInfo<Room> pageInfo = roomService.query(room);
        pageInfo.getList().forEach(entity->{
            Building building = buildingService.detail(entity.getBuildingId());
            entity.setBuilding(building);
        });
        return Result.ok(pageInfo);
    }

    /**
     * 用户管理根据选择的性别查询空房间
     * @param room
     * @return 对应性别的楼栋的空房间列表
     */
    @PostMapping("query_free_room")
    public Map<String,Object> queryFreeRoom(@RequestBody Room room){
        PageInfo<Room> pageInfo = roomService.queryFreeRoom(room);
        return Result.ok(pageInfo);
    }


    @PostMapping("queryRid")
    public Map<String,Object> queryRid(@RequestBody  Room room){
        PageInfo<Room> pageInfo = roomService.queryRid(room);
        return Result.ok(pageInfo);
    }

    // 住在当前房间的人数
    @GetMapping("query_liver_amount")
    public Result queryLiverAmount(Integer id){
        int liverAmount = userService.queryLiverAmount(id);
        return Result.ok(liverAmount);
    }

    /**
     * 为房间增加一个空床位
     * @param id
     * @return
     */
    @GetMapping("capacity_plus_one")
    public Result capacityPlusOne(Integer id){
        int flag = roomService.capacityPlusOne(id);
        if (flag>0){
            return Result.ok();
        }else {
            return Result.fail();
        }
    }

    /**
     * 为房间减少一个空床位
     * @param id
     * @return
     */
    @GetMapping("capacity_minus_one")
    public Result capacityMinusOne(Integer id){
        int flag = roomService.capacityMinusOne(id);
        if (flag>0){
            return Result.ok();
        }else {
            return Result.fail();
        }
    }

    // 当前楼栋入住率
    @GetMapping("occupancy_rate")
    public Result occupancyRate(Integer buildingId){
        int buildingTotalStudentBedAmount = roomService.buildingTotalStudentBedAmount(buildingId);
        int buildingActualStudentAmount = userService.buildingActualStudentAmount(buildingId);

        Double occupancyRate = (double) (buildingActualStudentAmount / buildingTotalStudentBedAmount) * 100;

        BigDecimal bd1 = new BigDecimal(occupancyRate);
        occupancyRate = bd1.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

        System.out.println(buildingId + "栋入住率: " + occupancyRate + "%");

        return Result.ok(occupancyRate);

    }

}
