package com.bjwg.main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjwg.main.dao.DictDetailDao;
import com.bjwg.main.model.DictDetail;
import com.bjwg.main.model.DictDetailExample;
import com.bjwg.main.service.DictService;

@Service
public class DictServiceImpl implements DictService {

	@Resource
	private DictDetailDao dictDetailDao;
	
	/**
	 * 查询所有
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public List<DictDetail> queryList() throws Exception{
		DictDetailExample example = new DictDetailExample();
		return dictDetailDao.selectByExample(example);
	}
	
	/**
	 * 根据字典明细code查询
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public List<DictDetail> queryList(String code) throws Exception{
		DictDetailExample example = new DictDetailExample();
		DictDetailExample.Criteria criteria = example.createCriteria();
		criteria.andCodeEqualTo(code);
		return dictDetailDao.selectByExample(example);
	}
	/**
	 * 根据字典code查询
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<DictDetail> queryListByParentCode(String parentCode) throws Exception{
		DictDetailExample example = new DictDetailExample();
		DictDetailExample.Criteria criteria = example.createCriteria();
		criteria.addCriterion(" EXISTS(SELECT 1 FROM bjwg_dict dict WHERE dict.DICT_ID = dctd.DICT_ID AND dict.CODE = '" + parentCode + "')");
		
		example.setOrderByClause(" dctd.dict_detail_id ");
		return dictDetailDao.selectByExample(example);
	}
	/**
	 * 根据字典code查询
	 * @param parentCode
	 * @param sort
	 * @return
	 * @throws Exception
	 */
	public List<DictDetail> queryListByParentCode(String parentCode,String sort) throws Exception{
		DictDetailExample example = new DictDetailExample();
		DictDetailExample.Criteria criteria = example.createCriteria();
		criteria.addCriterion(" EXISTS(SELECT 1 FROM bjwg_dict dict WHERE dict.DICT_ID = dctd.DICT_ID AND dict.CODE = '" + parentCode + "')");
		
		example.setOrderByClause(sort);
		return dictDetailDao.selectByExample(example);
	}
}
