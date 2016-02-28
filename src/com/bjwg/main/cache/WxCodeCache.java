package com.bjwg.main.cache;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.StringUtils;

/**
 * 微信网页授权code对应微信用户信息缓存
 * @author Allen
 * @version 创建时间：2015-10-13 上午11:08:14
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class WxCodeCache {
	
	private static Map<String, WeiXinUser> dataMap;
	
//	"access_token":"OezXcEiiBSKSxW0eoylIeJu8-rIkhWG-UyWWz2fdK9Q4AZlYHcUGYMBAymFAMn6C2QjVAHVOLKW650mf5g3WFLvsEFSNNo8KZh-jFi9xWiihMwYahaDLguohu2kheGk7rqGwXJf3lMS3VfdSOztZOw",
//	"expires_in":7200,
//	"refresh_token":"OezXcEiiBSKSxW0eoylIeJu8-rIkhWG-UyWWz2fdK9Q4AZlYHcUGYMBAymFAMn6Cl8MlqkUitUzppVL5n3rdLjVml-L9INw0KcJwEudzlpBy1u-Bi8KS2Pfw0xlBcKtNdDTV3tA9hU7CbWyw89qnaQ",
//	"openid":"oAFKhs7Z-GhUKQK3TqRCQMUxFxw8","scope":"snsapi_userinfo","unionid":"oNFUrwOKz9YsRhCexaTKNIh659EA"
	
	private WxCodeCache(){
		
	}
	/**
	 * 添加/更新缓存
	 */
	public static void put(String code,WeiXinUser weiXinUser){
		
		if(dataMap == null){
			
			dataMap = new HashMap<String, WeiXinUser>();
		}
		
		
		if(StringUtils.isNotEmpty(code) && !dataMap.containsKey(code)){
			
			weiXinUser.setCtime(new Date());
			
			dataMap.put(code, weiXinUser);
			
			ConsoleUtil.println("WxCodeCache缓存数据：code->"+code +",openid->"+weiXinUser.getOpenid() +",weiXinUser->"+weiXinUser);
		}
		
	}
	/**
	 * 删除缓存
	 * @param phone
	 * @param code
	 */
	public static void remove(String code){
		
		if(dataMap != null){
			
			dataMap.remove(code);
		}
	}
	
	
	public static WeiXinUser getWxUser(String code) {
		
		return dataMap != null ? dataMap.get(code) : null;
	}
	
	public static Map<String, WeiXinUser> getDataMap() {
		
		return dataMap;
	}

	

}
