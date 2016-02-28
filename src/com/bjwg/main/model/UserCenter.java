package com.bjwg.main.model;

import java.math.BigDecimal;

/**
 * 用户中心基本数据
 * @author Allen
 * @version 创建时间：2015-6-10 下午04:41:39
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class UserCenter {

	/**
	 * 余额
	 */
	private BigDecimal walletMoney;
	/**
	 * 猪仔数
	 */
	private Integer pigNumber;
	/**
	 * 总收益
	 */
	private BigDecimal earnings;
	
	/**
	 * 消息数
	 */
	private Integer msgNum;
	/**
	 * 未读消息数
	 */
	private Integer msgUnReadNum;
	
	
	public Integer getMsgNum() {
		return msgNum;
	}
	public void setMsgNum(Integer msgNum) {
		this.msgNum = msgNum;
	}
	public Integer getMsgUnReadNum() {
		return msgUnReadNum;
	}
	public void setMsgUnReadNum(Integer msgUnReadNum) {
		this.msgUnReadNum = msgUnReadNum;
	}
	public Integer getPigNumber() {
		return pigNumber;
	}
	public void setPigNumber(Integer pigNumber) {
		this.pigNumber = pigNumber;
	}
	public BigDecimal getEarnings() {
		return earnings;
	}
	public void setEarnings(BigDecimal earnings) {
		this.earnings = earnings;
	}
	public BigDecimal getWalletMoney() {
		return walletMoney;
	}
	public void setWalletMoney(BigDecimal walletMoney) {
		this.walletMoney = walletMoney;
	}
}
