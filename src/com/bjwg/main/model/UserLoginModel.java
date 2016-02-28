package com.bjwg.main.model;

import java.util.Date;


/**
 * 用户登录管理类
 * @author :Allen  
 * @CreateDate : 2015-3-18 上午11:21:08 
 * @lastModified : 2015-3-18 上午11:21:08 
 * @version : 1.0
 * @jdk：1.6
 */
public class UserLoginModel
{
	//用户id
	private Long userId;
	//用户名
	private String username;
	//密码
//	private String password;
	
	private String token;
	//token过期时间
	private Date expiredTime;
	
	private String driverId;
	
	//账户绑定的手机号
	private String bindPhone;
	
	//敏感操作授权码
	private String authCode;
	//授权码超时时间
	private Date authExpiredTime;
	/**
     * 头像
     * @mbggenerated
     */
    private String headImg;
    /**
     * 昵称
     * @mbggenerated
     */
    private String nickname;
    /**
     * 性别
     * @mbggenerated
     */
    private Byte sex;
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
    
    private String openId;
	

	public String getInviteCode() {
		return inviteCode;
	}

	public void setInviteCode(String inviteCode) {
		this.inviteCode = inviteCode;
	}

	public String getQrCode() {
		return qrCode;
	}

	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}

	public String getAuthCode()
	{
		return authCode;
	}

	public void setAuthCode(String authCode)
	{
		this.authCode = authCode;
	}

	public Date getAuthExpiredTime()
	{
		return authExpiredTime;
	}

	public void setAuthExpiredTime(Date authExpired)
	{
		this.authExpiredTime = authExpired;
	}

	public String getBindPhone()
	{
		return bindPhone;
	}

	public void setBindPhone(String bindPhone)
	{
		this.bindPhone = bindPhone;
	}

	public String getDriverId()
	{
		return driverId;
	}

	public void setDriverId(String driverId)
	{
		this.driverId = driverId;
	}

	public Date getExpiredTime()
	{
		return expiredTime;
	}

	public void setExpiredTime(Date expired)
	{
		expiredTime = expired;
	}

	public UserLoginModel(){}

	public String getToken()
	{
		return token;
	}

	public void setToken(String token)
	{
		this.token = token;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public String getHeadImg() {
		return headImg;
	}

	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public Byte getSex() {
		return sex;
	}

	public void setSex(Byte sex) {
		this.sex = sex;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}
	
	
}
