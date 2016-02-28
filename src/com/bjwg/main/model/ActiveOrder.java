package com.bjwg.main.model;

import java.math.BigDecimal;

import com.bjwg.main.base.BaseVo;

public class ActiveOrder extends BaseVo{
	//订单Id
    private Long orderId;
    //订单号
    private String orderCode;
    //关联Id
    private Long userId;
    //单价
    private BigDecimal price;
    //数量
    private short count;
    //总价
    private BigDecimal totalPrice;
    //活动关联Id
    private Long activeId;
   //状态 1为未付款，2为付款成功,
    private byte status;
	public Long getOrderId() {
		return orderId;
	}
	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}
	public String getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public short getCount() {
		return count;
	}
	public void setCount(short count) {
		this.count = count;
	}
	public BigDecimal getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}
	public Long getActiveId() {
		return activeId;
	}
	public void setActiveId(Long activeId) {
		this.activeId = activeId;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
	

	
}
