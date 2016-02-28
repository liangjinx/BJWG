package com.bjwg.main.model;

import java.math.BigDecimal;

import com.bjwg.main.base.BaseVo;

public class Active extends BaseVo{

	//产品ID
	private Long activeId;
	
	//产品品牌
	private String brand;
	//产品名称
	private String name;
	//产品重量
	private String weight;
	//产品价格
	private BigDecimal price;
	//产品说明
	private String declares;
	//简介
	private String intro;
	
	
	public Long getActiveId() {
		return activeId;
	}
	public void setActiveId(Long activeId) {
		this.activeId = activeId;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getDeclares() {
		return declares;
	}
	public void setDeclares(String declares) {
		this.declares = declares;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	
	

	
}
