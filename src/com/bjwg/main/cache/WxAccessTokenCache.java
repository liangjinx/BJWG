package com.bjwg.main.cache;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.bjwg.main.model.Provalue;
import com.bjwg.main.util.ConsoleUtil;

/**
 * 微信端access_token缓存，目前未使用到
 * @author Allen
 * @version 创建时间：2015-10-13 上午11:08:14
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class WxAccessTokenCache {
	
	private static Map<String, Object> dataMap;
	
//	"access_token":"OezXcEiiBSKSxW0eoylIeJu8-rIkhWG-UyWWz2fdK9Q4AZlYHcUGYMBAymFAMn6C2QjVAHVOLKW650mf5g3WFLvsEFSNNo8KZh-jFi9xWiihMwYahaDLguohu2kheGk7rqGwXJf3lMS3VfdSOztZOw",
//	"expires_in":7200,
//	"refresh_token":"OezXcEiiBSKSxW0eoylIeJu8-rIkhWG-UyWWz2fdK9Q4AZlYHcUGYMBAymFAMn6Cl8MlqkUitUzppVL5n3rdLjVml-L9INw0KcJwEudzlpBy1u-Bi8KS2Pfw0xlBcKtNdDTV3tA9hU7CbWyw89qnaQ",
//	"openid":"oAFKhs7Z-GhUKQK3TqRCQMUxFxw8","scope":"snsapi_userinfo","unionid":"oNFUrwOKz9YsRhCexaTKNIh659EA"
	
	private WxAccessTokenCache(){
		
	}
	/**
	 * 添加/更新缓存
	 */
	public static void put(String access_token,Integer expires_in,String refresh_token,String openid){
		
		if(dataMap == null){
			
			dataMap = new HashMap<String, Object>();
		}
		
		dataMap.put("access_token", access_token);
		dataMap.put("expires_in", expires_in);
		dataMap.put("refresh_token", refresh_token);
		dataMap.put("openid", openid);
		dataMap.put("time", new Date());
		
		ConsoleUtil.println("WxAccessTokenCache缓存数据：access_token->"+access_token +",expires_in->"+expires_in +",refresh_token->"+refresh_token+",openid->"+openid);
	}
	/**
	 * 删除缓存
	 * @param phone
	 * @param code
	 */
	public static void remove(){
		
		dataMap = null;
	}
	
	
	public static Map<String, Object> getDataMap() {
		
		return dataMap;
	}

	

}
