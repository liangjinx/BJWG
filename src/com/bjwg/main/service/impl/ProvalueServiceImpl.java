package com.bjwg.main.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.dao.ProvalueDao;
import com.bjwg.main.model.Provalue;
import com.bjwg.main.service.ProvalueService;

@Service
public class ProvalueServiceImpl implements ProvalueService {
	
	@Autowired
	private ProvalueDao provalueDao;

	public boolean save(Provalue entity) throws Exception {
		int n = provalueDao.save(entity);
		if(n == 1 )return true;
		return false;
	}

	public boolean update(Provalue entity) throws Exception {
		// TODO Auto-generated method stub
		int n = provalueDao.edit(entity);
		if(n == 1 )return true;
		return false;
	}

	@Override
	public Provalue findProName(String proName) {
		// TODO Auto-generated method stub
		return provalueDao.findProName(proName);
	}

}
