package com.bjwg.main.util;

import java.util.HashMap;
import java.util.Map;

/**
 * @author chen
 * @version 创建时间：2015-4-29 上午09:30:45
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public class ShopTelMananer {
	
	private static ShopTelMananer instance;
	
	//
	private Map<Long,String> loginList = new HashMap<Long,String>();
	
	private ShopTelMananer(){
		
	}
	
	public static ShopTelMananer getInstance(){
		
		if(instance == null){
			try {
				
				instance = new ShopTelMananer();
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
		
		return instance;
	}
	
	public Map<Long, String> getLoginList() {
		return loginList;
	}

	public void setLoginList(Map<Long, String> loginList) {
		this.loginList = loginList;
	}

	//载入缓存 
	public synchronized void putCache(Long key, String obj) 
	{ 
		Map<Long,String> map = ShopTelMananer.getInstance().getLoginList();
		
		if(!map.containsKey(key))
		{
			loginList.put(key, obj);
		}
		 
	} 
	
	/**
	 * 来源的验证
	 * @return
	 */
	public static String  checkIsLogin(Long shop_id , String referer ,String host){
		
		Map<Long,String> map = ShopTelMananer.getInstance().getLoginList();
		
		if(!MyUtils.isMapEmpty(map) && StringUtils.isNotEmpty(shop_id.toString())){
			
			if(map.containsKey(shop_id)){
				
				String newSecretKey = host; //"m.hzd.com";
				//状态匹配了
				if( referer.contains( newSecretKey ) ){
					
					String tel = map.get(shop_id);
					
					return tel;
				}
				
			}
			
			return null;
			
		}
		
		return null;
	}

}
