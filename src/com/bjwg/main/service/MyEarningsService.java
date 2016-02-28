package com.bjwg.main.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.bjwg.main.base.Pages;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.MyEarningsExample;
import com.bjwg.main.model.Wallet;


/**
 * 我的收益service
 * @author Administrator
 *
 */
public interface MyEarningsService {

	
	/**
	 * 查询我的收益
	 * @param MyEarningsExample
	 * @return
	 * @throws Exception
	 */
	List<MyEarnings> selectByExample(MyEarningsExample example)throws Exception;
	/**
     * 查询进入农场数据
     * @param queryMap
     * @return
     * @throws Exception
     */
    Map<String, Object> selectMyHomeData(Long userId)throws Exception;
    
    /**
	 * 查询抢购的每期的猪头数
	 * 不包括已完成的
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectPerPigNum(Long userId) throws Exception;

	/**
	 * 查看指定期的成长记录
	 * @param userId
	 * @param queryProjectId
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectPerPigGrow(Long userId, String queryProjectId) throws Exception;

	/**
	 * 查看我参与的所有期
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	List<MyEarnings> selectAllJoin(Long userId) throws Exception;

	/**
	 * 查看我参与的指定期的收益
	 * @param userId
	 * @param queryProjectId
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectPerMyEarnings(Long userId, String queryProjectId) throws Exception;
    
    
    /**
	 * 新增
	 * @return
	 * @throws Exception
	 */
	public void insert(MyEarnings myEarnings)throws Exception;
	
	/**
	 * 修改
	 * @return
	 * @throws Exception
	 */
	public int updateByPrimaryKeySelective(MyEarnings myEarnings)throws Exception;
	
	/**
     * 查询每期的已抢购总数、个人抢购总数、个人花费的成本、每期总数、每期的id和名称
     * @return
     * @throws Exception
     */
    Pages<MyEarnings> selectMyFinancing(Long userId,String projectId,Pages<MyEarnings> pages,boolean isPage) throws Exception;
    
    /**
     * 计算收益
     * @param num 总数
     * @param rate 年收益率
     * @param money 单只成本
     * @param days 累计天数
     * @return
     * @throws Exception
     */
    public BigDecimal calcEarnings(Integer num,BigDecimal rate,BigDecimal money,Integer days) throws Exception;
    
    /**
     * 添加赠送记录
     * @param presentedRelationId 被赠送关联id
     * @param presentedUser 被赠送人昵称
     * @param presentedUserId 被赠送人id
     * @param presentNum 赠送数量
     * @param presentRelationId 赠送关联id
     * @param presentUser 赠送人昵称
     * @param presentUserId 赠送人id
     * @param price 单价
     * @param type 类型
     * @throws Exception
     */
    public void insertPresentRecord(Long presentedRelationId,String presentedUser,Long presentedUserId,Integer presentNum,Long presentRelationId,String presentUser
    		,Long presentUserId,BigDecimal price,Byte type)throws Exception;

    /**
     * 生成猪肉券
     * @param beginTime
     * @param couponMoney
     * @param couponName
     * @param endTime
     * @param relationId
     * @param relationType
     * @param sendRemark
     * @param userId
     * @param couponId
     * @throws Exception
     */
    public Long insertPigCoupon(Date beginTime,BigDecimal couponMoney,String couponName,Date endTime,Long relationId,Byte relationType
    		,String sendRemark,Long userId,Long couponId) throws Exception;
    
    /**
     * 生成猪肉券的使用记录
     * @param canUseMoney
     * @param couponCode
     * @param couponId
     * @param couponMoney
     * @param myCouponId
     * @param relationId
     * @param remark
     * @param province
     * @param city
     * @param address
     * @param useMoney
     * @param userId
     * @param type
     * @throws Exception
     */
    public Long insertPigCouponUseRecord(BigDecimal canUseMoney,String couponCode,Long couponId,BigDecimal couponMoney,Long myCouponId,Long relationId,String remark
    		,Long province,Long city,String address,BigDecimal useMoney,Long userId,Byte type) throws Exception;
    
    /**
     * 保存回报方式
     * @param userId
     * @param repayTypeId
     * @param queryProjectId
     * @param divisionType
     * @param divisionTypeDetail
     * @param packageSpec
     * @return
     * @throws Exception
     */
	public Map<String, Object> saveRepayType(Long userId, String repayTypeId,String queryProjectId, String divisionType,String divisionTypeDetail, String packageSpec) throws Exception;
	
	/**
	 * pc端我的猪场数据
	 * @param userId
	 * @param earningsId
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectMyFarmData(Long userId, Long earningsId) throws Exception;
	
	
	/**
	 * 更新处理类型
	 * @param updateEarnings
	 * @throws Exception
	 */
	void updateDealType(MyEarnings updateEarnings) throws Exception;
	
}
