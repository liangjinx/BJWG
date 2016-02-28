package com.bjwg.main.dao;

import java.util.List;

import com.bjwg.main.model.Area_V2;

public interface Area_V2Dao {
	/**
	 * 查询所有地区信息
	 */
	public List<Area_V2> selectByExample() throws Exception;
}