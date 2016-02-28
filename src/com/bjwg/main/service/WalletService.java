package com.bjwg.main.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.BankCard;
import com.bjwg.main.model.BankCardExample;
import com.bjwg.main.model.BankPersonInfo;
import com.bjwg.main.model.Order;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.model.WalletChange;
import com.bjwg.main.model.WalletChangeExample;
import com.bjwg.main.model.WalletExample;
import com.bjwg.main.model.WithDrawals;


/**
 * 我的钱包service
 * @author Allen
 * @version 创建时间：2015-4-2 下午04:55:08
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：用户
 */

public interface WalletService{

	/**
     *
     * @mbggenerated
     */
    int countByExample(WalletExample example);

    /**
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long balanceId);

    /**
     *
     * @mbggenerated
     */
    int insert(Wallet record);

    /**
     *
     * @mbggenerated
     */
    int insertSelective(Wallet record);

    /**
     *
     * @mbggenerated
     */
    List<Wallet> selectByExample(WalletExample example);

    /**
     *
     * @mbggenerated
     */
    Wallet selectByPrimaryKey(Long balanceId);

    /**
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Wallet record);

    /**
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Wallet record);
    
    /**
     * 查询余额并统计银行卡数
     * @param example
     * @return
     */
    public List<Wallet> selectCountCardNumberByExample(WalletExample example) throws Exception;
    
    /**
     * 查询钱包变更记录
     * @param example
     * @return
     */
    public Pages<WalletChange> selectWalletChangeByExample(WalletChangeExample example,Pages<WalletChange> pages,boolean isPage) throws Exception;
    
    /**
     * 查询银行卡记录
     * @param example
     * @return
     */
    public List<BankCard> selectBankCardByExample(BankCardExample example) throws Exception;

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
    Map<String, Object> updateWalletTakeCash(String bankCardId,String password,String money, Long userId,String username) throws Exception;

	/**
	 * 提现记录
	 * @param request
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	List<WithDrawals> selectWithDrawalsList(Long userId) throws Exception;
	
	/**
	 * 检测用户输入的支付密码是否正确，若错误则更新错误次数，同一天错误的最大次数为BalanceConstant.PAY_PASSWORD_LIMIT_ERROR_COUNT
	 * @param json 密码输入错误信息
	 * @param password 输入的支付密码
	 * @param payPassword 数据库中保存的输入密码
	 * @param balanceId 余额记录id
	 * @return
	 * @throws Exception
	 */
	public Status updateWalletPWErrorCount(String json,String password,String payPassword,Long balanceId) throws Exception;
	
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
	public void insertWalletChange(Long balanceId,BigDecimal beforeMoney,BigDecimal changeMoney,BigDecimal afterMoney,Byte changType,Long userId,Long relationId,Byte relationType) throws Exception;
	

	/**
	 * 查询银行卡号记录
	 * @param bankCardId
	 * @return
	 * @throws Exception
	 */
	BankCard selectBankCardByPrimaryKey(Long bankCardId) throws Exception;

	/**
	 * 编辑银行卡记录
	 * @param request
	 * @return
	 * @throws Exception
	 */
	Status saveBankCard(String cardId,String cardType,String accountName,String cardNo,String idCard,String bank,String bankCode,String link,Long userId,String provinceStr,String cityStr) throws Exception;

	/**
	 * 设置支付密码
	 * @param request
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Status savePayPassword(String pw,String cpw, Long userId) throws Exception;

	/**
	 * 根据userId查询账户余额
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Wallet queryByUserId(Long userId)throws Exception;

	/**
	 * 删除银行卡
	 * @param cardId
	 * @param request
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Status deleteBankCard(Long cardId, Long userId) throws Exception;
	
	/**
	 * 编辑银行卡记录前检查参数是否合法
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Status checkBeforesaveBankCard(String cardId,String cardType,String accountName,String cardNo,String idCard,String bank,String bankCode,String link,Long userId,String provinceStr,String cityStr) throws Exception;

	/**
	 * 修改支付密码
	 * @param request
	 * @return
	 * @throws Exception
	 */
	Status updatePasswordReset(String payPassword,String confirmPayPassword,Long userId) throws Exception;

	
	/**
	 * 查询个人银行信息
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public BankPersonInfo selectBankPersonInfo(Long userId) throws Exception;

	Status updatePayPassword(String oldPwd, String newPwd, Long userId) throws Exception;

	
	/**
     * 统计银行卡记录
     * @param example
     * @return
     */
    public int countBankCardByExample(BankCardExample example) throws Exception;
	
	
}
