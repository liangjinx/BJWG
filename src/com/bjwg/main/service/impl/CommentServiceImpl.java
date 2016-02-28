package com.bjwg.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.dao.CommentDao;
import com.bjwg.main.model.Comment;
import com.bjwg.main.model.CommentExample;
import com.bjwg.main.model.Info;
import com.bjwg.main.model.InfoExample;
import com.bjwg.main.service.CommentService;
import com.bjwg.main.service.InfoService;

/**
 * @author Carter
 * @version 创建时间：2015-10-10 下午04:30:27
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentDao commentDao;

	@Override
	public void queryPage(Long projectId, Pages<Comment> pages) throws Exception{
		
		try {
			
			CommentExample example = new CommentExample();
			CommentExample.Criteria criteria = example.createCriteria();
			
			example.setOrderByClause("ctime desc");
			
			criteria.andProjectIdEqualTo(projectId);
			
			int count = commentDao.countByExample(example);
			pages.setCountRows(count);
			example.setPage(pages);
				
			List<Comment> list = commentDao.selectByExample(example);
			
			pages.setRoot(list);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public Status add(Comment comment) throws Exception{
		try {
			int i = commentDao.insert(comment);
			
			return i==1?Status.success:Status.commentContentNullity;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}

