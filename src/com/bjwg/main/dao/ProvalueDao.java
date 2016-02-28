package com.bjwg.main.dao;

import com.bjwg.main.model.Provalue;

public interface ProvalueDao{
	
	/**
	 * 
	 * @param proName
	 * @return
	 */
	Provalue findProName(String proName);

	int edit(Provalue entity) throws Exception;

	int save(Provalue entity) throws Exception;

}
