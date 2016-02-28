package com.bjwg.main.test;

import com.bjwg.main.util.ConsoleUtil;

/**
 * @author chen
 * @version 创建时间：2015-4-3 下午04:56:01
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public class Parent {

	private String areaCode;//区号  
    private String phoneNumber;//电话号码  
    
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
    
    public static void main(String[] args) {
    	String test = "DDDDeerretex3";
		ConsoleUtil.println(test.toLowerCase());
	}
}
