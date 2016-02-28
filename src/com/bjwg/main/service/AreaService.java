package com.bjwg.main.service;

import java.util.List;

import com.bjwg.main.model.Area_V2;

/**
 * 地区service接口
 * @author :Allen  
 * @CreateDate : 2015-3-18 上午09:35:25 
 * @lastModified : 2015-3-18 上午09:35:25 
 * @version : 1.0
 * @jdk：1.6
 */
public interface AreaService{

	
	/**
	 * 查询所有地区信息V2
	 * @throws Exception 
	 */
	public List<Area_V2> query_v2() throws Exception;

	
}
