package com.bjwg.main.service;

import java.util.List;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Comment;
import com.bjwg.main.model.Info;
import com.bjwg.main.model.InfoExample;

/**
 * @author Carter
 * @version 创建时间：2015-9-28 下午05:50:10
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public interface CommentService {

	void queryPage(Long projectId, Pages<Comment> pages) throws Exception;

	Status add(Comment comment) throws Exception;
	
	
	
}

