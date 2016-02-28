package com.bjwg.main.service;

import java.util.List;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Message;
import com.bjwg.main.model.MessageExample;

/**
 * 消息管理
 * @author Allen
 * @version 创建时间：2015-6-22 下午05:00:58
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public interface MessageService {

	/**
	 * 添加消息记录
	 * @param userId 用户id not null
	 * @param content 内容 not null
	 * @param messageType 消息类型 not null
	 * @param relationId 关联id null
	 * @param relationType 关联类型 null
	 * @return
	 * @throws Exception
	 */
	public Status insertMessage(Long userId,String content,byte messageType,Long relationId,byte relationType) throws Exception;
	
	List<Message> selectByExample(MessageExample example) throws Exception;
	
	/**
	 * 更新状态为已读
	 * @param userId
	 * @throws Exception
	 */
	public void updateStatus(Long userId) throws Exception;

	/**
	 * 进入农场查询的推送消息
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<Message> selectForHomeData(Long userId) throws Exception;
	
	public int countByExample(MessageExample example) throws Exception;

	void queryPage(Long userId, Pages<Message> pages);

	int deleteByPrimaryKey(Long userId, Long messageId) throws Exception;

	/**
	 * 删除全部个人信息
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	int deleteAll(Long userId) throws Exception;
}
