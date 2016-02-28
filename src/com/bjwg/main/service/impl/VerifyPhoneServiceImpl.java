package com.bjwg.main.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.cache.PhoneCodeCache;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.StatusConstant;
import com.bjwg.main.constant.VerifyCodeConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.dao.UserDao;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserExample;
import com.bjwg.main.model.VerifyPhone;
import com.bjwg.main.service.VerifyPhoneService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.SMSUtil;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ValidateUtil;

/**
 * @author chen
 * @version 创建时间：2015-4-15 下午06:30:44
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：手机验证码
 */
@Service
public class VerifyPhoneServiceImpl implements VerifyPhoneService{
	@Autowired
	private UserDao userDao;
	
	
	
	
	/**
	 * 验证手机号的验证码是否有效
	 * @param verifyCode
	 * @param phone
	 * @return
	 * @throws Exception
	 */
	public Status validateCode(String verifyCode, String phone,short type) throws Exception{
		
		/*if(null != verifyCode){
			
			return verifyCode.equalsIgnoreCase(PhoneCodeCache.getCode(phone, type)) ? Status.success : Status.verifyCodeInvalid;
		}else{
			
			return Status.success;
		}*/
		return Status.success;
	}
	
	
	/**
	 * 发送短信验证码
	 * @param phone
	 * @param type
	 * @throws Exception
	 */
	public Map<String, Object> sendVerifyCode(String phone, String type) throws Exception{
		
		Status status = Status.success;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(!MyUtils.isMobileNO2(phone)){
			
			status = Status.mobilePhoneNullity;
			map.put("status", status);
			return map;
		}
		if(!ValidateUtil.validateInteger(type, false, 0, 10)){
			
			status = Status.paramFormatError;
			map.put("status", status);
			return map;
		}
		
		//检测手机号是否合法
		status = this.checkPhoneUser(phone, Short.valueOf(type));
		
		if(status != Status.success){
			
			map.put("status", status);
			return map;
		}
		
		Map<String, Object> cacheMap = PhoneCodeCache.getCache(Short.valueOf(type), phone);
		
		boolean canSend = false;
		
		if(null != cacheMap){
			
			long time = (Long)cacheMap.get("time");
			
			//超过一分钟后可再次发送
			if(System.currentTimeMillis() - time > 1 * 60 * 1000l){
				
				canSend = true;
				
			}else{
				
				long leftTime = (1 * 60 * 1000l - (System.currentTimeMillis() - time)) / 1000;
				map.put("status", Status.getVerifyCodeIntervalTooShort);
				map.put("leftTime", leftTime);
				return map;
				
			}
			
		}else{
			
			canSend = true;
		}
		
		if(canSend){
			
			String code = MyUtils.getVerify();
			ConsoleUtil.println("code:"+code);
			if(SMSUtil.sendOne(phone, "您的验证码为:"+code)){
				
				ConsoleUtil.println("code2:"+code);
				PhoneCodeCache.put(phone, code, Short.valueOf(type));
				ConsoleUtil.println("code3:"+code);
				
				map.put("status", status);
				return map;
			}
		}
		
		map.put("status", Status.verifyCodeSendFail);
		return map;
	}
	
	
	/**
	 * 根据不同发送验证码的类型来验证数据是否合法
	 * @param phone
	 * @param type
	 * @return
	 * @throws Exception
	 */
	private Status checkPhoneUser(String phone,short type) throws Exception{
		
		Status status = Status.success;
		
		//查找是否存在该手机对应的用户
		UserExample example = new UserExample();
		UserExample.Criteria criteria = example.createCriteria();
		criteria.andPhoneEqualTo(phone);
		
		switch (type) {
		case VerifyCodeConstant.VERIFY_CODE_PASSWORD:

			if(userDao.countByExample(example) == 0){
				
				status = Status.userNotExistedNullity;
			}
			
			break;
		case VerifyCodeConstant.VERIFY_CODE_REGISTER:
			
			if(userDao.countByExample(example) > 0){
				
				status = Status.phoneAlreadyBindingWithOtherUser;
			}
			
			break;
		case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD:
			
			if(userDao.countByExample(example) == 0){
				
				status = Status.phoneUserIsNotExist;
			}
			
			break;
		case VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW:
			
			if(userDao.countByExample(example) > 0){
				
				status = Status.phoneAlreadyBindingWithOtherUser;
			}
			

		default:
			break;
		}
		
		
		return status;
	}
	
	
	/**
	 * 修改绑定新手机号
	 * @param userId
	 * @param phone
	 * @param code
	 * @param password
	 * @param ip
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public Status updateBindNewPhone(Long userId, String phone, String code,short type) throws Exception {
		try
		{
			if(!ValidateUtil.validateNumberic(phone, false, 11, 11)){
				
				return Status.mobilePhoneNullity;
			}
			if(!ValidateUtil.validateString(code, false, 4, 4)){
				
				return Status.verifyCodeNullity;
			}
			
			Status status = this.validateCode(code, phone, type);
			
			if(Status.success != status){
				
				return status;
			}
			
			UserExample userExample = new UserExample();
			UserExample.Criteria criteria2 = userExample.createCriteria();
			criteria2.andPhoneEqualTo(phone);
			
			//新手机绑定
			if(type == VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW){
				
				if(!MyUtils.isMobileNO2(phone)){
					
					return Status.mobilePhoneNullity;
				}
				
				criteria2.andUserIdNotEqualTo(Long.valueOf(userId));
				
				if(userDao.countByExample(userExample) > 0){
					
					return Status.phoneAlreadyBindingWithOtherUser;
				}
				
				User user = new User();
				user.setUserId(Long.valueOf(userId));
				user.setPhone(phone);
				//更新用户手机号信息以及状态
				userDao.updateByPrimaryKeySelective(user);
				
			}else {
				
				criteria2.andUserIdEqualTo(Long.valueOf(userId));
				
				//旧手机验证
				if(userDao.countByExample(userExample) == 0){
					
					return Status.phoneUserIsNotExist;
				}
			}
			
			return Status.success;
		} catch (Exception e)
		{
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 获取验证码
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	/*public boolean save(VerifyPhone entity) throws Exception {
		try
		{
			
//			VerifyPhoneExample example = new VerifyPhoneExample();
//			VerifyPhoneExample.Criteria criteria = example.createCriteria();
//			criteria.andPhoneNoEqualTo(entity.getPhoneNo());
//			criteria.andTypeEqualTo(entity.getType());
			
			if(entity.getUserId() != null && entity.getUserId() > 0){
				
//				criteria.andUserIdEqualTo(entity.getUserId());
			}
			
			List<VerifyPhone> verifyPhoneList=verifyPhoneDao.selectByExample(example);
			
			if(!MyUtils.isListEmpty(verifyPhoneList))
			{
				//如果验证码获取间隔小于2分钟不允许重新获取
				if(MyUtils.addDate2(verifyPhoneList.get(0).getCtime(), 1).after(new Date()))
				{
					return false;
				}
				//删除之前的验证码
				verifyPhoneDao.deleteByPrimaryKey(verifyPhoneList.get(0).getVerifyPhoneId());
			}
			if(entity!=null)
			{
				entity.setCtime(new Date());
				//插入手机验证码表
				verifyPhoneDao.insert(entity);
			}
			return true;
		} catch (Exception e)
		{
			e.printStackTrace();
			throw e;
		}
	}*/


	/*public String updateBind(Long userId, Long phone, String code,String password,String ip,short type,HttpServletRequest request) throws Exception {
		try
		{
			boolean isValidateUserId = false;
			
			if(type == VerifyCodeConstant.VERIFY_CODE_BINDING || type == VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD || type == VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW){
				
				isValidateUserId = true;
			}
			
			if(isValidateUserId){
				if(userId == null || userId <= 0){
					
					return "数据无效";
				}
			}
			
//			VerifyPhoneExample example = new VerifyPhoneExample();
//			VerifyPhoneExample.Criteria criteria = example.createCriteria();
//			criteria.andPhoneNoEqualTo(phone);
//			criteria.andTypeEqualTo(type);
//			
//			if(userId != null && userId > 0){
//				
//				criteria.andUserIdEqualTo(userId);
//			}
			
			//查询验证码实体
			List<VerifyPhone> verifyPhoneList=null;//verifyPhoneDao.selectByExample(example);
			//判断非空及验证码有效
//			String yeCode = ;//查询发送code
			if(!MyUtils.isListEmpty(verifyPhoneList)&& verifyPhoneList.get(0).getVerifyCode().toLowerCase().equals(code.toLowerCase()))
			{
				VerifyPhone verifyPhone = verifyPhoneList.get(0);
				
				//如果验证码获取时间大于10分钟即失效
				if(MyUtils.addDate2(verifyPhone.getCtime(), 10).before(new Date()))
				{
					return "验证码已失效";
				}
				//验证码只能验证一次，验证完即删
//				verifyPhoneDao.deleteByPrimaryKey(verifyPhone.getVerifyPhoneId());
				
						
				UserExample userExample = new UserExample();
				UserExample.Criteria criteria2 = userExample.createCriteria();
				criteria2.andPhoneEqualTo(phone+"");
				
				if(isValidateUserId){
					
					criteria2.andUserIdNotEqualTo(Long.valueOf(userId));
				}
				
				int tel = userDao.countByExample(userExample);
				
				//不是找回密码
				if(type != VerifyCodeConstant.VERIFY_CODE_PASSWORD && type != VerifyCodeConstant.VERIFY_CODE_UNBINDING){
					
					if(tel > 0){
						return "该电话号码已被验证，请重新验证电话号码！";
					}
				}else if(tel == 0){
					
					return "手机号对应的用户不存在";
				}
				
				if(type == VerifyCodeConstant.VERIFY_CODE_BINDING ){
					
					
					User user = new User();
					user.setUserId(Long.valueOf(userId));
					user.setPhone(phone+"");
					user.setStatus((short)1);
					//更新用户手机号信息以及状态
					userDao.updateByPrimaryKeySelective(user);
					
					
					//查询用户实体
					user = userDao.selectByPrimaryKey(Long.valueOf(userId));
					
				}else if(type == VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW){
					
					User user = new User();
					user.setUserId(Long.valueOf(userId));
					user.setPhone(phone+"");
					//更新用户手机号信息以及状态
					userDao.updateByPrimaryKeySelective(user);
					
				}else if(type == VerifyCodeConstant.VERIFY_CODE_UNBINDING){
					
					List<User> userList = userDao.selectByExample(userExample);
					if(!MyUtils.isListEmpty(userList)){
						User user = userList.get(0);
						
						User user2 = new User();
						user2.setUserId(user.getUserId());
						user2.setPhone("");
						//更新用户手机号信息以及状态
						userDao.updateByPrimaryKeySelective(user2);
						
						//解绑成功后，自动绑定，同时登录
						User sessionUser = (User)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
						User updateUser = new User();
						updateUser.setUserId(sessionUser.getUserId());
						updateUser.setPhone(phone+"");
						userDao.updateByPrimaryKeySelective(updateUser);
					}
				}
			}
			else
			{
				return "验证码无效";
			}
			return null;
		} catch (Exception e)
		{
			e.printStackTrace();
			throw e;
		}
	}*/

	/*public int findPhone(Long phone, Long userId,short type) {
		UserExample userExample = new UserExample();
		UserExample.Criteria criteria = userExample.createCriteria();
		criteria.andPhoneEqualTo(phone+"");
		//不是注册
		if(type == VerifyCodeConstant.VERIFY_CODE_BINDING || type == VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD || type == VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW){
			
			if(userId == null || userId <= 0){
				
				return -1;
			}
			criteria.andUserIdNotEqualTo(userId);
		}
		int tel = userDao.countByExample(userExample);
		return tel;
	}*/
	
	/**
	 * 验证手机号和发送的验证码
	 * @param request
	 * @param type
	 * @return
	 * @throws Exception
	 
	public Status updateVerifyValidate(HttpServletRequest request, short type) throws Exception{
		
		String phone = request.getParameter("phone");
		String code = request.getParameter("verifyCode");
		if(!ValidateUtil.validateNumberic(phone, false, 11, 11)){
			return Status.mobilePhoneNullity;
		}
		if(!ValidateUtil.validateNumberic(code, false, 4, 4)){
			return Status.verifyCodeNullity;
		}
		
		User user = (User)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		//手机号已被其他用户绑定了
		if(this.findPhone(Long.valueOf(phone), user.getUserId(), type) > 0){
			
			return Status.phoneAlreadyBindingWithOtherUser;
		}
		
		//验证手机号和验证码是否有效
		return Status.success;
	}*/
	
	
}
