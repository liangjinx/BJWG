package com.bjwg.main.model;


import com.bjwg.main.base.BaseVo;

public class ActiveWinning extends BaseVo{
	private Long winningId;
	private Long userId;
	private String realName;
	private String phone;
	private Long winningCode;
	private Long activeId;
	
	
	public Long getWinningId() {
		return winningId;
	}
	public void setWinningId(Long winningId) {
		this.winningId = winningId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Long getWinningCode() {
		return winningCode;
	}
	public void setWinningCode(Long winningCode) {
		this.winningCode = winningCode;
	}
	public Long getActiveId() {
		return activeId;
	}
	public void setActiveId(Long activeId) {
		this.activeId = activeId;
	}
	
	
	
	
}
