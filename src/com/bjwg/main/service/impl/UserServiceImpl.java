package com.bjwg.main.service.impl;

import java.math.BigDecimal;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import oracle.net.aso.e;

import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.cache.PhoneCodeCache;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.FileConstant;
import com.bjwg.main.constant.LoginConstants;
import com.bjwg.main.constant.MessageConstant;
import com.bjwg.main.constant.OrderConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.constant.TypeConstant;
import com.bjwg.main.constant.VerifyCodeConstant;
import com.bjwg.main.dao.FreindsDao;
import com.bjwg.main.dao.MyCouponDao;
import com.bjwg.main.dao.MyCouponUseDao;
import com.bjwg.main.dao.OrderDao;
import com.bjwg.main.dao.PresentFreindsDao;
import com.bjwg.main.dao.ShopDao;
import com.bjwg.main.dao.UserAddressDao;
import com.bjwg.main.dao.UserDao;
import com.bjwg.main.dao.UserExtDao;
import com.bjwg.main.dao.UserPreorderDao;
import com.bjwg.main.dao.WeiXinUserDao;
import com.bjwg.main.model.Area_V2;
import com.bjwg.main.model.Freinds;
import com.bjwg.main.model.FreindsExample;
import com.bjwg.main.model.MessageExample;
import com.bjwg.main.model.MyCoupon;
import com.bjwg.main.model.MyCouponExample;
import com.bjwg.main.model.MyCouponUse;
import com.bjwg.main.model.MyCouponUseExample;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.MyEarningsExample;
import com.bjwg.main.model.OrderExample;
import com.bjwg.main.model.Shop;
import com.bjwg.main.model.ShopExample;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.UserAddressExample;
import com.bjwg.main.model.UserCenter;
import com.bjwg.main.model.UserExample;
import com.bjwg.main.model.UserExt;
import com.bjwg.main.model.UserPreorder;
import com.bjwg.main.model.UserPreorderExample;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.model.WalletExample;
import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.model.WeiXinUserExample;
import com.bjwg.main.service.MessageService;
import com.bjwg.main.service.MyEarningsService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.VerifyPhoneService;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.FileUtils;
import com.bjwg.main.util.MD5;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.RandomUtils;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ToolKit;
import com.bjwg.main.util.ValidateUtil;

/**
 * @author chen
 * @version 创建时间：2015-4-15 下午05:21:30
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Service
public class UserServiceImpl implements UserService{
	
	@Resource
	private UserDao userDao;
	@Resource
	private WeiXinUserDao weiXinUserDao;
	@Resource
	private VerifyPhoneService verifyPhoneService;
	@Resource
	private UserAddressDao userAddressDao;
	@Resource
	private SysConfigService sysConfigService;
	@Resource
	private MyEarningsService myEarningsService;
	@Resource
	private WalletService walletService;
	@Resource
	private FreindsDao freindsDao;
	@Resource
	private UserExtDao userExtDao;
	@Resource
	private MessageService messageService;
	@Resource
	private PresentFreindsDao presentFreindsDao;
	@Resource
	private MyCouponDao myCouponDao;
	@Resource
	private MyCouponUseDao myCouponUseDao;
	@Resource
	private ShopDao shopDao;
	@Resource
	private UserPreorderDao userPreorderDao;
	@Resource
	private OrderDao orderDao;
	
	
	/**
	 * 注册账号
	 * @param phone
	 * @param password
	 * @param verifyCode
	 * @param remoteAddr
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> insertUser(String phone, String password,String verifyCode, String remoteAddr,WeiXinUser weiXinUser,String inviteCode) throws Exception{
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			
			Status status = this.checkVerifyCodeValid(phone, password, verifyCode,VerifyCodeConstant.VERIFY_CODE_REGISTER);
			
			if(status != Status.success){
				
				map.put("status", status);
				return map;
			}
			
			User user = new User();
			//默认为男
			user.setSex((byte)1);
			user.setUsername(phone);
			user.setHeadImg(sysConfigService.queryOneValue(SysConstant.DEFAULT_HEADIMG));
			String nickname = phone;
			if(nickname.length() > 8){
				nickname = nickname.substring(0,3) + "*****"+nickname.substring(8);
			}
			user.setNickname(nickname);
			//密码随机6位数字
			if(StringUtils.isEmptyNo(password)){
				password = MyUtils.random(6)+"";
			}
			password = MD5.GetMD5Code(MD5.GetMD5Code(password)+ LoginConstants.LOGIN_PASSWORD_PARAM);
			user.setPassword(password);
			user.setRegisterIp(MyUtils.ip2long(remoteAddr));
			user.setRegisterTime(new Date());
			user.setStatus((byte)1);
			user.setPhone(phone);
			
			UserExample userExample = new UserExample();
			UserExample.Criteria criteria = userExample.createCriteria();
			criteria.andUsernameEqualTo(user.getUsername());
			
			//判断用户名是否重复,重复则进行随机处理
			if(userDao.countByExample(userExample)>0)
			{
				//用户名：qq/微信昵称+下划线+6位随机大小写字母或数字
				user.setUsername(user.getUsername().trim() + "_" + RandomUtils.getNumAndWord(6));
			}
			
			this.setInviteAndQRCode(user);
			
			ConsoleUtil.println("inviteCode:"+inviteCode);
			User invitedUser = null;
			//有邀请码则设置当前注册用户为 好友
			if(StringUtils.isNotEmpty(inviteCode)){
				
				criteria.getAllCriteria().clear();
				criteria.andInviteCodeEqualTo(inviteCode);
				
				List<User> user2List = userDao.selectByExample(userExample);
				
				if(MyUtils.isListEmpty(user2List)){
					map.put("status", Status.inviteCodeNullity);
					return map;
				}
				
				invitedUser = user2List.get(0);
			}
			
			userDao.insert(user); 
			ConsoleUtil.println("invitedUser:"+invitedUser);
			//有邀请码则设置当前注册用户为 好友
			if(null != invitedUser){
				
				Freinds freinds = new Freinds();
				freinds.setMyUserId(invitedUser.getUserId());
				freinds.setAddType(TypeConstant.FREINDS_ADD_TYPE_2);
				freinds.setAgreeTime(user.getRegisterTime());
				freinds.setSendRemark("");
				freinds.setStatus(CommConstant.ADD_FREINDS_1);
				freinds.setFreindId(user.getUserId());
				freinds.setSendTime(user.getRegisterTime());
				
				freindsDao.insert(freinds);
			}
			
			UserExt userExt = new UserExt();
			userExt.setUserId(user.getUserId());
			userExt.setLastButtinId(0l);
			userExtDao.insert(userExt);
			
			ConsoleUtil.println("weiXinUser:"+weiXinUser+",userId:"+user.getUserId());
			if(weiXinUser != null){
				
				weiXinUser.setUserId(user.getUserId());
				weiXinUserDao.updateByPrimaryKeySelective(weiXinUser);
			}
			
			//移除验证码
			PhoneCodeCache.delete(phone, VerifyCodeConstant.VERIFY_CODE_REGISTER);
			
			map.put("status", status);
			map.put("user", user);
			
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
     * 封装user对象基本信息
     * @param user
     * @param user_nickname
     * @param user_sex
     * @param ip
     * @param user_headimgurl
     * @param user_province
     * @param user_city
     * @param user_country
     */
	public void encapUserInfo(User user,String user_nickname, String user_sex, String ip,
			String user_headimgurl, String user_province, String user_city,
			String user_country){
		
		user.setUsername(user_nickname);
		// 密码为六位数字加密
		user.setPassword(MD5.GetMD5Code(MyUtils.random(6) + LoginConstants.LOGIN_PASSWORD_PARAM));
		user.setSex(Byte.valueOf(user_sex));
		user.setRegisterTime(new Date());
		// Java获取客户端真实IP地址
		if (!StringUtils.isNotEmpty(ip)) {
			try {
				ip = InetAddress.getLocalHost().getHostAddress();
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}
		}
		user.setRegisterIp(MyUtils.ip2long(ip));
		// 默认状态为1
		user.setStatus((byte)1);
		user.setHeadImg(user_headimgurl);
		user.setProvince(user_province);
		user.setCity(user_city);
		if (StringUtils.isEmptyNo(user_country)) {
			user.setCountry("CN");
		} else {
			user.setCountry(user_country);
		}
	}
	
	
	/**
	 * 查询微信表
	 * @param user
	 * @throws Exception
	 */
	public WeiXinUser selectByWeixinUserExample(WeiXinUserExample weiXinUserExample) throws Exception{
		
		try {
			
			List<WeiXinUser> list = weiXinUserDao.selectByExample(weiXinUserExample);
			
			return MyUtils.isListEmpty(list) ? null : list.get(0);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 保存个人头像
	 * @param user
	 * @throws Exception
	 */
	public void saveLogo(User user) throws Exception{
		
		try {
			
			if(StringUtils.isNotEmpty(user.getHeadImg()) && MyUtils.isIntegerGtZero(user.getUserId().intValue())){
				
				User user2 = new User();
				user2.setUserId(user.getUserId());
				user2.setHeadImg(user.getHeadImg());
				userDao.updateByPrimaryKeySelective(user2);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 检测数据是否合法和验证码是否有效
	 * @param request
	 * @return Status
	 */
	public Status checkVerifyCodeValid(String phone,String password,String verifyCode,short codeType) throws Exception{
		
		
		Status status = Status.success;
		
		//用户名就是手机号
		if(!ValidateUtil.validateNumberic(phone, false, 1, 11)){
			return Status.mobilePhoneNullity;
		}
		if(!ValidateUtil.validateString(password, true, 1, 32)){
			return Status.passwordNullity;
		}
		if(!ValidateUtil.validateNumberic(verifyCode, false, 1, 4)){
			return Status.verifyCodeInvalid;
		}
		
		status = verifyPhoneService.validateCode(verifyCode, phone, codeType);
		
		return status;
	}
	/**
	 * 新增用户公用
	 * @param phone
	 * @param password
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public User insertUser(String phone,String password,HttpServletRequest request,Short type) throws Exception{
		try {
			
			User user = new User();
			//默认为男
			user.setSex((byte)1);
			user.setUsername(phone);
			String nickname = phone;
			if(nickname.length() > 8){
				nickname = nickname.substring(0,3) + "*****"+nickname.substring(8);
			}
			user.setNickname(nickname);
			//密码随机6位数字
			if(StringUtils.isEmptyNo(password)){
				password = MyUtils.random(6)+"";
			}
			password = MD5.GetMD5Code(MD5.GetMD5Code(password)+ LoginConstants.LOGIN_PASSWORD_PARAM);
			user.setPassword(password);
			user.setRegisterIp(MyUtils.ip2long(request.getRemoteAddr()));
			user.setRegisterTime(new Date());
			user.setStatus((byte)1);
			user.setPhone(phone);
			
			UserExample userExample = new UserExample();
			UserExample.Criteria criteria = userExample.createCriteria();
			criteria.andUsernameEqualTo(user.getUsername());
			
			//判断用户名是否重复,重复则进行随机处理
			if(userDao.countByExample(userExample)>0)
			{
				//用户名：qq/微信昵称+下划线+6位随机大小写字母或数字
				user.setUsername(user.getUsername().trim() + "_" + RandomUtils.getNumAndWord(6));
			}
			
			this.setInviteAndQRCode(user);
			
			userDao.insert(user);
			
			UserExt userExt = new UserExt();
			userExt.setUserId(user.getUserId());
			userExt.setLastButtinId(0l);
			userExt.setSettingType(TypeConstant.USER_SETTING_TYPE_0);
			userExtDao.insert(userExt);
			
			return user;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 设置邀请码和二维码
	 * @param user
	 * @throws Exception
	 */
	private void setInviteAndQRCode(User user) throws Exception{
		//邀请码
		String inviteCode = RandomUtils.getNumAndWord(10);
		
		user.setInviteCode(CommConstant.INVITECODE_PREFIX+inviteCode);
		
		List<String> codeList = new ArrayList<String>(Arrays.asList(SysConstant.PROJECT_IMG_ACCESS_URL,SysConstant.PROJECT_IMG_UPLOAD_ROOT_PATH
				,SysConstant.QR_CODE_URL,SysConstant.PROJECT_ACCESS_URL));
		
		List<SysConfig> list = sysConfigService.queryList(codeList);
		
		if(!MyUtils.isListEmpty(list)){
			
			//二维码url
			String url = null;
			//图片存储根路径
			String imgPath = null;
			//访问地址
			String accessUrl = null;
			//项目地址
			String projectUrl = null;
			for (SysConfig syscon : list) {
				
				if(SysConstant.PROJECT_IMG_ACCESS_URL.equals(syscon.getCode())){
					//http://testweixin.hzd.com/
					url = syscon.getValue();
				}else if(SysConstant.QR_CODE_URL.equals(syscon.getCode())){
					
					///wpnv/ixhome?inviteCode=
					accessUrl = syscon.getValue();
				}else if(SysConstant.PROJECT_ACCESS_URL.equals(syscon.getCode())){
					
					///wpnv/ixhome?inviteCode=
					projectUrl = syscon.getValue();
				}else{
					///mnt/tomcat_bjwg/webapps/ROOT/resources/
					imgPath = syscon.getValue();
				}
			}
			if(StringUtils.isAllNotEmpty(url,imgPath)){
				
				String imgName = "qr_"+System.currentTimeMillis()+".jpg";
				
				String filePath = "/" + MyUtils.getYYYYMMDD(0)+ToolKit.getInstance().getSingleConfig(FileConstant.UPLOAD_INVITE_CODE_PATH)+"/";
				
				String  test = ToolKit.getInstance().getSingleConfig("test");
				
				//二维码
				FileUtils.createQRCodeFile(projectUrl+accessUrl+user.getInviteCode(), imgPath+filePath, imgName, "jpg");
				
				if("yes".equals(test)){
					
					url += "resources";
				}
				
				user.setQrCode(url + filePath +imgName);
			}
		}
	}
	
	

	@Override
	public User getById(Long id) throws Exception {
		return userDao.selectByPrimaryKey(id);
	}


	/**
     * 查询个人中心的数据:钱包、猪仔、总收益(不包括到账收益，按截止时间算)
     * @param example
     * @return
     */
	@Override
	public UserCenter selectUserCenterData(Long userId) throws Exception {
		
		MyEarningsExample earningsExample = new MyEarningsExample();
		MyEarningsExample.Criteria eCriteria = earningsExample.createCriteria();
		
		Date date = new Date();
		
		eCriteria.andUserIdEqualTo(userId);
		eCriteria.andEndTimeGreaterThanOrEqualTo(date);
		eCriteria.andBeginTimeLessThanOrEqualTo(date);
		
		//查询符合条件的猪仔和收益
		List<MyEarnings> eList = myEarningsService.selectByExample(earningsExample);
		
		UserCenter userCenter = new UserCenter();
		
		//总收益 = 数量 * 成本 * 年收益率 * 时间  / 360天
		BigDecimal earnings = BigDecimal.ZERO;
		//猪仔数
		Integer pigNum = 0;
		
		if(!MyUtils.isListEmpty(eList)){
			
			//间隔天数
			Long intervalDays = 0l;
			
			for (MyEarnings en : eList) {
				
				intervalDays = MyUtils.calcDays(en.getBeginTime(), date);
				
				earnings = earnings.add(en.getMoney().multiply(BigDecimal.valueOf(en.getNum() - en.getPresentNum())).multiply(en.getRate())
										.multiply(BigDecimal.valueOf(intervalDays)).divide(BigDecimal.valueOf(100)).divide(BigDecimal.valueOf(360),2,BigDecimal.ROUND_HALF_UP));
				
				pigNum += en.getNum() - en.getPresentNum();
			}
			
		}
		
		userCenter.setPigNumber(pigNum);
		
		userCenter.setEarnings(earnings);
		
		//钱包余额
		Wallet wallet = walletService.queryByUserId(userId);
		
		if(null != wallet){
			
			userCenter.setWalletMoney(wallet.getMoney());
		}
		
		MessageExample messageExample = new MessageExample();
		MessageExample.Criteria criteria = messageExample.createCriteria();
		criteria.andUserIdEqualTo(userId);
		criteria.andStatusEqualTo(MessageConstant.MSG_UNREAD);
		//未读消息数
		int count = messageService.countByExample(messageExample);
		
		userCenter.setMsgUnReadNum(count);
		
		return userCenter;
	}

	
	/**
	 * 修改个人资料信息 - 昵称/性别
	 * @throws Exception
	 */
	public Status updateUserNickNameOrSex(String nickName,String sex,Long userId) throws Exception{
		
		try {
			if(null == userId || userId <= 0){
				
				return Status.useridNullity;
			}
			//只是修改昵称
			if(!ValidateUtil.validateString(nickName, true, 1, 45)){
				return Status.usernameNullity;
			}
			//只是修改性别
			if(!ValidateUtil.validateString(sex, true, 1, 2)){
				return Status.sexNullity;
			}
			User user2 = new User();
			
			user2.setUserId(userId);
			
			if(StringUtils.isNotEmpty(nickName)){
				
				user2.setNickname(nickName);
			}
			if(StringUtils.isNotEmpty(sex)){
				//1-男性，2-女性，0-未知
				user2.setSex(Byte.valueOf(sex));
			}
			
			userDao.updateByPrimaryKeySelective(user2);
			
			return Status.success;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 添加 用户  上门地址
	 * @param userAddress
	 * @return
	 */
	public Map<String, Object> insert(UserAddress userAddress) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Status status = Status.success;
		try {

			String phone = userAddress.getContactPhone().toString();
			if(StringUtils.isNotEmpty(phone))
			{
				boolean falg = MyUtils.isMobileNO2( phone );
				if(falg){
					userAddressDao.insert(userAddress);
					map.put("userAddress", userAddress);
				}
				else{
					status = Status.mobilePhoneNullity;
				}
			}else {
				status = Status.mobilePhoneNullity;
			}
			
			map.put("status", status);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return map;
	}

	/***
	 * 根据用户id查询上门地址
	 */
	@Override
	public List<UserAddress> getUserId(Long userId) throws Exception {
		// TODO Auto-generated method stub
		UserAddressExample example = new UserAddressExample();
		UserAddressExample.Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userId);
		List<UserAddress> addressList = userAddressDao.selectByExample(example);
		return MyUtils.isListEmpty(addressList) ? null : addressList;
		
	}

	/**
	 * 根据上门地址id查询信息
	 */
	@Override
	public UserAddress getAddressId(Long addressId) throws Exception {
		// TODO Auto-generated method stub
		return userAddressDao.selectByPrimaryKey(addressId);
	}

	/**
	 * 保存编辑后的上门地址信息
	 */
	@Override
	public Map<String, Object> update(UserAddress userAddress) throws Exception{
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Status status = Status.success;
		int n = userAddressDao.updateByPrimaryKeySelective(userAddress);
		if( 1 == n ){
			map.put("status", status);
		}
		return map;
	}

	/**
     * 更新默认选择
     * @param record
     * @return
     */
    public int updateDefaultByUserId(UserAddress record) throws Exception{
    	try {
			
    		return userAddressDao.updateDefaultByUserId(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
    }
    
	/**
	 * 删除上门地址
	 */
	@Override
	public Map<String, Object> delete(Integer addressId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Status status = Status.success;
		int n = userAddressDao.deleteByPrimaryKey(Long.valueOf(addressId));
		if( 1 == n ){
			map.put("status", status);
		}
		return map;
	}

	/**
	 * 根据用户id 查询默认上门地址
	 */
	@Override
	public UserAddress getUserIdIs(Long userId) throws Exception {
		UserAddressExample example = new UserAddressExample();
		UserAddressExample.Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userId);
		criteria.andIsDefaultEqualTo((byte)1);
		List<UserAddress> addressList = userAddressDao.selectByExample(example);
		return MyUtils.isListEmpty(addressList) ? null : addressList.get(0);
	}
	

	
	/**
	 * 设置密码 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Status updateLoginPassword(HttpServletRequest request,String source) throws Exception{
		
		try {
			
			String password = request.getParameter("password");
			
			if(!ValidateUtil.validateString(password, false, 1, null)){
				return Status.passwordNullity;
			}
			
			
			String username = request.getParameter("username");
			
			Long userId = null;
				
			User user = (User)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			userId = user.getUserId();
			
			
			User updateUser = new User();
			updateUser.setUserId(userId);
			updateUser.setPassword(MD5.GetMD5Code(MD5.GetMD5Code(password)+ LoginConstants.LOGIN_PASSWORD_PARAM));
			userDao.updateByPrimaryKeySelective(updateUser);
			
			return Status.success;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 验证登录密码是否正确
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Status validatePassword(String password,Long userId) throws Exception{
		
		try {
			
			
			if(!ValidateUtil.validateString(password, false, 1, 32)){
				
				return Status.passwordNullity;
			}
			
			User user2 = userDao.selectByPrimaryKey(userId);
			String pw = MD5.GetMD5Code(MD5.GetMD5Code(password) + LoginConstants.LOGIN_PASSWORD_PARAM);
			if(user2.getPassword().equals(pw)){
			
				return Status.success;
			}
			return Status.passwordInvalid;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 修改登录密码
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Status updateLoginPassword(String password,Long userId) throws Exception{
		
		try {
			
			
			if(!ValidateUtil.validateString(password, false, 1, 32)){
				
				return Status.passwordNullity;
			}
			
			String pw = MD5.GetMD5Code(MD5.GetMD5Code(password) + LoginConstants.LOGIN_PASSWORD_PARAM);
			
			User user2 = new User();
			user2.setUserId(userId);
			user2.setPassword(pw);
			userDao.updateByPrimaryKeySelective(user2);
			
			return Status.success;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public Status updateLoginPassword(String oldPwd,String newPwd, Long userId) throws Exception {
		try {
			
			if(!ValidateUtil.validateString(oldPwd, false, 1, 32)){
				
				return Status.passwordNullity;
			}
			
			User user2 = userDao.selectByPrimaryKey(userId);
			String pw = MD5.GetMD5Code(MD5.GetMD5Code(oldPwd) + LoginConstants.LOGIN_PASSWORD_PARAM);
			if(user2.getPassword().equals(pw)){
				String npw = MD5.GetMD5Code(MD5.GetMD5Code(newPwd) + LoginConstants.LOGIN_PASSWORD_PARAM);
				
				User user3 = new User();
				user3.setUserId(userId);
				user3.setPassword(npw);
				userDao.updateByPrimaryKeySelective(user3);
				
				return Status.success;
			}
			return Status.passwordInvalid;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public Status updateEmail(String email, Long userId) throws Exception {
		try {
			
			/*if(!ValidateUtil.isEmail(email)){
				
				return Status;
			}*/
			
			User user3 = new User();
			user3.setUserId(userId);
			user3.setEmail(email);
			userDao.updateByPrimaryKeySelective(user3);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return Status.success;
	}
	
	/**
	 * 检测微信收货地址，没有则新增
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public UserAddress insertWxAddressAfterCheck(HttpServletRequest request) throws Exception{
		
		try {
			//邮编 
			String zipcode = request.getParameter("zipcode");
			//省、市、具体地址
			String provinceName = request.getParameter("provinceName");
			String cityName = request.getParameter("cityName");
			String address = request.getParameter("address");
			//联系人、电话
			String contactMan = request.getParameter("contactMan");
			String contactPhone = request.getParameter("contactPhone");
			
			if(StringUtils.isAllNotEmpty(zipcode,provinceName,cityName,address,contactMan,contactPhone)){
				
				List<Area_V2> areaList = PhoneBaseData.getInstance().getProvinceList();
				
				String[] ss = PhoneBaseData.getInstance().getAreaCode(provinceName, cityName);
				Long provinceId = Long.valueOf(PhoneBaseData.getInstance().getAreaId(ss[0]));
				Long cityId = Long.valueOf(PhoneBaseData.getInstance().getAreaId(ss[1]));
				
				ConsoleUtil.println("address:"+address +",contactMan:"+contactMan+",contactPhone:"+contactPhone+",cityName:"+cityName+",provinceName:"+provinceName);
				ConsoleUtil.println("provinceId:"+provinceId+",cityId:"+cityId);
				//先检测hzd是否有了该用户的微信收货地址，没有则新增，否则不做处理
				User user = (User) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
				UserAddressExample addressExample = new UserAddressExample();
				UserAddressExample.Criteria criteria = addressExample.createCriteria();
				criteria.andUserIdEqualTo(user.getUserId());
				criteria.andContactManEqualTo(contactMan);
				criteria.andContactPhoneEqualTo(contactPhone);
				criteria.andAddressEqualTo(contactPhone);
				criteria.andCityEqualTo(cityId == null ? provinceId : cityId);
				criteria.andProvinceEqualTo(provinceId);
				
				List<UserAddress> list = userAddressDao.selectByExample(addressExample);
				
				ConsoleUtil.println("has address ?" + MyUtils.isListEmpty(list));
				
				if(MyUtils.isListEmpty(list)){
					UserAddress userAddress = new UserAddress();
					userAddress.setContactMan(contactMan);
					userAddress.setContactPhone(contactPhone);
					userAddress.setAddress(address);
					userAddress.setCity(cityId == null ? provinceId : cityId);
					userAddress.setProvince(provinceId);
					userAddress.setUserId(user.getUserId());
					userAddress.setIsDefault((byte)1);
					
					//查询默认的地址，修改成非默认
					UserAddress userAddress2 = this.getUserIdIs(user.getUserId());
					if(userAddress2 != null){
						userAddress2.setIsDefault((byte)0);
						this.update(userAddress2);
					}
					//新增微信的收货地址
					userAddressDao.insert(userAddress);
					
					return userAddress;
				}else{
					
					return list.get(0);
				}
				
			}
			
			return null;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	/**
	 * 查询我的好友
	 * @param userId
	 * @param time
	 * @return
	 * @throws Exception
	 */
	public List<User> queryMyFreinds(Long userId,Date time,List<Byte> queryStatusList) throws Exception{
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		queryMap.put("userId", userId);
		
		if(null != time){
			
			queryMap.put("agreeTime", time);
		}
		if(!MyUtils.isListEmpty(queryStatusList)){
			
			queryMap.put("queryStatusList", queryStatusList);
		}
		
		return userDao.selectMyFreinds(queryMap);
	}
	
	
	/**
	 * 我的好友 分页
	 * @param userId
	 * @param time
	 * @param queryStatusList
	 * @param pages
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<User> queryMyFreinds(Long userId,Date time,List<Byte> queryStatusList, Pages<User> pages) throws Exception{
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		queryMap.put("userId", userId);
		
		if(null != time){
			
			queryMap.put("agreeTime", time);
		}
		if(!MyUtils.isListEmpty(queryStatusList)){
			
			queryMap.put("queryStatusList", queryStatusList);
		}
		
		pages.setCountRows(userDao.countMyFriend(userId));
		
		queryMap.put("page", pages);
		
		return userDao.selectMyFreinds(queryMap);
	}
	
	/**
	 * 统计我的新的好友数
	 * @param userId
	 * @param time
	 * @return
	 * @throws Exception
	 */
	public int countMyNewFreinds(Long userId,Date time,List<Byte> queryStatusList) throws Exception{
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		queryMap.put("userId", userId);
		
		if(null != time){
			
			queryMap.put("agreeTime", time);
		}
		if(!MyUtils.isListEmpty(queryStatusList)){
			
			queryMap.put("queryStatusList", queryStatusList);
		}
		
		return userDao.countMyNewFreinds(queryMap);
	}
	
	
	/**
	 * 添加我的好友 同意/不同意
	 * @param userId
	 * @param freindId
	 * @param agreeType
	 * @return
	 * @throws Exception
	 */
	public Status updateAddMyFreinds(Long userId, String freindId,String agreeType) throws Exception{
		
		try {
			
			if(!ValidateUtil.validateInteger(freindId, false, 0, null)){
				
				return Status.useridNullity;
			}
			
			if(!ValidateUtil.validateInteger(agreeType, false, 1, 2)){
				
				return Status.agreeTypeNullity;
			}
			FreindsExample example = new FreindsExample();
			FreindsExample.Criteria criteria = example.createCriteria();
			criteria.andStatusIn(new ArrayList<Byte>(Arrays.asList(CommConstant.ADD_FREINDS_1)));
			criteria.addCriterion(" ((fr.freind_id = "+userId+" and fr.my_user_id = "+freindId+") or (fr.freind_id = "+freindId+" and fr.my_user_id = "+userId+"))");
			
			//已经是好友了
			if(freindsDao.countByExample(example) > 0){
				
				return Status.success;
			}
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("myUserId", userId);
			paramMap.put("freindId", freindId);
			paramMap.put("status", agreeType);
			paramMap.put("agreeTime", new Date());
			
			freindsDao.updateStatus(paramMap);
			
			return Status.success;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	
	/**
	 * 搜索好友
	 * @param userId
	 * @param keywords
	 * @return
	 * @throws Exception
	 */
	public List<User> searchFreinds(Long userId, String keywords, Pages<User> page) throws Exception{
		
		if(StringUtils.isEmptyNo(keywords)){
			
			return null;
		}
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("userId", userId);
		queryMap.put("keywords", "%"+keywords+"%");
		queryMap.put("page", page);
		
		List<Byte> queryStatusList = new ArrayList<Byte>();
		queryStatusList.add(CommConstant.ADD_FREINDS_1);
		queryMap.put("queryStatusList", queryStatusList);
		
		if(page!=null){
			page.setCountRows(userDao.countSearchFreinds(queryMap));
		}
		
		List<User> users = userDao.searchFreinds(queryMap);
		
		if(page!=null){
			page.setRoot(users);
		}
		return users;
	}
	
	
	
	
	/**
	 * 申请添加好友
	 * @param userId
	 * @param freindId
	 * @return
	 * @throws Exception
	 */
	public Status insertFreinds(Long userId, String freindId,String sendRemark) throws Exception{
		
		try {
			
			//查看该用户是否已是我的好友了（同意才算），不同意或者未处理的更新记录即可
			FreindsExample example = new FreindsExample();
			FreindsExample.Criteria criteria = example.createCriteria();
			
			criteria.addCriterion(" ((fr.my_user_id = " + userId + " and fr.freind_id = " + freindId + ") or (fr.my_user_id = " + freindId + " and fr.freind_id = " + userId + "))"); 
			
			List<Freinds> list = freindsDao.selectByExample(example);
			
			Date date = new Date();
			
			if(!MyUtils.isListEmpty(list)){
				
				for (Freinds freinds : list) {
					
					if(freinds.getStatus() == CommConstant.ADD_FREINDS_1){
						
						return Status.freindsIsAlreadyAdd;
					}
					
				}
				
				for (Freinds freinds : list) {
					
					if(freinds.getMyUserId().longValue() == userId.longValue() && freinds.getFreindId().longValue() == Long.valueOf(freindId)){
						
						freinds.setStatus(CommConstant.ADD_FREINDS_0);
						freinds.setSendRemark(sendRemark);
						freinds.setSendTime(date);
						freindsDao.updateByPrimaryKeySelective(freinds);
						
					}
					
				}
			}else{
				
				Freinds freinds = new Freinds();
				freinds.setAddType(TypeConstant.FREINDS_ADD_TYPE_1);
				freinds.setFreindId(Long.valueOf(freindId));
				freinds.setMyUserId(userId);
				freinds.setStatus(CommConstant.ADD_FREINDS_0);
				freinds.setSendRemark(sendRemark);
				freinds.setSendTime(date);
				freindsDao.insert(freinds);
			}
			
			return Status.success;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 保存赠送猪仔数量
	 * @param projectId
	 * @param sendNum
	 * @param freindId
	 * @param sendRemark
	 * @return
	 * @throws Exception
	 */
	public Status updateSendPigToFreinds(Long userId ,String nickname,String projectId, String sendNum,String password,String freindId, String sendRemark) throws Exception{
		
		try {
			
			if(null == userId || userId <= 0){
				
				return Status.login_first;
			}
			
			if(!ValidateUtil.validateInteger(projectId, false, 0, null)){
				
				return Status.projectidNullity;
			}
			if(!ValidateUtil.validateInteger(sendNum, false, 0, null)){
				
				return Status.numNullity;
			}
			if(!ValidateUtil.validateInteger(freindId, false, 0, null)){
				
				return Status.freindsIdNullity;
			}
			if(!ValidateUtil.validateString(sendRemark, true, 0, 200)){
				
				return Status.remarkNullity;
			}
			if(!ValidateUtil.validateString(password, false, 6, 6)){
				
				return Status.payPasswordNullity;
			}
			
			//是否为我的好友
			FreindsExample example = new FreindsExample();
			FreindsExample.Criteria criteria = example.createCriteria();
			
			criteria.addCriterion(" ((fr.my_user_id = " + userId + " and fr.freind_id = " + freindId + ") or (fr.my_user_id = " + freindId + " and fr.freind_id = " + userId + "))"); 
			criteria.andStatusEqualTo(CommConstant.ADD_FREINDS_1);
			
			if(freindsDao.countByExample(example) == 0){
				return Status.userIsNotYourFreinds;
			}
			
			//查询指定期用户的猪仔数量 ，检测送的数量是否符合要求
			MyEarningsExample example2 = new MyEarningsExample();
			MyEarningsExample.Criteria criteria2 = example2.createCriteria();
			
			criteria2.andUserIdIn(new ArrayList<Long>(Arrays.asList(userId,Long.valueOf(freindId))));
			criteria2.andPaincbuyProjectIdEqualTo(Long.valueOf(projectId));
			
			List<MyEarnings> list = myEarningsService.selectByExample(example2);
			
			if(MyUtils.isListEmpty(list)){
				
				return Status.myJoinedProjectNotExist;
			}
			
			//当前用户的收益
			MyEarnings myEarnings = null;
			//当前用户的好友的收益
			MyEarnings freindsEarnings = null;
			
			for (MyEarnings mer : list) {
				
				if(mer.getUserId().longValue() == userId){
					
					myEarnings = mer;
				}else if(mer.getUserId().longValue() == Long.valueOf(freindId)){
					
					freindsEarnings = mer;
				}
			}
			if(null == myEarnings){
				
				return Status.myJoinedProjectNotExist;
			}
			
			//查询该用户和好友是否已生成了 屠宰订单或领活猪的订单
			OrderExample orderExample = new OrderExample();
			OrderExample.Criteria criteria4 = orderExample.createCriteria();
			criteria4.andRelationIdEqualTo(myEarnings.getPaincbuyProjectId());
			criteria4.andTypeIn(new ArrayList<Byte>(Arrays.asList(OrderConstant.ORDER_TYPE_2,OrderConstant.ORDER_TYPE_3)));
			criteria4.andStatusNotEqualTo(OrderConstant.ORDER_STATUS_0);
			criteria4.andUserIdIn(new ArrayList<Long>(Arrays.asList(userId,Long.valueOf(freindId))));
			
			if(orderDao.countByExample(orderExample) > 0){
				
				return Status.cannotSendPigCauseCreateOrder;
			}
			
			
			//145天后不能确认回报方式了，那么同样不能赠送猪仔
			String d = sysConfigService.queryOneValue(SysConstant.CONFIRM_REWARDS_BEFORE_N_DAYS);
			
			Date limitTime = new Date();
			
			Date currentTime = new Date();
			
			if(StringUtils.isNotEmpty(d)){
				
				limitTime = MyUtils.dateFormat(MyUtils.addDate3(myEarnings.getEndTime(), -(Integer.valueOf(d))) + " 00:00:00",0);
			}
			
			//已过期限了不能再赠送了
			if(currentTime.after(limitTime)){
				
				return Status.cannotSendPigOverTime;
			}
			//已经处理了就不能赠送了
			if(myEarnings.getDealStatus() == CommConstant.DEAL_STATUS_1){
				
				return Status.cannotSendPigDealed;
			}
			
			if(myEarnings.getNum().intValue() - myEarnings.getPresentNum().intValue() < Integer.valueOf(sendNum)){
			
				return Status.pigNumNotEnought;
			}
			//剩余1头猪不能赠送
			if(myEarnings.getNum().intValue() - myEarnings.getPresentNum().intValue() <= 1){
				
				return Status.pigNumNotSendOnlyOne;
			}
			
			User user = userDao.selectByPrimaryKey(Long.valueOf(freindId));
			
			if(null == user){
				
				return Status.freindsNotExist;
			}
			
			//根据用户id和支付密码查询余额记录
			WalletExample example3 = new WalletExample();
			WalletExample.Criteria criteria3 = example3.createCriteria();
			criteria3.andUserIdEqualTo(userId);
			//查询余额记录
			List<Wallet> walletList = walletService.selectByExample(example3);
			
			if(MyUtils.isListEmpty(walletList)){
				
				return Status.payPasswordNotExist;
			}
			Wallet wallet = walletList.get(0);
			
			if(StringUtils.isEmptyNo(wallet.getPayPassword())){
				
				return Status.payPasswordNotExist;
			}
			
			//验证支付密码
			Status status = walletService.updateWalletPWErrorCount(wallet.getJson(), password, wallet.getPayPassword(), wallet.getWalletId());
			
			if(status != Status.success){
				
				return status;
			}
			//赠送的猪仔的收益
			BigDecimal addEarnings = myEarningsService.calcEarnings(Integer.valueOf(sendNum), myEarnings.getRate(), myEarnings.getMoney(), myEarnings.getDays());
			//好友没有收益则插入，否则修改
			if(null == freindsEarnings){
				
				freindsEarnings = new MyEarnings();
				freindsEarnings.setBeginTime(myEarnings.getBeginTime());
				freindsEarnings.setDays(myEarnings.getDays());
//				freindsEarnings.setBeforeDealType(myEarnings.getBeforeDealType());
				freindsEarnings.setDealStatus(CommConstant.DEAL_STATUS_0);
//				freindsEarnings.setDealTime(myEarnings.getDealTime());
//				freindsEarnings.setDealType(myEarnings.getDealType());
				freindsEarnings.setEndTime(myEarnings.getEndTime());
				freindsEarnings.setMoney(myEarnings.getMoney());
				freindsEarnings.setNum(Integer.valueOf(sendNum));
//				freindsEarnings.setOverDays(myEarnings.getOverDays());
//				freindsEarnings.setOverTime(myEarnings.getOverTime());
				freindsEarnings.setPaincbuyProjectId(myEarnings.getPaincbuyProjectId());
				freindsEarnings.setPaincbuyProjectName(myEarnings.getPaincbuyProjectName());
				freindsEarnings.setPresentNum(0);
				freindsEarnings.setRate(myEarnings.getRate());
				freindsEarnings.setUserId(Long.valueOf(freindId));
				
				freindsEarnings.setExpectEarning(addEarnings);
				
				myEarningsService.insert(freindsEarnings);
			}else{
				
				MyEarnings updateFreindsEarnings = new MyEarnings();
				updateFreindsEarnings.setEarningsId(freindsEarnings.getEarningsId());
				freindsEarnings.setNum(freindsEarnings.getNum() + Integer.valueOf(sendNum));
				updateFreindsEarnings.setNum(freindsEarnings.getNum());
				//加上收益
				updateFreindsEarnings.setExpectEarning(freindsEarnings.getExpectEarning().add(addEarnings));
				
				myEarningsService.updateByPrimaryKeySelective(updateFreindsEarnings);
			}
			
			MyEarnings updateMyEarnings = new MyEarnings();
			updateMyEarnings.setEarningsId(myEarnings.getEarningsId());
			updateMyEarnings.setPresentNum(myEarnings.getPresentNum() + Integer.valueOf(sendNum));
			//减去收益
			updateMyEarnings.setExpectEarning(myEarnings.getExpectEarning().subtract(addEarnings));
			
			myEarningsService.updateByPrimaryKeySelective(updateMyEarnings);
			
			//赠送记录
			myEarningsService.insertPresentRecord(freindsEarnings.getEarningsId(), user.getNickname() == null ? user.getUsername() : user.getNickname(), user.getUserId(), Integer.valueOf(sendNum), myEarnings.getEarningsId()
					, nickname, userId, myEarnings.getMoney(), TypeConstant.SEND_TYPE_PIG);
			
			String content = "您赠送给您的好友"+(user.getNickname() == null ? user.getUsername() : user.getNickname())+" "+sendNum+"头猪仔成功";
			//给用户发送系统消息
			messageService.insertMessage(userId, content, MessageConstant.SYS_MESSAGE_1, myEarnings.getEarningsId(), MessageConstant.MSG_RELATION_ID_EARNINGS);
			
			content = "您的好友"+nickname+"赠送给您"+sendNum+"头猪仔";
			
			if(StringUtils.isNotEmpty(sendRemark)){
				
				content += "。您的好友给您的留言："+sendRemark;
			}
			
			//给好友发送系统消息
			messageService.insertMessage(Long.valueOf(freindId), content, MessageConstant.SYS_MESSAGE_1, myEarnings.getEarningsId(), MessageConstant.MSG_RELATION_ID_EARNINGS);
			
			return Status.success;
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	/**
	 * 保存赠送猪肉券
	 * @param myCouponId
	 * @param sendMoney
	 * @param freindId
	 * @param sendRemark
	 * @return
	 * @throws Exception
	 */
	public Status updateSendPigCouponToFreinds(Long userId ,String nickname,String myCouponId, String sendMoney,String freindId, String password,String sendRemark) throws Exception{
		
		try {
			
			if(null == userId || userId <= 0){
				
				return Status.login_first;
			}
			
			if(!ValidateUtil.validateInteger(myCouponId, false, 0, null)){
				
				return Status.couponIdNullity;
			}
			if(!ValidateUtil.validateDoublue(sendMoney, false, 0f, null)){
				
				return Status.moneyNullity;
			}
			if(!ValidateUtil.validateInteger(freindId, false, 0, null)){
				
				return Status.freindsIdNullity;
			}
			if(!ValidateUtil.validateString(sendRemark, true, 0, 200)){
				
				return Status.remarkNullity;
			}
			
			if(!ValidateUtil.validateString(password, false, 6, 6)){
				
				return Status.payPasswordNullity;
			}

			//是否为我的好友
			FreindsExample example = new FreindsExample();
			FreindsExample.Criteria criteria = example.createCriteria();
			
			criteria.addCriterion(" ((fr.my_user_id = " + userId + " and fr.freind_id = " + freindId + ") or (fr.my_user_id = " + freindId + " and fr.freind_id = " + userId + "))"); 
			criteria.andStatusEqualTo(CommConstant.ADD_FREINDS_1);
			
			if(freindsDao.countByExample(example) == 0){
				
				return Status.userIsNotYourFreinds;
			}
			

			//我的猪肉券
			MyCouponExample couponExample = new MyCouponExample();
			MyCouponExample.Criteria couponCriteria = couponExample.createCriteria();
			couponCriteria.andUserIdEqualTo(userId);
			couponCriteria.andMyCouponIdEqualTo(Long.valueOf(myCouponId));
			
			List<MyCoupon> myCouponList = myCouponDao.selectByExample(couponExample);
			
			if(MyUtils.isListEmpty(myCouponList)){
				
				return Status.couponNotExist;
			}
			
			MyCoupon myCoupon = myCouponList.get(0);
			
			Date currentTime = new Date();
			
			//已过期
			if(myCoupon.getEndTime().before(currentTime)){
				
				return Status.couponIsOverTime;
			}
			
			//券的余额不足
			if(myCoupon.getCanUseMoney().doubleValue() < Double.valueOf(sendMoney)){
				
				return Status.couponLeftMoneyNotEnought;
			}
			
			User user = userDao.selectByPrimaryKey(Long.valueOf(freindId));
			
			if(null == user){
				
				return Status.freindsNotExist;
			}
			
			//根据用户id和支付密码查询余额记录
			WalletExample example3 = new WalletExample();
			WalletExample.Criteria criteria3 = example3.createCriteria();
			criteria3.andUserIdEqualTo(userId);
			//查询余额记录
			List<Wallet> walletList = walletService.selectByExample(example3);
			
			if(MyUtils.isListEmpty(walletList)){
				
				return Status.payPasswordNotExist;
			}
			Wallet wallet = walletList.get(0);
			
			if(StringUtils.isEmptyNo(wallet.getPayPassword())){
				
				return Status.payPasswordNotExist;
			}
			//验证支付密码
			Status status = walletService.updateWalletPWErrorCount(wallet.getJson(), password, wallet.getPayPassword(), wallet.getWalletId());
			
			if(status != Status.success){
				
				return status;
			}
			
						
			//新增一条我的券记录
			BigDecimal couponMoney = new BigDecimal(sendMoney);
				
			Long newCouponId = myEarningsService.insertPigCoupon(myCoupon.getBeginTime(), couponMoney, myCoupon.getCouponName(), myCoupon.getEndTime(), myCoupon.getMyCouponId(), TypeConstant.SEND_TYPE_PIG_COUPON
					, sendRemark, Long.valueOf(freindId), myCoupon.getCouponId());
			//修改
			MyCoupon updateCoupon = new MyCoupon();
			updateCoupon.setMyCouponId(myCoupon.getMyCouponId());
			updateCoupon.setLastUseTime(currentTime);
			updateCoupon.setCanUseMoney(myCoupon.getCanUseMoney().subtract(couponMoney));
			if(updateCoupon.getCanUseMoney().doubleValue() > 0){
				updateCoupon.setStatus(CommConstant.COUPON_STATUS_1);
			}else{
				updateCoupon.setStatus(CommConstant.COUPON_STATUS_2);
			}
			myCouponDao.updateByPrimaryKeySelective(updateCoupon);
			
			//添加使用记录
			myEarningsService.insertPigCouponUseRecord(updateCoupon.getCanUseMoney(), myCoupon.getCouponCode(), myCoupon.getCouponId(), myCoupon.getCouponMoney(), myCoupon.getMyCouponId()
						, null, "赠送好友"+user.getNickname(), null, null, null, couponMoney, userId, TypeConstant.COUPON_USE_TYPE_2);
			
			//赠送记录
			myEarningsService.insertPresentRecord(newCouponId, user.getNickname(), user.getUserId(), 1, myCoupon.getMyCouponId()
					, nickname, userId, couponMoney, TypeConstant.SEND_TYPE_PIG_COUPON);
			
			String content = "您成功赠送给您的好友"+user.getNickname()+""+couponMoney+"元的猪肉券";
			//给用户发送系统消息
			messageService.insertMessage(userId, content, MessageConstant.SYS_MESSAGE_1, myCoupon.getMyCouponId(), MessageConstant.MSG_RELATION_ID_COUPON);
			
			content = "您的好友"+nickname+"赠送给您"+couponMoney+"元的猪肉券";
			
			if(StringUtils.isNotEmpty(sendRemark)){
				
				content += "。您的好友给您的留言："+sendRemark;
			}
			
			//给好友发送系统消息
			messageService.insertMessage(Long.valueOf(freindId), content, MessageConstant.SYS_MESSAGE_1, myCoupon.getMyCouponId(), MessageConstant.MSG_RELATION_ID_COUPON);
			
			return Status.success;
			
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 查询我的券
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Pages<MyCoupon> selectMyCoupon(Long userId,Pages<MyCoupon> pages,boolean isPage) throws Exception{
		
		MyCouponExample example = new MyCouponExample();
		MyCouponExample.Criteria criteria = example.createCriteria();
		
		criteria.andUserIdEqualTo(userId);
		
		if(null == pages){
			
			pages = new Pages<MyCoupon>();
		}
		if(isPage){
			
			int count = myCouponDao.countByExample(example);
			pages.setCountRows(count);
			example.setPage(pages);
		}
		
		List<MyCoupon> list =  myCouponDao.selectByExample(example);
		pages.setRoot(list);
		
		return pages;
	}
	

	/**
	 * 查询我的券
	 * @param userId
	 * @param queryCouponId
	 * @return
	 * @throws Exception
	 */
	public MyCoupon selectMyCoupon(Long userId, String queryCouponId,String couponCode) throws Exception{
		
		if(!ValidateUtil.validateInteger(queryCouponId, false, 0, null)){
			
			return null;
		}
		
		MyCouponExample example = new MyCouponExample();
		MyCouponExample.Criteria criteria = example.createCriteria();
		
		if(null != userId && userId > 0){
			
			criteria.andUserIdEqualTo(userId);
		}
		if(StringUtils.isNotEmpty(queryCouponId)){
			
			criteria.andMyCouponIdEqualTo(Long.valueOf(queryCouponId));
		}
		if(StringUtils.isNotEmpty(couponCode)){
			
			criteria.andCouponCodeEqualTo(couponCode);
		}
		
		List<MyCoupon> list = myCouponDao.selectByExample(example);
		
		return MyUtils.isListEmpty(list) ? null : list.get(0);
		
	}
	
	
	/**
	 * 我的券消费记录
	 * @param userId
	 * @param queryCouponId
	 * @return
	 * @throws Exception
	 */
	public Pages<MyCouponUse> selectMyCouponUseDetail(Long userId, String queryCouponId,Pages<MyCouponUse> pages,boolean isPage) throws Exception{
		
		if(!ValidateUtil.validateInteger(queryCouponId, false, 0, null)){
			
			return null;
		}

		MyCouponUseExample useExample = new MyCouponUseExample();
		MyCouponUseExample.Criteria criteria = useExample.createCriteria();
		
		useExample.setOrderByClause("use_time desc");
		
		criteria.andUserIdEqualTo(userId);
		criteria.andMyCouponIdEqualTo(Long.valueOf(queryCouponId));
		if(null == pages){
			
			pages = new Pages<MyCouponUse>();
		}
		if(isPage){
			
			int count = myCouponUseDao.countByExample(useExample);
			pages.setCountRows(count);
			useExample.setPage(pages);
		}
		
		List<MyCouponUse> list =  myCouponUseDao.selectByExample(useExample);
		pages.setRoot(list);
		
		return pages;
	}
	
	
	/**
	 * 查询附近商家
	 * @param longtitude
	 * @param latitude
	 * @return
	 * @throws Exception
	 */
	public Pages<Shop> selectNearShop(String longtitude, String latitude,Pages<Shop> pages,boolean isPage) throws Exception{
		
		ShopExample example = new ShopExample();
		ShopExample.Criteria criteria = example.createCriteria();
		
		String city = sysConfigService.queryOneValue(SysConstant.PIG_COUPON_CAN_USE_CITY);
		
		if(StringUtils.isNotEmpty(city)){
			
			List<Long> idList = new ArrayList<Long>();
			
			String[] citys = city.split(",");
			
			for (String c : citys) {
				
				idList.add(Long.valueOf(c));
			}
			
			criteria.andCityIn(idList);
		}
		
		if(null == pages){
			
			pages = new Pages<Shop>();
		}
		
		if(isPage){
			
			int count = shopDao.countByExample(example);
			
			pages.setCountRows(count);
			
			example.setPage(pages);
		}
		
		if(StringUtils.isAllNotEmpty(latitude , longtitude)){
			
			example.setOrderByClause("("+latitude+" - LATITUDE)*("+latitude+" - LATITUDE) + cos("+latitude+" * 3.14159265358979323846 /180.0)* cos(LATITUDE * 3.14159265358979323846 /180.0) * ("+longtitude+" - LONGITUDE) * ("+longtitude+" - LONGITUDE )");
		}
		
		List<Shop> list = shopDao.selectByExample(example);
		
		pages.setRoot(list);
		
		return pages;
	}
	
	
	
	
	/**
	 * 用户扩展表
	 * @param example
	 * @return
	 * @throws Exception
	 */
	public UserExt selectUserExtByPrimaryKey(Long userId) throws Exception{
		
		return userExtDao.selectByPrimaryKey(userId);
	}
	/**
     * 联合查询，加载项目名称(未来10期)
     * @param example
     * @return
     * @throws Exception
     */
    public List<UserPreorder> selectLoadNameByUserId(Long userId) throws Exception{
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("beginTime", MyUtils.getYYYYMMDDHHmmss(0));
    	map.put("userId", userId);
    	map.put("top", 10);
    	
    	return userPreorderDao.selectLoadNameByMap(map);
    }
    
  /*  
    */
    
    /**
     * 设置抢标
     * @param userId
     * @param projectId
     * @param settingType
     * @param isCancel
     * @return
     * @throws Exception
     */
	public Status updateUserPreorder(Long userId, String projectId,String num,String settingType,boolean isCancel) throws Exception{
		
		try {
			
			if(null == userId || userId <= 0){
				
				return Status.useridNullity;
			}
			if(!ValidateUtil.validateInteger(settingType, false, 1, 2)){
				
				return Status.settingTypeNullity;
			}
			
			byte settype = Byte.valueOf(settingType);
			
			//设置某期抢标
			if(settype == TypeConstant.USER_SETTING_TYPE_2){
				
				if(!ValidateUtil.validateInteger(projectId, false, 0, null)){
					
					return Status.projectidNullity;
				}
				
				if(!isCancel){
					
					num = StringUtils.isEmptyNo(num) ? "0" : num;
					
					if(!ValidateUtil.validateInteger(num, false, 0, null)){
						
						return Status.numNullity;
					}
					//已有则更新，否则插入
					UserPreorder preorder = userPreorderDao.selectByPrimaryKey(Long.valueOf(projectId), userId);
					
					if(null == preorder){
						
						preorder = new UserPreorder();
						
						preorder.setUserId(userId);
						preorder.setProjectId(Long.valueOf(projectId));
						preorder.setCtime(new Date());
						preorder.setNum(Integer.valueOf(num));
						preorder.setUserId(userId);
						userPreorderDao.insert(preorder);
					}else{
						
						UserPreorder updatePreorder = new UserPreorder();
						updatePreorder.setUserId(userId);
						updatePreorder.setProjectId(preorder.getProjectId());
						updatePreorder.setNum(Integer.valueOf(num));
						updatePreorder.setCtime(new Date());
						userPreorderDao.updateByPrimaryKeySelective(preorder);
					}
					
					UserExt userExt = new UserExt();
					userExt.setSettingType(settype);
					userExt.setUserId(userId);
					userExt.setSettingTime(new Date());
					userExtDao.updateByPrimaryKeySelective(userExt);
				}else{
					
					UserPreorderExample example = new UserPreorderExample();
					UserPreorderExample.Criteria criteria = example.createCriteria();
					criteria.andUserIdEqualTo(userId);
					//查询是否为最后一个，是则默认全部不选
					if(userPreorderDao.countByExample(example) == 1){
						
						UserExt userExt = new UserExt();
						userExt.setSettingType(TypeConstant.USER_SETTING_TYPE_0);
						userExt.setUserId(userId);
						userExt.setSettingTime(new Date());
						userExtDao.updateByPrimaryKeySelective(userExt);
					}
					
					//取消设置
					userPreorderDao.deleteByPrimaryKey(Long.valueOf(projectId), userId);
				}
			}else if(settype == TypeConstant.USER_SETTING_TYPE_1){
				UserExt userExt = new UserExt();
				userExt.setSettingType(settype);
				if(isCancel){
					userExt.setSettingType(TypeConstant.USER_SETTING_TYPE_0);
				}else{
					
					UserPreorderExample example = new UserPreorderExample();
					UserPreorderExample.Criteria criteria = example.createCriteria();
					criteria.andUserIdEqualTo(userId);
					List<UserPreorder> list = userPreorderDao.selectByExample(example);
					
					for (UserPreorder up : list) {
						
						userPreorderDao.deleteByPrimaryKey(up.getProjectId(), userId);
					}
				}
				userExt.setUserId(userId);
				userExt.setSettingValue(Integer.valueOf(num));
				userExt.setSettingTime(new Date());
				userExtDao.updateByPrimaryKeySelective(userExt);
				
				
			}
			
			return Status.success;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
    
    
  
    
    
    
    
    
    /**
     * 设置抢标
     * @param userId
     * @param projectId
     * @param settingType
     * @param isCancel
     * @return
     * @throws Exception
     *//*
	public Status updateUserPreorder(Long userId, String projectId,String num,String settingType,boolean isCancel) throws Exception{
		System.out.println("jinlai  a a ddnddjjisddbsdb");
		try {
			
			if(null == userId || userId <= 0){
				
				return Status.useridNullity;
			}
			if(!ValidateUtil.validateInteger(settingType, false, 1, 2)){
				
				return Status.settingTypeNullity;
			}
			
			byte settype = Byte.valueOf(settingType);
			System.out.println("??????????");
			//设置某期抢标
			if(settype == TypeConstant.USER_SETTING_TYPE_2){
			System.out.println("d1111111111111111");	
				if(!ValidateUtil.validateInteger(projectId, false, 0, null)){
				
					return Status.projectidNullity;
				}
				System.out.println("d2222222222222222");
				if(!isCancel){
					System.out.println("d333333333333");
					num = StringUtils.isEmptyNo(num) ? "0" : num;
					
					if(!ValidateUtil.validateInteger(num, false, 0, null)){
						
						return Status.numNullity;
					}
					//已有则更新，否则插入
					UserPreorder preorder = userPreorderDao.selectByPrimaryKey(Long.valueOf(projectId), userId);
					
					if(null == preorder){
						
						preorder = new UserPreorder();
						
						preorder.setUserId(userId);
						preorder.setProjectId(Long.valueOf(projectId));
						preorder.setCtime(new Date());
						preorder.setNum(Integer.valueOf(num));
						preorder.setUserId(userId);
						System.out.println("lalalalalalalalalalal");
						userPreorderDao.insert(preorder);
					}else{
						
						UserPreorder updatePreorder = new UserPreorder();
						updatePreorder.setUserId(userId);
						updatePreorder.setProjectId(preorder.getProjectId());
						updatePreorder.setNum(Integer.valueOf(num));
						updatePreorder.setCtime(new Date());
						System.out.println("lal22222222222222222222");
						userPreorderDao.updateByPrimaryKeySelective(preorder);
					}
					
					UserExt userExt = new UserExt();
					userExt.setSettingType(settype);
					userExt.setUserId(userId);
					userExt.setSettingTime(new Date());
					userExtDao.updateByPrimaryKeySelective(userExt);
				}else{
					System.out.println("lal333333333333");
					UserPreorderExample example = new UserPreorderExample();
					UserPreorderExample.Criteria criteria = example.createCriteria();
					criteria.andUserIdEqualTo(userId);
					//查询是否为最后一个，是则默认全部不选
					if(userPreorderDao.countByExample(example) == 1){
						System.out.println("lal444444444444444444");
						UserExt userExt = new UserExt();
						userExt.setSettingType(TypeConstant.USER_SETTING_TYPE_0);
						userExt.setUserId(userId);
						userExt.setSettingTime(new Date());
						userExtDao.updateByPrimaryKeySelective(userExt);
					}
					
					//取消设置
					userPreorderDao.deleteByPrimaryKey(Long.valueOf(projectId), userId);
				}
			}
			
			
			
			
			else if(settype == TypeConstant.USER_SETTING_TYPE_1){
				System.out.println("0000000000000000000000qq");
				UserExt userExt = new UserExt();
				userExt.setSettingType(settype);
				if(isCancel){
					userExt.setSettingType(TypeConstant.USER_SETTING_TYPE_0);
				}else{
					
					UserPreorderExample example = new UserPreorderExample();
					UserPreorderExample.Criteria criteria = example.createCriteria();
					criteria.andUserIdEqualTo(userId);
					List<UserPreorder> list = userPreorderDao.selectByExample(example);
					
					for (UserPreorder up : list) {
						
						userPreorderDao.deleteByPrimaryKey(up.getProjectId(), userId);
					}
				}
				userExt.setUserId(userId);
				userExt.setSettingValue(Integer.valueOf(num));
				userExt.setSettingTime(new Date());
				System.out.println("userExt num="+userExt.getSettingValue());
				userExtDao.updateByPrimaryKeySelective(userExt);
				System.out.println("ooooooooooooooooooooooooooo");
				
			}
			System.out.println("cccc");
			return Status.success;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}*/
	
	/**
     * 查询我的券
     * @param couponExample
     * @return
     * @throws Exception
     */
	public List<MyCoupon> selectMyCouponByExample(MyCouponExample couponExample) throws Exception{
		
		return myCouponDao.selectByExample(couponExample);
	}
	
//	@Override
//	public void insert(Opinion opinion) throws Exception {
//		opinionDao.insert(opinion);
//	}
		
	
	/**
	 * 重新设置二维码的访问地址，旧的图片有不bug
	 * @param user
	 * @throws Exception
	 */
	public void updateQRCodeAccessUrl() throws Exception{
		
		List<User> userList = userDao.selectByExample(new UserExample());
		
		List<String> codeList = new ArrayList<String>(Arrays.asList(SysConstant.PROJECT_IMG_ACCESS_URL,SysConstant.PROJECT_IMG_UPLOAD_ROOT_PATH
				,SysConstant.QR_CODE_URL,SysConstant.PROJECT_ACCESS_URL));
		
		List<SysConfig> list = sysConfigService.queryList(codeList);
		
		if(!MyUtils.isListEmpty(list)){
			
			//二维码url
			String url = null;
			//图片存储根路径
			String imgPath = null;
			//访问地址
			String accessUrl = null;
			//项目地址
			String projectUrl = null;
			for (SysConfig syscon : list) {
				
				if(SysConstant.PROJECT_IMG_ACCESS_URL.equals(syscon.getCode())){
					//http://testweixin.hzd.com/
					url = syscon.getValue();
				}else if(SysConstant.QR_CODE_URL.equals(syscon.getCode())){
					
					///wpnv/ixhome?inviteCode=
					accessUrl = syscon.getValue();
				}else if(SysConstant.PROJECT_ACCESS_URL.equals(syscon.getCode())){
					
					///wpnv/ixhome?inviteCode=
					projectUrl = syscon.getValue();
				}else{
					///mnt/tomcat_bjwg/webapps/ROOT/resources/
					imgPath = syscon.getValue();
				}
			}
			if(StringUtils.isAllNotEmpty(url,imgPath)){
				
				
				String filePath = "/" + MyUtils.getYYYYMMDD(0)+ToolKit.getInstance().getSingleConfig(FileConstant.UPLOAD_INVITE_CODE_PATH)+"/";
				
				for (User user : userList) {
					
					String imgName = "qr_"+System.currentTimeMillis()+".jpg";
					//二维码
					FileUtils.createQRCodeFile(projectUrl+accessUrl+user.getInviteCode(), imgPath+filePath, imgName, "jpg");
					
					user.setQrCode(url + filePath +imgName);
				}
				
				User updateUser = null;
				for (User user : userList) {
					updateUser = new User();
					updateUser.setUserId(user.getUserId());
					updateUser.setQrCode(user.getQrCode());
					userDao.updateByPrimaryKeySelective(updateUser);
				}
			}
		}
	}
	
	
	/**
	 * 删除好友
	 * @param userId
	 * @param freindsId
	 * @return
	 * @throws Exception
	 */
	public Status deleteAddMyFreinds(Long userId, String freindsId) throws Exception{
		
		try {
			
			if(!ValidateUtil.validateInteger(freindsId, false, 0, null)){
				
				return Status.freindsIdNullity;
			}
			
			FreindsExample example = new FreindsExample();
			FreindsExample.Criteria criteria = example.createCriteria();
//			criteria.andStatusIn(new ArrayList<Byte>(Arrays.asList(CommConstant.ADD_FREINDS_1)));
			criteria.addCriterion(" ((fr.freind_id = "+userId+" and fr.my_user_id = "+freindsId+") or (fr.freind_id = "+freindsId+" and fr.my_user_id = "+userId+"))");
			
			List<Freinds> freindsList = freindsDao.selectByExample(example);
			
			//删除彼此之间的关系
			if(!MyUtils.isListEmpty(freindsList)){
				
				Map<String, Long> map = new HashMap<String, Long>();
				for (Freinds freinds : freindsList) {
					map.put("myUserId", freinds.getMyUserId());
					map.put("freindId", freinds.getFreindId());
					freindsDao.delete(map);
				}
			}
			
			return Status.success;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	/**
	 * 查询企业信息
	 */
	public List<User> getEpInfo(Long userId){
	
		return 	userDao.selectEpInfo(userId);		
	}

	@Override
	public User selectByUsername(String username) {
         
		return userDao.selectByUsername(username);
	}
}
