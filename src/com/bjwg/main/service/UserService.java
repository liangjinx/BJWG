package com.bjwg.main.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.MyCoupon;
import com.bjwg.main.model.MyCouponExample;
import com.bjwg.main.model.MyCouponUse;
import com.bjwg.main.model.Shop;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.UserCenter;
import com.bjwg.main.model.UserExt;
import com.bjwg.main.model.UserPreorder;
import com.bjwg.main.model.UserPreorderExample;
import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.model.WeiXinUserExample;

/**
 * @author chen
 * @version 创建时间：2015-4-15 上午10:56:39
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public interface UserService{

	/**
	 * 注册账号
	 * @param phone
	 * @param password
	 * @param verifyCode
	 * @param remoteAddr
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> insertUser(String phone, String password,String verifyCode, String remoteAddr,WeiXinUser weiXinUser,String inviteCode) throws Exception;
	
	  
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
	void encapUserInfo(User user,String user_nickname, String user_sex, String ip,
			String user_headimgurl, String user_province, String user_city,
			String user_country);

	/**
	 * 保存个人头像
	 * @param user
	 * @throws Exception
	 */
	void saveLogo(User user) throws Exception;
	/**
	 * 意见反馈
	 * 
	 */
//	void insert(Opinion opinion)throws Exception;

	/**
	 * 查询用户
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public User getById(Long id) throws Exception;
	/**
	 * 检测数据是否合法和验证码是否有效
	 * @param request
	 * @return Status
	 */
	public Status checkVerifyCodeValid(String phone,String password,String verifyCode,short codeType) throws Exception;
	
	
	/**
     * 查询个人中心的数据:钱包、猪仔、总收益
     * @param userId
     * @return
     */
	UserCenter selectUserCenterData(Long userId) throws Exception;
	
	/**
	 * 修改个人资料信息 - 昵称/性别
	 * @throws Exception
	 */
	public Status updateUserNickNameOrSex(String nickName,String sex,Long userId) throws Exception;
	/**
	 * 添加 用户  上门地址
	 * @param userAddress
	 * @return
	 */
	Map<String, Object> insert(UserAddress userAddress)throws Exception;
	/**
	 * 根据用户id查询上门地址
	 * @param userId
	 * @return
	 */
	List<UserAddress> getUserId(Long userId)throws Exception;
	/**
	 * 根据上门地址id查询信息
	 * @param addressId
	 * @return
	 */
	UserAddress getAddressId(Long addressId)throws Exception;
	/**
	 * 保存编辑后的上门地址信息
	 * @param userAddress
	 * @return
	 */
	Map<String, Object> update(UserAddress userAddress)throws Exception;
	/***
	 * 删除上门地址
	 * @param addressId
	 * @return
	 */
	Map<String, Object> delete(Integer addressId)throws Exception;
	/***
	 * 根据用户查询默认上门地址
	 * @param userId
	 * @return
	 */
	UserAddress getUserIdIs(Long userId)throws Exception;
	
	/**
	 * 新增用户公用
	 * @param phone
	 * @param password
	 * @param request
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public User insertUser(String phone,String password,HttpServletRequest request,Short type) throws Exception;
	
	/**
	 * 设置密码 
	 * @param request
	 * @param source
	 * @return
	 * @throws Exception
	 */
	Status updateLoginPassword(HttpServletRequest request,String source) throws Exception;
	
	/**
	 * 验证登录密码是否正确
	 * @param request
	 * @return
	 * @throws Exception
	 */
	Status validatePassword(String password,Long userId) throws Exception;
	/**
	 * 修改登录密码
	 * @param request
	 * @return
	 * @throws Exception
	 */
	Status updateLoginPassword(String password,Long userId) throws Exception;
	
	/**
	 * 检测微信收货地址，没有则新增
	 * @param request
	 * @return
	 * @throws Exception
	 */
	UserAddress insertWxAddressAfterCheck(HttpServletRequest request) throws Exception;
	

	/**
	 * 查询微信表
	 * @param user
	 * @throws Exception
	 */
	public WeiXinUser selectByWeixinUserExample(WeiXinUserExample weiXinUserExample) throws Exception;


	/**
	 * 查询我的好友
	 * @param userId
	 * @param time
	 * @param queryStatusList
	 * @return
	 * @throws Exception
	 */
	List<User> queryMyFreinds(Long userId,Date time,List<Byte> queryStatusList) throws Exception;


	/**
	 * 添加我的好友 同意/不同意
	 * @param userId
	 * @param freindId
	 * @param agreeType
	 * @return
	 * @throws Exception
	 */
	Status updateAddMyFreinds(Long userId, String freindId,String agreeType) throws Exception;
	
	
	public Status updateLoginPassword(String oldPwd,String newPwd, Long userId) throws Exception;


	Status updateEmail(String email, Long userId) throws Exception;


	/**
	 * 搜索好友
	 * @param userId
	 * @param keywords
	 * @param page
	 * @return
	 * @throws Exception
	 */
	List<User> searchFreinds(Long userId, String keywords, Pages<User> page) throws Exception;

	/**
	 * 申请添加好友
	 * @param userId
	 * @param freindId
	 * @return
	 * @throws Exception
	 */
	Status insertFreinds(Long userId, String freindId,String sendRemark) throws Exception;


	/**
	 * 保存赠送猪仔数量
	 * @param projectId
	 * @param sendNum
	 * @param freindId
	 * @param sendRemark
	 * @return
	 * @throws Exception
	 */
	Status updateSendPigToFreinds(Long userId ,String nickname,String projectId, String sendNum,String password,String freindId, String sendRemark) throws Exception;
	/**
	 * 保存赠送猪肉券
	 * @param myCouponId
	 * @param sendMoney
	 * @param freindId
	 * @param password
	 * @param sendRemark
	 * @return
	 * @throws Exception
	 */
	Status updateSendPigCouponToFreinds(Long userId ,String nickname,String myCouponId, String sendMoney,String freindId,String password, String sendRemark) throws Exception;


	/**
	 * 查询我的券
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	Pages<MyCoupon> selectMyCoupon(Long userId,Pages<MyCoupon> pages,boolean isPage) throws Exception;

	/**
	 * 查询我的券
	 * @param userId
	 * @param queryCouponId
	 * @return
	 * @throws Exception
	 */
	MyCoupon selectMyCoupon(Long userId, String queryCouponId,String couponCode) throws Exception;


	/**
	 * 我的券消费记录
	 * @param userId
	 * @param queryCouponId
	 * @return
	 * @throws Exception
	 */
	public Pages<MyCouponUse> selectMyCouponUseDetail(Long userId, String queryCouponId,Pages<MyCouponUse> pages,boolean isPage) throws Exception;

	/**
	 * 查询附近商家
	 * @param longtitude
	 * @param latitude
	 * @return
	 * @throws Exception
	 */
	Pages<Shop> selectNearShop(String longtitude, String latitude,Pages<Shop> pages,boolean isPage) throws Exception;
	
	/**
	 * 用户扩展表
	 * @param example
	 * @return
	 * @throws Exception
	 */
	public UserExt selectUserExtByPrimaryKey(Long userId) throws Exception;
	
	/**
     * 联合查询，加载项目名称
     * @param userId
     * @return
     * @throws Exception
     */
    List<UserPreorder> selectLoadNameByUserId(Long userId) throws Exception;


    /**
     * 设置抢标
     * @param userId
     * @param projectId
     * @param num
     * @param settingType
     * @param isCancel
     * @return
     * @throws Exception
     */
	Status updateUserPreorder(Long userId, String projectId,String num,String settingType,boolean isCancel) throws Exception;
	
	/**
	 * 统计我的新的好友数
	 * @param userId
	 * @param time
	 * @return
	 * @throws Exception
	 */
	public int countMyNewFreinds(Long userId,Date time,List<Byte> queryStatusList) throws Exception;
	
	/**
     * 更新默认选择
     * @param record
     * @return
     */
    public int updateDefaultByUserId(UserAddress record) throws Exception;

    /**
     * 查询我的券
     * @param couponExample
     * @return
     * @throws Exception
     */
	List<MyCoupon> selectMyCouponByExample(MyCouponExample couponExample) throws Exception;
	
	/**
	 * 重新设置二维码的访问地址，旧的图片有不bug
	 * @param user
	 * @throws Exception
	 */
	public void updateQRCodeAccessUrl() throws Exception;


	/**
	 * 删除好友
	 * @param userId
	 * @param freindsId
	 * @return
	 * @throws Exception
	 */
	Status deleteAddMyFreinds(Long userId, String freindsId) throws Exception;


	List<User> queryMyFreinds(Long userId, Date time, List<Byte> queryStatusList, Pages<User> pages) throws Exception;

//获取企业信息
	List<User> getEpInfo(Long userId);
	//通过用户名查询用户
	User selectByUsername(String username);
}
