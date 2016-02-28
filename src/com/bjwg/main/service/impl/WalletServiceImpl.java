package com.bjwg.main.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.constant.BalanceConstant;
import com.bjwg.main.constant.LoginConstants;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.dao.BankCardDao;
import com.bjwg.main.dao.BankPersonInfoDao;
import com.bjwg.main.dao.PayDao;
import com.bjwg.main.dao.WalletChangeDao;
import com.bjwg.main.dao.WalletDao;
import com.bjwg.main.dao.WithDrawalsDao;
import com.bjwg.main.model.BankCard;
import com.bjwg.main.model.BankCardExample;
import com.bjwg.main.model.BankPersonInfo;
import com.bjwg.main.model.BankPersonInfoExample;
import com.bjwg.main.model.Info;
import com.bjwg.main.model.InfoExample;
import com.bjwg.main.model.PanicbuyProjectExample;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.model.WalletAndBankCard;
import com.bjwg.main.model.WalletChange;
import com.bjwg.main.model.WalletChangeExample;
import com.bjwg.main.model.WalletExample;
import com.bjwg.main.model.WithDrawals;
import com.bjwg.main.model.WithDrawalsExample;
import com.bjwg.main.service.PanicbuyProjectService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.MD5;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ValidateUtil;
import com.sun.org.apache.bcel.internal.generic.RETURN;

/**
 * 钱包管理service
 * @author Allen
 * @version 创建时间：2015-4-2 下午04:55:56
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：用户
 */
@Service
public class WalletServiceImpl  implements WalletService {
	
	@Resource
	private WalletDao walletDao;
	@Resource
	private WalletChangeDao walletChangeDao;
	@Resource
	private BankCardDao bankCardDao;
	@Resource
	private WithDrawalsDao withDrawalsDao;
	@Resource
	private BankPersonInfoDao bankPersonInfoDao;
	@Resource
	private PayDao payDao;
	@Resource
	private SysConfigService sysConfigService;
	@Resource
	private PanicbuyProjectService panicbuyProjectService;

	
	/**
     * 查询余额并统计银行卡数
     * @param example
     * @return
     */
    public List<Wallet> selectCountCardNumberByExample(WalletExample example) throws Exception{
    	
    	return walletDao.selectCountCardNumberByExample(example);
    	
    }
    /**
     * 查询钱包变更记录
     * @param example
     * @return
     */
    public Pages<WalletChange> selectWalletChangeByExample(WalletChangeExample example,Pages<WalletChange> pages,boolean isPage) throws Exception{
    	
    	//分页查询
    	if(isPage){
    		int count = walletChangeDao.countByExample(example);
    		pages.setCountRows(count);
    		example.setPage(pages);
    	}
    	if(null == pages){
    		pages = new Pages<WalletChange>();
    	}
    	
    	List<WalletChange> list = walletChangeDao.selectByExample(example);
    	pages.setRoot(list);
    	return pages;
    }
    /**
     * 查询银行卡记录
     * @param example
     * @return
     */
    public List<BankCard> selectBankCardByExample(BankCardExample example) throws Exception{
    	
    	return bankCardDao.selectByExample(example);
    	
    }
    
    
    /**
     * 提现
     * @param bankCardId
     * @param password
     * @param money
     * @param userId
     * @param username
     * @return
     * @throws Exception
     */
	public Map<String, Object> updateWalletTakeCash(String bankCardId,String password,String money, Long userId,String username) throws Exception{
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			if(!ValidateUtil.validateInteger(bankCardId, false, null, null)){
				map.put("status", Status.bankCardIdNullity);
				return map;
			}
			if(!ValidateUtil.validateString(password, false, 6, 6)){
				map.put("status", Status.payPasswordNullity);
				return map;
			} 
			if(!ValidateUtil.validateDoublue(money, false, 0.01f, null)){
				map.put("status", Status.takeCashMoneyNullity);
				return map;
			} 
			//联合余额表和银行卡号表
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(userId);
			criteria.addCriterion(" bc.CARD_ID = " + bankCardId);
			List<WalletAndBankCard> bbcList = walletDao.selectLoadBankCardByExample(example);
			
			if(MyUtils.isListEmpty(bbcList)){
				map.put("status", Status.takeCashFail);
				return map;
			}
			WalletAndBankCard walletAndBankCard = bbcList.get(0);
			
			//余额记录不存在
			if(walletAndBankCard.getWalletId() == null || walletAndBankCard.getWalletId() < 0){
				map.put("status", Status.balanceNotExist);
				return map;
			}
			//银行卡号记录不存在
			if(walletAndBankCard.getCardId() == null || walletAndBankCard.getCardId() < 0){
				map.put("status", Status.bankCardNotExist);
				return map;
			}
			
			//检测用户输入的支付密码是否正确，若错误则更新错误次数，同一天错误的最大次数为WalletConstant.PAY_PASSWORD_LIMIT_ERROR_COUNT
			Status status = this.updateWalletPWErrorCount(walletAndBankCard.getJson(), password, walletAndBankCard.getPayPassword(), walletAndBankCard.getWalletId());
			
			if(status != Status.success){
				
				map.put("status", status);
				return map;
			}
			//保留2位小数，4舍5入
			BigDecimal changeMoney = new BigDecimal(money).setScale(2,4);
			
			//验证金额是否充足
			if(walletAndBankCard.getMoney().doubleValue() < changeMoney.doubleValue()){
				
				map.put("status", Status.takeCashMoneyNotEnough);
				return map;
			}
			
			//更改余额记录
			Wallet balance = new Wallet();
			balance.setWalletId(walletAndBankCard.getWalletId());
			balance.setMoney(walletAndBankCard.getMoney().subtract(changeMoney));
			
			//添加提现记录
			WithDrawals withDrawals = new WithDrawals();
			withDrawals.setAccountName(walletAndBankCard.getAccountName());
			withDrawals.setWalletId(walletAndBankCard.getWalletId());
			withDrawals.setBank(walletAndBankCard.getBank());
			withDrawals.setBankCode(walletAndBankCard.getBankCode());
			withDrawals.setCardId(walletAndBankCard.getCardId());
			withDrawals.setCardType(walletAndBankCard.getCardType());
			withDrawals.setCtime(new Date());
			withDrawals.setIdCard(walletAndBankCard.getIdCard());
			withDrawals.setMoney(changeMoney);
			withDrawals.setStatus(BalanceConstant.W_STATUS_NEW);
			withDrawals.setUserId(userId);
			withDrawals.setUsername(username);
			
			walletDao.updateByPrimaryKeySelective(balance);
			
			withDrawalsDao.insert(withDrawals);
			
			this.insertWalletChange(walletAndBankCard.getWalletId(), walletAndBankCard.getMoney(), changeMoney, balance.getMoney(), 
					BalanceConstant.CHANGE_TYPE_TRANSFER, userId, withDrawals.getWithwradalsId(),BalanceConstant.RELATION_TYPE_TRANSFER);
			
			map.put("walletAndBankCard", walletAndBankCard);
			map.put("status", Status.success);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 检测用户输入的支付密码是否正确，若错误则更新错误次数，同一天错误的最大次数为BalanceConstant.PAY_PASSWORD_LIMIT_ERROR_COUNT
	 * @param json 密码输入错误信息
	 * @param password 输入的支付密码
	 * @param payPassword 数据库中保存的输入密码
	 * @param balanceId 余额记录id
	 * @return
	 * @throws Exception
	 */
	public Status updateWalletPWErrorCount(String json,String password,String payPassword,Long balanceId) throws Exception{
		try {
			JSONObject jsonObject = null;
			Integer errorCount = null;
			String errorDate = null;
			Date fErrorDate = null;
			//当天输入密码错误的次数是否超过限制了
			if(StringUtils.isNotEmpty(json)){
				jsonObject = JSONObject.fromObject(json);
				errorCount = jsonObject.getInt(BalanceConstant.PPW_ERROR_COUNT_KEY);
				errorDate = jsonObject.getString(BalanceConstant.PPW_ERROR_DATE_KEY);
				fErrorDate = MyUtils.dateFormat4(errorDate, 0);
				
				//查询
				String payPasswordLimitErrorCount = sysConfigService.queryOneValue(SysConstant.PAY_PASSWORD_LIMIT_ERROR_COUNT);
				
				if(StringUtils.isNotEmpty(payPasswordLimitErrorCount)){
					
					//是当天且输入密码错误超过指定限制
					if(MyUtils.isSameDay(new Date(), fErrorDate) && errorCount >= Integer.valueOf(payPasswordLimitErrorCount)){
						Status.payPasswordErrorOverLimit.setMsg("您当天支付密码输入错误已超过"+payPasswordLimitErrorCount+"次，请明天再操作");
						return Status.payPasswordErrorOverLimit;
					}
				}
				
			}
			
			//验证密码是否正确
			String encryptPassword = MD5.GetMD5Code(MD5.GetMD5Code(password)+ LoginConstants.LOGIN_PASSWORD_PARAM);
			if(!encryptPassword.equals(payPassword)){
				//取当天
				errorDate = MyUtils.dateFormat4(new Date(), 0);
				//已有历史输入错误记录
				if(jsonObject != null){
					//是当天则+1，否则为1
					if(MyUtils.isSameDay(new Date(), fErrorDate)){
						errorCount ++;
					}else{
						errorCount = 1;
					}
				}else{
					jsonObject = new JSONObject();
					errorCount = 1;
				}
				jsonObject.put(BalanceConstant.PPW_ERROR_COUNT_KEY, errorCount);
				jsonObject.put(BalanceConstant.PPW_ERROR_DATE_KEY, errorDate);
				//更新错误次数
				Wallet balance = new Wallet();
				balance.setWalletId(balanceId);
				balance.setJson(jsonObject.toString());
				walletDao.updateByPrimaryKeySelective(balance);
				
				return Status.payPasswordIncorrect;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return Status.success;
		
	}
	
	/**
	 * 添加余额变更记录
	 * @param balanceId 余额记录id
	 * @param beforeMoney 变更前金额
	 * @param changeMoney 变更金额
	 * @param afterMoney 变更后金额
	 * @param changType 变更类型
	 * @param userId 用户id
	 * @param relationId 提现记录id
	 * @throws Exception
	 */
	public void insertWalletChange(Long balanceId,BigDecimal beforeMoney,BigDecimal changeMoney,BigDecimal afterMoney,Byte changType,Long userId,Long relationId,Byte relationType) throws Exception{
		try {
			
			//添加余额变更记录
			WalletChange balanceChange = new WalletChange();
			balanceChange.setWalletId(balanceId);
			balanceChange.setBeforeMoney(beforeMoney);
			balanceChange.setChangeMoney(changeMoney);
			balanceChange.setAfterMoney(afterMoney);
			balanceChange.setChangeTime(new Date());
			balanceChange.setChangeType(changType);
			balanceChange.setUserId(userId);
			balanceChange.setRelationId(relationId);
			balanceChange.setRelationType(relationType);
			walletChangeDao.insert(balanceChange);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 提现记录
	 * @param request
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<WithDrawals> selectWithDrawalsList(Long userId) throws Exception{
		
		WithDrawalsExample example = new WithDrawalsExample();
		WithDrawalsExample.Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userId);
		example.setOrderByClause(" wd.CTIME desc ");
		return withDrawalsDao.selectByExample(example);
	}
	
	
	/**
	 * 查询银行卡号记录
	 * @param bankCardId
	 * @return
	 * @throws Exception
	 */
	public BankCard selectBankCardByPrimaryKey(Long cardId) throws Exception{
		return bankCardDao.selectByPrimaryKey(cardId);
	}
	
	
	/**
	 * 编辑银行卡记录前检查参数是否合法
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Status checkBeforesaveBankCard(String cardId,String cardType,String accountName,String cardNo,String idCard,String bank,String bankCode,String link,Long userId,String provinceStr,String cityStr) throws Exception{
		
		if(!ValidateUtil.validateInteger(cardId, true, 1, null)){
			return Status.bankCardIdNullity;
		}
		//卡类型
		if(!ValidateUtil.validateString(cardType, false, 1, null)){
			return Status.bankCardTypeNullity;
		}
		//户名
		if(!ValidateUtil.validateString(accountName, false, 1, 255)){
			return Status.bankCardNameNullity;
		}
		//卡号
		if(!ValidateUtil.validateString(cardNo, false, 1, 19)){
			return Status.bankCardNoNullity;
		}
		//身份证号
		if(!ValidateUtil.validateString(idCard, false, 1, 18)){
//			return Status.credentialsNoInvalid;
		}
		//联系方式
		if(!ValidateUtil.validateString(link, true, 1, 15)){
			return Status.bankCardLinkNullity;
		}
		//省份
		if(!ValidateUtil.validateString(provinceStr, false, 1, null)){
			return Status.provinceNullity;
		}
		//城市
		if(!ValidateUtil.validateString(cityStr, true, 1, null)){
			return Status.cityNullity;
		}
		
		return Status.success;
	}
	/**
	 * 编辑银行卡记录
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Status saveBankCard(String cardId,String cardType,String accountName,String cardNo,String idCard,String bank,String bankCode,String link,Long userId,String provinceStr,String cityStr) throws Exception{
		
		try {
			cityStr = StringUtils.isEmptyNo(cityStr) ? provinceStr : cityStr;
			Status status = checkBeforesaveBankCard(cardId,cardType,accountName,cardNo,idCard,bank,bankCode,link, userId,provinceStr,cityStr);
			if(status == Status.success){
				
				
				BankCard bankCard = new BankCard();
				bankCard.setAccountName(accountName);
				//要记得改
				bankCard.setBank(bank);
				bankCard.setBankCode(bankCode);
				//要记得改
				bankCard.setCardNo(cardNo);
				bankCard.setCardType(Short.valueOf(cardType));
				bankCard.setIdCard(idCard);
				bankCard.setLink(link);
				bankCard.setUserId(userId);
				bankCard.setProvince(Long.valueOf(provinceStr));
				bankCard.setCity(Long.valueOf(cityStr));
				if(StringUtils.isNotEmpty(cardId)){
					bankCard.setCardId(Long.valueOf(cardId));
					bankCardDao.updateByPrimaryKeySelective(bankCard);
				}else{
					
					//如果没有个人银行信息则添加
					BankPersonInfo bankPersonInfo = this.selectBankPersonInfo(userId);
					
					if(null == bankPersonInfo){
						
						bankPersonInfo = new BankPersonInfo();
						
						bankPersonInfo.setCtime(new Date());
						bankPersonInfo.setIdCard(bankCard.getIdCard());
						bankPersonInfo.setName(bankCard.getAccountName());
						bankPersonInfo.setUserId(userId);
						bankPersonInfoDao.insert(bankPersonInfo);
					}
					
					bankCardDao.insert(bankCard);
					//查询是否设置了支付密码
					WalletExample balanceExample = new WalletExample();
					WalletExample.Criteria criteria = balanceExample.createCriteria();
					criteria.andUserIdEqualTo(userId);
					List<Wallet> list = walletDao.selectByExample(balanceExample);
					//没有支付密码，则需要用户设置支付密码
					if(MyUtils.isListEmpty(list) || !StringUtils.isNotEmpty(list.get(0).getPayPassword())){
						
						return Status.balanceNotExist;
					}
					
				}
				
				return Status.success;
			}
			
			return status;
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 删除银行卡
	 * @param cardId
	 * @param request
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Status deleteBankCard(Long cardId, Long userId) throws Exception{
		
		try {
			
			if(cardId != null && cardId > 0){
				
				//查询银行卡记录，确认是否为当前用户的记录
				BankCardExample example = new BankCardExample();
				BankCardExample.Criteria criteria = example.createCriteria();
				criteria.andCardIdEqualTo(cardId);
				criteria.andUserIdEqualTo(userId);
				if(bankCardDao.countByExample(example) > 0){
					
					bankCardDao.deleteByPrimaryKey(cardId);
				}
			}
			
			return Status.success;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 设置支付密码
	 * @param request
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Status savePayPassword(String pw,String cpw, Long userId) throws Exception{
		try {
			
			//检测密码是否6位
			if(!ValidateUtil.validateString(pw, false, 6, 6)){
				return Status.payPasswordNullity;
			}
			
			if(!ValidateUtil.validateString(cpw, false, 6, 6)){
				return Status.payPasswordConfirmNullity;
			}
			
			//查询用户之前是否设置过支付密码
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(userId);
			List<Wallet> list = walletDao.selectByExample(example);
			
			Long balanceId = null;
			if(!MyUtils.isListEmpty(list)){
				//有设置过密码，不能再设置一遍
				if(StringUtils.isNotEmpty(list.get(0).getPayPassword())){
					return Status.payPasswordForbidSet;
				}
				balanceId = list.get(0).getWalletId();
			}
			 
			String enPw = MD5.GetMD5Code(MD5.GetMD5Code(pw)+ LoginConstants.LOGIN_PASSWORD_PARAM);
			Wallet balance = new Wallet();
			balance.setPayPassword(enPw);
			if(balanceId != null){
				balance.setWalletId(balanceId);
				walletDao.updateByPrimaryKeySelective(balance);
			}else{
				balance.setUserId(userId);
				balance.setMoney(BigDecimal.ZERO);
				balance.setStatus(BalanceConstant.B_STATUS_NORMAL);
				walletDao.insert(balance);
			}
			
			return Status.success;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 修改支付密码
	 * @return
	 * @throws Exception
	 */
	public Status updatePasswordReset(String payPassword,String confirmPayPassword,Long userId) throws Exception{
		
		try {
			
			
			if(null == userId || userId <= 0){
				return Status.useridNullity;
			}
			if(!ValidateUtil.validateString(payPassword, false, 6, 6)){
				return Status.payPasswordNewNullity;
			}
			if(!ValidateUtil.validateString(confirmPayPassword, false, 6, 6)){
				return Status.payPasswordConfirmNullity;
			}
			
			if(!payPassword.equals(confirmPayPassword)){
				return Status.payPasswordNotSame;
			}
				
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(userId);
			//查询密码
			List<Wallet> balanceList = walletDao.selectByExample(example);
			
			if(!MyUtils.isListEmpty(balanceList)){
				
				//更新新的支付密码
				String enPw = MD5.GetMD5Code(MD5.GetMD5Code(payPassword)+ LoginConstants.LOGIN_PASSWORD_PARAM);
				Wallet balance = new Wallet();
				balance.setPayPassword(enPw);
				balance.setWalletId(balanceList.get(0).getWalletId());
				walletDao.updateByPrimaryKeySelective(balance);
				
				return Status.success;
			}
				
			return Status.balanceNotExist;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int countByExample(WalletExample example) {
		return walletDao.countByExample(example);
	}

	@Override
	public int deleteByPrimaryKey(Long balanceId) {
		return walletDao.deleteByPrimaryKey(balanceId);
	}

	@Override
	public int insert(Wallet record) {
		return walletDao.insert(record);
	}

	@Override
	public int insertSelective(Wallet record) {
		return walletDao.insertSelective(record);
	}

	@Override
	public List<Wallet> selectByExample(WalletExample example) {
		return walletDao.selectByExample(example);
	}

	@Override
	public Wallet selectByPrimaryKey(Long balanceId) {
		return walletDao.selectByPrimaryKey(balanceId);
	}

	@Override
	public int updateByPrimaryKeySelective(Wallet record) {
		return walletDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Wallet record) {
		return walletDao.updateByPrimaryKey(record);
	}
	
	/**
	 * 查询账户余额
	 */
	@Override
	public Wallet queryByUserId(Long userId) throws Exception {

		if(null == userId || userId <= 0){
			
			return null;
		}
		WalletExample example = new WalletExample();
		WalletExample.Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userId);
		List<Wallet> balances = walletDao.selectByExample(example);
		return MyUtils.isListEmpty(balances) ? null : balances.get(0);
	}
	
	/**
	 * 查询个人银行信息
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public BankPersonInfo selectBankPersonInfo(Long userId) throws Exception{
		
		BankPersonInfoExample example = new BankPersonInfoExample();
		BankPersonInfoExample.Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userId);
		
		List<BankPersonInfo> list = bankPersonInfoDao.selectByExample(example);
		
		return MyUtils.isListEmpty(list) ? null : list.get(0);
		
	}
	
	@Override
	public Status updatePayPassword(String oldPwd,String newPwd,Long userId) throws Exception{
		Status status = Status.success;
		try {
			WalletExample example = new WalletExample();
			WalletExample.Criteria criteria = example.createCriteria();
			criteria.andUserIdEqualTo(userId);
			List<Wallet> walletList = walletDao.selectByExample(example);
			
			if(!MyUtils.isListEmpty(walletList)){
				
				if(StringUtils.isNotEmpty(walletList.get(0).getPayPassword())){
					
					//检测密码是否正确，若不正确则更新当天密码输入错误次数
					status = this.updateWalletPWErrorCount(walletList.get(0).getJson(), oldPwd, walletList.get(0).getPayPassword(), walletList.get(0).getWalletId());
					if(status==Status.success){
						String enPw = MD5.GetMD5Code(MD5.GetMD5Code(newPwd)+ LoginConstants.LOGIN_PASSWORD_PARAM);
						Wallet balance = new Wallet();
						balance.setPayPassword(enPw);
						balance.setWalletId(walletList.get(0).getWalletId());
						walletDao.updateByPrimaryKeySelective(balance);
					}
				}else{
					
					status = Status.payPasswordNotExist;
				}
			}else{
				
				status = Status.payPasswordNotExist;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return status;
	}
	
	
	/**
     * 统计银行卡记录
     * @param example
     * @return
     */
    public int countBankCardByExample(BankCardExample example) throws Exception{
    	
    	return bankCardDao.countByExample(example);
    	
    }
}
















