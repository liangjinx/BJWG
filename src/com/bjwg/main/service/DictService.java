package com.bjwg.main.service;

import java.util.List;

import com.bjwg.main.model.DictDetail;

/**
 * 字典service
 * @author Administrator
 *
 */
public interface DictService {
	
	/**
	 * 查询所有
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public List<DictDetail> queryList() throws Exception;

	/**
	 * 根据字典明细code查询
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public List<DictDetail> queryList(String code) throws Exception;
	
	/**
	 * 根据字典code查询
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<DictDetail> queryListByParentCode(String parentCode) throws Exception;
	
	/**
	 * 根据字典code查询
	 * @param parentCode
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public List<DictDetail> queryListByParentCode(String parentCode,String sort) throws Exception;
}
