package com.bjwg.main.model;

import java.util.Date;

import com.bjwg.main.base.BaseVo;

/**
 * 消息
 * @author Administrator
 *
 */
public class Message extends BaseVo{
    /**
	 * 
	 */
	private static final long serialVersionUID = 8688184974106317912L;

	/**
     *
     * @mbggenerated
     */
    private Long messageId;

    /**
     *
     * @mbggenerated
     */
    private Long userId;

    /**
     * 创建时间
     * @mbggenerated
     */
    private Date ctime;
    
    /**
     * 内容
     * @mbggenerated
     */
    private String content;

    /**
     * 消息类型
     * @mbggenerated
     */
    private Byte messageType;

    /**
     * 关联id
     * @mbggenerated
     */
    private Long relationId;

    /**
     * 关联类型
     * @mbggenerated
     */
    private Byte relationType;

    /**
     * 状态 0:未读 1:已读
     * @mbggenerated
     */
    private Byte status;
    
    /**
     * 扩展 - 格式化后的时间
     */
    private String fmtTime;

    public String getFmtTime() {
		return fmtTime;
	}

	public void setFmtTime(String fmtTime) {
		this.fmtTime = fmtTime;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_message.message_id
     *
     * @return the value of bjwg_message.message_id
     *
     * @mbggenerated
     */
    public Long getMessageId() {
        return messageId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_message.message_id
     *
     * @param messageId the value for bjwg_message.message_id
     *
     * @mbggenerated
     */
    public void setMessageId(Long messageId) {
        this.messageId = messageId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_message.user_id
     *
     * @return the value of bjwg_message.user_id
     *
     * @mbggenerated
     */
    public Long getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_message.user_id
     *
     * @param userId the value for bjwg_message.user_id
     *
     * @mbggenerated
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_message.ctime
     *
     * @return the value of bjwg_message.ctime
     *
     * @mbggenerated
     */
    public Date getCtime() {
        return ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_message.ctime
     *
     * @param ctime the value for bjwg_message.ctime
     *
     * @mbggenerated
     */
    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_message.content
     *
     * @return the value of bjwg_message.content
     *
     * @mbggenerated
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_message.content
     *
     * @param content the value for bjwg_message.content
     *
     * @mbggenerated
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_message.message_type
     *
     * @return the value of bjwg_message.message_type
     *
     * @mbggenerated
     */
    public Byte getMessageType() {
        return messageType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_message.message_type
     *
     * @param messageType the value for bjwg_message.message_type
     *
     * @mbggenerated
     */
    public void setMessageType(Byte messageType) {
        this.messageType = messageType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_message.relation_id
     *
     * @return the value of bjwg_message.relation_id
     *
     * @mbggenerated
     */
    public Long getRelationId() {
        return relationId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_message.relation_id
     *
     * @param relationId the value for bjwg_message.relation_id
     *
     * @mbggenerated
     */
    public void setRelationId(Long relationId) {
        this.relationId = relationId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_message.relation_type
     *
     * @return the value of bjwg_message.relation_type
     *
     * @mbggenerated
     */
    public Byte getRelationType() {
        return relationType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_message.relation_type
     *
     * @param relationType the value for bjwg_message.relation_type
     *
     * @mbggenerated
     */
    public void setRelationType(Byte relationType) {
        this.relationType = relationType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_message.status
     *
     * @return the value of bjwg_message.status
     *
     * @mbggenerated
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_message.status
     *
     * @param status the value for bjwg_message.status
     *
     * @mbggenerated
     */
    public void setStatus(Byte status) {
        this.status = status;
    }
}