package com.bjwg.main.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.cache.PhoneCodeCache;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.LoginConstants;
import com.bjwg.main.constant.OperateConstant;
import com.bjwg.main.constant.OrderConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.constant.VerifyCodeConstant;
import com.bjwg.main.dao.QQUserDao;
import com.bjwg.main.dao.UserDao;
import com.bjwg.main.dao.WeiXinUserDao;
import com.bjwg.main.model.QQUser;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserCenter;
import com.bjwg.main.model.UserExample;
import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.model.WeiXinUserExample;
import com.bjwg.main.service.LoginService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.VerifyPhoneService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.MD5;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.RandomUtils;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ToolKit;
import com.bjwg.main.util.ValidateUtil;

/**
 * @author chen
 * @version 创建时间：2015-4-2 下午04:55:56
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：用户
 */

@Service
public class LoginServiceImpl  implements LoginService {
	
	@Resource
	private UserService userService;
	@Resource
	private UserDao userDao;
	@Resource
	private QQUserDao qqUserDao;
	@Resource
	private WeiXinUserDao weiXinUserDao;
	@Resource
	private VerifyPhoneService verifyPhoneService;



	private Status checkQQUserParam(QQUser qqUser) throws Exception{
		//标识  S - L：32	- N
		String openid = qqUser.getOpenid();
		//40*40的qq头像url S - L：255 - N
		String figureurl_qq_1 = qqUser.getFigureurlQq1();
		//100*100的qq头像url S - L：255	- Y
		String figureurl_qq_2 = qqUser.getFigureurlQq2();
		//昵称 S - L：45	- N
		String nickname = qqUser.getNickname();
		//黄钻等级 I - L：2	- N
		String yellow_vip_level = qqUser.getYellowVipLevel()+"";
		//50*50的qq空间头像url S - L：255 - Y
		String figureurl_1 = qqUser.getFigureurl1();
		//100*100的qq空间头像url S - L：255	- Y
		String figureurl_2 = qqUser.getFigureurl2();
		//性别 I - L：1	- N
		String sex = qqUser.getSex()+"";
		//30*30的qq空间头像url S - L：255 - Y
		String figureurl = qqUser.getFigureurl();
		String province = qqUser.getProvince();
		String city = qqUser.getCity();
		
		Status status = Status.success;
		//验证数据
		if(!ValidateUtil.validateString(openid, false, 32, 32)){
			status = Status.qqOpenidNullity;
		}
		if(!ValidateUtil.validateString(figureurl_qq_1, false, 1, 255)){
			status = Status.qqFigureurlNullity;
		}
		if(!ValidateUtil.validateString(figureurl_qq_2, true, 1, 255)){
			status = Status.qqFigureurl2Nullity;
		}
		if(!ValidateUtil.validateString(nickname, false, 1, 45)){
			status = Status.nicknameNullity;
		}
		if(!ValidateUtil.validateInteger(yellow_vip_level, false, null, null)){
			status = Status.yellowVipLevelNullity;
		}
		if(!ValidateUtil.validateInteger(sex, false, 1, 2)){
			status = Status.sexNullity;
		}
		if(!ValidateUtil.validateString(province, true, 1, 45)){
			status = Status.provinceNullity;
		}
		if(!ValidateUtil.validateString(city, true, 1, 45)){
			status = Status.cityNullity;
		}
		if(!ValidateUtil.validateString(figureurl_1, true, 1, 255)){
			status = Status.qqFigureurl3Nullity;
		}
		if(!ValidateUtil.validateString(figureurl_2, true, 1, 255)){
			status = Status.qqFigureurl4Nullity;
		}
		if(!ValidateUtil.validateString(figureurl, true, 1, 255)){
			status = Status.qqFigureurl5Nullity;
		}
		return status;
	}
	
	private Status checkWeixinUserParam(WeiXinUser weiXinUser,User user) throws Exception{
		
		/*
		 * 注释 S（类型，S表示String，I表示Integer） L（长度） Y(可否为空)
		 * 
		 * 微信和qq的openid是不一样的意思，所以长度也是不一样的
		 */
		//用户统一标识 主键 S - L：29	- N
		String unionid = weiXinUser.getUnionid();
		//标识  S - L：28	- N
		String openid = weiXinUser.getOpenid();
		//昵称 S - L：16	- N
		String nickname = weiXinUser.getNickname();
		//用户头像 S - L：255	- Y
		String headimgurl = user.getHeadImg();
		
		Status status = Status.success;
		//验证数据
		if(!ValidateUtil.validateString(unionid, false, 28, 29)){
			status = Status.unionidNullity;
		}
		if(!ValidateUtil.validateString(openid, false, 28, 28)){
			
			status = Status.openidNullity;
		}
		if(!ValidateUtil.validateString(nickname, false, 1, 45)){
			
			status = Status.nicknameNullity;
		}
		if(!ValidateUtil.validateString(headimgurl, true, 1, 255))
		{
			status = Status.headimgNullity;
		}
		
		return status;
	}
	
	/**
	 * 登录
	 * @param QQUser
	 * @param WeiXinUser
	 * @param User
	 * @param type 1 是qq 登录，2表示微信登录(没用到)，3表示账号登录
	 * @param verifyCode 验证码
	 * @return
	 * @throws Exception
	 */
	public Map<String,Object> updateUserLogin(QQUser qqUser,WeiXinUser weiXinUser,User user,short type,String ip,String verifyCode) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			Status status = Status.success; 

			Long userId = null;
			//type:1 是qq 登录，2表示微信公众号登录，3表示手机号登录
			if(type == OperateConstant.LOGIN_QQ){
				
				if(null != qqUser){
					
					status = checkQQUserParam(qqUser);
					
					if(status != Status.success){
						map.put("status", status);
						return map;
					}
					//查询qq用户是否存在，存在表示可以登录，否则需要注册
					QQUser queryQQUser = qqUserDao.selectByPrimaryKey(qqUser.getOpenid());
					
					if(queryQQUser != null){
						
						userId = queryQQUser.getUserId();
					}else{
						
						qqUserDao.insert(qqUser);
					}
				}else{
					status = Status.login_first;
					map.put("status", status);
					return map;
				}
				
				//微信公众号登录
			}else if(type == OperateConstant.LOGIN_WX){
				
				status = checkWeixinUserParam(weiXinUser, user);
				
				if(status != Status.success){
					map.put("status", status);
					return map;
				}
				
				if(weiXinUser != null){
					
					WeiXinUserExample weiXinUserExample = new WeiXinUserExample();
					WeiXinUserExample.Criteria criteria = weiXinUserExample.createCriteria();
					
					//测试配置，主要是为了测试环境使用的，不影响正式环境
					String test = ToolKit.getInstance().getSingleConfig("test");
					
					if("yes".equals(test)){
						
						criteria.andOpenidEqualTo(weiXinUser.getOpenid());
					}else{
						
						criteria.andUnionidEqualTo(weiXinUser.getUnionid().trim());
					}
					
					//查询是否已存在了微信用户了
					List<WeiXinUser> weiXinUserList = weiXinUserDao.selectByExample(weiXinUserExample);
					
					ConsoleUtil.println("-------\n跟踪微信注册unionId："+weiXinUser.getUnionid().trim()+"，user是否存在？" + (!MyUtils.isListEmpty(weiXinUserList)));
					
					if(!MyUtils.isListEmpty(weiXinUserList)){
						
						//判断openid是否一致，否则要更新上去(这是因为之前使用了两个公众号了，但是账号是同一个但是openid不一样)
						WeiXinUser oldWeiXinUser = weiXinUserList.get(0);
						
						if(!oldWeiXinUser.getOpenid().trim().equals(weiXinUser.getOpenid())){
							
							WeiXinUser updateWeiXinUser = new WeiXinUser();
							updateWeiXinUser.setUnionid(oldWeiXinUser.getUnionid());
							updateWeiXinUser.setOpenid(weiXinUser.getOpenid());
							weiXinUserDao.updateByPrimaryKeySelective(updateWeiXinUser);
						}
						
						userId = weiXinUserList.get(0).getUserId();
												
					}else{
						
						weiXinUserDao.insert(weiXinUser);
					}
				}else{
					status = Status.login_first;
					map.put("status", status);
					return map;
				}
				
				
				//手机号码登录
			}else if(type==OperateConstant.LOGIN_PHONE){
				
				String username = user.getPhone();
				String password = user.getPassword();
				if(!MyUtils.isMobileNO2(username)){
					status = Status.mobilePhoneNullity;
				}
				if(!StringUtils.isNotEmpty(password)){
					status = Status.passwordNullity;
				}
				
				if(status != Status.success){
					map.put("status", status);
					return map;
				}
					
				//密码md5加密
				password = MD5.GetMD5Code(MD5.GetMD5Code(password.trim()) + LoginConstants.LOGIN_PASSWORD_PARAM);
				UserExample userExample = new UserExample();
				UserExample.Criteria criteria = userExample.createCriteria();
				criteria.andPhoneEqualTo(username.trim());
				criteria.andPasswordEqualTo(password);
				
				//查询是否有该用户
				List<User> list = userDao.selectByExample(userExample);
			
				//没有该用户
				if(MyUtils.isListEmpty(list)){
					status = Status.usernameorPasswordIncorrect;
					map.put("status", status);
					return map;
				}
				
				status = Status.success;
				map.put("status", status);
				user = list.get(0);
				map.put(CommConstant.SESSION_MANAGER, user);
				
				//分配token
//				map.put(CommConstant.SESSION_APP_TOKEN, "token");
		
				return map;
			}
			
			else{
				/*
				 * 企业用户登录
				 */
				String username = user.getUsername();
				String password = user.getPassword();
				
				if(!StringUtils.isNotEmpty(username)){
					status=status.usernameNullity;
				}
				if(!StringUtils.isNotEmpty(password)){
					status = Status.passwordNullity;
				}
				
				if(status != Status.success){
					map.put("status", status);
					return map;
				}
					
				//密码md5加密
				password = MD5.GetMD5Code(MD5.GetMD5Code(password.trim()) + LoginConstants.LOGIN_PASSWORD_PARAM);
				System.out.println("pw="+password);
				UserExample userExample = new UserExample();
				UserExample.Criteria criteria = userExample.createCriteria();
				criteria.andUsernameEqualTo(username.trim());
				criteria.andPasswordEqualTo(password);
				//查询是否有该用户
				
				List<User> list = userDao.selectByExample(userExample);
				//List<User> list = userDao.selectByUser(user);
				//没有该用户
				if(MyUtils.isListEmpty(list)){
					status = Status.usernameorPasswordIncorrect;
					map.put("status", status);
					return map;
				}
				
				status = Status.success;
				map.put("status", status);
				user = list.get(0);
				map.put(CommConstant.SESSION_MANAGER, user);
				
				//分配token
//				map.put(CommConstant.SESSION_APP_TOKEN, "token");
				
				return map;
				
				
			}
			
			
			
			
			if(userId != null && userId.intValue() > 0){
				
				//查询qq或微信对应的用户表记录
				user = userDao.selectByPrimaryKey(userId);
				
				//用户不存在
				if(user == null){
					status = Status.userNotExistedNullity;
					map.put("status", status);
					return map;
					//手机号未绑定
				}else if(!StringUtils.isNotEmpty(user.getPhone())){
					
					status = Status.userPhoneInactive;
					map.put(CommConstant.SESSION_MANAGER, user);
					map.put("status", status);
					return map;
				}
				
				User user2 = new User();
				user2.setUserId(user.getUserId());
				user2.setLastLoginTime(new Date());
				user2.setLastLoginIp(MyUtils.ip2long(ip));
				
				//更新用户登录信息
				userDao.updateByPrimaryKeySelective(user2);
			
				map.put(CommConstant.SESSION_MANAGER, user);
				status = Status.success;
				map.put("status",status);
			}else{
				status = Status.userPhoneInactive;
				map.put("status",status);
			}

			return map;
			
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		}
		
		
		
	}
	
	/**
	 * 找回密码_保存
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Status savePassword(String phone,String password,String verifyCode) throws Exception{
		
		try {
			
			ConsoleUtil.println("找回密码，手机号："+phone);
			
			Status status = userService.checkVerifyCodeValid(phone, password, verifyCode,VerifyCodeConstant.VERIFY_CODE_PASSWORD);
			
			if(status != Status.success){
				
				return status;
			}
			
			UserExample example = new UserExample();
			UserExample.Criteria criteria = example.createCriteria();
			criteria.andPhoneEqualTo(phone);
			List<User> userList = userDao.selectByExample(example);
			
			if(!MyUtils.isListEmpty(userList)){
				
				User user = new User();
				password = MD5.GetMD5Code(MD5.GetMD5Code(password)+ LoginConstants.LOGIN_PASSWORD_PARAM);
				user.setUserId(userList.get(0).getUserId());
				user.setPassword(password);
				userDao.updateByPrimaryKeySelective(user);
				
				//移除验证码
				PhoneCodeCache.delete(phone, VerifyCodeConstant.VERIFY_CODE_PASSWORD);
				return Status.success;
			}
			
			return Status.phoneUserIsNotExist;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	/**
	 * 手机app登录后需要查询的数据
	 * @param user
	 * @return
	 * @throws Exception
	 
	public JSONObject queryWhenAppAfterLogin(HttpServletRequest request,User user) throws Exception{
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", user.getUserId());
		params.put("status", OrderConstant.ORDER_STATUS_4);
		UserCenter userCenter = userService.selectUserCenterData(params);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("user_id", user.getUserId());
		jsonObject.put("user_name", user.getUsername());
		jsonObject.put("portrait", MyUtils.getImgUrl(user.getHeadImg(),BaseController.webroot, BaseController.webrootImg, 0, BaseController.USER_HEAD_IMAGE,false));
		jsonObject.put("store_id",userCenter != null ? userCenter.getShopId() : null);
		jsonObject.put("collect_count", userCenter != null ? userCenter.getFavorites() : null);
		jsonObject.put("is_store", (userCenter != null && userCenter.getShopId() != null && userCenter.getShopId() > 0));
		jsonObject.put("store_logourl", (userCenter != null && StringUtils.isNotEmpty(userCenter.getShopLogo())) ? (BaseController.webrootImg + userCenter.getShopLogo()) : null);
		jsonObject.put("store_name", userCenter != null ? userCenter.getShopName() : null);
		jsonObject.put("phone", user.getPhone());
		
		request.getSession().setAttribute(CommConstant.SESSION_USER_ID, user.getUserId());
		if(userCenter != null && userCenter.getShopId() != null){
			request.getSession().setAttribute(CommConstant.SESSION_SHOP_ID, userCenter.getShopId());
		}
		return jsonObject;
	}
*/
}
