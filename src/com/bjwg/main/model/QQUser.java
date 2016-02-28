package com.bjwg.main.model;

import com.bjwg.main.base.BaseVo;

/**
 * qq用户记录
 * @ClassName: QQUser 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Administrator
 * @date 2015-6-1 下午05:21:35
 */
public class QQUser extends BaseVo{
    /**
	 * 
	 */
	private static final long serialVersionUID = -8129044542429226601L;

	/**
     * 唯一标识
     * @mbggenerated
     */
    private String openid;

    /**
     * 用户id
     * @mbggenerated
     */
    private Long userId;

    /**
     * 昵称
     * @mbggenerated
     */
    private String nickname;

    /**
     * 头像地址
     * @mbggenerated
     */
    private String figureurl;

    /**
     * 头像地址
     * @mbggenerated
     */
    private String figureurl1;

    /**
     * 头像地址
     * @mbggenerated
     */
    private String figureurl2;

    /**
     * 头像地址
     * @mbggenerated
     */
    private String figureurlQq1;

    /**
     * 头像地址
     * @mbggenerated
     */
    private String figureurlQq2;

    /**
     * 是否黄钻vip
     * @mbggenerated
     */
    private Short isYellowVip;

    /**
     * 是否vip
     * @mbggenerated
     */
    private Short vip;

    /**
     * 黄钻vip等级
     * @mbggenerated
     */
    private Short yellowVipLevel;

    /**
     * vip等级
     * @mbggenerated
     */
    private Short vipLevel;

    /**
     * 是否黄钻年vip
     * @mbggenerated
     */
    private Short isYellowYearVip;
    
    /**
     * 非表字段 - 性别
     */
    private Short sex;
    /**
     * 非表字段 - 省份
     */
    private String province;
    /**
     * 非表字段 - 城市
     */
    private String city;
    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.OPENID
     *
     * @return the value of HZD_QQUSER.OPENID
     *
     * @mbggenerated
     */
    public String getOpenid() {
        return openid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.OPENID
     *
     * @param openid the value for HZD_QQUSER.OPENID
     *
     * @mbggenerated
     */
    public void setOpenid(String openid) {
        this.openid = openid == null ? null : openid.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.USER_ID
     *
     * @return the value of HZD_QQUSER.USER_ID
     *
     * @mbggenerated
     */
    public Long getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.USER_ID
     *
     * @param userId the value for HZD_QQUSER.USER_ID
     *
     * @mbggenerated
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.NICKNAME
     *
     * @return the value of HZD_QQUSER.NICKNAME
     *
     * @mbggenerated
     */
    public String getNickname() {
        return nickname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.NICKNAME
     *
     * @param nickname the value for HZD_QQUSER.NICKNAME
     *
     * @mbggenerated
     */
    public void setNickname(String nickname) {
        this.nickname = nickname == null ? null : nickname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.FIGUREURL
     *
     * @return the value of HZD_QQUSER.FIGUREURL
     *
     * @mbggenerated
     */
    public String getFigureurl() {
        return figureurl;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.FIGUREURL
     *
     * @param figureurl the value for HZD_QQUSER.FIGUREURL
     *
     * @mbggenerated
     */
    public void setFigureurl(String figureurl) {
        this.figureurl = figureurl == null ? null : figureurl.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.FIGUREURL_1
     *
     * @return the value of HZD_QQUSER.FIGUREURL_1
     *
     * @mbggenerated
     */
    public String getFigureurl1() {
        return figureurl1;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.FIGUREURL_1
     *
     * @param figureurl1 the value for HZD_QQUSER.FIGUREURL_1
     *
     * @mbggenerated
     */
    public void setFigureurl1(String figureurl1) {
        this.figureurl1 = figureurl1 == null ? null : figureurl1.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.FIGUREURL_2
     *
     * @return the value of HZD_QQUSER.FIGUREURL_2
     *
     * @mbggenerated
     */
    public String getFigureurl2() {
        return figureurl2;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.FIGUREURL_2
     *
     * @param figureurl2 the value for HZD_QQUSER.FIGUREURL_2
     *
     * @mbggenerated
     */
    public void setFigureurl2(String figureurl2) {
        this.figureurl2 = figureurl2 == null ? null : figureurl2.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.FIGUREURL_QQ_1
     *
     * @return the value of HZD_QQUSER.FIGUREURL_QQ_1
     *
     * @mbggenerated
     */
    public String getFigureurlQq1() {
        return figureurlQq1;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.FIGUREURL_QQ_1
     *
     * @param figureurlQq1 the value for HZD_QQUSER.FIGUREURL_QQ_1
     *
     * @mbggenerated
     */
    public void setFigureurlQq1(String figureurlQq1) {
        this.figureurlQq1 = figureurlQq1 == null ? null : figureurlQq1.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.FIGUREURL_QQ_2
     *
     * @return the value of HZD_QQUSER.FIGUREURL_QQ_2
     *
     * @mbggenerated
     */
    public String getFigureurlQq2() {
        return figureurlQq2;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.FIGUREURL_QQ_2
     *
     * @param figureurlQq2 the value for HZD_QQUSER.FIGUREURL_QQ_2
     *
     * @mbggenerated
     */
    public void setFigureurlQq2(String figureurlQq2) {
        this.figureurlQq2 = figureurlQq2 == null ? null : figureurlQq2.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.IS_YELLOW_VIP
     *
     * @return the value of HZD_QQUSER.IS_YELLOW_VIP
     *
     * @mbggenerated
     */
    public Short getIsYellowVip() {
        return isYellowVip;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.IS_YELLOW_VIP
     *
     * @param isYellowVip the value for HZD_QQUSER.IS_YELLOW_VIP
     *
     * @mbggenerated
     */
    public void setIsYellowVip(Short isYellowVip) {
        this.isYellowVip = isYellowVip;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.VIP
     *
     * @return the value of HZD_QQUSER.VIP
     *
     * @mbggenerated
     */
    public Short getVip() {
        return vip;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.VIP
     *
     * @param vip the value for HZD_QQUSER.VIP
     *
     * @mbggenerated
     */
    public void setVip(Short vip) {
        this.vip = vip;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.YELLOW_VIP_LEVEL
     *
     * @return the value of HZD_QQUSER.YELLOW_VIP_LEVEL
     *
     * @mbggenerated
     */
    public Short getYellowVipLevel() {
        return yellowVipLevel;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.YELLOW_VIP_LEVEL
     *
     * @param yellowVipLevel the value for HZD_QQUSER.YELLOW_VIP_LEVEL
     *
     * @mbggenerated
     */
    public void setYellowVipLevel(Short yellowVipLevel) {
        this.yellowVipLevel = yellowVipLevel;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.VIP_LEVEL
     *
     * @return the value of HZD_QQUSER.VIP_LEVEL
     *
     * @mbggenerated
     */
    public Short getVipLevel() {
        return vipLevel;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.VIP_LEVEL
     *
     * @param vipLevel the value for HZD_QQUSER.VIP_LEVEL
     *
     * @mbggenerated
     */
    public void setVipLevel(Short vipLevel) {
        this.vipLevel = vipLevel;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column HZD_QQUSER.IS_YELLOW_YEAR_VIP
     *
     * @return the value of HZD_QQUSER.IS_YELLOW_YEAR_VIP
     *
     * @mbggenerated
     */
    public Short getIsYellowYearVip() {
        return isYellowYearVip;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column HZD_QQUSER.IS_YELLOW_YEAR_VIP
     *
     * @param isYellowYearVip the value for HZD_QQUSER.IS_YELLOW_YEAR_VIP
     *
     * @mbggenerated
     */
    public void setIsYellowYearVip(Short isYellowYearVip) {
        this.isYellowYearVip = isYellowYearVip;
    }

	public Short getSex() {
		return sex;
	}

	public void setSex(Short sex) {
		this.sex = sex;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
}