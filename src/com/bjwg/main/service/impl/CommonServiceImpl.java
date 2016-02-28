package com.bjwg.main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.dao.BulletinDao;
import com.bjwg.main.dao.ServiceProtocolDao;
import com.bjwg.main.dao.UserExtDao;
import com.bjwg.main.model.Bulletin;
import com.bjwg.main.model.BulletinExample;
import com.bjwg.main.model.ServiceProtocol;
import com.bjwg.main.model.UserExt;
import com.bjwg.main.service.CommonService;
import com.bjwg.main.util.MyUtils;

@Service
public class CommonServiceImpl implements CommonService {

	@Resource
	private BulletinDao bulletinDao;
	@Resource
	private UserExtDao userExtDao;
	@Resource
	private ServiceProtocolDao serviceProtocolDao;
	
	
	/**
	 * 查询近期公告，检查用户是否已查看过该期公告
	 * @return
	 * @throws Exception 
	 */
	@Override
	public Bulletin selectRecentOneAfterChk(Long userId,Long lastBulletinId) throws Exception{
		
		BulletinExample example = new BulletinExample();
		BulletinExample.Criteria criteria = example.createCriteria();
		
		criteria.andStatusEqualTo(CommConstant.BUTTIN_STATUS_ING);
		criteria.andTypeEqualTo(CommConstant.BUTTIN_TYPE_1);
		
		if(null != userId && 0 < userId){
			
			//criteria.addCriterion(" EXISTS (SELECT 1 FROM bjwg_user_ext EX1 WHERE EX1.USER_ID = " + userId + " AND (EX1.LAST_BUTTIN_ID < bt.BULLETIN_ID))");
		}else if(null != lastBulletinId && 0 < lastBulletinId){
			
			//criteria.addCriterion(" ( bulletin_id > " + lastBulletinId + " ) ");
		}
		
		//最近一期的
		example.setOrderByClause(" bt.BULLETIN_ID desc ");
		
		List<Bulletin> bList = bulletinDao.selectByExample(example);
		
		if(!MyUtils.isListEmpty(bList)){
			
			//更新，表示已看过了
			if(null != userId && 0 < userId){
				
				UserExt ext = new UserExt();
				ext.setUserId(userId);
				ext.setLastButtinId(bList.get(0).getBulletinId());
				userExtDao.updateByPrimaryKeySelective(ext);
				
			}
			return bList.get(0);
		}
		
		return null;
	}
	/**
	 * 查询近期的公告
	 * @return
	 * @throws Exception 
	 */
	@Override
	public Bulletin selectRecentOne() throws Exception{
		
		BulletinExample example = new BulletinExample();
		BulletinExample.Criteria criteria = example.createCriteria();
		
		criteria.andStatusEqualTo(CommConstant.BUTTIN_STATUS_ING);
		criteria.andTypeEqualTo(CommConstant.BUTTIN_TYPE_1);
		//最近一期的
		example.setOrderByClause(" bt.BULLETIN_ID desc ");
		
		List<Bulletin> bList = bulletinDao.selectByExample(example);
		
		return MyUtils.isListEmpty(bList) ? null : bList.get(0);
	}
	
	/**
	 * 查询公告
	 * @param pages
	 * @param isPage
	 * @return
	 * @throws Exception
	 */
	public Pages<Bulletin> selectBulletin(Pages<Bulletin> pages,boolean isPage) throws Exception{
		
		BulletinExample example = new BulletinExample();
		BulletinExample.Criteria criteria = example.createCriteria();
		
		criteria.andStatusEqualTo(CommConstant.BUTTIN_STATUS_ING);
		criteria.andTypeEqualTo(CommConstant.BUTTIN_TYPE_1);
		//最近一期的
		example.setOrderByClause(" bt.BULLETIN_ID desc ");
		
		if(isPage){
			
			int count = bulletinDao.countByExample(example);
			
			pages.setCountRows(count);
		}
		
		List<Bulletin> list = bulletinDao.selectByExample(example);
		
		if(null == pages){
			
			pages = new Pages<Bulletin>();
		}
		
		pages.setRoot(list);
		
		return pages;
	}
	/**
	 * 查询协议
	 * @param pages
	 * @param isPage
	 * @return
	 * @throws Exception
	 */
	public ServiceProtocol selectProtocol(String code) throws Exception{
		
		return serviceProtocolDao.selectByType(code);
	}

}
