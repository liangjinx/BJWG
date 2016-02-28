package com.bjwg.main.model;

import java.util.Date;

import com.bjwg.main.base.BaseVo;
/**
 * 企业用户记录
 * @ClassName: User 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Administrator
 * @date 2015-9-10 下午08:18:45
 */
public class epUser extends BaseVo{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 企业用户 id
	 */
	private Long userId;
	/**
	 * 企业法人
	 */
	private String legalperson;
	
	/**
	 * 企业地址
	 */
	private String address;
	/**
	 * 企业营业执照
	 */
	private String businessLicense;

	
	
	
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
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
	public String getBusinessLicense() {
		return businessLicense;
	}
	public void setBusinessLicense(String businessLicense) {
		this.businessLicense = businessLicense;
	}
	

	
}