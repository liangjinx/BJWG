package com.bjwg.main.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.MessageConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.dao.MessageDao;
import com.bjwg.main.model.Message;
import com.bjwg.main.model.MessageExample;
import com.bjwg.main.service.MessageService;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.ValidateUtil;

/**
 * @author Allen
 * @version 创建时间：2015-6-22 下午05:03:32
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Service
public class MessageServiceImpl implements MessageService{

	@Resource
	private MessageDao messageDao;
	
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
	public Status insertMessage(Long userId,String content,byte messageType,Long relationId,byte relationType) throws Exception{
		
		try {
			
			if(userId == null){
				return Status.useridNullity;
			}
			if(!ValidateUtil.validateString(content, false, 1, 255)){
				return Status.messageContentNullity;
			}
			
			Message message = new Message();
			message.setUserId(userId);
			message.setContent(content);
			message.setMessageType(messageType);
			message.setRelationId(relationId);
			message.setRelationType(relationType);
			message.setCtime(new Date());
			//默认未读
			message.setStatus(MessageConstant.MSG_UNREAD);
			messageDao.insert(message);
			
			return Status.success;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	public List<Message> selectByExample(MessageExample example) throws Exception{
		return messageDao.selectByExample(example);
	}
	
	public int countByExample(MessageExample example) throws Exception{
		return messageDao.countByExample(example);
	}
	
	@Override
	public void queryPage(Long userId, Pages<Message> pages){
		MessageExample example = new MessageExample();
		MessageExample.Criteria criteria = example.createCriteria();
		example.setOrderByClause("msg.ctime desc");
		
		criteria.andUserIdEqualTo(userId);
		
		int count = messageDao.countByExample(example);
		pages.setCountRows(count);
		example.setPage(pages);
			
		List<Message> list = messageDao.selectByExample(example);
		
		pages.setRoot(list);
	}
	
	@Override
	public int deleteByPrimaryKey(Long userId, Long messageId) throws Exception{
		try {
			MessageExample example = new MessageExample();
			MessageExample.Criteria criteria = example.createCriteria();
			
			criteria.andUserIdEqualTo(userId);
			criteria.andMessageIdEqualTo(messageId);
			
			if(messageDao.countByExample(example) > 0){
				return messageDao.deleteByPrimaryKey(messageId);
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int deleteAll(Long userId) throws Exception{
		return messageDao.deleteByUserId(userId);
	}
	
	/**
	 * 更新状态为已读
	 * @param userId
	 * @throws Exception
	 */
	public void updateStatus(Long userId) throws Exception{
		try {
			messageDao.updateStatus(userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 进入农场查询的推送消息
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<Message> selectForHomeData(Long userId) throws Exception{
		
		if(null == userId || userId <= 0){
			
			return null;
		}
		
		MessageExample example = new MessageExample();
		MessageExample.Criteria criteria = example.createCriteria();
		
		criteria.andUserIdEqualTo(userId);
		criteria.andMessageTypeEqualTo(MessageConstant.SYS_MESSAGE_2);
		criteria.andStatusEqualTo((byte)CommConstant.FALSE);
		//推送类型、未读过的消息
		List<Message> list = messageDao.selectByExample(example);
		
		if(!MyUtils.isListEmpty(list)){
			
			Message updateMsg = new Message();
			updateMsg.setStatus((byte)CommConstant.TRUE);
			//更新状态
			for (Message message : list) {
				updateMsg.setMessageId(message.getMessageId());
				messageDao.updateByPrimaryKeySelective(updateMsg);
			}
		}
		
		return list;
	}
}
