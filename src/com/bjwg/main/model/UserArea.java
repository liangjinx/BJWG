package com.bjwg.main.model;

import com.bjwg.main.base.BaseVo;

/**
 * @author chen
 * @version 创建时间：2015-4-18 下午02:24:25
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：保存当前用户地址信息
 *	{  
        address: "CN|北京|北京|None|CHINANET|1|None",   #地址  
        content:       #详细内容  
        {  
        address: "北京市",   #简要地址  
        address_detail:      #详细地址信息  
	        {  
	        city: "北京市",        #城市  
	        city_code: 131,       #百度城市代码  
	        district: "",           #区县  
	        province: "北京市",   #省份  
	        street: "",            #街道  
	        street_number: ""    #门址  
	        },  
	        point:               #百度经纬度坐标值  
	        {  
	        x: "116.39564504",  
	        y: "39.92998578"  
	        }  
        },  
        status: 0     #返回状态码  
    }
 */
public class UserArea extends BaseVo{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3455320981190340345L;
	//速度，以米/每秒计
	private String speed;
	//位置精度
	private String accuracy;

	//简要地址
	private String address;
	//省份  
	private String province;
	//城市  
	private String city;
	//百度城市代码 
	private String city_code;
	//区县
	private String district;
	//街道 
	private String street;
	//门址
	private String street_number;
	//经度
	private Double longitude;
	//纬度
	private Double latitude ;
	//返回状态码  
	private String status;
	
	public String getSpeed() {
		return speed;
	}
	public void setSpeed(String speed) {
		this.speed = speed;
	}
	public String getAccuracy() {
		return accuracy;
	}
	public void setAccuracy(String accuracy) {
		this.accuracy = accuracy;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	public String getCity_code() {
		return city_code;
	}
	public void setCity_code(String city_code) {
		this.city_code = city_code;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getStreet_number() {
		return street_number;
	}
	public void setStreet_number(String street_number) {
		this.street_number = street_number;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
