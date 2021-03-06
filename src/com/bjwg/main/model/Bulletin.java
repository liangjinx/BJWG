package com.bjwg.main.model;

import java.util.Date;

import com.bjwg.main.base.BaseVo;

public class Bulletin extends BaseVo{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8251131044744749240L;

	/**
     * 
     * @mbggenerated
     */
    private Long bulletinId;

    /**
     * 标题
     * @mbggenerated
     */
    private String title;

    /**
     * 内容
     * @mbggenerated
     */
    private String content;

    /**
     * 创建时间
     * @mbggenerated
     */
    private Date ctime;

    /**
     * 类型
     * @mbggenerated
     */
    private Short type;

    /**
     * 状态
     * @mbggenerated
     */
    private Byte status;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_bulletin.bulletin_id
     *
     * @return the value of bjwg_bulletin.bulletin_id
     *
     * @mbggenerated
     */
    public Long getBulletinId() {
        return bulletinId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_bulletin.bulletin_id
     *
     * @param bulletinId the value for bjwg_bulletin.bulletin_id
     *
     * @mbggenerated
     */
    public void setBulletinId(Long bulletinId) {
        this.bulletinId = bulletinId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_bulletin.title
     *
     * @return the value of bjwg_bulletin.title
     *
     * @mbggenerated
     */
    public String getTitle() {
        return title;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_bulletin.title
     *
     * @param title the value for bjwg_bulletin.title
     *
     * @mbggenerated
     */
    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_bulletin.content
     *
     * @return the value of bjwg_bulletin.content
     *
     * @mbggenerated
     */
    public String getContent() {
        return content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_bulletin.content
     *
     * @param content the value for bjwg_bulletin.content
     *
     * @mbggenerated
     */
    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_bulletin.ctime
     *
     * @return the value of bjwg_bulletin.ctime
     *
     * @mbggenerated
     */
    public Date getCtime() {
        return ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_bulletin.ctime
     *
     * @param ctime the value for bjwg_bulletin.ctime
     *
     * @mbggenerated
     */
    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_bulletin.type
     *
     * @return the value of bjwg_bulletin.type
     *
     * @mbggenerated
     */
    public Short getType() {
        return type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_bulletin.type
     *
     * @param type the value for bjwg_bulletin.type
     *
     * @mbggenerated
     */
    public void setType(Short type) {
        this.type = type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_bulletin.status
     *
     * @return the value of bjwg_bulletin.status
     *
     * @mbggenerated
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_bulletin.status
     *
     * @param status the value for bjwg_bulletin.status
     *
     * @mbggenerated
     */
    public void setStatus(Byte status) {
        this.status = status;
    }
}