package com.bjwg.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.dao.InfoDao;
import com.bjwg.main.model.Info;
import com.bjwg.main.model.InfoExample;
import com.bjwg.main.service.InfoService;

/**
 * @author Carter
 * @version 创建时间：2015-9-28 上午09:42:37
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Service
public class InfoServiceImpl implements InfoService {

	@Autowired
	InfoDao infoDao;
	
	@Override
	public void queryPage(Byte type, Pages<Info> pages) throws Exception{
		
		try {
			
			InfoExample example = new InfoExample();
			InfoExample.Criteria criteria = example.createCriteria();
			
			example.setOrderByClause("ISNULL(sort),sort asc, ctime desc");
			
			if(type!=null && type.intValue()>0){
				criteria.andTypeEqualTo(type);
			}
			
			int count = infoDao.countByExample(example);
			pages.setCountRows(count);
			example.setPage(pages);
				
			List<Info> list = infoDao.selectByExample(example);
			
			pages.setRoot(list);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public List<Info> selectByPrimaryKey(Long infoId) throws Exception{
		try {
			return infoDao.selectNear(infoId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	
}

