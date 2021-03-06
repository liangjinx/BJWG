package com.bjwg.main.model;

import java.math.BigDecimal;
import java.util.Date;

import com.bjwg.main.base.BaseVo;

/**
 * 赠送好友表
 * @ClassName: PresentFreinds 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Administrator
 * @date 2015-9-15 上午11:36:47
 */
public class PresentFreinds extends BaseVo{
    /**
	 * 
	 */
	private static final long serialVersionUID = 3095823479861632615L;

	/**
     * 
     * @mbggenerated
     */
    private Long presentId;

    /**
     * 赠送人id
     * @mbggenerated
     */
    private Long presentUserId;

    /**
     * 赠送人昵称
     * 
     * @mbggenerated
     */
    private String presentUser;

    /**
     * 被赠送人id
     * @mbggenerated
     */
    private Long presentedUserId;

    /**
     * 被赠送人昵称
     * @mbggenerated
     */
    private String presentedUser;

    /**
     * 数量
     * @mbggenerated
     */
    private Integer presentNum;

    /**
     * 单价
     * @mbggenerated
     */
    private BigDecimal price;

    /**
     * 总额
     * @mbggenerated
     */
    private BigDecimal totalMoney;

    /**
     * 时间
     * @mbggenerated
     */
    private Date ctime;

    /**
     * 类型 1:送猪仔2:送猪肉券
     * @mbggenerated
     */
    private Byte type;

    /**
     * 赠送关联id 送猪仔记录我的收益id，送券记录券id
     * @mbggenerated
     */
    private Long presentRelationId;

    /**
     * 被赠送关联id 送猪仔记录好友的收益id，送券记录新券id
     * @mbggenerated
     */
    private Long presentedRelationId;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.present_id
     *
     * @return the value of bjwg_present_freinds.present_id
     *
     * @mbggenerated
     */
    public Long getPresentId() {
        return presentId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.present_id
     *
     * @param presentId the value for bjwg_present_freinds.present_id
     *
     * @mbggenerated
     */
    public void setPresentId(Long presentId) {
        this.presentId = presentId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.present_user_id
     *
     * @return the value of bjwg_present_freinds.present_user_id
     *
     * @mbggenerated
     */
    public Long getPresentUserId() {
        return presentUserId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.present_user_id
     *
     * @param presentUserId the value for bjwg_present_freinds.present_user_id
     *
     * @mbggenerated
     */
    public void setPresentUserId(Long presentUserId) {
        this.presentUserId = presentUserId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.present_user
     *
     * @return the value of bjwg_present_freinds.present_user
     *
     * @mbggenerated
     */
    public String getPresentUser() {
        return presentUser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.present_user
     *
     * @param presentUser the value for bjwg_present_freinds.present_user
     *
     * @mbggenerated
     */
    public void setPresentUser(String presentUser) {
        this.presentUser = presentUser == null ? null : presentUser.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.presented_user_id
     *
     * @return the value of bjwg_present_freinds.presented_user_id
     *
     * @mbggenerated
     */
    public Long getPresentedUserId() {
        return presentedUserId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.presented_user_id
     *
     * @param presentedUserId the value for bjwg_present_freinds.presented_user_id
     *
     * @mbggenerated
     */
    public void setPresentedUserId(Long presentedUserId) {
        this.presentedUserId = presentedUserId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.presented_user
     *
     * @return the value of bjwg_present_freinds.presented_user
     *
     * @mbggenerated
     */
    public String getPresentedUser() {
        return presentedUser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.presented_user
     *
     * @param presentedUser the value for bjwg_present_freinds.presented_user
     *
     * @mbggenerated
     */
    public void setPresentedUser(String presentedUser) {
        this.presentedUser = presentedUser == null ? null : presentedUser.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.present_num
     *
     * @return the value of bjwg_present_freinds.present_num
     *
     * @mbggenerated
     */
    public Integer getPresentNum() {
        return presentNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.present_num
     *
     * @param presentNum the value for bjwg_present_freinds.present_num
     *
     * @mbggenerated
     */
    public void setPresentNum(Integer presentNum) {
        this.presentNum = presentNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.price
     *
     * @return the value of bjwg_present_freinds.price
     *
     * @mbggenerated
     */
    public BigDecimal getPrice() {
        return price;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.price
     *
     * @param price the value for bjwg_present_freinds.price
     *
     * @mbggenerated
     */
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.total_money
     *
     * @return the value of bjwg_present_freinds.total_money
     *
     * @mbggenerated
     */
    public BigDecimal getTotalMoney() {
        return totalMoney;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.total_money
     *
     * @param totalMoney the value for bjwg_present_freinds.total_money
     *
     * @mbggenerated
     */
    public void setTotalMoney(BigDecimal totalMoney) {
        this.totalMoney = totalMoney;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.ctime
     *
     * @return the value of bjwg_present_freinds.ctime
     *
     * @mbggenerated
     */
    public Date getCtime() {
        return ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.ctime
     *
     * @param ctime the value for bjwg_present_freinds.ctime
     *
     * @mbggenerated
     */
    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.type
     *
     * @return the value of bjwg_present_freinds.type
     *
     * @mbggenerated
     */
    public Byte getType() {
        return type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.type
     *
     * @param type the value for bjwg_present_freinds.type
     *
     * @mbggenerated
     */
    public void setType(Byte type) {
        this.type = type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.present_relation_id
     *
     * @return the value of bjwg_present_freinds.present_relation_id
     *
     * @mbggenerated
     */
    public Long getPresentRelationId() {
        return presentRelationId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.present_relation_id
     *
     * @param presentRelationId the value for bjwg_present_freinds.present_relation_id
     *
     * @mbggenerated
     */
    public void setPresentRelationId(Long presentRelationId) {
        this.presentRelationId = presentRelationId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_present_freinds.presented_relation_id
     *
     * @return the value of bjwg_present_freinds.presented_relation_id
     *
     * @mbggenerated
     */
    public Long getPresentedRelationId() {
        return presentedRelationId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_present_freinds.presented_relation_id
     *
     * @param presentedRelationId the value for bjwg_present_freinds.presented_relation_id
     *
     * @mbggenerated
     */
    public void setPresentedRelationId(Long presentedRelationId) {
        this.presentedRelationId = presentedRelationId;
    }
}