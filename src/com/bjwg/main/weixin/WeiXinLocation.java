package com.bjwg.main.weixin;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bjwg.main.util.StringUtils;

/**
 * 缓存微信公众号推送的位置信息
 * @author Allen
 * @version 创建时间：2015-5-26 下午05:10:10
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class WeiXinLocation {

	public static final Logger  logger = LoggerFactory.getLogger("LOGISTICS-COMPONENT"); 
	
	private static WeiXinLocation weiXinLocation;
	private static Map<String, String[]> locationMap;
	
	private WeiXinLocation(){
		
	}
	
	public static WeiXinLocation getInstance(){
		
		try {
			
			if(weiXinLocation == null){
				
				weiXinLocation = new WeiXinLocation();
				
				locationMap = new HashMap<String, String[]>();
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("缓存微信公众号推送的位置信息 初始化失败",e);
		}
		
		return weiXinLocation;
	}

	public Map<String, String[]> getLocationMap() {
		return locationMap;
	}

	public void setLocationMap(Map<String, String[]> locationMap) {
		this.locationMap = locationMap;
	}
	
	/**
	 * 获取微信用户的地理位置
	 * @param openid
	 * @return
	 */
	public String[] getLocations(String openid){
		
		if(StringUtils.isNotEmpty(openid) && locationMap.containsKey(openid.trim())){
			
			return locationMap.get(openid.trim());
		}
		
		return null;
	}
	
	/**
	 * 存放微信用户的地理位置
	 * @param openid
	 * @return
	 */
	public void setLocations(String openid,String longtitude,String latitude){
		
		String[] s = new String[]{longtitude,latitude};
		locationMap.put(openid.trim(), s);
	}
	
}
