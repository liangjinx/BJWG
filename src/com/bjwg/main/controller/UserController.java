package com.bjwg.main.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.base.Pages;
import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.FileConstant;
import com.bjwg.main.constant.RedirectConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.constant.VerifyCodeConstant;
import com.bjwg.main.model.Bulletin;
import com.bjwg.main.model.Message;
import com.bjwg.main.model.MessageExample;
import com.bjwg.main.model.MyCoupon;
import com.bjwg.main.model.MyCouponExample;
import com.bjwg.main.model.MyCouponUse;
import com.bjwg.main.model.Shop;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserCenter;
import com.bjwg.main.model.UserExt;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.model.UserPreorder;
import com.bjwg.main.service.CommonService;
import com.bjwg.main.service.MessageService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.VerifyPhoneService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.JsonUtils;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.PersonalCookie;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.UploadFile;
import com.bjwg.main.weixin.WeiXinLocation;

/**
 * @author chen
 * @version 创建时间：2015-4-15 下午09:26:50
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：个人中心
 */
@Controller
@Scope("prototype")
public class UserController extends BaseController{
	
	@Autowired
	private UserService userService;
	@Autowired
	private VerifyPhoneService verifyPhoneService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private SysConfigService sysConfigService;
	@Autowired
	private CommonService commonService;
	
	/**
	 * 跳转我的猪场(个人中心)
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urstoreMe", method = { RequestMethod.GET,RequestMethod.POST })
	public String storeMe(HttpServletRequest request) throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urstoreMe -- > user:"+user + " --> userId:"+userId);
			
			//获取的信息包括：钱包、猪仔、总收益(不包括到账收益)
			UserCenter userCenter = userService.selectUserCenterData(userId);
			
			request.setAttribute("userCenter", userCenter);
			
			List<SysConfig> serviceList = (List<SysConfig>)request.getSession().getAttribute("serviceList");
			
			if(MyUtils.isListEmpty(serviceList)){
				
				//查询客服热线和qq客户
				List<String> codeList = new ArrayList<String>(Arrays.asList(SysConstant.SYS_MANAGE_CUSTOMER_SERVICE_PHONE,SysConstant.SYS_MANAGE_CUSTOMER_SERVICE_QQ,SysConstant.SYS_MANAGE_CUSTOMER_SERVICE_QQ_GROUP));
				
				serviceList = sysConfigService.queryList(codeList);
				
				request.setAttribute("serviceList", serviceList);
			}
			
					
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转我的猪场 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return "user/my_pig_farm";
	}
	
	/**
	 * 跳转我的好友
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urmyFriends", method = { RequestMethod.GET,RequestMethod.POST })
	public String myFriends(HttpServletRequest request) throws Exception {
		try {
			
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urmyFriends -- > user:"+user + " --> userId:"+userId);
			
			String type = request.getParameter("type");
			
			Date time = null;
			
			List<Byte> queryStatusList = new ArrayList<Byte>();
			
			//新的好友
			if(StringUtils.isNotEmpty(type) && "new".equals(type)){
				
				String days = sysConfigService.queryOneValue(SysConstant.NEW_FREINDS_FILTER_TIME);
				
				if(StringUtils.isNotEmpty(days)){
					
					time = MyUtils.dateFormat(MyUtils.addDate3(new Date(), -Integer.valueOf(days)) + " 00:00:00" , 0);
				}
				
				queryStatusList.add(CommConstant.ADD_FREINDS_0);
			}else{
				
				String days = sysConfigService.queryOneValue(SysConstant.NEW_FREINDS_FILTER_TIME);
				
				if(StringUtils.isNotEmpty(days)){
					
					time = MyUtils.dateFormat(MyUtils.addDate3(new Date(), -Integer.valueOf(days)) + " 00:00:00" , 0);
				}
				
				queryStatusList.add(CommConstant.ADD_FREINDS_0);
				
				request.setAttribute("newFreindsCount", userService.countMyNewFreinds(userId, time, queryStatusList));
				
				queryStatusList.remove(0);
				
				queryStatusList.add(CommConstant.ADD_FREINDS_1);
				
				time = null;
			}
			
			List<User> freindsList = userService.queryMyFreinds(userId,time,queryStatusList);
			
			request.setAttribute("freindsList", freindsList);
			
			if(!MyUtils.isListEmpty(freindsList)){
				
				//查询我所有未使用完的猪肉券
				MyCouponExample couponExample = new MyCouponExample();
				MyCouponExample.Criteria criteria = couponExample.createCriteria();
				
				criteria.andUserIdEqualTo(userId);
				criteria.andStatusNotEqualTo(CommConstant.COUPON_STATUS_2);
				
				List<MyCoupon> couponList = userService.selectMyCouponByExample(couponExample);
				
				/*测试数据
				  List<MyCoupon> list = new ArrayList<MyCoupon>();
				for (int i = 0; i<15;i++) {
					list.addAll(couponList);
				}
				couponList = list;*/
				request.setAttribute("couponList", couponList);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转我的好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return "user/my_freinds";
	}
	/**
	 * 搜索好友
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/ursearchFriends", method = { RequestMethod.GET,RequestMethod.POST })
	public String searchFriends(HttpServletRequest request) throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/searchFriends -- > user:"+user + " --> userId:"+userId);
			
			String keywords = request.getParameter("keywords");
			
			List<User> freindsList = userService.searchFreinds(userId,keywords, null);
			
			request.setAttribute("freindsList", freindsList);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("搜索好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return "user/search_freinds";
	}
	
	/**
	 * 申请好友
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urapplyFriends", method = { RequestMethod.GET,RequestMethod.POST })
	public String applyFriends(HttpServletRequest request) throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/searchFriends -- > user:"+user + " --> userId:"+userId);
			
			String freindId = request.getParameter("freindId");
			
			String sendRemark = request.getParameter("sendRemark");
			
			Status status = userService.insertFreinds(userId,freindId,sendRemark);
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("搜索好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return "user/search_freinds";
	}
	
	/**
	 * 同意/不同意加为好友
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/uraddMyFriends", method = { RequestMethod.GET,RequestMethod.POST })
	public String addMyFriends(HttpServletRequest request) throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
			
			String agreeType = request.getParameter("agreeType");
			
			String freindsId = request.getParameter("freindsId");
			
			Status status = userService.updateAddMyFreinds(userId,freindsId,agreeType);
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("同意/不同意加为好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return this.myFriends(request);
	}
	
	
	/**
	 * 送猪仔
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/ursendPig",method = {RequestMethod.POST,RequestMethod.GET})
	public String sendPig(HttpServletRequest request) throws Exception{
		
		String freindId = request.getParameter("freindId");
		
		String pageSource = request.getParameter("pageSource");
		
		String projectId = request.getParameter("projectId");
		
		Status status = Status.success;
		try {
			
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			String nickname = user.getNickname() != null ? user.getNickname() : user.getUsername();
			
			ConsoleUtil.println("/wpnv/urmyFriends -- > user:"+user + " --> userId:"+userId);
			
			String sendNum = request.getParameter("sendNum");
			
			String sendRemark = request.getParameter("sendRemark");
			
			String password = request.getParameter("password");
			
			status = userService.updateSendPigToFreinds(userId,nickname,projectId,sendNum,password,freindId,sendRemark);
			
			this.notifyMsg(request, status);
			
			//这里简要处理了，本想具体的提示返回具体的页面的，太麻烦了，统一返回原始入口页面
			if(Status.success == status){
				
				if(RedirectConstant.MY_PIGLETS.equals(pageSource)){
					
					return "redirect:/wpnv/ixpigGrow?queryProjectId="+projectId+"&msgCode="+status.getStatus();
				}else{
					
					return myFriends(request);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转我的好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		if(RedirectConstant.MY_PIGLETS.equals(pageSource)){
			
			return "redirect:/wpnv/ixpigGrow?queryProjectId="+projectId+"&msgCode="+status.getStatus();
		}else{
			
			return myFriends(request);
		}
		
	}
	
	/**
	 * 送券
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/ursendCoupon",method = {RequestMethod.POST,RequestMethod.GET})
	public String sendCoupon(HttpServletRequest request) throws Exception{
		
		
		String pageSource = request.getParameter("pageSource");
		
		String myCouponId = request.getParameter("myCouponId");
		
		Status status = Status.success;
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			String nickname = null != user ? user.getNickname() : null;
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urmyFriends -- > user:"+user + " --> userId:"+userId);
			
			String sendMoney = request.getParameter("sendMoney");
			
			String sendRemark = request.getParameter("sendRemark");
			
			String freindId = request.getParameter("freindId");
			
			String password = request.getParameter("password");
			
			status = userService.updateSendPigCouponToFreinds(userId, nickname, myCouponId, sendMoney, freindId, password,sendRemark);
			
			this.notifyMsg(request, status);
			
			if(Status.success == status){
				
				if(RedirectConstant.MY_COUPON_DETAIL.equals(pageSource)){
					
					return "redirect:/wpv/urmyCouponDetail?queryCouponId="+myCouponId+"&msgCode="+status.getStatus();
				}else{
					
					return myFriends(request);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转我的好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		if(RedirectConstant.MY_COUPON_DETAIL.equals(pageSource)){
			
			return "redirect:/wpv/urmyCouponDetail?queryCouponId="+myCouponId+"&msgCode="+status.getStatus();
		}else{
			
			return myFriends(request);
		}
	}
	
	
	/**
	 * 我的券
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/urmyCoupon",method = {RequestMethod.POST,RequestMethod.GET})
	public String myCoupon(HttpServletRequest request) throws Exception{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urmyCoupon -- > user:"+user + " --> userId:"+userId);
			
			Pages<MyCoupon> pages = userService.selectMyCoupon(userId,null,false);
			
			request.setAttribute("list", pages.getRoot());
			
			String city = sysConfigService.queryOneValue(SysConstant.PIG_COUPON_CAN_USE_CITY);
			
			if(StringUtils.isNotEmpty(city)){
				
				String[] citys = city.split(",");
				
				StringBuffer stringBuffer = new StringBuffer("");
				
				for (String c : citys) {
					
					stringBuffer.append(PhoneBaseData.getInstance().getArea_V2Name(c)+",");
				}
				
				request.setAttribute("limitCity", stringBuffer.substring(0,stringBuffer.length() - 1));
			}
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("我的券 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "user/my_coupon";
	}
	/**
	 * 我的券详情
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/urmyCouponDetail",method = {RequestMethod.POST,RequestMethod.GET})
	public String myCouponDetail(HttpServletRequest request) throws Exception{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urmyCouponDetail -- > user:"+user + " --> userId:"+userId);
			
			String queryCouponId = request.getParameter("queryCouponId");
			
			if(null != userId && userId >= 0){
				
				MyCoupon myCoupon = userService.selectMyCoupon(userId,queryCouponId,null);
				
				request.setAttribute("myCoupon", myCoupon);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("我的券详情 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		this.notifyMsgByRedirectCode(request);
		
		return "user/my_coupon_detail";
	}
	/**
	 * 我的券详情(无需登录)
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpnv/urmyCouponDetail",method = {RequestMethod.POST,RequestMethod.GET})
	public String myCouponDetail2(HttpServletRequest request) throws Exception{
		
		try {
			
			String queryCouponCode = request.getParameter("queryCouponCode");
			
			MyCoupon myCoupon = userService.selectMyCoupon(null,null,queryCouponCode);
			
			request.setAttribute("myCoupon", myCoupon);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("我的券详情(无需登录) 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "user/my_coupon_detail";
	}
	/**
	 * 我的券消费记录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/urmyCouponUse",method = {RequestMethod.POST,RequestMethod.GET})
	public String myCouponUse(HttpServletRequest request) throws Exception{
		
		try {
			
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urmyCouponUseDetail -- > user:"+user + " --> userId:"+userId);
			
			String queryCouponId = request.getParameter("queryCouponId");
			
			Pages<MyCouponUse> pages = userService.selectMyCouponUseDetail(userId,queryCouponId,null,false);
			
			request.setAttribute("list", pages != null ? pages.getRoot() : null);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("我的券消费记录 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "user/my_coupon_use";
	}
	/**
	 * 附近的店铺
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/urnearShop",method = {RequestMethod.POST,RequestMethod.GET})
	public String nearShop(HttpServletRequest request) throws Exception{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urnearShop -- > user:"+user + " --> userId:"+userId);
			
			String openId = (String)request.getSession().getAttribute(CommConstant.SESSION_OPENID);
			
			ConsoleUtil.println("获取session中的openid："+openId);
			
			String longtitude = null;
			String latitude = null;
			//是否是微信端
			if(MyUtils.isWx(request)) {
				
				if(StringUtils.isEmptyNo(openId)){
					
					openId = userId + "";
				}
				ConsoleUtil.println("shop openId:" + openId);
				
				if(StringUtils.isNotEmpty(openId)){
					
					String s[] = WeiXinLocation.getInstance().getLocations(openId);
					
					ConsoleUtil.println("current loaction:" + s);
					
					if(null != s){
						if(s.length == 2){
							
							longtitude = s[0];
							latitude = s[1];
						}
					}else{
						
						return "redirect:/wpnv/ixlaglot";
					}
				}
			}
			
			
			Pages<Shop> pages = userService.selectNearShop(longtitude,latitude,null,false);
			
			List<Shop> list = pages.getRoot();
			
			if(StringUtils.isAllNotEmpty(longtitude,latitude)){
				
				for (Shop shop : list) {
					Double formatDistance = MyUtils.Distance(Double.valueOf(longtitude),Double.valueOf(latitude), shop.getLongitude().doubleValue(),shop.getLatitude().doubleValue());
					ConsoleUtil.println("distance:"+formatDistance);
					shop.setDistance(MyUtils.formatDistance2(formatDistance));
				}
			}
			
			request.setAttribute("list", list);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("附近的店铺 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "user/nearbyStore";
	}
	
	
	
	/**
	 * 跳转至设置页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/ursetting",method = {RequestMethod.POST,RequestMethod.GET})
	public String setting(HttpServletRequest request ) throws Exception{
		
		
		return "user/setting";
	}
	
	/**
	 * 跳转关于我们页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/urgetAbout",method = {RequestMethod.POST,RequestMethod.GET})
	public String getAbout(HttpServletRequest request ){
		return "user/store.about";
	}

	/**
	 * 跳转意见反馈
	 * @param request
	 * @return
	 
	@RequestMapping(value="getFeedback",method = {RequestMethod.POST,RequestMethod.GET})
	public String getFeedback(HttpServletRequest request ){
		return "user/store.feedback";
	}
	*/
	/**
	 * 上传个人logo
	 */
	@RequestMapping(value = "/wpv/uruploadHeadImg", method = {RequestMethod.POST,RequestMethod.GET})
	public String uploadImg(HttpServletRequest request){
		
		try{
			
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Map<String, Object> dataMap = UploadFile.uploadSingleFile(request, FileConstant.UPLOAD_HEAD_IMG);
			
			Status status = (Status)dataMap.get("status");
			
			if(Status.success == status){
				
				String filePath = (String)dataMap.get("filePath");
				
				if(!StringUtils.isEmptyNo(filePath))
				{
					User user2 = new User();
					user2.setUserId(user.getUserId());
					user2.setHeadImg(filePath);
					userService.saveLogo(user2);
					
					user.setHeadImg(filePath);
					//修改保存session
					request.getSession().setAttribute(CommConstant.SESSION_MANAGER, user);
				}
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("上传个人logo出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return null;
	}
	
	/**
	 * 上传图片ajax
	 * @param request
	 * @param fresh 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/wpv/uruploadHeadImgAjax", method = {RequestMethod.GET,RequestMethod.POST}, produces = "application/json; charset=utf-8")
	public String fresh_upload(HttpServletRequest request,HttpServletResponse response) throws Exception{
		response.addHeader("Access-Control-Allow-Origin", "*");
		org.json.JSONObject json=new org.json.JSONObject();
		try{
			Map<String, Object> dataMap = UploadFile.uploadSingleFile(request, FileConstant.UPLOAD_HEAD_IMG);
			
			Status status = (Status)dataMap.get("status");
			
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			if(Status.success == status){
				
				String filePath = (String)dataMap.get("filePath");
				
				if(!StringUtils.isEmptyNo(filePath))
				{
					User user2 = new User();
					user2.setUserId(user.getUserId());
					user2.setHeadImg(filePath);
					userService.saveLogo(user2);
					
					user.setHeadImg(filePath);
					//修改保存session
					request.getSession().setAttribute(CommConstant.SESSION_MANAGER, user);
				}
			}
			
			json = JsonUtils.getJsonObject(status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("上传个人logo出错",e);
			json = JsonUtils.getJsonObject(Status.fileUploadError);
		}finally{
			
			return json.toString();
		}
		
	}	
	
	/**
	 * 意见反馈
	 * @param opinion
	 * @param request
	 * @return
	 
	@RequestMapping(value = "/saveOpinion", method = {RequestMethod.POST,RequestMethod.GET})
	public String saveOpinion(Opinion opinion,HttpServletRequest request){
		
		try{
			User user = (User)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			if(opinion!=null && StringUtils.isNotEmpty(opinion.getContent())
					&& user != null ){
				
				opinion.setType((short)1);
				opinion.setUserId(user.getUserId());
				userService.insert(opinion);
				
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("意见反馈出错",e);
		}
		
		
		return "redirect:/index/storeMe?opinion=-1";
	}*/
	
	
	
	
	/**
	 * 跳转个人资料
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/uruserInfo", method = {RequestMethod.POST,RequestMethod.GET})
	public String userInfo(HttpServletRequest request){
		
		return "user/personage_info";
	}
	
	/**
	 * 修改个人信息页面
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/uruserInfoModifyPage", method = {RequestMethod.POST,RequestMethod.GET})
	public String userInfoModify(HttpServletRequest request){
		try{
			String r_type = request.getParameter("r_type");
			if(StringUtils.isNotEmpty(r_type)){
				int t = Integer.valueOf(r_type);
				if(t == RedirectConstant.USER_INFO_MODIFY_PHONE){
					
					return "user/modify_userphone";
				}else if(t == RedirectConstant.USER_INFO_MODIFY_USERNAME){
					
					return "user/modify_username";
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("修改个人信息页面",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return userInfo(request);
	}
	/**
	 * 保存个人信息
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/uruserInfoSave", method = {RequestMethod.POST,RequestMethod.GET})
	public String userInfoSave(HttpServletRequest request){
		try {
			
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			String nickName = request.getParameter("nickName");
			
			String sex = request.getParameter("sex");
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
			
			Status status = userService.updateUserNickNameOrSex(nickName, sex,userId);
				
			if(Status.success == status){
				
				if(StringUtils.isNotEmpty(nickName)){
					
					user.setNickname(nickName);
				}
				
				if(StringUtils.isNotEmpty(sex)){
					
					user.setSex(Byte.valueOf(sex));
				}
				
				//同步session中的user信息
				request.getSession().setAttribute(CommConstant.SESSION_MANAGER, user);
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("保存个人信息 出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return userInfo(request);
	}
	
	
	/**
	 * 更换手机号页面1
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urphoneChangePage1", method = {RequestMethod.POST,RequestMethod.GET})
	public String userPhoneChange1(HttpServletRequest request){
		
		return "user/phone_change1";
	}
	/**
	 * 更换手机号页面2
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urphoneChangePage2", method = {RequestMethod.POST,RequestMethod.GET})
	public String userPhoneChange2(HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urphoneChangePage2 -- > user:"+user + " --> userId:"+userId);
			
			//验证码		I - L： 4 -N
			String code = request.getParameter("verifyCode");
			
			Status status = verifyPhoneService.updateBindNewPhone(userId, user.getBindPhone(), code, VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD);

			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("验证发送的验证码出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "user/phone_change2";
	}
	/**
	 * 更换为新手机号
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urphoneChangeNew", method = {RequestMethod.POST,RequestMethod.GET})
	public String userPhoneChangeNew(HttpServletRequest request){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			//手机号码	I - L：11 - N
			String phone = request.getParameter("phone");
			//验证码		I - L： 4 -N
			String code = request.getParameter("verifyCode");
				
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urphoneChangePage2 -- > user:"+user + " --> userId:"+userId);
			
			Status status = verifyPhoneService.updateBindNewPhone(userId, phone, code, VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW);
			
			this.notifyMsg(request, status);
			
			if(Status.success != status){
				
				return "user/phone_change2";
			}
			
			//成功则同步session中的信息
			user.setBindPhone(phone);
			
			request.getSession().setAttribute(CommConstant.SESSION_MANAGER, user);
			
			return "redirect:/wpv/urphoneChangeSuccess";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("更换为新手机号出错",e);
		}
		return "user/phone_chang_success";
	}
	
	/**
	 * 更换为新手机号成功
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urphoneChangeSuccess", method = {RequestMethod.POST,RequestMethod.GET})
	public String phoneChangeSuccess(HttpServletRequest request){
		
		return "user/phone_chang_success";
	}
	
	
	/**
	 * 查询个人消息
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urpersonalMsg", method = {RequestMethod.POST,RequestMethod.GET})
	public String personalMsg(Integer currentPage,HttpServletRequest request) throws Exception{
		
		try {
			//不知道要不要分页
			/*Pages<Message> page = new Pages<Message>();
			page.setPerRows(10);
			page.setCurrentPage(currentPage);*/
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			MessageExample example = new MessageExample();
			MessageExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(user.getUserId());
			example.setOrderByClause(" msg.ctime desc ");
			
			List<Message> list = messageService.selectByExample(example);
			
			for (Message message : list) {
				message.setFmtTime(MyUtils.dateFormat5(message.getCtime()));
			}
			request.setAttribute("list", list);
			
			//标记消息为已读
			messageService.updateStatus(user.getUserId());
			
			Pages<Bulletin> pages = commonService.selectBulletin(null, false);
			
			request.setAttribute("bulletinList", pages.getRoot());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
		return "user/personal_msg";
	}
	/**
	 * 查询猪场公告
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urbulletin", method = {RequestMethod.POST,RequestMethod.GET})
	public String bulletin(Integer currentPage,HttpServletRequest request) throws Exception{
		
		try {
			
			Pages<Bulletin> pages = commonService.selectBulletin(null, false);
			
			request.setAttribute("list", pages.getRoot());
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "user/bulletin";
	}
	
	/**
	 * 删除个人消息
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urpersonalMsgDel", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String personalMsgDel(Long messageId,HttpServletRequest request) throws Exception{
		
		UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		try {
			
			if(messageId != null && messageId > 0){
				
				messageService.deleteByPrimaryKey(user.getUserId(), messageId);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
		return personalMsg(1, request);
	}
	
	
	/**
	 * 修改登录密码之旧密码页面
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urloginPasswordPage", method = {RequestMethod.POST,RequestMethod.GET})
	public String loginPasswordPage(HttpServletRequest request) throws Exception{
		
		return "user/validate_password";
	}
	/**
	 * 修改登录密码之验证旧密码
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urvalidateLoginPassword", method = {RequestMethod.POST,RequestMethod.GET})
	public String validateLoginPassword(HttpServletRequest request) throws Exception{
		
		try {
			
			String password = request.getParameter("password");
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urupdateLoginPassword -- > user:"+user + " --> userId:"+userId);
			
			Status status = userService.validatePassword(password,userId);
			
			if(status == Status.success){
				
				return "user/update_login_password";
			}
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "user/validate_password";
	}
	
	/**
	 * 修改登录密码之验证旧密码
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urupdateLoginPassword", method = {RequestMethod.POST,RequestMethod.GET})
	public String updateLoginPassword(HttpServletRequest request) throws Exception{
		
		try {
			
			String password = request.getParameter("password");
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urupdateLoginPassword -- > user:"+user + " --> userId:"+userId);
			
			Status status = userService.updateLoginPassword(password,userId);
			
			this.notifyMsg(request, status);
			
			if(status != Status.success){
				
				return "user/validate_password";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return setting(request);
	}
	/**
	 * 抢标入口
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urpreorderIndex", method = {RequestMethod.POST,RequestMethod.GET})
	public String preorderIndex(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urproorderIndex -- > user:"+user + " --> userId:"+userId);
			
			UserExt userExt = userService.selectUserExtByPrimaryKey(userId);
			
			request.setAttribute("userExt", userExt);
			
			List<UserPreorder> list = userService.selectLoadNameByUserId(userId);
			
			request.setAttribute("list", list);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "user/preorder_index";
	}
	
	/**
	 * 抢标详情
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urpreorderDetail", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String preorderDetail(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		try {
			
			/*UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urproorderIndex -- > user:"+user + " --> userId:"+userId);
			
			UserExt userExt = userService.selectUserExtByPrimaryKey(userId);
			
			List<UserPreorder> list = userService.selectLoadNameByUserId(userId);
			
			request.setAttribute("userExt", userExt);
			request.setAttribute("list", list);
			*/
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "user/preorder_detail";
	}
	/**
	 * 设置抢标
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urpreorderSet", method = {RequestMethod.POST,RequestMethod.GET}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String preorderSet(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		JSONObject object = new JSONObject();
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/urpreorderSet -- > user:"+user + " --> userId:"+userId);
			
			String settingType = request.getParameter("settingType");
			
			String projectId = request.getParameter("projectId");
			
			String num = request.getParameter("num");
			
			String cancel = request.getParameter("cancel");
			
			//不是取消一定要传“false”到后台
			boolean isCancel = !(StringUtils.isNotEmpty(cancel) && "false".equals(cancel));
			
			Status status = userService.updateUserPreorder(userId,projectId,num,settingType,isCancel);
			
			object = JsonUtils.getJsonObject(status);
			
		} catch (Exception e) {
			e.printStackTrace();
			object = JsonUtils.getJsonObject(Status.serverError);
			throw e;
		}finally{
			
			return object.toString();
		}
	}
	
	
	/**
	 * 重新设置二维码的访问地址，旧的图片有不bug
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/wpv/urQrCode",method = {RequestMethod.POST,RequestMethod.GET})
	public String updateQRCodeAccessUrl(HttpServletRequest request ) throws Exception{
		
		UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		Long userId = null != user ? user.getUserId() : null;
		
		ConsoleUtil.println("/wpnv/urpreorderSet -- > user:"+user + " --> userId:"+userId);
		
		if(user.getBindPhone().equals("13544250134")){
			
			userService.updateQRCodeAccessUrl();
		}
		
		return null;
	}
	
	
	
	/**
	 * 删除好友
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpv/urdeleteMyFriends", method = { RequestMethod.GET,RequestMethod.POST })
	public String deleteMyFriends(HttpServletRequest request) throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
			
			String freindsId = request.getParameter("freindsId");
			
			Status status = userService.deleteAddMyFreinds(userId,freindsId);
			
			this.notifyMsg(request, status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.myFriends(request);
	}
	
}
