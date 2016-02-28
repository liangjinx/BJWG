package com.bjwg.main.cache;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bjwg.main.constant.VerifyCodeConstant;

/**
 * @author jun
 * @version 创建时间：2015-7-22 下午06:03:53
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：手机验证码缓存
 */
public class PhoneCodeCache {
	private static Map<String,Map<String,Object>> phoneCacheRegister;//注册验证码
	private static Map<String,Map<String,Object>> phoneCachePassword;//找回密码验证码
	private static Map<String,Map<String,Object>> phoneCacheOld;//修改手机号发送的旧手机的验证码
	private static Map<String,Map<String,Object>> phoneCacheNew;//修改手机号发送的新手机的验证码
	
	
	/**
	 * 获取缓存
	 * @return
	 */
	public static List<Map<String,Map<String,Object>>> getCache(){
		if(phoneCacheRegister==null)phoneCacheRegister=new HashMap<String,Map<String,Object>>();
		if(phoneCachePassword==null)phoneCachePassword=new HashMap<String,Map<String,Object>>();
		if(phoneCacheOld==null)phoneCacheOld=new HashMap<String,Map<String,Object>>();
		if(phoneCacheNew==null)phoneCacheNew=new HashMap<String,Map<String,Object>>();
		List<Map<String,Map<String,Object>>> l=new ArrayList<Map<String,Map<String,Object>>>();
		l.add(phoneCacheRegister);
		l.add(phoneCachePassword);
		l.add(phoneCacheOld);
		l.add(phoneCacheNew);
		return l;
	}
	/**
	 * 获取缓存
	 * @return
	 */
	public static Map<String,Object> getCache(short type,String phone){
		Map<String,Object> map = null;
		switch(type){
			case VerifyCodeConstant.VERIFY_CODE_REGISTER:{
				if(phoneCacheRegister==null){
					break;
				}
				map = phoneCacheRegister.get(phone);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PASSWORD:{
				if(phoneCachePassword==null){
					break;
				}
				map=phoneCachePassword.get(phone);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_BINDING:{
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW:{
				if(phoneCacheNew==null){
					break;
				}
				map = phoneCacheNew.get(phone);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD:{
				if(phoneCacheOld==null){
					break;
				}
				map = phoneCacheOld.get(phone);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_UNBINDING:{
				break;
			}
			default:break;
		}
		return map;
	}
	
	/**
	 * 添加缓存
	 * @param phone
	 * @param code
	 */
	public static void put(String phone,String code,short type){
		switch(type){
			case VerifyCodeConstant.VERIFY_CODE_REGISTER:{
				if(phoneCacheRegister==null)phoneCacheRegister=new HashMap<String,Map<String,Object>>();
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("code", code);
				map.put("time", System.currentTimeMillis());
				phoneCacheRegister.put(phone, map);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PASSWORD:{
				if(phoneCachePassword==null)phoneCachePassword=new HashMap<String,Map<String,Object>>();
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("code", code);
				map.put("time", System.currentTimeMillis());
				phoneCachePassword.put(phone, map);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_BINDING:{
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW:{
				if(phoneCacheNew==null)phoneCacheNew=new HashMap<String,Map<String,Object>>();
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("code", code);
				map.put("time", System.currentTimeMillis());
				phoneCacheNew.put(phone, map);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD:{
				if(phoneCacheOld==null)phoneCacheOld=new HashMap<String,Map<String,Object>>();
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("code", code);
				map.put("time", System.currentTimeMillis());
				phoneCacheOld.put(phone, map);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_UNBINDING:{
				break;
			}
			default:break;
		}
		
	}
	
	/**
	 * 删除缓存
	 * @param phone
	 */
	public static void delete(String phone,short type){
		switch(type){
			case VerifyCodeConstant.VERIFY_CODE_REGISTER:{
				if(phoneCacheRegister==null)phoneCacheRegister=new HashMap<String,Map<String,Object>>();
				if(phoneCacheRegister.containsKey(phone))phoneCacheRegister.remove(phone);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PASSWORD:{
				if(phoneCachePassword==null)phoneCachePassword=new HashMap<String,Map<String,Object>>();
				if(phoneCachePassword.containsKey(phone))phoneCachePassword.remove(phone);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_BINDING:{
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW:{
				if(phoneCacheNew==null)phoneCacheNew=new HashMap<String,Map<String,Object>>();
				if(phoneCacheNew.containsKey(phone))phoneCacheNew.remove(phone);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD:{
				if(phoneCacheOld==null)phoneCacheOld=new HashMap<String,Map<String,Object>>();
				if(phoneCacheOld.containsKey(phone))phoneCacheOld.remove(phone);
				break;
			}
			case VerifyCodeConstant.VERIFY_CODE_UNBINDING:{
				break;
			}
			default:break;
		}
		
	}
	
	/**
	 * 获得缓存手机验证码
	 * @param phone
	 * @return
	 */
	public static String getCode(String phone,short type){
		switch(type){
			case VerifyCodeConstant.VERIFY_CODE_REGISTER:{
				if(phoneCacheRegister==null)phoneCacheRegister=new HashMap<String,Map<String,Object>>();
				Map<String,Object> map=phoneCacheRegister.get(phone);
				if(map==null)return null;
				return (String)map.get("code");
			}
			case VerifyCodeConstant.VERIFY_CODE_PASSWORD:{
				if(phoneCachePassword==null)phoneCachePassword=new HashMap<String,Map<String,Object>>();
				Map<String,Object> map=phoneCachePassword.get(phone);
				if(map==null)return null;
				return (String)map.get("code");
			}
			case VerifyCodeConstant.VERIFY_CODE_BINDING:{
				return null;
			}
			case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW:{
				if(phoneCacheNew==null)phoneCacheNew=new HashMap<String,Map<String,Object>>();
				Map<String,Object> map=phoneCacheNew.get(phone);
				if(map==null)return null;
				return (String)map.get("code");
			}
			case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD:{
				if(phoneCacheOld==null)phoneCacheOld=new HashMap<String,Map<String,Object>>();
				Map<String,Object> map=phoneCacheOld.get(phone);
				if(map==null)return null;
				return (String)map.get("code");
			}
			case VerifyCodeConstant.VERIFY_CODE_UNBINDING:{
				return null;
			}
			default:return null;
		}
		
	}
	
}
