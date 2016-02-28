package com.bjwg.main.controller.pc;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Area_V2;
import com.bjwg.main.model.BankCard;
import com.bjwg.main.model.BankCardExample;
import com.bjwg.main.model.BankPersonInfo;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.model.WalletChange;
import com.bjwg.main.model.WalletChangeExample;
import com.bjwg.main.model.WalletExample;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.JsonUtils;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ValidateUtil;

/**
 * @author Carter
 * @version 创建时间：Sep 14, 2015 2:58:30 PM
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_wallet_controller")
@Scope("prototype")
public class WalletController extends BaseController {

	@Autowired
	WalletService walletService;
	
	/**
	 * 首次设置支付密码
	 * @return
	 * @throws JSONException 
	 */
	@RequestMapping(value="/pc/pv/wallet/setPayPassword",method = {RequestMethod.GET,RequestMethod.POST},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String setPayPassword() throws JSONException{
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			String pw = request.getParameter("newPwd");
			
			String cpw = pw;
			
			Status status = walletService.savePayPassword(pw,cpw,user.getUserId());
			
			if(status==Status.success){
				request.getSession().setAttribute(CommConstant.SESSION_USER_SET_PAY_PASSWORD,"yes");
			}
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("设置支付密码",e);
		}
		return this.outputJson();
	}
	
	/**
	 * 支付密码修改
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/pc/pv/wallet/payPasswordModify",method = {RequestMethod.POST},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String payPasswordModify() throws Exception{
		JSONObject jsonObject = new JSONObject();
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			String oldPwd = request.getParameter("oldPwd");
			String newPwd = request.getParameter("newPwd");
			
			Status status = walletService.updatePayPassword(oldPwd, newPwd, user.getUserId());
			jsonObject = JsonUtils.getJsonObject(status);
		} catch (Exception e) {
			e.printStackTrace();
			/*logger.error("支付密码管理  - 修改密码  - 验证旧密码是否正确",e);*/
			/*this.notifyMsg(request, Status.serverError);*/
		}
		
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/wlwalletChange",method = {RequestMethod.GET,RequestMethod.POST})
	public String walletChange(HttpServletRequest request ){
		
		try {
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			WalletChangeExample changeExample = new WalletChangeExample();
			WalletChangeExample.Criteria criteria = changeExample.createCriteria();
			criteria.andUserIdEqualTo(user.getUserId());
			//变更类型
			String changeType = request.getParameter("changeType");
			if(StringUtils.isNotEmpty(changeType)){
				if("2".equals(changeType) || "4".equals(changeType) || "5".equals(changeType)){
					changeType = "2";
				}
				criteria.andChangeTypeEqualTo(Short.valueOf(changeType));
			}
			changeExample.setOrderByClause(" change_time desc ");
			
			Pages<WalletChange> page = new Pages<WalletChange>();
			page.setCurrentPage(currentPage);
			page.setPerRows(10);
			
			walletService.selectWalletChangeByExample(changeExample,page,true);
			
			request.setAttribute("page", page);
			request.setAttribute("list", page.getRoot());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("钱包变更记录",e);
			this.notifyMsg(request, Status.serverError);
		}
		return "wallet/wallet_change";
	}
	
	/**
	 * 账户总览
	 * @return
	 */
	@RequestMapping(value="/pc/pv/wallet/home",method = {RequestMethod.GET,RequestMethod.POST})
	public String home(){
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(user.getUserId());
			
			//查余额与银行卡数量
			List<Wallet> list = walletService.selectCountCardNumberByExample(example);
			request.setAttribute("wallet", MyUtils.isListEmpty(list) ? new Wallet() : list.get(0));
			
			BankCardExample example_bk = new BankCardExample();
			BankCardExample.Criteria criteria_bk = example_bk.createCriteria();
			criteria_bk.andUserIdEqualTo(user.getUserId());
			example_bk.setOrderByClause(" card_id desc ");
			
			//查银行卡列表
			List<BankCard> list_bk = walletService.selectBankCardByExample(example_bk);
			request.setAttribute("bankCardList", list_bk);
			
			WalletChangeExample example_wc = new WalletChangeExample();
			WalletChangeExample.Criteria criteria_wc = example_wc.createCriteria();
			criteria_wc.andUserIdEqualTo(user.getUserId());
			example_wc.setOrderByClause(" change_time desc ");

			//查资金变动
			Pages<WalletChange> page = new Pages<WalletChange>();
			page.setCurrentPage(currentPage);
			page.setPerRows(10);
			walletService.selectWalletChangeByExample(example_wc,page,true);
			request.setAttribute("pager", MyUtils.calcPagerNum(page.getPerRows(), page.getCountRows(), page.getCurrentPage(), 6));
			request.setAttribute("walletChangeList", page.getRoot());
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("我的钱包页面",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "/pc/wallet/home";
	}
	
	/**
	 * 银行卡编辑页
	 * @return
	 */
	@RequestMapping(value = "/pc/pv/wallet/bandCardEdit", method = { RequestMethod.GET, RequestMethod.POST })
	public String bandCardEdit(Long cardId) {
		try {
			if(!this.validateIsUserSetPayPw()){
				return "/pc/wallet/setPayPwd";
			}
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			BankCard bankCard = null;
			if(cardId != null && cardId > 0){
				bankCard = walletService.selectBankCardByPrimaryKey(cardId);
			}
			request.setAttribute("bankCard", bankCard);
			//request.setAttribute("s_type", request.getParameter("s_type"));
			
/*			String password = request.getParameter("password");*/
			
			//需要验证支付密码
//			if(validatePw){
//				
//				Status status = this.validatePayPassword(password, request);
//				
//				//支付密码错误则跳转到列表页面
//				if(status != Status.success){
//					
//					if(status == Status.payPasswordIncorrect){
//						
//						//显示密码输入错误框
//						request.setAttribute("showPwIncorrect", "yes");
//					}
//					notifyMsg(request, status);
//					return bankCardList(request);
//				}
//			}
			
			//查询个人银行信息
			BankPersonInfo bankPersonInfo = walletService.selectBankPersonInfo(userId);
			
			request.setAttribute("bankPersonInfo", bankPersonInfo);
			
			List<Area_V2> areas = PhoneBaseData.getInstance().getProvinceList();
			request.setAttribute("provinceList", areas);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转编辑上门地址信息  出错", e);
		}
		return "/pc/wallet/bandCardEdit";
	}
	
	/**
	 * 银行卡保存
	 * @return
	 */
	@RequestMapping(value="/pc/pv/wallet/bankCardSave",method = {RequestMethod.GET,RequestMethod.POST})
	public String bankCardSave(){
		try {
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/wlbankCardSave -- > user:"+user + " --> userId:"+userId);
			
			String cardId = request.getParameter("cardId");
			//卡类型
			String cardType = request.getParameter("cardType");
			//户名
			String accountName = request.getParameter("accountName");
			//卡号
			String cardNo = request.getParameter("cardNo");
			//身份证号
			String idCard = request.getParameter("idCard");
			//联系方式
			String link = request.getParameter("link");
			String bank = request.getParameter("bank");
			String bankCode = request.getParameter("bankCode");
			//省份
			String provinceStr = request.getParameter("province");
			//城市
			String cityStr = request.getParameter("city");
			
			Status status = walletService.saveBankCard(cardId,cardType,accountName,cardNo,idCard,bank,bankCode,link,userId,provinceStr,cityStr);
			
			//设置支付密码
			if(status == Status.balanceNotExist){
				return "/pc/wallet/setPayPwd";
			}
			this.notifyMsg(request, status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("银行卡编辑",e);
			this.notifyMsg(request, Status.serverError);
		}
		return home();
	}

	/**
	 * 检测用户是否设置了支付密码，添加银行卡和删除银行卡调用
	 * @return
	 * @throws Exception
	 */
	private boolean validateIsUserSetPayPw() throws Exception{
		
		String is_set_pw = (String)request.getSession().getAttribute(CommConstant.SESSION_USER_SET_PAY_PASSWORD);
		if(!StringUtils.isNotEmpty(is_set_pw)){
			//查询是否有支付密码
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria = example.createCriteria();
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			criteria.andUserIdEqualTo(user.getUserId());
			List<Wallet> list = walletService.selectByExample(example);
			//没有支付密码则不需要验证
			if(MyUtils.isListEmpty(list) || StringUtils.isEmptyNo(list.get(0).getPayPassword())){
				request.getSession().setAttribute(CommConstant.SESSION_USER_SET_PAY_PASSWORD,"no");
				return false;
			}else{
				request.getSession().setAttribute(CommConstant.SESSION_USER_SET_PAY_PASSWORD,"yes");
				return true;
			}
		}else if("yes".equals(is_set_pw)){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 银行卡删除
	 * @param cardId
	 * @return
	 * @throws JSONException
	 */
	@RequestMapping(value="/pc/pv/wallet/bankCardDel",method = {RequestMethod.GET,RequestMethod.POST},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String bankCardDelete(Long cardId, String password) throws JSONException{
		try {
			
			Status status = Status.success;
			
			status = this.validatePayPassword(password, request);
			
			if(status == Status.success){
				UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
				status = walletService.deleteBankCard(cardId,user.getUserId());
			}
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("银行卡删除",e);
			this.putJsonStatus(Status.serverError);
		}
		
		return this.outputJson();
	}
	
	private Status validatePayPassword(String password,HttpServletRequest request){
		
		Status status = Status.success;
		try {
			
			if(!ValidateUtil.validateString(password,false,6,6)){
				
				status = Status.payPasswordNullity;
				return status;
			}
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(user.getUserId());
			List<Wallet> walletList = walletService.selectByExample(example);
			if(!MyUtils.isListEmpty(walletList)){
				
				Wallet wallet = walletList.get(0);
				
				status = walletService.updateWalletPWErrorCount(wallet.getJson(), password, wallet.getPayPassword(), wallet.getWalletId());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("验证输入支付密码",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return status;
	}
	
	/**
	 * 提现
	 * @return
	 */
	@RequestMapping(value="/pc/pv/wallet/takeCash",method = {RequestMethod.GET,RequestMethod.POST})
	public String takeCash(){
		try {
		
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			BankCardExample cardExample = new BankCardExample();
			BankCardExample.Criteria criteria = cardExample.createCriteria();
			criteria.andUserIdEqualTo(user.getUserId());
			
			//查询银行卡列表
			List<BankCard> bankCardList = walletService.selectBankCardByExample(cardExample);
			request.setAttribute("bankCardList", bankCardList);
			
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria2 = example.createCriteria();
			criteria2.andUserIdEqualTo(user.getUserId());
			
			//查询余额
			List<Wallet> walletList = walletService.selectByExample(example);
			request.setAttribute("wallet", MyUtils.isListEmpty(walletList) ? null : walletList.get(0));
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("提现页面",e);
			this.notifyMsg(request, Status.serverError);
		}
		return "/pc/wallet/takeCash";
	}
	
	/**
	 * 提现确认
	 * @param cardId
	 * @param money
	 * @return
	 */
	@RequestMapping(value="/pc/pv/wallet/takeCashConfirm",method = {RequestMethod.GET,RequestMethod.POST})
	public String takeCashConfirm(Long cardId, String money){
		try {
			
			String cardNo=request.getParameter("cardNo");
			System.out.println("银行卡号"+cardNo);
			Status status = Status.success;
			
			if(!ValidateUtil.validateDoublue(money, false, 0.01f, null)){
				status = Status.takeCashMoneyNullity;
			} 
			if(cardId == null || cardId <= 0){
				status = Status.bankCardIdNullity;
			} 
			
			this.notifyMsg(request, status);
			
			if(Status.success != status){
				
				return home();
			}
			
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			BankCardExample cardExample = new BankCardExample();
			BankCardExample.Criteria criteria = cardExample.createCriteria();
			criteria.andUserIdEqualTo(user.getUserId());
			criteria.andCardIdEqualTo(cardId);
			criteria.andCardNoEqualTo(cardNo);
			//查询银行卡列表
			List<BankCard> bankCardList = walletService.selectBankCardByExample(cardExample);
			
			if(status == Status.success){
				
				request.setAttribute("cardId", cardId);
				request.setAttribute("money", money);
				//request.setAttribute("s_type", RedirectConstant.MY_WALLET_RETURN_INIT);
				if(!MyUtils.isListEmpty(bankCardList)) {
					request.setAttribute("bank", bankCardList.get(0).getBank());
					request.setAttribute("cardNo", bankCardList.get(0).getCardNo());
					request.setAttribute("bankCard", bankCardList.get(0));
				}
				return "/pc/wallet/takeCashConfirm";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("提现输入支付密码页面",e);
			this.notifyMsg(request, Status.serverError);
		}
		
		return "/pc/wallet/takeCashConfirm";
	}
	
	/**
	 * 提现提交
	 * @param cardId
	 * @param password
	 * @param money
	 * @return
	 * @throws JSONException 
	 */
	@RequestMapping(value="/pc/pv/wallet/takeCashSubmit",method = {RequestMethod.GET,RequestMethod.POST},produces = "application/json; charset=utf-8")
	@ResponseBody
	public String takeCashSubmit(Long cardId, String password, String money) throws JSONException{
		try {
			
			//查询银行卡记录
			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Map<String, Object> map = walletService.updateWalletTakeCash(cardId.toString(),password,money,user.getUserId(),user.getNickname());
			
			Status status = (Status)map.get("status");
			
			if(status == Status.success){
				
				/*WalletAndBankCard walletAndBankCard = (WalletAndBankCard)map.get("walletAndBankCard");
				
				request.getSession().setAttribute("walletAndBankCard", walletAndBankCard);
				
				return "redirect:/wpv/wlpaySuccess?pay_type=1&money="+money;*/
			}
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("生成提现记录",e);
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	
}

















