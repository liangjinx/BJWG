package com.bjwg.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.dao.SlideDao;
import com.bjwg.main.model.Info;
import com.bjwg.main.model.Slide;
import com.bjwg.main.model.SlideExample;
import com.bjwg.main.service.SlideService;

/**
 * @author Carter
 * @version 创建时间：2015-9-28 下午05:50:40
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Service
public class SlideServiceImpl implements SlideService {

	@Autowired
	SlideDao slideDao;

	@Override
	public List<Slide> queryIndex() {
		SlideExample example = new SlideExample();
		SlideExample.Criteria criteria = example.createCriteria();
		
		example.setOrderByClause("ISNULL(sort) ASC,sort,slide_id asc");
		
		List<Slide> list = slideDao.selectByExample(example);
		
		return list;
	}
	
	
	
}

