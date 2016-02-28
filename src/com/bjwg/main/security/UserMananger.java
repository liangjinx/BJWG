package com.bjwg.main.security;

import java.security.SecureRandom;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.RandomUtils;

/**
 * 登录用户管理类(分手机端和微信、pc端) 
 * @author :Allen  
 * @CreateDate : 2015-3-20 上午11:07:33 
 * @lastModified : 2015-3-20 上午11:07:33 
 * @version : 1.0
 * @jdk：1.6
 * 说明：用户登录缓存数据 有专门的定时任务UserCacheTask在清理
 */
public class UserMananger
{
	private static UserMananger instance;
	
	//单位小时
	public static final Integer EXPIRED_HOUR = 12;
	
	//DriverId to UserLoginModel(手机端)
	private Map<String, UserLoginModel> userLoginModelPhoneMap = new HashMap<String, UserLoginModel>();
	//token to UserLoginModel(微信端和pc端)
	private Map<String, UserLoginModel> userLoginModelMap = new HashMap<String, UserLoginModel>();
	
	private UserMananger(){}
	
	public static UserMananger getInst(){
		
		if(instance == null){
			try {
				
				instance = new UserMananger();
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
		
		return instance;
	}
	
	public void setPhoneLoginList(Map<String, UserLoginModel> loginList) 
	{	
		this.userLoginModelPhoneMap = loginList;
	}
	public void setLoginList(Map<String, UserLoginModel> loginList) 
	{	
		this.userLoginModelMap = loginList;
	}
	public Map<String, UserLoginModel> getPhoneLoginList() 
	{	
		return this.userLoginModelPhoneMap;
	}
	public Map<String, UserLoginModel> getLoginList() 
	{	
		return this.userLoginModelMap;
	}

	/**
	 * 检测用户是否已登录
	 * 如果当前是登录状态则刷新超时时间
	 * @param secret_key
	 * @return
	 
	public boolean checkIsLogin(String driverId, String token)
	{
		ConsoleUtil.println("是否有driverId："+userLoginModelPhoneMap.containsKey(driverId));
		
		if(userLoginModelPhoneMap.containsKey(driverId))
		{
			UserLoginModel model = userLoginModelPhoneMap.get(driverId);
			
			ConsoleUtil.println("token是否匹配："+model.getToken().equals(token));
			
			if(model.getToken().equals(token))
			{
				ConsoleUtil.println("token是否过期："+(new Date().compareTo(model.getExpiredTime()) == 1));
				
				if(new Date().compareTo(model.getExpiredTime()) == 1)
				{
					ConsoleUtil.println("token timeout");
					
					//过期移除
					userLoginModelPhoneMap.remove(driverId);
					return false;
				}
				
				//已登录刷新过期时间
				model.setExpiredTime(MyUtils.addDate(new Date(), EXPIRED_HOUR));
				
				userLoginModelPhoneMap.put(driverId, model);
				
				return true;
			}
			ConsoleUtil.println("token not match");
			return false;
		}
		ConsoleUtil.println("token not found");
		return false;
	}
	*/
	/**
	 * 设置登录用户缓存（微信、pc端）
	 * @return
	 */
	public String add(Long userId, String username, String phone,String nickname,Byte sex,String headImg,String inviteCode,String qrCode,String openId)
	{
		ConsoleUtil.println("token----1");
		String token = generateToken(64);
		ConsoleUtil.println("token----2"+token +"，openid："+openId);
		UserLoginModel model = new UserLoginModel();
		model.setDriverId(null);
		model.setUserId(userId);
		model.setUsername(username);
		model.setBindPhone(phone);
		model.setToken(token);
		model.setExpiredTime(MyUtils.addDate(new Date(), EXPIRED_HOUR));
		model.setNickname(nickname);
		model.setSex(sex);
		model.setHeadImg(headImg);
		model.setInviteCode(inviteCode);
		model.setQrCode(qrCode);
		model.setOpenId(openId);
		userLoginModelMap.put(token, model);
		
		return token;
	}
	/**
	 * 设置登录用户缓存（手机端）
	 * @return
	 */
	public String addPhone(String driverId, Long userId, String username, String phone,String nickname,Byte sex,String headImg,String inviteCode,String qrCode)
	{
		String token = generateToken(64);
		
		UserLoginModel model = new UserLoginModel();
		model.setDriverId(driverId);
		model.setUserId(userId);
		model.setUsername(username);
		model.setBindPhone(phone);
		model.setToken(token);
		model.setExpiredTime(MyUtils.addDate(new Date(), EXPIRED_HOUR));
		model.setNickname(nickname);
		model.setSex(sex);
		model.setHeadImg(headImg);
		model.setInviteCode(inviteCode);
		model.setQrCode(qrCode);
		userLoginModelPhoneMap.put(driverId, model);
		
		return token;
	}
	
	/**
	 * 根据driverId获取登录用户缓存（微信、pc端）
	 * @param driverId
	 * @return
	 */
	public UserLoginModel getUser(String token)
	{
		return userLoginModelMap.get(token);
	}
	/**
	 * 更新登录用户缓存（微信、pc端）
	 * @param driverId
	 * @param userLoginModel
	 */
	public void setUser(String token, UserLoginModel userLoginModel)
	{
		userLoginModelMap.put(token, userLoginModel);
	}
	/**
	 * 删除登录用户缓存（微信、pc端）
	 * @param token
	 */
	public void removeUser(String token)
	{
		if(null != userLoginModelMap) {
			
			userLoginModelMap.remove(token);
		}
	}
	
	/**
	 * 根据driverId获取登录用户缓存（手机端）
	 * @param driverId
	 * @return
	 */
	public UserLoginModel getUserPhone(String driverId)
	{
		return userLoginModelPhoneMap.get(driverId);
	}
	/**
	 * 更新登录用户缓存（手机端）
	 * @param driverId
	 * @param userLoginModel
	 */
	public void setUserPhone(String driverId, UserLoginModel userLoginModel)
	{
		userLoginModelPhoneMap.put(driverId, userLoginModel);
	}
	
	/**
	 * 删除登录用户缓存（手机端）
	 * @param driverId
	 */
	public void removeUserPhone(String driverId)
	{
		if(null != userLoginModelPhoneMap) {
			
			userLoginModelPhoneMap.remove(driverId);
		}
	}
	
	/**
	 * 生成token(随机+当前时间)
	 * @param length
	 * @return
	 */
	public static String generateToken(Integer length)
	{
		if(length == null)
			length = 64;
//		SecureRandom secureRandom = new SecureRandom();
//		byte seedBytes[] = secureRandom.generateSeed(length);
//		return byteToHex(seedBytes)+System.currentTimeMillis();
		return RandomUtils.getNumAndWord(64)+System.currentTimeMillis();
	}
	
	private static String byteToHex(byte[] b)
	{
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++)
		{
			stmp = (Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
			{
				hs = hs + "0" + stmp;
			} else
			{
				hs = hs + stmp;
			}
		}
		
		return hs.toUpperCase();
	}
	public static void main(String[] args) throws Exception {
		try {
			
			ConsoleUtil.println(UserMananger.generateToken(10));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}

















