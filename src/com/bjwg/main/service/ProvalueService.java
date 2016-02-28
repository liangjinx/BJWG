package com.bjwg.main.service;

import com.bjwg.main.model.Provalue;

public interface ProvalueService {
	/**
	 * 
	 * @param proName 
	 * @return
	 */
	Provalue findProName(String proName);

	boolean save(Provalue provalue)throws Exception;

	boolean update(Provalue provalue_t)throws Exception;

}
