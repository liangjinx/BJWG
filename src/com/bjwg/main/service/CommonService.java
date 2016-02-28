package com.bjwg.main.service;

import javax.annotation.Resource;

import com.bjwg.main.base.Pages;
import com.bjwg.main.dao.BulletinDao;
import com.bjwg.main.model.Bulletin;
import com.bjwg.main.model.ServiceProtocol;

/**
 * 不太重要的service
 * @author Administrator
 *
 */
public interface CommonService {

	/**
	 * 查询近期公告，检查用户是否已查看过该期公告
	 * @return
	 * @throws Exception 
	 */
	public Bulletin selectRecentOneAfterChk(Long userId,Long lastBulletinId) throws Exception;
	/**
	 * 查询近期的公告
	 * @return
	 * @throws Exception 
	 */
	public Bulletin selectRecentOne() throws Exception;
	
	/**
	 * 查询公告
	 * @param pages
	 * @param isPage
	 * @return
	 * @throws Exception
	 */
	public Pages<Bulletin> selectBulletin(Pages<Bulletin> pages,boolean isPage) throws Exception;
	
	/**
	 * 查询协议
	 * @param pages
	 * @param isPage
	 * @return
	 * @throws Exception
	 */
	public ServiceProtocol selectProtocol(String code) throws Exception;
}
