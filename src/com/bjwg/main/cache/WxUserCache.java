package com.bjwg.main.cache;

import java.util.HashMap;
import java.util.Map;

import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.StringUtils;

/**
 * 微信用户资料信息缓存
 * @author Allen
 * @version 创建时间：2015-10-13 上午11:08:14
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class WxUserCache {
	
	private static Map<String, WeiXinUser> dataMap;
	
//	"access_token":"OezXcEiiBSKSxW0eoylIeJu8-rIkhWG-UyWWz2fdK9Q4AZlYHcUGYMBAymFAMn6C2QjVAHVOLKW650mf5g3WFLvsEFSNNo8KZh-jFi9xWiihMwYahaDLguohu2kheGk7rqGwXJf3lMS3VfdSOztZOw",
//	"expires_in":7200,
//	"refresh_token":"OezXcEiiBSKSxW0eoylIeJu8-rIkhWG-UyWWz2fdK9Q4AZlYHcUGYMBAymFAMn6Cl8MlqkUitUzppVL5n3rdLjVml-L9INw0KcJwEudzlpBy1u-Bi8KS2Pfw0xlBcKtNdDTV3tA9hU7CbWyw89qnaQ",
//	"openid":"oAFKhs7Z-GhUKQK3TqRCQMUxFxw8","scope":"snsapi_userinfo","unionid":"oNFUrwOKz9YsRhCexaTKNIh659EA"
	
	private WxUserCache(){
		
	}
	/**
	 * 添加/更新缓存
	 */
	public static void put(String unionid,String nickname,String openid,String privilege,String sex,String province,String city,String headImg,String country){
		
		if(dataMap == null){
			
			dataMap = new HashMap<String, WeiXinUser>();
		}
		
		
		if(StringUtils.isNotEmpty(openid) && !dataMap.containsKey(openid)){
			
			WeiXinUser weiXinUser = new WeiXinUser();
			weiXinUser.setNickname(nickname);
			weiXinUser.setOpenid(openid);
			weiXinUser.setPrivilege(privilege);
			weiXinUser.setUnionid(unionid);
			weiXinUser.setSex(sex);
			weiXinUser.setProvince(province);
			weiXinUser.setCity(city);
			weiXinUser.setHeadImg(headImg);
			weiXinUser.setCountry(country);
			
			dataMap.put(openid, weiXinUser);
			
			ConsoleUtil.println("WxUserCache缓存数据：nickname->"+nickname +",openid->"+openid +",unionid->"+unionid);
		}
		
	}
	/**
	 * 删除缓存
	 * @param phone
	 * @param code
	 */
	public static void remove(String openId){
		
		if(dataMap != null){
			
			dataMap.remove(openId);
		}
	}
	
	
	public static WeiXinUser getWxUser(String openid) {
		
		return dataMap != null ? dataMap.get(openid) : null;
	}
	
	public static Map<String, WeiXinUser> getDataMap() {
		
		return dataMap;
	}

	

}
