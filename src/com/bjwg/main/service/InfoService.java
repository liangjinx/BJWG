package com.bjwg.main.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.bjwg.main.base.Pages;
import com.bjwg.main.dao.InfoDao;
import com.bjwg.main.model.Info;

/**
 * @author Carter
 * @version 创建时间：2015-9-25 下午06:06:18
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：新闻资讯接口
 */
public interface InfoService {

	void queryPage(Byte type, Pages<Info> pages) throws Exception;

	List<Info> selectByPrimaryKey(Long infoId) throws Exception;

	
	
	
}

