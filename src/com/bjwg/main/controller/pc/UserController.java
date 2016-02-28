package com.bjwg.main.controller.pc;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.FileConstant;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.constant.VerifyCodeConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.dao.UserDao;
import com.bjwg.main.model.Bulletin;
import com.bjwg.main.model.Message;
import com.bjwg.main.model.MyCoupon;
import com.bjwg.main.model.MyCouponUse;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserExt;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.model.UserPreorder;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.model.WalletExample;
import com.bjwg.main.service.CommonService;
import com.bjwg.main.service.MessageService;
import com.bjwg.main.service.MyEarningsService;
import com.bjwg.main.service.PanicbuyProjectService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.VerifyPhoneService;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.JsonUtils;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.UploadFile;

/**
 * @author Carter
 * @version 创建时间：Sep 14, 2015 3:24:11 PM
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_user_controller")
@Scope("prototype")
public class UserController extends BaseController {

	@Autowired
	UserService userService;
	
	@Autowired
	MessageService messageService;
	
	@Autowired
	WalletService walletService;
	
	@Autowired
	VerifyPhoneService verifyPhoneService;
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	SysConfigService sysConfigService;
	
	@Autowired
	MyEarningsService myEarningsService;
	
	@Autowired
	PanicbuyProjectService panicbuyProjectService;
	
	
	@RequestMapping(value = "/pv/user/home", method = {RequestMethod.POST,RequestMethod.GET})
	public String home() throws Exception {
		return "pc/user/home";
	}
	

	/**
	 * 企业：个人中心
	 */
	@RequestMapping(value = "/pc/pv/user/personalMsg", method = {RequestMethod.POST,RequestMethod.GET})
	public String personMsg() throws Exception {
		
		UserLoginModel userLoginModel = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		List<User> users=userService.getEpInfo(userLoginModel.getUserId());
		User user=new User();
		
		if(users.size()>0){
			user=users.get(0);
		}
		request.setAttribute("user", user);
		
		return "pc/epuser/personalMsg";
		
	}

	/**
	 * 基础设置页
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/personalSetting", method = {RequestMethod.POST,RequestMethod.GET})
	public String personalSetting() throws Exception {
		
		UserLoginModel userLoginModel = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		//查询用户之前是否设置过支付密码
		WalletExample example = new WalletExample();
		WalletExample.Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userLoginModel.getUserId());
		List<Wallet> list = walletService.selectByExample(example);
		
		if(!MyUtils.isListEmpty(list)){
			//有设置过密码，不能再设置一遍
			if(StringUtils.isNotEmpty(list.get(0).getPayPassword())){
				request.setAttribute("newPayPwd", false);
			} else {
				request.setAttribute("newPayPwd", true);
			}
		}else{
			request.setAttribute("newPayPwd", true);
		}
		
		User user = userService.getById(userLoginModel.getUserId());
		
		request.setAttribute("email", user!=null?user.getEmail():null);
		request.setAttribute("mobile", user!=null?user.getPhone():null);
		
		return "pc/user/personalSetting";
	}
	
	
	

	/**
	 * 企业版：基础设置页
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/epuser/personalSetting", method = {RequestMethod.POST,RequestMethod.GET})
	public String personalSetting2() throws Exception {
		
		UserLoginModel userLoginModel = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		List<User> users=userService.getEpInfo(userLoginModel.getUserId());
		User user=new User();
		
		if(users.size()>0){
			user=users.get(0);
		}
		request.setAttribute("user", user);
		
		
		//查询用户之前是否设置过支付密码
		WalletExample example = new WalletExample();
		WalletExample.Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userLoginModel.getUserId());
		List<Wallet> list = walletService.selectByExample(example);
		
		if(!MyUtils.isListEmpty(list)){
			//有设置过密码，不能再设置一遍
			if(StringUtils.isNotEmpty(list.get(0).getPayPassword())){
				request.setAttribute("newPayPwd", false);
			} else {
				request.setAttribute("newPayPwd", true);
			}
		}else{
			request.setAttribute("newPayPwd", true);
		}
		
		User user2 = userService.getById(userLoginModel.getUserId());
		
		request.setAttribute("email", user2!=null?user2.getEmail():null);
		request.setAttribute("mobile", user2!=null?user2.getPhone():null);
		
		return "pc/epuser/personalSetting";
	}
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 修改登录密码
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/updateLoginPassword", method = {RequestMethod.POST},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String updateLoginPassword(String oldPwd,String newPwd) throws Exception {
		JSONObject jsonObject = new JSONObject();
		try {
			UserLoginModel userLoginModel = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Status status = userService.updateLoginPassword(oldPwd, newPwd, userLoginModel.getUserId());
		
			jsonObject = JsonUtils.getJsonObject(status);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return jsonObject.toString();
	}
	
	/**
	 * 更新邮箱
	 * @param email
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/updateEmail", method = {RequestMethod.POST},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String updateEmail(String email) throws Exception {
		JSONObject jsonObject = new JSONObject();
		try {
			UserLoginModel userLoginModel = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Status status = userService.updateEmail(email, userLoginModel.getUserId());
			
			jsonObject = JsonUtils.getJsonObject(status);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return jsonObject.toString();
	}
	
	/**
	 * 昵称,sex保存
	 * @return
	 * @throws JSONException
	 */
	@RequestMapping(value = "pc/pv/user/basicInfoSave", method = {RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String userInfoSave() throws JSONException{
		try {
			
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			String nickName = request.getParameter("nickName");
			
			String sex = request.getParameter("sex");
			
			Long userId = null != user ? user.getUserId() : null;
			
			Status status = userService.updateUserNickNameOrSex(nickName, sex,userId);
				
			if(Status.success == status){
				
				if(StringUtils.isNotEmpty(nickName)){
					
					user.setUsername(nickName);
					user.setNickname(nickName);
				}
				
				if(StringUtils.isNotEmpty(sex)){
					
					user.setSex(Byte.valueOf(sex));
				}
				
				//同步session中的user信息
				request.getSession().setAttribute(CommConstant.SESSION_MANAGER, user);
			}
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("保存个人信息 出错",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return this.outputJson();
	}
	
	/**
	 * 个人/系统消息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/msg", method = {RequestMethod.POST,RequestMethod.GET})
	public String msg(String cnav) throws Exception{
		try {
			request.setAttribute("cnav", cnav);
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			//查询个人消息
			Pages<Message> pages = new Pages<Message>();
			pages.setCurrentPage((cnav!=null&&cnav.equals("psn"))?currentPage:1);
			pages.setPerRows(7);
			messageService.queryPage(user.getUserId(), pages);
			request.setAttribute("msgList", pages.getRoot());
			request.setAttribute("msgCount", pages.getCountRows());
			request.setAttribute("pager_msg", MyUtils.calcPagerNum(10, pages.getCountRows(), pages.getCurrentPage(), 6));
			
			//标记消息为已读
			messageService.updateStatus(user.getUserId());
			
			//查询公告
			Pages<Bulletin> pages1 = new Pages<Bulletin>();
			pages1.setCurrentPage((cnav!=null&&cnav.equals("blt"))?currentPage:1);
			pages1.setPerRows(10);
			commonService.selectBulletin(pages1, true);
			request.setAttribute("bulletinList", pages1.getRoot());
			request.setAttribute("bulletinCount", pages1.getCountRows());
			request.setAttribute("pager_blt", MyUtils.calcPagerNum(10, pages1.getCountRows(), pages1.getCurrentPage(), 6));
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
		return "pc/user/msg";
	}
	
	/**
	 * 猪场公告
	 * @param currentPage
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pv/user/bulletin", method = {RequestMethod.POST,RequestMethod.GET})
	public String bulletin() throws Exception{
		
		try {
			
			Pages<Bulletin> pages = commonService.selectBulletin(null, false);
			
			request.setAttribute("bulletinList", pages.getRoot());
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "pc/user/bulletin";
	}

	/**
	 * 删除系统/个人消息
	 * @param messageId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/msgDel", method = {RequestMethod.POST,RequestMethod.GET})
	public String personalMsgDel(Long messageId) throws Exception{
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			if(messageId != null && messageId > 0){
				messageService.deleteByPrimaryKey(user.getUserId(), messageId);
			}else{
				messageService.deleteAll(user.getUserId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/pc/pv/user/msg";
	}
	
	/**
	 * 我的猪肉券
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/user/ticket",method = {RequestMethod.POST,RequestMethod.GET})
	public String ticket() throws Exception{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			//ConsoleUtil.println("/wpnv/urmyCoupon -- > user:"+user + " --> userId:"+userId);
			
			Pages<MyCoupon> pages = userService.selectMyCoupon(userId,null,false);
			
			request.setAttribute("ticketList", pages.getRoot());
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("我的券 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "pc/user/ticket";
	}
	
	/**
	 * 猪肉券使用记录
	 * @param ticketId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/user/ticketUseRecord",method = {RequestMethod.POST,RequestMethod.GET})
	public String ticketUseRecord(String ticketId) throws Exception{
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Pages<MyCouponUse> pages = new Pages<MyCouponUse>();
			pages.setCurrentPage(currentPage);
			pages.setPerRows(10);
			userService.selectMyCouponUseDetail(userId,ticketId,pages,true);
			request.setAttribute("rdList", pages.getRoot());
			request.setAttribute("pager", MyUtils.calcPagerNum(pages.getPerRows(), pages.getCountRows(), pages.getCurrentPage(), 6));
			
			/*JSONArray array = new JSONArray();
			for(MyCouponUse myCouponUse : pages.getRoot()){
				JSONObject jsonObject2  = new JSONObject();
				jsonObject2.put("money", myCouponUse.getUseMoney());
				jsonObject2.put("time", myCouponUse.getUseTime());
				jsonObject2.put("where", myCouponUse.getUseAddress());
				array.put(jsonObject2);
			}
			this.putJsonStatus(Status.success);
			this.putJsonData(new JSONObject().put("rds", array));*/
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("我的券消费记录 出错", e);
			/*this.notifyMsg(request, Status.serverError);*/
		}
		return "pc/user/ticket_rd";
	}
	
	/**
	 * 修改手机号码手机号验证
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "pc/pv/user/mobileModifyVerify", method = {RequestMethod.POST},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String mobileModifyVerify(short type, String verifyCode, String phone){
		JSONObject jsonObject = new JSONObject();
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			//类型1代表旧手机验证  类型2为新手机号验证
			phone = type==1 ? user.getBindPhone() : phone;
			
			type= type==1 ? VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_OLD : VerifyCodeConstant.VERIFY_CODE_PHONECHANGE_NEW;
			
			
			Long userId = null != user ? user.getUserId() : null;
			
			Status status = verifyPhoneService.updateBindNewPhone(userId, phone, verifyCode, type);
			
			//同步session中的信息
			if(status==Status.success){
				
				user.setBindPhone(phone);
				
				request.getSession().setAttribute(CommConstant.SESSION_MANAGER, user);
			}
			
			jsonObject = JsonUtils.getJsonObject(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("验证发送的验证码出错",e);
		}
		return jsonObject.toString();
	}
	
	/**
	 * 我的好友
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/friend", method = { RequestMethod.GET,RequestMethod.POST })
	public String myFriends(String keyword) throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			//String type = request.getParameter("type");
			
			//request.setAttribute("type", type);
			
			Date time = null;
			
			List<Byte> queryStatusList = new ArrayList<Byte>();
			queryStatusList.add(CommConstant.ADD_FREINDS_1);
			
			List<User> freindsList = null;
			Pages<User> pages = new Pages<User>();
			if(StringUtils.isNotEmpty(keyword)){
				pages = new Pages<User>();
				pages.setPerRows(10);
				pages.setCurrentPage(currentPage);
				freindsList = userService.searchFreinds(userId, keyword, pages);
				request.setAttribute("isSearch", true);
			} else {
				pages = new Pages<User>();
				pages.setPerRows(10);
				pages.setCurrentPage(currentPage);
				freindsList = userService.queryMyFreinds(userId,time,queryStatusList,pages);
				
				//统计新好友数
				String days = sysConfigService.queryOneValue(SysConstant.NEW_FREINDS_FILTER_TIME);
				if(StringUtils.isNotEmpty(days)){
					
					time = MyUtils.dateFormat(MyUtils.addDate3(new Date(), -Integer.valueOf(days)) + " 00:00:00" , 0);
				}
				queryStatusList.remove(0);
				queryStatusList.add(CommConstant.ADD_FREINDS_0);
				request.setAttribute("newFreindsCount", userService.countMyNewFreinds(userId, time, queryStatusList));
			}
			request.setAttribute("friendList", freindsList);
			request.setAttribute("pager", MyUtils.calcPagerNum(10, pages.getCountRows(), pages.getCurrentPage(), 6));
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转我的好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return "pc/user/friend";
	}
	
	/**
	 * 新增的好友(审核列表)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/newFriends", method = { RequestMethod.GET,RequestMethod.POST })
	public String newFriends() throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Date time = null;
			
			List<Byte> queryStatusList = new ArrayList<Byte>();
			
			String days = sysConfigService.queryOneValue(SysConstant.NEW_FREINDS_FILTER_TIME);
			
			if(StringUtils.isNotEmpty(days)){
				
				time = MyUtils.dateFormat(MyUtils.addDate3(new Date(), -Integer.valueOf(days)) + " 00:00:00" , 0);
			}
			
			queryStatusList.add(CommConstant.ADD_FREINDS_0);
			
			List<User> freindsList = null;
			
			Pages<User> pages = new Pages<User>();
			pages.setPerRows(10);
			pages.setCurrentPage(currentPage);
			freindsList = userService.queryMyFreinds(userId, time, queryStatusList,pages);
			
			request.setAttribute("friendList", freindsList);
			request.setAttribute("pager", MyUtils.calcPagerNum(10, freindsList.size(), currentPage, 6));
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转我的好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return "pc/user/newFriends";
	}

	/**
	 * 同意/不同意加为好友
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/addFriend", method = { RequestMethod.GET,RequestMethod.POST },produces = "application/json; charset=utf-8")
	@ResponseBody
	public String addFriend(String agreeType,String friendId) throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Status status = userService.updateAddMyFreinds(userId, friendId, agreeType);
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("同意/不同意加为好友 出错", e);
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	/**
	 * 发送好友请求
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/sendFriendRequest", method = { RequestMethod.GET,RequestMethod.POST},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String sendFriendRequest() throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			String freindId = request.getParameter("friendId");
			
			String sendRemark = request.getParameter("sendRemark");
			
			Status status = userService.insertFreinds(userId,freindId,sendRemark);
			
			this.putJsonStatus(status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("搜索好友 出错", e);
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	/**
	 * 删除好友
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/pc/pv/user/deleteFriend", method = { RequestMethod.GET,RequestMethod.POST },produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteMyFriends() throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uraddMyFriends -- > user:"+user + " --> userId:"+userId);
			
			String freindsId = request.getParameter("friendId");
			
			Status status = userService.deleteAddMyFreinds(userId,freindsId);
			
			this.putJsonStatus(status);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除好友 出错", e);
			this.putJsonStatus(Status.serverError);
		}
		
		return this.outputJson();
	}
	
	/**
	 * 赠送猪仔选择
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/sendPigChoose", method = { RequestMethod.GET,RequestMethod.POST })
	public String sendPigChoose(Long friendId) throws Exception {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Map<String, Object> dataMap = myEarningsService.selectPerPigNum(userId);
			
			request.setAttribute("dataMap", dataMap);
			request.setAttribute("friendId", friendId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "pc/user/sendPigChoose";
	}
	
	/**
	 * 赠送猪仔提交
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/user/sendPigSubmit",method = {RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String sendPigSubmit() throws Exception{
		
		String freindId = request.getParameter("friendId");
		
		String projectId = request.getParameter("projectId");
		
		Status status = Status.success;
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			String nickname = user.getNickname() != null ? user.getNickname() : user.getUsername();
			
			String sendNum = request.getParameter("sendCount");
			
			String sendRemark = request.getParameter("sendRemark");
			
			String password = request.getParameter("password");
			
			status = userService.updateSendPigToFreinds(userId,nickname,projectId,sendNum,password,freindId,sendRemark);
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转我的好友 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return this.outputJson();
	}
	
	/**
	 * 赠送猪肉券选择
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/user/sendTicketChoose",method = {RequestMethod.POST,RequestMethod.GET})
	public String sendTicketChoose(Long friendId) throws Exception{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Pages<MyCoupon> pages = new Pages<MyCoupon>();
			pages.setPerRows(3);
			pages.setCurrentPage(currentPage);
			userService.selectMyCoupon(userId,pages,true);
			
			request.setAttribute("ticketList", pages.getRoot());
			request.setAttribute("pager", MyUtils.calcPagerNum(3, pages.getPageCount(), currentPage, 6));
			request.setAttribute("friendId", friendId);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("我的券 出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "pc/user/sendTicketChoose";
	}

	/**
	 * 赠送猪肉券提交
	 * @param ticketId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/user/sendTicketSubmit",method = {RequestMethod.POST,RequestMethod.GET},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String sendTicketSubmit() throws Exception{
		Status status = Status.success;
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			String nickname = null != user ? user.getNickname() : null;
			
			Long userId = null != user ? user.getUserId() : null;
			
			String myCouponId = request.getParameter("ticketId");
			
			String sendMoney = request.getParameter("sendMoney");
			
			String sendRemark = request.getParameter("sendRemark");
			
			String freindId = request.getParameter("friendId");
			
			String password = request.getParameter("password");
			
			status = userService.updateSendPigCouponToFreinds(userId, nickname, myCouponId, sendMoney, freindId, password,sendRemark);
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("赠送猪肉券提交", e);
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	/**
	 * 我的猪场
	 * @param earningsId
	 * @return
	 */
	@RequestMapping(value = "/pc/pv/user/farm", method = { RequestMethod.GET,RequestMethod.POST })
	public String myPigFarm(Long earningsId){
		try {
			
			//拉取用户农场中的基本信息,包括公告信息、目前的猪数量、猪的成长状态、收益情况
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
			Long userId = null != user ? user.getUserId() : null;
			
			//1.公告消息
			//从cookie中读取lastBulletinId
/*			Cookie cookie = CookieHelper.getCookieByName(request, CommConstant.COOKIE_LASTBULLETINID);
			
			Long lastBulletinId = null;
			
			if(null != cookie && StringUtils.isNotEmpty(cookie.getValue())){
				
				lastBulletinId = Long.valueOf(cookie.getValue());
			}
			
			Bulletin bulletin = commonService.selectRecentOneAfterChk(userId, lastBulletinId);
			
			if(null != bulletin){
				
				CookieHelper.addCookie(response, CommConstant.COOKIE_LASTBULLETINID, bulletin.getBulletinId().toString(), -1);
			}
			
			request.setAttribute("bulletin", bulletin);*/
				
			Map<String, Object> dataMap = myEarningsService.selectMyFarmData(userId, earningsId);
			
			//总猪数
			request.setAttribute("farmData",dataMap);
			
			if(dataMap!=null){
				//查询成长记录数据
				Map<String, Object> growData = myEarningsService.selectPerPigGrow(userId, dataMap.get("projectId").toString());
				if(growData!=null){
					request.setAttribute("groupRecordList", growData.get("groupRecordList"));
				}
				request.setAttribute("growData", growData);
			}
			
			//4.有没有需要推送的消息
/*			List<MyEarnings> meList = panicbuyProjectService.selectLast30DaysEarnings(userId);
			
			request.setAttribute("meList", meList);*/
			
			//获取本地时间（小时）
			request.setAttribute("hours", MyUtils.dateFormat8(new Date()));
			
			UserExt userExt = userService.selectUserExtByPrimaryKey(userId);
			
			request.setAttribute("userExt", userExt);
			
			List<UserPreorder> list = userService.selectLoadNameByUserId(userId);
			
			request.setAttribute("preOrderList", list);
			
			request.setAttribute("totalEr", userService.selectUserCenterData(userId).getEarnings());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Date date =sdf.parse("2015-09-30");
	         request.setAttribute("begTime", date);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("进入农场错误", e);
		}
		return "pc/user/myPigFarm";
	}
	
	
	
	/**
	 * 企业版：我的猪场
	 * @param earningsId
	 * @return
	 */
	@RequestMapping(value = "/pc/pv/epuser/farm", method = { RequestMethod.GET,RequestMethod.POST })
	public String myPigFarm2(Long earningsId){
		try {
			
			//拉取用户农场中的基本信息,包括公告信息、目前的猪数量、猪的成长状态、收益情况
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		
		
			Long userId = null != user ? user.getUserId() : null;
			
			//1.公告消息
			//从cookie中读取lastBulletinId
/*			Cookie cookie = CookieHelper.getCookieByName(request, CommConstant.COOKIE_LASTBULLETINID);
			
			Long lastBulletinId = null;
			
			if(null != cookie && StringUtils.isNotEmpty(cookie.getValue())){
				
				lastBulletinId = Long.valueOf(cookie.getValue());
			}
			
			Bulletin bulletin = commonService.selectRecentOneAfterChk(userId, lastBulletinId);
			
			if(null != bulletin){
				
				CookieHelper.addCookie(response, CommConstant.COOKIE_LASTBULLETINID, bulletin.getBulletinId().toString(), -1);
			}
			
			request.setAttribute("bulletin", bulletin);*/
				
			Map<String, Object> dataMap = myEarningsService.selectMyFarmData(userId, earningsId);
			
			//总猪数
			request.setAttribute("farmData",dataMap);
			
			if(dataMap!=null){
				//查询成长记录数据
				Map<String, Object> growData = myEarningsService.selectPerPigGrow(userId, dataMap.get("projectId").toString());
				if(growData!=null){
					request.setAttribute("groupRecordList", growData.get("groupRecordList"));
				}
				request.setAttribute("growData", growData);
			}
			
			//4.有没有需要推送的消息
/*			List<MyEarnings> meList = panicbuyProjectService.selectLast30DaysEarnings(userId);
			
			request.setAttribute("meList", meList);*/
			
			//获取本地时间（小时）
			request.setAttribute("hours", MyUtils.dateFormat8(new Date()));
			
			UserExt userExt = userService.selectUserExtByPrimaryKey(userId);
			
			request.setAttribute("userExt", userExt);
			
			List<UserPreorder> list = userService.selectLoadNameByUserId(userId);
			
			request.setAttribute("preOrderList", list);
			
			request.setAttribute("totalEr", userService.selectUserCenterData(userId).getEarnings());
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("进入农场错误", e);
		}
		return "pc/epuser/myPigFarm";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 我的收益
	 * @param projectId
	 * @return
	 */
	@RequestMapping(value = "/pc/pv/user/myEarning", method = { RequestMethod.GET,RequestMethod.POST })
	public String myEarning(Long projectId) {
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			//查询指定期的收益数据
			Map<String, Object> dataMap = myEarningsService.selectPerMyEarnings(userId,projectId.toString());
			
			request.setAttribute("data", dataMap);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("查看近期的收益情况", e);
		}
		
		return "/pc/user/myEarning";
	}
	
	/**
	 * 历史收益
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/user/earningHistory",method = {RequestMethod.GET,RequestMethod.POST})
	public String earningHistory() throws Exception{
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			Pages<MyEarnings> pages = myEarningsService.selectMyFinancing(userId, null,null, false);
			
			BigDecimal average = BigDecimal.ZERO;
			
			if(!MyUtils.isListEmpty(pages.getRoot())){
				
				Date date = new Date();
				
				Long intervalDays = null;
				
				for (MyEarnings myEarnings : pages.getRoot()) {
					
					intervalDays = MyUtils.calcDays(myEarnings.getBeginTime(), date);
					
					if(myEarnings.getEndTime().after(date)){
						
						//计算百分比
						myEarnings.setRate(BigDecimal.valueOf(intervalDays * 100).divide(BigDecimal.valueOf(myEarnings.getDays()) , 2, BigDecimal.ROUND_HALF_UP));
					}else{
						
						myEarnings.setRate(BigDecimal.valueOf(100));
					}	
					
					average = average.add(myEarnings.getRate());
				}
				
				average = average.divide(BigDecimal.valueOf(pages.getRoot().size()) , 2 , BigDecimal.ROUND_HALF_UP);
			}
			
			request.setAttribute("list", pages.getRoot());
			
			request.setAttribute("average", average);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("历史收益",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "/pc/user/earningHistory";
	}
	
	/**
	 * 抢标设置保存
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pv/user/preOrderSave", method = {RequestMethod.POST,RequestMethod.GET}, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String preOrderSave() throws Exception{
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
			System.out.println("aaaaaaaaaaaaaa");
			this.putJsonStatus(status);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			this.putJsonStatus(Status.serverError);
			throw e;
		}
		return this.outputJson();
	}
	
	/**
	 * 上传图片ajax
	 * @param request
	 * @param fresh 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/pc/pv/user/uploadHeadImgAjax", method = {RequestMethod.GET,RequestMethod.POST}, produces = "application/json; charset=utf-8")
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
	
}



















