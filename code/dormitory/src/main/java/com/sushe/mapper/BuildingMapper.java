package com.sushe.mapper;

import java.util.List;
import java.util.Map;

import com.sushe.entity.Building;


public interface BuildingMapper {

	public int create(Building building);

	public int delete(Integer id);

	public int update(Building building);

	public int updateSelective(Building building);

	public List<Building> query(Building building);

	public List<Building> queryDid(Building building);

	public Building detail(Integer id);

	public int count(Building building);

	public int queryGender(Integer buildingId);

	public int queryDomersBuilding(Integer userId);

}