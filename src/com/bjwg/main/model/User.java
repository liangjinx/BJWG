package com.bjwg.main.model;

import java.util.Date;

import com.bjwg.main.base.BaseVo;
/**
 * 用户记录
 * @ClassName: User 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Administrator
 * @date 2015-9-10 下午08:18:45
 */
public class User extends BaseVo{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2405979836697895032L;

	/**
     * 
     * @mbggenerated
     */
    private Long userId;

    /**
     * 用户名称
     * @mbggenerated
     */
    private String username;

    /**
     * 昵称
     * @mbggenerated
     */
    private String nickname;

    /**
     * 密码
     * @mbggenerated
     */
    private String password;

    /**
     * 邮箱
     * @mbggenerated
     */
    private String email;

    /**
     * 性别 1-男性，2-女性，0-未知
     * @mbggenerated
     */
    private Byte sex;

    /**
     * 手机
     * @mbggenerated
     */
    private String phone;

    /**
     * 注册时间
     * @mbggenerated
     */
    private Date registerTime;

    /**
     *
     * @mbggenerated
     */
    private Long registerIp;

    /**
     * 登录时间
     * @mbggenerated
     */
    private Date lastLoginTime;

    /**
    *
     * @mbggenerated
     */
    private Long lastLoginIp;

    /**
     * 状态 默认为1表示正常 0表示禁用
     * @mbggenerated
     */
    private Byte status;

    /**
     * 头像
     * @mbggenerated
     */
    private String headImg;

    /**
     * 省份
     * @mbggenerated
     */
    private String province;

    /**
     * 城市
     * @mbggenerated
     */
    private String city;

    /**
     * 国家
     * @mbggenerated
     */
    private String country;

    /**
     * 来源(1:微信端 2:pc端3：android端 4:ios端) 见SourceConstant
     * @mbggenerated
     */
    private Byte source;

    /**
     * 邀请码
     * @mbggenerated
     */
    private String inviteCode;

    /**
     * 二维码
     * @mbggenerated
     */
    private String qrCode;
    
    /**
     * 扩展字段
     */
    private Integer extend1;
    /**
     * 扩展字段
     */
    private String extend2;
    
    /**
     * 扩展字段  企业营业执照
     */
    private String businessLicense;
    
    /**
     * 扩展字段  法人
     */
    private String legalperson;

    /**
      * 扩展字段   地址
     */
    private String address;
    

    
    /*
     * 标记(1:个人用户登录  2:企业用户登录)
     * 
     */
   private byte flag;


    
    
   
    
    
	public String getBusinessLicense() {
	return businessLicense;
}

public void setBusinessLicense(String businessLicense) {
	this.businessLicense = businessLicense;
}

public String getLegalperson() {
	return legalperson;
}

public void setLegalperson(String legalperson) {
	this.legalperson = legalperson;
}

public String getAddress() {
	return address;
}

public void setAddress(String address) {
	this.address = address;
}

	public byte getFlag() {
	return flag;
}

public void setFlag(byte flag) {
	this.flag = flag;
}

	public Integer getExtend1() {
		return extend1;
	}

	public void setExtend1(Integer extend1) {
		this.extend1 = extend1;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.user_id
     *
     * @return the value of bjwg_user.user_id
     *
     * @mbggenerated
     */
    public Long getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.user_id
     *
     * @param userId the value for bjwg_user.user_id
     *
     * @mbggenerated
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.username
     *
     * @return the value of bjwg_user.username
     *
     * @mbggenerated
     */
    public String getUsername() {
        return username;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.username
     *
     * @param username the value for bjwg_user.username
     *
     * @mbggenerated
     */
    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.nickname
     *
     * @return the value of bjwg_user.nickname
     *
     * @mbggenerated
     */
    public String getNickname() {
        return nickname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.nickname
     *
     * @param nickname the value for bjwg_user.nickname
     *
     * @mbggenerated
     */
    public void setNickname(String nickname) {
        this.nickname = nickname == null ? null : nickname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.password
     *
     * @return the value of bjwg_user.password
     *
     * @mbggenerated
     */
    public String getPassword() {
        return password;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.password
     *
     * @param password the value for bjwg_user.password
     *
     * @mbggenerated
     */
    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.email
     *
     * @return the value of bjwg_user.email
     *
     * @mbggenerated
     */
    public String getEmail() {
        return email;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.email
     *
     * @param email the value for bjwg_user.email
     *
     * @mbggenerated
     */
    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.sex
     *
     * @return the value of bjwg_user.sex
     *
     * @mbggenerated
     */
    public Byte getSex() {
        return sex;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.sex
     *
     * @param sex the value for bjwg_user.sex
     *
     * @mbggenerated
     */
    public void setSex(Byte sex) {
        this.sex = sex;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.phone
     *
     * @return the value of bjwg_user.phone
     *
     * @mbggenerated
     */
    public String getPhone() {
        return phone;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.phone
     *
     * @param phone the value for bjwg_user.phone
     *
     * @mbggenerated
     */
    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.register_time
     *
     * @return the value of bjwg_user.register_time
     *
     * @mbggenerated
     */
    public Date getRegisterTime() {
        return registerTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.register_time
     *
     * @param registerTime the value for bjwg_user.register_time
     *
     * @mbggenerated
     */
    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.register_ip
     *
     * @return the value of bjwg_user.register_ip
     *
     * @mbggenerated
     */
    public Long getRegisterIp() {
        return registerIp;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.register_ip
     *
     * @param registerIp the value for bjwg_user.register_ip
     *
     * @mbggenerated
     */
    public void setRegisterIp(Long registerIp) {
        this.registerIp = registerIp;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.last_login_time
     *
     * @return the value of bjwg_user.last_login_time
     *
     * @mbggenerated
     */
    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.last_login_time
     *
     * @param lastLoginTime the value for bjwg_user.last_login_time
     *
     * @mbggenerated
     */
    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.last_login_ip
     *
     * @return the value of bjwg_user.last_login_ip
     *
     * @mbggenerated
     */
    public Long getLastLoginIp() {
        return lastLoginIp;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.last_login_ip
     *
     * @param lastLoginIp the value for bjwg_user.last_login_ip
     *
     * @mbggenerated
     */
    public void setLastLoginIp(Long lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.status
     *
     * @return the value of bjwg_user.status
     *
     * @mbggenerated
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.status
     *
     * @param status the value for bjwg_user.status
     *
     * @mbggenerated
     */
    public void setStatus(Byte status) {
        this.status = status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.head_img
     *
     * @return the value of bjwg_user.head_img
     *
     * @mbggenerated
     */
    public String getHeadImg() {
        return headImg;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.head_img
     *
     * @param headImg the value for bjwg_user.head_img
     *
     * @mbggenerated
     */
    public void setHeadImg(String headImg) {
        this.headImg = headImg == null ? null : headImg.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.province
     *
     * @return the value of bjwg_user.province
     *
     * @mbggenerated
     */
    public String getProvince() {
        return province;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.province
     *
     * @param province the value for bjwg_user.province
     *
     * @mbggenerated
     */
    public void setProvince(String province) {
        this.province = province == null ? null : province.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.city
     *
     * @return the value of bjwg_user.city
     *
     * @mbggenerated
     */
    public String getCity() {
        return city;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.city
     *
     * @param city the value for bjwg_user.city
     *
     * @mbggenerated
     */
    public void setCity(String city) {
        this.city = city == null ? null : city.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.country
     *
     * @return the value of bjwg_user.country
     *
     * @mbggenerated
     */
    public String getCountry() {
        return country;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.country
     *
     * @param country the value for bjwg_user.country
     *
     * @mbggenerated
     */
    public void setCountry(String country) {
        this.country = country == null ? null : country.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.source
     *
     * @return the value of bjwg_user.source
     *
     * @mbggenerated
     */
    public Byte getSource() {
        return source;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.source
     *
     * @param source the value for bjwg_user.source
     *
     * @mbggenerated
     */
    public void setSource(Byte source) {
        this.source = source;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.invite_code
     *
     * @return the value of bjwg_user.invite_code
     *
     * @mbggenerated
     */
    public String getInviteCode() {
        return inviteCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.invite_code
     *
     * @param inviteCode the value for bjwg_user.invite_code
     *
     * @mbggenerated
     */
    public void setInviteCode(String inviteCode) {
        this.inviteCode = inviteCode == null ? null : inviteCode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_user.qr_code
     *
     * @return the value of bjwg_user.qr_code
     *
     * @mbggenerated
     */
    public String getQrCode() {
        return qrCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_user.qr_code
     *
     * @param qrCode the value for bjwg_user.qr_code
     *
     * @mbggenerated
     */
    public void setQrCode(String qrCode) {
        this.qrCode = qrCode == null ? null : qrCode.trim();
    }

	public String getExtend2() {
		return extend2;
	}

	public void setExtend2(String extend2) {
		this.extend2 = extend2;
	}
}