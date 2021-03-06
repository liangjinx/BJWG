package com.bjwg.main.model;

import java.math.BigDecimal;

import com.bjwg.main.base.BaseVo;

/**
 * 店铺
 * @ClassName: Shop 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Administrator
 * @date 2015-9-18 下午05:13:35
 */
public class Shop extends BaseVo{
    /**
	 * 
	 */
	private static final long serialVersionUID = 3659946323908656630L;

	/**
     *
     * @mbggenerated
     */
    private Long shopId;

    /**
     * 店名
     * @mbggenerated
     */
    private String name;

    /**
     * 所在省份
     * @mbggenerated
     */
    private Long province;

    /**
     * 所在城市
     * @mbggenerated
     */
    private Long city;

    /**
     * 具体地址
     * @mbggenerated
     */
    private String address;

    /**
     * 纬度
     * @mbggenerated
     */
    private BigDecimal latitude;

    /**
     * 经度
     * @mbggenerated
     */
    private BigDecimal longitude;

    /**
     * logo
     * @mbggenerated
     */
    private String logo;

    /**
     * 状态
     * @mbggenerated
     */
    private Byte status;

    /**
     * 备注
     * @mbggenerated
     */
    private String remark;
    
    /**
     * 自定义 - 距离
     */
    private String distance;
    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.shop_id
     *
     * @return the value of bjwg_shop.shop_id
     *
     * @mbggenerated
     */
    public Long getShopId() {
        return shopId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.shop_id
     *
     * @param shopId the value for bjwg_shop.shop_id
     *
     * @mbggenerated
     */
    public void setShopId(Long shopId) {
        this.shopId = shopId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.name
     *
     * @return the value of bjwg_shop.name
     *
     * @mbggenerated
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.name
     *
     * @param name the value for bjwg_shop.name
     *
     * @mbggenerated
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.province
     *
     * @return the value of bjwg_shop.province
     *
     * @mbggenerated
     */
    public Long getProvince() {
        return province;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.province
     *
     * @param province the value for bjwg_shop.province
     *
     * @mbggenerated
     */
    public void setProvince(Long province) {
        this.province = province;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.city
     *
     * @return the value of bjwg_shop.city
     *
     * @mbggenerated
     */
    public Long getCity() {
        return city;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.city
     *
     * @param city the value for bjwg_shop.city
     *
     * @mbggenerated
     */
    public void setCity(Long city) {
        this.city = city;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.address
     *
     * @return the value of bjwg_shop.address
     *
     * @mbggenerated
     */
    public String getAddress() {
        return address;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.address
     *
     * @param address the value for bjwg_shop.address
     *
     * @mbggenerated
     */
    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.latitude
     *
     * @return the value of bjwg_shop.latitude
     *
     * @mbggenerated
     */
    public BigDecimal getLatitude() {
        return latitude;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.latitude
     *
     * @param latitude the value for bjwg_shop.latitude
     *
     * @mbggenerated
     */
    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.longitude
     *
     * @return the value of bjwg_shop.longitude
     *
     * @mbggenerated
     */
    public BigDecimal getLongitude() {
        return longitude;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.longitude
     *
     * @param longitude the value for bjwg_shop.longitude
     *
     * @mbggenerated
     */
    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.logo
     *
     * @return the value of bjwg_shop.logo
     *
     * @mbggenerated
     */
    public String getLogo() {
        return logo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.logo
     *
     * @param logo the value for bjwg_shop.logo
     *
     * @mbggenerated
     */
    public void setLogo(String logo) {
        this.logo = logo == null ? null : logo.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.status
     *
     * @return the value of bjwg_shop.status
     *
     * @mbggenerated
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.status
     *
     * @param status the value for bjwg_shop.status
     *
     * @mbggenerated
     */
    public void setStatus(Byte status) {
        this.status = status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_shop.remark
     *
     * @return the value of bjwg_shop.remark
     *
     * @mbggenerated
     */
    public String getRemark() {
        return remark;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_shop.remark
     *
     * @param remark the value for bjwg_shop.remark
     *
     * @mbggenerated
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

	public String getDistance() {
		return distance;
	}

	public void setDistance(String distance) {
		this.distance = distance;
	}
}