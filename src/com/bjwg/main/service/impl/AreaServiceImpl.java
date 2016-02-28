package com.bjwg.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.dao.Area_V2Dao;
import com.bjwg.main.model.Area_V2;
import com.bjwg.main.model.Area_V2Example;
import com.bjwg.main.service.AreaService;


/**
 * 地区service接口实现类
 * @author :Allen  
 * @CreateDate : 2015-3-20 下午03:38:10 
 * @lastModified : 2015-3-20 下午03:38:10 
 * @version : 1.0
 * @jdk：1.6
 */
@Service
public class AreaServiceImpl implements AreaService{

	@Autowired
	private Area_V2Dao area_V2Dao;
	
	
	/**
	 * 查询所有地区信息V2
	 */
	public List<Area_V2> query_v2() throws Exception{
		
		return area_V2Dao.selectByExample();
	}


}
