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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author  
 * @date
 */
@RestController
@RequestMapping("/building")
public class BuildingController {

    @Autowired
    private BuildingService buildingService;
    @Autowired
    private UserService userService;
    @Autowired
    private RoomService roomService;

    @PostMapping("create")
    public Result create(@RequestBody Building building){
        if(buildingService.detail(building.getId())!=null){
            return Result.fail("已有该楼宇编号！！");
        }else{
            int flag = buildingService.create(building);
            if(flag>0){
                // 初始化房间信息
                Integer floorNum = building.getFloorNum();
                Integer roomNum = building.getRoomNum();
                for(int i=1;i<=floorNum;i++){
                    for(int j=1;j<=roomNum;j++){
                        Room room = new Room();
                        String brand ="";
                        if(j>=1 && j<=9){
                            brand = i + "0" + j;
                        }else{
                            brand = "" + i + j;
                        }
                        room.setBuildingId(building.getId());
                        room.setFloor(i);
                        room.setBrand(Integer.valueOf(brand));
                        room.setRoomCapacity(building.getRoomCapacity());
                        room.setFreeCapacity(building.getRoomCapacity());

                        int f = roomService.create(room);
                        if(f<=0){
                            return Result.fail("初始化房间失败！");
                        }
                    }
                }
                //设置宿管房间
                User user = userService.detail(building.getManagerId());
                String roomId = "" + building.getId() + 101;
                user.setRoomId(Integer.valueOf(roomId));
                int f1 = userService.updateSelective(user);
                if(f1>0){
                    int f2 = roomService.capacityMinusOne(user.getRoomId());
                    if(f2>0){
                        return Result.ok("添加楼宇成功！");
                    }else{
                        return Result.fail("修改宿管房间失败！");
                    }
                }else{
                    return Result.fail("修改宿管房间失败！");
                }
            }else{
                return Result.fail("添加楼宇失败！");
            }
        }
    }

    @GetMapping("delete")
    public Result delete(String ids){
        int flag = buildingService.delete(ids);
        if(flag>0){
            return Result.ok();
        }else{
            return Result.fail();
        }
    }

    @PostMapping("delete_by_id")
    public Result deleteById(@RequestBody Building building){
        Integer id = building.getId();
        //查询该楼栋是否有学生入住
        if(userService.buildingActualStudentAmount(id)>0){
            return Result.fail("该楼栋有学生入住，无法删除！");
        }else{
            int flag = buildingService.delete(id);
            if(flag>0){
                //批量删除房间
                int f = roomService.deleteByBuildingId(id);
                if(f>0){
                    return Result.ok("已成功删除楼栋及对应房间！");
                }else{
                    return Result.fail("删除房间失败！");
                }
            }else{
                return Result.fail("删除楼栋失败！");
            }
        }
    }

    @PostMapping("update")
    public Result update(@RequestBody Building building){
        Building b = buildingService.detail(building.getId());
        int flag;
        if(userService.buildingActualStudentAmount(building.getId())>0){    //有学生入住时只能更新宿舍费和宿管员
            if(!b.getBuildGender().equals(building.getBuildGender())){
                return Result.fail("该楼栋有学生入住，无法更新住宿性别！");
            }else if(!b.getRoomCapacity().equals(building.getRoomCapacity())){
                return Result.fail("该楼栋有学生入住，无法更新每间房床位数！");
            }else{
                flag = buildingService.updateSelective(building);
                if(flag>0){
                    //设置宿管房间
                    User user = userService.detail(building.getManagerId());
                    String roomId = "" + building.getId() + 101;
                    user.setRoomId(Integer.valueOf(roomId));
                    int f1 = userService.updateSelective(user);
                    if(f1>0){
                        User u = userService.detail(b.getManagerId());
                        u.setRoomId(null);
                        int f2 = userService.update(u);
                        if(f2>0){
                            return Result.ok("更新成功！");
                        }else{
                            return Result.fail("修改宿管房间失败！");
                        }
                    }else{
                        return Result.fail("修改宿管房间失败！");
                    }
                }else{
                    return Result.fail("更新失败！");
                }
            }
        }else{
            flag = buildingService.updateSelective(building);
            if(flag>0){
                //批量更新房间的床位总数和空床位数
                Room room = new Room();
                room.setBuildingId(building.getId());
                PageInfo<Room> pageInfo = roomService.query(room);
                pageInfo.getList().forEach(entity->{
                    entity.setRoomCapacity(building.getRoomCapacity());
                    entity.setFreeCapacity(building.getRoomCapacity());
                    roomService.updateSelective(entity);
                });
                //设置宿管房间
                User user = userService.detail(building.getManagerId());
                String roomId = "" + building.getId() + 101;
                user.setRoomId(Integer.valueOf(roomId));
                int f1 = userService.updateSelective(user);
                if(f1>0){
                    User u = userService.detail(b.getManagerId());
                    u.setRoomId(null);
                    int f2 = userService.update(u);
                    if(f2>0){
                        return Result.ok("更新成功！");
                    }else{
                        return Result.fail("修改宿管房间失败！");
                    }
                }else{
                    return Result.fail("修改宿管房间失败！");
                }
            }else{
                return Result.fail("更新失败！");
            }
        }

    }

    @GetMapping("detail")
    public Building detail(Integer id){
        return buildingService.detail(id);
    }

    @PostMapping("query")
    public Map<String,Object> query(@RequestBody  Building building){
        PageInfo<Building> pageInfo = buildingService.query(building);

        /*
         * @imp 获取用户信息
         * @description 楼栋->根据楼栋表管理员ID，查用户表对应的管理员名字
         */
        pageInfo.getList().forEach(entity->{
            User user = userService.detail(entity.getManagerId());
            entity.setUser(user);
        });

        return Result.ok(pageInfo);
    }

    /**
     * 学生自选宿舍时根据学生性别查询空宿舍
     * @param building
     * @param request
     * @return
     */
    @PostMapping("queryGender")
    public Map<String,Object> queryGender(@RequestBody  Building building,HttpServletRequest request){
        User param = (User)request.getAttribute("user");        // 获取前端发起请求的用户信息
        User student = userService.detail(param.getId());
        building.setBuildGender(student.getGender());
        PageInfo<Building> pageInfo = buildingService.queryDid(building);

        return Result.ok(pageInfo);
    }

    /**
     * 后勤部门调换宿舍审核时查询空宿舍
     * @param building
     * @return
     */
    @PostMapping("queryDid")
    public Map<String,Object> queryDid(@RequestBody  Building building,HttpServletRequest request){
        PageInfo<Building> pageInfo = buildingService.queryDid(building);
        return Result.ok(pageInfo);
    }

    // 楼栋的楼层数
    @GetMapping("query_floor_num")
    public Result queryFloorNum(Integer id){
        return Result.ok(buildingService.detail(id));
    }


    // 楼栋的学生入住率（学生人数/学生房间床位总数）
    @GetMapping("occupancy_rate_and_gender")
    public Result occupancyRateAndGender(Integer buildingId){
        int buildingTotalStudentBedAmount = roomService.buildingTotalStudentBedAmount(buildingId);
        int buildingActualStudentAmount = userService.buildingActualStudentAmount(buildingId);

        int buildingLiverGender = buildingService.queryGender(buildingId);

        Double occupancyRate = (double) buildingActualStudentAmount / buildingTotalStudentBedAmount;
        System.out.println("occupancyRate: " + occupancyRate);

        double rateTimesOneHundred = occupancyRate * 100;
        System.out.println("midFigure: " + rateTimesOneHundred);
        BigDecimal bd1 = new BigDecimal(rateTimesOneHundred);
        rateTimesOneHundred = bd1.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();


        System.out.println(buildingId + "栋入住率: " + rateTimesOneHundred + "%");

        List<Object> occupancyRateAndGenderList = new ArrayList<>();
        occupancyRateAndGenderList.add(rateTimesOneHundred);
        occupancyRateAndGenderList.add(buildingLiverGender);

        System.out.println("occupancyRateAndGenderList: " + occupancyRateAndGenderList);
        return Result.ok(occupancyRateAndGenderList);

    }


    @PostMapping("query_male_building")
    public Map<String,Object> queryMaleBuilding(@RequestBody Building building){            // @RequestBody:将json格式的数据转为java对象
        PageInfo<Building> pageInfo = buildingService.query(building);

        pageInfo.getList().forEach(entity->{
            int buildingId = entity.getId();
            int totalStuBed = roomService.buildingTotalStudentBedAmount(buildingId);             // 某栋楼的学生床位总数
            int totalStuLiver = userService.buildingActualStudentAmount(buildingId);            // 某栋楼的现住学生总数
            entity.setFreeStuBed(totalStuBed - totalStuLiver);                                  // 空床位数量
            System.out.println("空床位数量" + entity.getFreeStuBed());
        });

        return Result.ok(pageInfo);
    }


    @PostMapping("query_female_building")
    public Map<String,Object> queryFemaleBuilding(@RequestBody Building building){            // @RequestBody:将json格式的数据转为java对象
        PageInfo<Building> pageInfo = buildingService.query(building);

        pageInfo.getList().forEach(entity->{
            int buildingId = entity.getId();
            int totalStuBed = roomService.buildingTotalStudentBedAmount(buildingId);             // 某栋楼的学生床位总数
            int totalStuLiver = userService.buildingActualStudentAmount(buildingId);            // 某栋楼的现住学生总数
            entity.setFreeStuBed(totalStuBed - totalStuLiver);                                  // 空床位数量
            System.out.println("空床位数量" + entity.getFreeStuBed());
        });

        return Result.ok(pageInfo);
    }


}
