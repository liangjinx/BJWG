package com.bjwg.main.cache;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.bjwg.main.model.Provalue;

/**
 * @author Allen
 * @version 创建时间：2015-10-7 下午03:17:53
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public class ProvalueCache {

	private static Map<String, Provalue> provalueMap;
	
	
	private ProvalueCache(){
		
	}
	
	/**
	 * 添加/更新缓存
	 */
	public static void put(String proName,String proValue,Date ctime,String key){
		
		Provalue provalue = null;
		if(provalueMap == null){
			
			provalueMap = new HashMap<String, Provalue>();
			
			provalue = new Provalue();
		}else if(provalueMap.containsKey(key)){
			
			provalue = provalueMap.get(key);
		}else{
			
			provalue = new Provalue();
		}
		provalue.setCtime(ctime);
		provalue.setProName(proName);
		provalue.setProValue(proValue);
		
		provalueMap.put(key, provalue);
	}
	/**
	 * 删除缓存
	 * @param phone
	 * @param code
	 */
	public static void remove(String key){
		
		if(provalueMap != null && provalueMap.containsKey(key)){
			
			provalueMap.remove(key);
		}
	}

	public static Provalue getProvalue(String key) {
		return (provalueMap != null ? provalueMap.get(key) : null);
	}

	public static Map<String, Provalue> getProvalueMap() {
		return provalueMap;
	}
}
