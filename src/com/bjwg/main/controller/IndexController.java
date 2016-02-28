package com.bjwg.main.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.cache.WxCodeCache;
import com.bjwg.main.cache.WxUserCache;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.OperateConstant;
import com.bjwg.main.constant.RedirectConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Bulletin;
import com.bjwg.main.model.Gps;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.PanicbuyProject;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.model.rating;
import com.bjwg.main.security.UserMananger;
import com.bjwg.main.service.CommonService;
import com.bjwg.main.service.LoginService;
import com.bjwg.main.service.MessageService;
import com.bjwg.main.service.MyEarningsService;
import com.bjwg.main.service.OrderService;
import com.bjwg.main.service.PanicbuyProjectService;
import com.bjwg.main.service.ProvalueService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.test.Sign;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.CookieHelper;
import com.bjwg.main.util.GetWeiXinCode;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.PositionUtil;
import com.bjwg.main.util.RandomUtils;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ToolKit;
import com.bjwg.main.util.insertXML;
import com.bjwg.main.util.selectXML;
import com.bjwg.main.weixin.CoreService;
import com.bjwg.main.weixin.MessageUtil;
import com.bjwg.main.weixin.SignUtil;
import com.bjwg.main.weixin.WeiXinLocation;

/**
 * @author chen
 * @version 创建时间：2015-4-8 上午09:14:22
 * @Modified By:Administrator Version: 1.0 jdk : 1.6 类说明：首页页面跳转
 */
@Controller
@Scope("prototype")
public class IndexController extends BaseController {

	@Resource
	LoginService loginService;
	@Resource
	private ProvalueService provalueService;
	@Resource
	private CoreService coreService;
	
	@Resource
	private UserService userService;
	@Resource
	private CommonService commonService;
	@Resource
	private MyEarningsService myEarningsService;
	@Resource
	private PanicbuyProjectService panicbuyProjectService;
	@Resource
	private OrderService orderService;
	@Resource
	private MessageService messageService;
	@Resource
	private SysConfigService sysConfigService;
	
	/**
	 * 确认请求来自微信服务器
	 */
	@RequestMapping(value = "/wpnv/ixtok", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void doGet(String code,HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		/*
		 * request.setCharacterEncoding("UTF-8");
		 * response.setCharacterEncoding("UTF-8");
		 * 
		 * // 调用核心业务类接收消息、处理消息 String respMessage =
		 * coreService.processRequest(request);
		 * 
		 * // 响应消息 PrintWriter out = response.getWriter();
		 * out.print(respMessage); out.close();
		 */
		
		//this.validateSign(request, response);
		
		index(code, request, response);
	}

	/**
	 * 获取参数
	 * 
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/wpnv/ixlaglot", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String laglot(HttpServletRequest request, HttpSession session)
			throws Exception {
		// 百度ip定位，返回省市地址和经纬等，以得到用户当前地理位置，用以筛选数据，这个方法整合到首页后要修改一下公众号的链接
		// 由首页去接收code以获取当前用户，不再做js跳转

		/*
		 *  * 这个是微信的方法 暂时不用
		 */
		try {

			String theUrl = request.getRequestURL().toString();
			Sign sign = new Sign(theUrl, sysConfigService);
			// sign.getTicket();
			Map<String, String> ret = sign.getVal();
			request.setAttribute("timestamp", ret.get("timestamp"));
			request.setAttribute("nonceStr", ret.get("nonceStr"));
			request.setAttribute("signature", ret.get("signature"));
			request.setAttribute("url", ret.get("url"));
			request.setAttribute("jsapi_ticket", ret.get("jsapi_ticket"));
			request.setAttribute("token", ret.get("token"));
			request.setAttribute("appid", ret.get("appid"));
			request.setAttribute("appSecret", ret.get("appSecret"));
			// 获取用户信息
			String code = request.getParameter("code");
			request.setAttribute("code", code);
		} catch (Exception e) {
			e.printStackTrace();
			ConsoleUtil.println(e.getMessage());
			logger.error("获取参数出错", e);
		}
		return "sign";
	}
	
	/**
	 * 缓存用户经纬度
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/wpnv/ixsetLaglot", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String setlaglot(HttpServletRequest request, HttpSession session)
			throws Exception {
		try {

			String latitude = request.getParameter("latitude");
			
			String longitude = request.getParameter("longitude");
			
			ConsoleUtil.println("latitude - "  +latitude +" ,longitude - " + longitude);
			
			String openId = (String)request.getSession().getAttribute(CommConstant.SESSION_OPENID);
			
			if(StringUtils.isAllNotEmpty(latitude,longitude)){
				
				Gps gps = PositionUtil.gcj02_To_Bd09(Double.valueOf(latitude),Double.valueOf(longitude));
				
				latitude = gps.getWgLat()+"";
				
				longitude = gps.getWgLon()+"";
				
			}
			ConsoleUtil.println("openId:"+openId);
			if(StringUtils.isNotEmpty(openId)){
				
				WeiXinLocation.getInstance().setLocations(openId, longitude, latitude);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			ConsoleUtil.println(e.getMessage());
			logger.error("获取参数出错", e);
		}
		return "redirect:/wpv/urnearShop";
	}

	
	/**
	 * 验证签名（设置微信号访问地址时）
	 * @param request
	 * @param response
	 */
	private void validateSign(HttpServletRequest request,HttpServletResponse response){

		try {
			
			// 微信加密签名  
			String signature = request.getParameter("signature");  
			// 时间戳  
			String timestamp = request.getParameter("timestamp");  
			// 随机数  
			String nonce = request.getParameter("nonce");  
			// 随机字符串  
			String echostr = request.getParameter("echostr");  
			
			PrintWriter out = response.getWriter();  
			// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败  
			if (SignUtil.checkSignature(signature, timestamp, nonce)) {  
				out.print(echostr);  
			}  
			out.close();  
			out = null;  
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 第一次进入猪场调用的方式
	 */
	@RequestMapping(value = "/wpnv/ixfirst", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String firstAccess(HttpServletRequest request, HttpServletResponse response)throws Exception {
		
		
		//获取微信appid
		String[] wxs = sysConfigService.queryWxAppidAndAppKey();
		
		request.setAttribute("appid", wxs[0]);
		
		return "login";
	}
	

	/**
	 * 获取微信公众号传递的用户信息
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/wpnv/ixindex", method = { RequestMethod.GET,RequestMethod.POST })
	public String index(String code, HttpServletRequest request,HttpServletResponse response) {
		try {
			// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			ConsoleUtil.println("\n\n执行index入口时，接收到的code：" + code);
			// 参数
			String ip = MyUtils.getIpAddr(request);
			String openid = null;
			//进入微信公众号的菜单“进入农场”
			if (StringUtils.isNotEmpty(code) && !"null".equals(code)) {
				
				/***
				 * 1、进入时获取网页授权access_token，这个token与code是关联的，因此每个人的token都不一样。返回access_token和openid
				 * 2、根据openid从缓存中获取微信用户资料，若有则不再从微信中获取，否则请求微信拉取用户资料信息
				 * 
				 * 异常情况：有时微信会执行两次 转向到redirect_uri的路径，因此需要处理一下，否则会出现以下错误的信息：
				 * json:{"errcode":40029,"errmsg":"req id: BXk0ha0815ns55, invalid code"}
				 * 处理方案：第一次获取access_token成功后将code与weiXinUser放入到map，再次检测到map中存在时，则不再从微信中获取信息，
				 * 直接执行登录的操作，并且将此code清除掉
				 */
				
				WeiXinUser weiXinUser = WxCodeCache.getWxUser(code);
				
				ConsoleUtil.println("从WxCodeCache缓存中获取weiXinUser："+weiXinUser);
				
				if(weiXinUser == null){
					
					String[] wxs = sysConfigService.queryWxAppidAndAppKey();
					
					StringBuffer tooken_url = new StringBuffer();
					tooken_url.append("https://api.weixin.qq.com/sns/oauth2/access_token?appid=");
					tooken_url.append(wxs[0]).append("&secret=").append(wxs[1]);
					tooken_url.append("&code=").append(code).append("&grant_type=authorization_code");
					//通过code换取网页授权access_token
					String json = GetWeiXinCode.getUrl(tooken_url.toString());
					
					ConsoleUtil.println("获取access_token请求的url："+tooken_url.toString());
					
					//记得屏蔽掉，测试数据
//					json = "{\"access_token\":\"OezXcEiiBSKSxW0eoylIeGaaHQpy5uNNiagGtZHEs2UO-0Kq2prk6mMUqRqjFx3p5SjGq364s-pKssSa4iUEjGRoZKSbDzxQgkD_7sezscaBc8gPLfZ3R4TVbkydigtx9_aI6Ed2qw8ZHHgEgYCJ2Q\",\"expires_in\":7200,\"refresh_token\":\"OezXcEiiBSKSxW0eoylIeGaaHQpy5uNNiagGtZHEs2UO-0Kq2prk6mMUqRqjFx3pH8dE3VBIetpNHjOQZfkIXEc2d5X4XCQLyyLV4_punHhL3wXIYTJ92jrs-79QBJmALi7MekTm1GgP1w9i8u6SpQ\",\"openid\":\"o1m-IuKm1mIU-Z9MV3BHUGc59lJU\",\"scope\":\"snsapi_userinfo\"}";
					
					JSONObject jsonObject = JSONObject.fromObject(json);

					ConsoleUtil.println("获取access_token请求返回的数据:"+jsonObject);

					if (jsonObject.containsKey("access_token")) {
						String access_token = jsonObject.getString("access_token");
						openid = jsonObject.getString("openid");
						
						weiXinUser = WxUserCache.getWxUser(openid);
						
						ConsoleUtil.println("从WxUserCache缓存中获取的weiXinUser："+weiXinUser);
						
						if(weiXinUser == null){
							
							//拉取用户信息(需scope为 snsapi_userinfo)
							StringBuffer get_userinfo = new StringBuffer();
							get_userinfo.append("https://api.weixin.qq.com/sns/userinfo?access_token=").append(access_token);
							get_userinfo.append("&openid=").append(openid).append("&lang=zh_CN");
							String userInfoJson = GetWeiXinCode.getUrl(get_userinfo.toString());
							
							ConsoleUtil.println("请求拉取用户信息的url："+get_userinfo);
							
							ConsoleUtil.println("请求拉取用户信息返回的数据:" + userInfoJson);
							
							//记得屏蔽掉，测试数据
							//userInfoJson = "{\"openid\":\"o1m-IuKm1mIU-Z9MV3BHUGc59lJU\",\"nickname\":\"dwycld\",\"sex\":2,\"language\":\"zh_CN\",\"city\":\"\",\"province\":\"\",\"country\":\"中国\",\"headimgurl\":\"http://wx.qlogo.cn/mmopen/ZAsIbHmSZNnjKzmQic5uk119tRNWAQ8EXQwnyt8o4a8JeQXGV1jOq96e7jO4MEicgG4TichJTu55ccu4O2u1hz1mq1fQvEw0o4n/0\",\"privilege\":[]}";
							
							if(userInfoJson.indexOf("errcode") > -1){
								
								this.notifyMsg(request, Status.getUserByWxFail);
								
								request.setAttribute("error_detail", userInfoJson);
								
								return "wx_error";
							}
							
							JSONObject userInfoJO = JSONObject.fromObject(userInfoJson);
							
							// 用户的唯一标识
							String user_openid = userInfoJO.getString("openid");
							// 用户昵称
							String user_nickname = userInfoJO.getString("nickname");
							// 用户的性别，值为1时是男性，值为2时是女性，值为0时是未知
							String user_sex = userInfoJO.getString("sex");
							// 用户个人资料填写的省份
							String user_province = userInfoJO.getString("province");
							// 普通用户个人资料填写的城市
							String user_city = userInfoJO.getString("city");
							// 国家，如中国为CN
							String user_country = userInfoJO.getString("country");
							// 用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空。若用户更换头像，原有头像URL将失效。
							String user_headimgurl = userInfoJO.getString("headimgurl");
							
							//测试配置，主要是为了测试环境使用的，不影响正式环境
							String test = ToolKit.getInstance().getSingleConfig("test");
							
							//是否能获取unionid
							String unionid = "";
							if("yes".equals(test)){
								if(userInfoJO.containsKey("unionid")){
									unionid = userInfoJO.getString("unionid");
								}else{
									unionid = RandomUtils.getNumAndWord(28);
								}
							}else{
								unionid = userInfoJO.getString("unionid");
							}
							
							// 用户特权信息，json 数组，如微信沃卡用户为（chinaunicom）
							JSONArray privilege = userInfoJO.getJSONArray("privilege");
							
							ConsoleUtil.println("微信接收到的用户信息中的 unionid   " + unionid + "，openid："+user_openid+"，nickname:"+user_nickname);
							
							try {
								
								user_nickname = new String(user_nickname.toString().getBytes("ISO-8859-1"),"UTF-8");
								
							} catch (Exception e) {
								
								user_nickname = "游客";
								ConsoleUtil.println("转换昵称字符编码出错:"+user_nickname);
							}
							
							weiXinUser = new WeiXinUser();
							weiXinUser.setNickname(user_nickname);
							weiXinUser.setOpenid(user_openid);
							weiXinUser.setUnionid(unionid);
							weiXinUser.setPrivilege(privilege.toString());
							weiXinUser.setCity(user_city);
							weiXinUser.setProvince(user_province);
							weiXinUser.setSex(user_sex);
							weiXinUser.setHeadImg(user_headimgurl);
							weiXinUser.setCountry(user_country);
							
							WxUserCache.put(unionid, user_nickname, user_openid, privilege.toString(), user_sex, user_province, user_country, user_headimgurl, user_country);
							
							WxCodeCache.put(code, weiXinUser);
						}
						
					}else{
						
						this.notifyMsg(request, Status.getAccessTokenFail);
						
						request.setAttribute("error_detail", jsonObject.toString());
						
						return "wx_error";
					}
				
				}else{
					
					ConsoleUtil.println("从WxCodeCache缓存中移除重复的code："+code);
					
					WxCodeCache.remove(code);
				}
				
				if(weiXinUser != null){
					
					User user = new User();
					
					userService.encapUserInfo(user,weiXinUser.getNickname(),weiXinUser.getSex(),ip,weiXinUser.getHeadImg(),weiXinUser.getProvince(),weiXinUser.getCity(),weiXinUser.getCountry());
					
					Map<String, Object> map = loginService.updateUserLogin(null,weiXinUser,user,OperateConstant.LOGIN_WX,request.getRemoteAddr(),null);
					
					Status status = (Status)map.get("status");
					
					ConsoleUtil.println("status:"+status.getMsg()+",将weiXinUser放入到session中:"+weiXinUser+",user_nickname:"+weiXinUser.getNickname());
					
					request.getSession().setAttribute(CommConstant.SESSION_OPENID, openid);
					
					request.getSession().setAttribute(CommConstant.SESSION_WX_USER, weiXinUser);
					
					User user2 = (User)map.get(CommConstant.SESSION_MANAGER);
					
					ConsoleUtil.println("微信用户对应的用户user2:"+user2+"，id" +(user2 != null ? (user2.getUserId()+ "用户名："+ user2.getUsername() + "头像："+ user2.getHeadImg()) : null));
					
					if (null != user2) {
						
						//生成token
						request.getSession().setAttribute(CommConstant.SESSION_LOGIN_TYPE, OperateConstant.LOGIN_WX);
						
						String token = UserMananger.getInst().add(user2.getUserId(), user2.getUsername(), user2.getPhone(),user2.getNickname(),user2.getSex(),user2.getHeadImg(),user2.getInviteCode(),user2.getQrCode(),openid);
						request.getSession().setAttribute(CommConstant.SESSION_MANAGER, UserMananger.getInst().getUser(token));
						//cookie生命周期为12小时
						CookieHelper.addCookie(response, CommConstant.SESSION_APP_TOKEN, token, 12 * 60 *60);
					}
					//进入农场
					return home(request,response);
				}
				
			} else {
				// 调用核心业务类接收消息、处理消息
				Map<String, String> resultMap = coreService.processRequest(request);
				if(!MyUtils.isMapEmpty(resultMap)){
					String type = resultMap.get("type");
					if(type.equals("xml")){
						String respMessage = resultMap.get("respMessage");
						if (!StringUtils.isEmptyNo(respMessage)) {
							// 响应消息
							PrintWriter out = response.getWriter();
							out.print(respMessage);
							out.close();
						}
					}else if(type.equals(MessageUtil.REQ_MESSAGE_TYPE_LOCATION)){
						
						String longtitude = resultMap.get("longtitude");
						String latitude =  resultMap.get("latitude");
						String tempOpenid = resultMap.get("open_id");
						WeiXinLocation.getInstance().setLocations(tempOpenid, longtitude, latitude);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			ConsoleUtil.println(e.getMessage());
			logger.error("微信登录     indexHome ： ", e);
		}
		return null;
	}
	
	/**
	@RequestMapping(value = "/testWeizhi", method = { RequestMethod.GET,	RequestMethod.POST })
	public String testWeizhi( HttpServletRequest request) throws Exception{
		// 微信获取地理位置接口
		String theUrl = request.getRequestURL().toString();
		Sign sign = new Sign(theUrl, provalueService);
		Map<String, String> ret = sign.getVal();
		
		logger.info("微信用户是否获取到了sign信息："+!MyUtils.isMapEmpty(ret));
		if (!MyUtils.isMapEmpty(ret)) {
			request.setAttribute("timestamp", ret.get("timestamp"));
			request.setAttribute("nonceStr", ret.get("nonceStr"));
			request.setAttribute("signature", ret.get("signature"));
			request.setAttribute("url", ret.get("url"));
			request.setAttribute("jsapi_ticket",
					ret.get("jsapi_ticket"));
			request.setAttribute("token", ret.get("token"));

		}
		return "MyJsp";
	}**/


	/**
	 * 进入农场 ，微信端执行的是/wpnv/ixindex方法获取微信账号后再执行本方法，pc端直接执行本方法，本方法是需要验证登录的
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpnv/ixhome", method = { RequestMethod.GET,RequestMethod.POST })
	public String home(HttpServletRequest request,HttpServletResponse response) {
		try {
			
			//拉取用户农场中的基本信息,包括公告信息、目前的猪数量、猪的成长状态、收益情况
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpv/ixhome -- > user:"+user + " --> userId:"+userId);
			
			//1.公告消息
			//从cookie中读取lastBulletinId
			Cookie cookie = CookieHelper.getCookieByName(request, CommConstant.COOKIE_LASTBULLETINID);
			
			Long lastBulletinId = null;
			
			if(null != cookie && StringUtils.isNotEmpty(cookie.getValue())){
				
				lastBulletinId = Long.valueOf(cookie.getValue());
			}
			
			Bulletin bulletin = commonService.selectRecentOneAfterChk(userId, lastBulletinId);
			
			if(null != bulletin){
				
				CookieHelper.addCookie(response, CommConstant.COOKIE_LASTBULLETINID, bulletin.getBulletinId().toString(), -1);
			}
			String flag=(String)request.getSession().getAttribute("bull");
			if(flag!=null){
				
				request.setAttribute("bulletin", null);
			}else{
				request.setAttribute("bulletin", bulletin);
			}
			
				
			//2.我拥有的总猪头数、最近一期的成长状态、最近一期的收益(数据有点问题)
			Map<String, Object> dataMap = myEarningsService.selectMyHomeData(userId);
			
			request.setAttribute("dataMap", dataMap);
			
			//3.当前进行中 或 下一期的抢购项目
			dataMap = panicbuyProjectService.selectCurrentOrNext();
			
			request.setAttribute("projectMap", dataMap);
			
			//4.有没有需要推送的消息
			List<MyEarnings> meList = panicbuyProjectService.selectLast30DaysEarnings(userId);
			
			request.setAttribute("meList", null);
			
			//获取本地时间（小时）
			request.setAttribute("hours", MyUtils.dateFormat8(new Date()));
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("进入农场错误", e);
		}
		System.out.println("wwwwxxxx");
		return "home";
	}
	/**
	 * 点击总数，查看详情
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpnv/ixpigNumDetail", method = { RequestMethod.GET,RequestMethod.POST })
	public String pigNumDetail(HttpServletRequest request) {
		try {
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/ixpigNumDetail -- > user:"+user + " --> userId:"+userId);
			
			Map<String, Object> dataMap = myEarningsService.selectPerPigNum(userId);
			
			request.setAttribute("dataMap", dataMap);
			
			if(MyUtils.isMapEmpty(dataMap)){
				
				//没有记录则出现倒计时
				dataMap = panicbuyProjectService.selectCurrentOrNext();
				
				request.setAttribute("projectMap", dataMap);
			}
			
			this.notifyMsgByRedirectCode(request);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("点击总数，查看详情", e);
		}
		
		return "user/my_pig_number";
	}
	/**
	 * 点击成长状态，默认最近期的成长记录
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpnv/ixpigGrow", method = { RequestMethod.GET,RequestMethod.POST })
	public String pigGrow(HttpServletRequest request) {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/ixpigGrow -- > user:"+user + " --> userId:"+userId);
			
			String queryProjectId = request.getParameter("queryProjectId");
			
			//查询一遍就够了
			List<MyEarnings> list = null;//(List<MyEarnings>)request.getSession().getAttribute(CommConstant.SESSION_ALL_I_JOIN_PROJECT);
					
			if(MyUtils.isListEmpty(list)){
				
				//查询所有我参与的期
				list = myEarningsService.selectAllJoin(userId);
				
				if(!MyUtils.isListEmpty(list)){
					
					request.getSession().setAttribute(CommConstant.SESSION_ALL_I_JOIN_PROJECT,list);
				}
			}
			if(!MyUtils.isListEmpty(list)){
				
				if(StringUtils.isEmptyNo(queryProjectId)){
					
					//默认最近期
					queryProjectId = list.get(0).getPaincbuyProjectId().toString();
				}
				
				//查询指定期的成长数据
				Map<String, Object> dataMap = myEarningsService.selectPerPigGrow(userId,queryProjectId);
				
				request.setAttribute("dataMap", dataMap);
			}else{
				
				//没有记录则出现倒计时
				Map<String, Object> dataMap = panicbuyProjectService.selectCurrentOrNext();
				
				request.setAttribute("projectMap", dataMap);
			}
			
			request.setAttribute("queryProjectId", queryProjectId);
			
			this.notifyMsgByRedirectCode(request);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date =sdf.parse("2015-09-30");
	         request.setAttribute("begTime", date);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("点击总数，查看详情", e);
		}
		
		return "user/my_piglets";
	}

	/**
	 * 查看近期的收益情况
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpnv/ixRecentEarning", method = { RequestMethod.GET,RequestMethod.POST })
	public String recentEarning(HttpServletRequest request) {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/ixRecentEarning -- > user:"+user + " --> userId:"+userId);
			
			String queryProjectId = request.getParameter("queryProjectId");
			
			
			//查询一遍就够了
			List<MyEarnings> list = null;//(List<MyEarnings>)request.getSession().getAttribute(CommConstant.SESSION_ALL_I_JOIN_PROJECT);
			
			if(null == list){
				
				//查询所有我参与的期
				list = myEarningsService.selectAllJoin(userId);
				
				if(!MyUtils.isListEmpty(list)){
					
					request.getSession().setAttribute(CommConstant.SESSION_ALL_I_JOIN_PROJECT,list);
				}
			}
			if(!MyUtils.isListEmpty(list)){
				
				if(StringUtils.isEmptyNo(queryProjectId)){
					
					//默认最近期
					
					queryProjectId = list.get(0).getPaincbuyProjectId().toString();
				}
				//查询指定期的收益数据
				Map<String, Object> dataMap = myEarningsService.selectPerMyEarnings(userId,queryProjectId);
				
				request.setAttribute("dataMap", dataMap);
			}else{
				//没有记录则出现倒计时
				Map<String, Object> dataMap = panicbuyProjectService.selectCurrentOrNext();
				
				request.setAttribute("projectMap", dataMap);
			}
			
			request.setAttribute("queryProjectId", queryProjectId);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("查看近期的收益情况", e);
		}
		
		return "user/my_earnings";
	}
	
	
	/**
	 * 点击抢购，进入抢购商品页面
	 */
	@RequestMapping(value = "/wpnv/ixPanicutBuyInit", method = { RequestMethod.GET,RequestMethod.POST })
	public String ixPanicutBuyInit(HttpServletRequest request) {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			this.setAttr(request);
			//查询当期正在进行的项目
			PanicbuyProject currentProj = panicbuyProjectService.selectCurrent(null);
			String queryProjectId = request.getParameter("queryProjectId");
			if(queryProjectId==null){
				request.setAttribute("ratings", null);
			}else{
			int pid=new Long(queryProjectId).intValue();
			List<rating> ratings=selectXML.selectXML(request,pid);
			if(ratings==null){
				insertXML.insertXML(request,pid,currentProj.getNum());
				 ratings=selectXML.selectXML(request,pid);
			}
			request.setAttribute("ratings", ratings);
			}
			ConsoleUtil.println("/wpnv/ixPanicutBuyInit -- > user:"+user + " --> userId:"+userId +" -- > queryProjectId:"+queryProjectId);
			
			Long projectId = StringUtils.isNotEmpty(queryProjectId) ? Long.valueOf(queryProjectId) : null;
			//查询抢购的项目
			Map<String, Object> map = panicbuyProjectService.selectPanicutBuyInit(projectId);
			
			request.setAttribute("map", map);
			
			/*if(map.containsKey("project")){
				
				String str = ((PanicbuyProject)map.get("project")).getOtherFeeDetail();
				JSONArray array = JSONArray.fromObject(str);
				request.setAttribute("array", array);
			}*/
			
			String msgCode = request.getParameter("msgCode");
			
			if(StringUtils.isNotEmpty(msgCode)){
				
				notifyMsg(request, Status.getStatus(Integer.valueOf(msgCode)));
			}
				
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("查看近期的收益情况", e);
		}
		
		return "activity/buy_pig";
	}
	

	/**
	 * 查询协议
	 */
	@RequestMapping(value = "/wpnv/ixprotocol", method = { RequestMethod.GET,RequestMethod.POST })
	public String getProtocol() throws Exception{
		
		
		try {
			
			String code = request.getParameter("code");
			
			if(StringUtils.isNotEmpty(code)){
				request.setAttribute("protocol", commonService.selectProtocol(code));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("查询协议", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "protocol";
	}
	

	/**
	 * 实时监控
	 * @param opinion
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/wpnv/ixmonitoring", method = {RequestMethod.POST,RequestMethod.GET})
	public String ixmonitoring(HttpServletRequest request) throws Exception{
		
		return "real_time_monitoring";
	}
	/**
	 * 设置密码
	 * @param opinion
	 * @param request
	 * @return
	 
	@RequestMapping(value = "/wpnv/ixsavePassword", method = {RequestMethod.POST,RequestMethod.GET})
	public String savePassword(HttpServletRequest request) throws Exception{
		
		String shopId = request.getParameter("shopId");
		
		try {
			
			String source = request.getParameter("source"); 
			
			Status status = userService.updateLoginPassword(request,source);
			
			request.setAttribute("source", source);
			
			request.setAttribute("shopId", shopId);
			
			if(status == Status.success){
				
				request.getSession().removeAttribute("rl_username");
				
				return "redirect:/wpnv/ixhome";
					
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/index/goodsDetailShop?id="+shopId+"&type=1";
	}*/
}
