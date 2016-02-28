package com.bjwg.main.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.DictConstant;
import com.bjwg.main.constant.OrderConstant;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.constant.TypeConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.dao.MyCouponDao;
import com.bjwg.main.dao.MyCouponUseDao;
import com.bjwg.main.dao.MyEarningsDao;
import com.bjwg.main.dao.OrderDao;
import com.bjwg.main.dao.PanicbuyProjectDao;
import com.bjwg.main.dao.PresentFreindsDao;
import com.bjwg.main.model.DictDetail;
import com.bjwg.main.model.MyCoupon;
import com.bjwg.main.model.MyCouponUse;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.MyEarningsExample;
import com.bjwg.main.model.Order;
import com.bjwg.main.model.OrderExample;
import com.bjwg.main.model.PanicbuyProject;
import com.bjwg.main.model.PanicbuyProjectExample;
import com.bjwg.main.model.PresentFreinds;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.Wallet;
import com.bjwg.main.model.WalletExample;
import com.bjwg.main.service.DictService;
import com.bjwg.main.service.MyEarningsService;
import com.bjwg.main.service.PanicbuyProjectService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.service.WalletService;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.RandomUtils;
import com.bjwg.main.util.StringUtils;
import com.bjwg.main.util.ValidateUtil;


@Service
public class MyEarningsServiceImpl implements MyEarningsService {

	@Resource
	private MyEarningsDao myEarningsDao;
	@Resource
	private SysConfigService sysConfigService;
	@Resource
	private PanicbuyProjectService panicbuyProjectService;
	@Resource
	private DictService dictService;
	@Resource
	private WalletService walletService;
	@Resource
	private PresentFreindsDao presentFreindsDao;
	@Resource
	private MyCouponDao myCouponDao;
	@Resource
	private MyCouponUseDao myCouponUseDao;
	@Resource
	private OrderDao orderDao;
	@Resource
	private UserService userService;
	@Autowired
	private PanicbuyProjectDao panicbuyProjectDao;
	
	@Override
	public Map<String, Object> selectMyFarmData(Long userId, Long earningsId) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//默认查询参与的最近一期
		if(earningsId==null || earningsId<=0){
			List<MyEarnings> myEarnings = myEarningsDao.selectAllJoin(userId);
			if(!MyUtils.isListEmpty(myEarnings)){
				earningsId = myEarnings.get(0).getEarningsId();
			} else {
				return null;
			}
		}
		
		MyEarningsExample example = new MyEarningsExample();
		MyEarningsExample.Criteria criteria = example.createCriteria();
		criteria.andUserIdEqualTo(userId);
		criteria.andEarningsIdEqualTo(earningsId);
		List<MyEarnings> myEarnings = myEarningsDao.selectByExample(example);
		
		if(MyUtils.isListEmpty(myEarnings)){
			return null;
		}
		
		MyEarnings myEarning = myEarnings.get(0);
		
		//id
		resultMap.put("projectId", myEarning.getPaincbuyProjectId());
		//项目名称
		resultMap.put("projectName", myEarning.getPaincbuyProjectName());
		//猪数量
		resultMap.put("num", myEarning.getNum());
		//已赠送数量
		resultMap.put("presentNum", myEarning.getPresentNum());
		//到期处理方式
		resultMap.put("way", myEarning.getDealType());
		//阶段
		resultMap.put("phase", "哺乳期");
		
		//计算本期收益
		long intervalDays = MyUtils.calcDays(myEarning.getBeginTime(),new Date());
		BigDecimal profit = myEarning.getMoney().multiply(BigDecimal.valueOf(myEarning.getNum()-myEarning.getPresentNum())).multiply(myEarning.getRate().divide(BigDecimal.valueOf(100)))
		.multiply(BigDecimal.valueOf(intervalDays))
		.divide(BigDecimal.valueOf(360),2,BigDecimal.ROUND_HALF_UP);
		
		//本期收益
		resultMap.put("profit", profit);
		//参与的所有项目总猪数
		resultMap.put("allCount", myEarningsDao.selectAllCount(userId));
		//我参与的所有项目
		resultMap.put("allMyMyEarnings", myEarningsDao.selectAllJoin(userId));
		
		return resultMap;
	}
	
	/**
     * 查询进入农场数据
     * @param queryMap
     * @return
     * @throws Exception
     */
	@Override
	public Map<String, Object> selectMyHomeData(Long userId)throws Exception {
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(null != userId && 0 < userId){
			
			queryMap.put("userId", userId);
			queryMap.put("currentTime", MyUtils.getYYYYMMDD(0));
			/*queryMap.put("queryStatusList", new ArrayList<Byte>(Arrays.asList(
					OrderConstant.ORDER_STATUS_2,
					OrderConstant.ORDER_STATUS_3)
					));
			queryMap.put("queryType", OrderConstant.ORDER_TYPE_1);*/
			
			MyEarnings myEarnings = myEarningsDao.selectMyHomeData(queryMap);
			
			queryMap.clear();
			
			if(null != myEarnings){
				
				//总数
				queryMap.put("totalNum", myEarnings.getTotalNum() == null ? 0 :myEarnings.getTotalNum());
				
				//计算最近期的成长状态 = 间隔天数 / 总天数
				Date beginTime = myEarnings.getBeginTime();
				
				long intervalDays = MyUtils.calcDays(beginTime,new Date());
				
				BigDecimal growStatus = BigDecimal.ZERO;
				BigDecimal profit = BigDecimal.ZERO;
				
				growStatus = BigDecimal.valueOf(intervalDays).multiply(BigDecimal.valueOf(100)).divide(new BigDecimal(myEarnings.getDays()),2,BigDecimal.ROUND_HALF_UP);
					
				//成长状态
				queryMap.put("growStatus", growStatus);
				
				//计算最近一期的收益 = 成本 * 年化率 * 间隔天数 / 360 
				if(null != myEarnings.getMoney()){
					
					profit = myEarnings.getMoney().multiply(BigDecimal.valueOf(myEarnings.getNum()- myEarnings.getPresentNum())).multiply(myEarnings.getRate().divide(BigDecimal.valueOf(100)))
							.multiply(BigDecimal.valueOf(intervalDays))
							.divide(BigDecimal.valueOf(360),2,BigDecimal.ROUND_HALF_UP);
				}
				
				
				//最近一期的收益
				queryMap.put("profit", profit);
				queryMap.put("projectId", myEarnings.getPaincbuyProjectId());
			}else{
				
				//总数
				queryMap.put("totalNum", 0);
				//最近一期的收益
				queryMap.put("profit", 0);
				//成长状态
				queryMap.put("growStatus", 0);
			}
			
		}else{
			//总数
			queryMap.put("totalNum", 0);
			//最近一期的收益
			queryMap.put("profit", 0);
			//成长状态
			queryMap.put("growStatus", 0);
		}
		
		return queryMap;
	}
	
	/**
	 * 查询抢购的每期的猪头数
	 * 不包括已完成的
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPerPigNum(Long userId) throws Exception{
		
		
		if(null == userId || userId <= 0){
			
			return null;
		}
		
		return this.obtainPigGrowUpInfo(userId, null, false);
		
	}
	
	
	/**
	 * 查看我参与的所有期
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<MyEarnings> selectAllJoin(Long userId) throws Exception{
		
		return myEarningsDao.selectAllJoin(userId);
	}
	
	
	
	/**
	 * 查看指定期的成长记录
	 * @param userId
	 * @param queryProjectId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPerPigGrow(Long userId, String queryProjectId) throws Exception{
		
		if(null == userId || userId <= 0 || null == queryProjectId){
			
			return null;
		}
		
		//1.查询指定期的成长状态
		return this.obtainPigGrowUpInfo(userId, Long.valueOf(queryProjectId), true);
	}
	
	
	/**
	 * 获取成长阶段数据。没有指定期数则返回所有
	 * 数据包括 ：猪只总数、成长天数、成长阶段、成长记录
	 * @param userId
	 * @param relationId
	 * @param getGroupRecord 是否获取成长记录
	 * @return
	 * @throws Exception
	 */
	private Map<String, Object> obtainPigGrowUpInfo(Long userId,Long relationId,boolean getGroupRecord) throws Exception{
		
		MyEarningsExample example = new MyEarningsExample();
		MyEarningsExample.Criteria criteria = example.createCriteria();
		
		criteria.andUserIdEqualTo(userId);
		criteria.andEndTimeGreaterThanOrEqualTo(new Date());
		
		if(null != relationId && relationId > 0){
			
			criteria.andPaincbuyProjectIdEqualTo(relationId);
		}
		example.setOrderByClause(" mer.begin_time desc ");
		
		List<MyEarnings> list = myEarningsDao.selectByExample(example);
		
		List<SysConfig> configList = sysConfigService.queryList(SysConstant.GROW_UP_LEVEL);
		
		//提前n天确认回报方式天数
		String d = sysConfigService.queryOneValue(SysConstant.CONFIRM_REWARDS_BEFORE_N_DAYS);
		
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		if(!MyUtils.isListEmpty(list)){
			
			Integer totalNum = 0;
			
			List<DictDetail> ddList = null;
			
			if(getGroupRecord){
				
				String sort = " CONVERT(dctd.value,DECIMAL) desc , dctd.dict_detail_id desc";
				//查询字典，截取相应的成长记录
				ddList = dictService.queryListByParentCode(DictConstant.DICT_GROUP_RECORD,sort);
			}
			
			//归类，计算每期的数量和成长状态对应的阶段
			for (MyEarnings mer : list) {
				
				//计算养殖天数
				mer.setDays(Integer.valueOf(MyUtils.calcDays(mer.getBeginTime(), new Date())+""));
				
				for (SysConfig scon : configList) {
					
					//区间值表，可获得是在哪个成长阶段（注，配置项的名称要特殊规定一下，必须是“保育期”、“生长期”等）
					if(MyUtils.calcRangeReturnStatus(scon.getValue(), mer.getDays())){
						
						mer.setRemark(scon.getName());
						break;
					}
				}
				
				mer.setEndModifyTime(MyUtils.dateFormat4(MyUtils.addDate3(mer.getEndTime(), Integer.valueOf(d)) , 0));
				
				
				if(getGroupRecord){
					
					//截取成长记录
					queryMap.put("groupRecordList", this.obtainGroupRecordDescription(ddList, mer.getBeginTime(), mer.getDays()));
				}
				
				totalNum += mer.getNum() - mer.getPresentNum();
				
			}
			
			queryMap.put("list", list);
			queryMap.put("totalNum", totalNum);
			
		}
		
		return queryMap;
	}
	
	/**
	 * 获取成长记录描述
	 * @return
	 * @throws Exception
	 */
	private List<DictDetail> obtainGroupRecordDescription(List<DictDetail> ddList,Date beginTime,Integer intervalDays) throws Exception{
		
		if(MyUtils.isListEmpty(ddList)){
			
			return null;
		}
		
		List<DictDetail> list = new ArrayList<DictDetail>();
		
		String dateStr = null;
		
		for (DictDetail dd : ddList) {
			
			if(Integer.valueOf(dd.getValue()) <= intervalDays){
				
				dateStr = MyUtils.addDate3(beginTime, Integer.valueOf(dd.getValue()));
				dd.setExtend(dateStr);
				//包含 成长描述remark,计算成长时间
				list.add(dd);
			}
		}
		
		return list;
	}
	
	
	/**
	 * 查看我参与的指定期的收益
	 * @param userId
	 * @param queryProjectId
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPerMyEarnings(Long userId, String queryProjectId) throws Exception{
		
		if(null == userId || userId <= 0 || null == queryProjectId){
			
			return null;
		}
		//1.当前期的累计收益、年收益率、计算预期收益、当前第几周、前后6周的收益、账户余额、当前期的成本、当前期养殖数量、我的猪肉券额度
		
		//1.配置项：成长天数、年收益率、猪肉券额度
		List<String> sysCodeList = new ArrayList<String>(Arrays.asList(SysConstant.GROW_UP_DAYS,
																		SysConstant.YEAR_RETURN_RATE,
																		SysConstant.STAT_N_WEEK_REWARDS,
																		SysConstant.PIG_COUPON_MONEY));
		List<SysConfig> sysList = sysConfigService.queryList(sysCodeList);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
//		String growUpDays = null;
//		String yearRate = null;
//		String pigCouponMoney = null;
		for (SysConfig scon : sysList) {
			
			/*if(SysConstant.GROW_UP_DAYS.equals(scon.getCode())){
				
				growUpDays = scon.getValue();
			}else if(SysConstant.YEAR_RETURN_RATE.equals(scon.getCode())){
				
				yearRate = scon.getValue();
			}else if(SysConstant.PIG_COUPON_MONEY.equals(scon.getCode())){
				
				pigCouponMoney = scon.getValue();
			}
			*/
			dataMap.put(scon.getCode(), scon.getValue());
		}
		
		//2.当前期的收益数据
		MyEarningsExample example = new MyEarningsExample();
		MyEarningsExample.Criteria criteria = example.createCriteria();
		
		criteria.andUserIdEqualTo(userId);
		criteria.andPaincbuyProjectIdEqualTo(Long.valueOf(queryProjectId));
		
		List<MyEarnings> earningsList = myEarningsDao.selectByExample(example);
		
		//计算当前期的预期收益和累积收益，年收益率已记录的为准
		if(!MyUtils.isListEmpty(earningsList)){
			
			MyEarnings earnings = earningsList.get(0);
			
			Long intevalDays = MyUtils.calcDays(earnings.getBeginTime(), new Date());
			
			dataMap.put("intevalDays", intevalDays);
			
			//一天的收益 ，保留4位小数，4舍5入
			BigDecimal oneDayEarning = earnings.getMoney().multiply(BigDecimal.valueOf(earnings.getNum() - earnings.getPresentNum()))
													.multiply(earnings.getRate())
													.divide(BigDecimal.valueOf(100))
													.divide(BigDecimal.valueOf(360),2,BigDecimal.ROUND_HALF_UP);
			
			dataMap.put("oneDayEarning", oneDayEarning);
			
			//累积收益 = 成本 * 年收益率 * 累积时间 /360天 
			BigDecimal allEarning = oneDayEarning.multiply(BigDecimal.valueOf(intevalDays));
			
			dataMap.put("earningMoney", allEarning);
			//年收益率
			dataMap.put("yearRate", earnings.getRate());
			//预期收益
			dataMap.put("expectEarning", earnings.getExpectEarning());
			//当期数量
			dataMap.put("currentNum", earnings.getNum() - earnings.getPresentNum());
			//成本
			dataMap.put("currentCost", earnings.getMoney().multiply(BigDecimal.valueOf(earnings.getNum()- earnings.getPresentNum())));
			//指定期的近六周的收益
			String n_week = (String)dataMap.get(SysConstant.STAT_N_WEEK_REWARDS);
			
			//共计几周
			Integer totalWeek = (int) (intevalDays / 7);
			
			dataMap.put("totalWeek", totalWeek);
			//剩余天数
			Integer leftDays = (int) (intevalDays % 7);
			
			dataMap.put("leftDays", leftDays);
			
			StringBuffer weeks = new StringBuffer("");
			StringBuffer weeksValue = new StringBuffer("");
			
			//有多余的天数则加1
			totalWeek = leftDays > 0 ? totalWeek +1 : totalWeek;
			
			//从1开始计算
			int begin = totalWeek.intValue() > (Integer.valueOf(n_week)) ? totalWeek - (Integer.valueOf(n_week) - 1) : 1; 
			
			//结构为：'1周','2周'
			for (int i = begin; i <= totalWeek; i++) {
				
				weeks.append("'"+i+"周',");
				
				if(i == totalWeek && leftDays > 0){
					
					weeksValue.append(oneDayEarning.multiply(BigDecimal.valueOf(((i - 1) * 7 + leftDays)))+",");
				}else{
					
					weeksValue.append(oneDayEarning.multiply(BigDecimal.valueOf(i * 7))+",");
				}
			}
			
			dataMap.put("weeks", StringUtils.isNotEmpty(weeks.toString()) ? weeks.subSequence(0, weeks.length() - 1) : "''");
			
			dataMap.put("weeksValue", StringUtils.isNotEmpty(weeksValue.toString()) ? weeksValue.subSequence(0, weeksValue.length() - 1) : "''");
		}
		
		WalletExample walletExample = new WalletExample();
		WalletExample.Criteria waCriteria = walletExample.createCriteria();
		waCriteria.andUserIdEqualTo(userId);
		//账户余额
		List<Wallet> walletList = walletService.selectByExample(walletExample);
		
		if(!MyUtils.isListEmpty(walletList)){
			
			BigDecimal walletMoney = walletList.get(0).getMoney();
			
			dataMap.put("walletMoney", walletMoney != null ? walletMoney : BigDecimal.ZERO);
		}
		
		return dataMap;
	}
	
	/**
	 * 查询我的收益
	 * @param MyEarningsExample
	 * @return
	 * @throws Exception
	 */
	public List<MyEarnings> selectByExample(MyEarningsExample example)throws Exception{
		
		return myEarningsDao.selectByExample(example);				
	}
	/**
	 * 新增
	 * @return
	 * @throws Exception
	 */
	public void insert(MyEarnings myEarnings)throws Exception{
		
		try {
			
			myEarningsDao.insert(myEarnings);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 修改
	 * @return
	 * @throws Exception
	 */
	public int updateByPrimaryKeySelective(MyEarnings myEarnings)throws Exception{
		
		try {
			
			return myEarningsDao.updateByPrimaryKeySelective(myEarnings);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
	/**
     * 查询每期的已抢购总数、个人抢购总数、个人花费的成本、每期总数、每期的id和名称
     * @return
     * @throws Exception
     */
    public Pages<MyEarnings> selectMyFinancing(Long userId,String projectId,Pages<MyEarnings> pages,boolean isPage) throws Exception{
    	
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	paramMap.put("userId", userId);
    	
    	//分页查询
    	if(isPage){
    		
    		MyEarningsExample example = new MyEarningsExample();
    		MyEarningsExample.Criteria criteria = example.createCriteria();
    		criteria.andUserIdEqualTo(userId);
    		
    		int count = myEarningsDao.countByExample(example);
    		
    		pages.setCountRows(count);
    		
    		paramMap.put("page", pages);
    		
    	} 
    	
    	if(StringUtils.isNotEmpty(projectId)){
    		
    		paramMap.put("projectId", Long.valueOf(projectId));
    	}
    	
    	List<MyEarnings> list = myEarningsDao.selectMyFinancing(paramMap);
    	
    	if(null == pages){
    		
    		pages = new Pages<MyEarnings>();
    	}
    	
    	//投资详情加载 订单号 
    	if(!MyUtils.isListEmpty(list) && StringUtils.isNotEmpty(projectId)){
    		
    		OrderExample orderExample = new OrderExample();
    		
    		OrderExample.Criteria criteria = orderExample.createCriteria();
    		
    		criteria.andUserIdEqualTo(userId);
    		
    		criteria.andRelationIdEqualTo(Long.valueOf(projectId));
    		
    		criteria.andTypeEqualTo(OrderConstant.ORDER_TYPE_1);
    		
    		criteria.andStatusGreaterThanOrEqualTo(OrderConstant.ORDER_STATUS_3);
    		
    		List<Order> orderList = orderDao.selectByExample(orderExample);
    		
    		list.get(0).setOrderList(orderList);
    	}
    	
    	pages.setRoot(list);
    	
    	return pages;
    }
    
    /**
     * 计算收益
     * @param num 总数
     * @param rate 年收益率
     * @param money 单只成本
     * @param days 累计天数
     * @return
     * @throws Exception
     */
    public BigDecimal calcEarnings(Integer num,BigDecimal rate,BigDecimal money,Integer days) throws Exception{
    	
    	return  money.multiply(BigDecimal.valueOf(num)).multiply(rate.divide(BigDecimal.valueOf(100)))
    				.multiply(BigDecimal.valueOf(days)).divide(BigDecimal.valueOf(360),2,BigDecimal.ROUND_HALF_UP);
    }
    
    
    
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
    		,Long presentUserId,BigDecimal price,Byte type) throws Exception{
    	
    	try {
			
    		//赠送记录
    		PresentFreinds presentFreinds = new PresentFreinds();
    		presentFreinds.setCtime(new Date());
    		presentFreinds.setPresentedRelationId(presentedRelationId);
    		presentFreinds.setPresentedUser(presentedUser);
    		presentFreinds.setPresentedUserId(presentedUserId);
    		presentFreinds.setPresentNum(presentNum);
    		presentFreinds.setPresentRelationId(presentRelationId);
    		presentFreinds.setPresentUser(presentUser);
    		presentFreinds.setPresentUserId(presentUserId);
    		presentFreinds.setPrice(price);
    		presentFreinds.setTotalMoney(presentFreinds.getPrice().multiply(BigDecimal.valueOf(presentFreinds.getPresentNum())));
    		presentFreinds.setType(type);
    		
    		presentFreindsDao.insert(presentFreinds);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
    }
    /**
     * 生成猪肉券
     */
    public Long insertPigCoupon(Date beginTime,BigDecimal couponMoney,String couponName,Date endTime,Long relationId,Byte relationType
    		,String sendRemark,Long userId,Long couponId) throws Exception{
    	
    	try {
    		
    		MyCoupon coupon = new MyCoupon();
			coupon.setBeginTime(beginTime);
			coupon.setCanUseMoney(couponMoney);
			coupon.setCouponCode(RandomUtils.getCouponCode());
			//二维码(链接到猪肉券的使用说明)
			String projectUrl = sysConfigService.queryOneValue(SysConstant.PROJECT_ACCESS_URL);
			coupon.setCouponImg(projectUrl + "/wpnv/urmyCouponDetail?queryCouponCode="+coupon.getCouponCode());
			coupon.setCouponMoney(couponMoney);
			coupon.setCouponName(couponName);
			coupon.setCtime(new Date());
			coupon.setEndTime(endTime);
			coupon.setRelationId(relationId);
			coupon.setRelationType(relationType);
			coupon.setRemark(sendRemark);
			coupon.setStatus(CommConstant.COUPON_STATUS_0);
			coupon.setUserId(userId);
			coupon.setCouponId(couponId);
			myCouponDao.insert(coupon);
			
			return coupon.getMyCouponId();
    	} catch (Exception e) {
    		e.printStackTrace();
    		throw e;
    	}
    }
    /**
     * 生成猪肉券的使用记录
     */
    public Long insertPigCouponUseRecord(BigDecimal canUseMoney,String couponCode,Long couponId,BigDecimal couponMoney,Long myCouponId,Long relationId,String remark
    		,Long province,Long city,String address,BigDecimal useMoney,Long userId,Byte type) throws Exception{
    	
    	try {
    		
    		MyCouponUse myCouponUse = new MyCouponUse();
			myCouponUse.setCanUseMoney(canUseMoney);
			myCouponUse.setCouponCode(couponCode);
			myCouponUse.setCouponId(couponId);
			myCouponUse.setCouponMoney(couponMoney);
			myCouponUse.setMyCouponId(myCouponId);
			myCouponUse.setRelationId(relationId);
			myCouponUse.setRemark(remark);
			myCouponUse.setUseProvince(province);
			myCouponUse.setUseCity(city);
			myCouponUse.setUseAddress(null);
			myCouponUse.setUseMoney(useMoney);
			myCouponUse.setUserId(userId);
			myCouponUse.setUseTime(new Date());
			myCouponUse.setUseType(type);
    		
    		myCouponUseDao.insert(myCouponUse);
    		
    		return myCouponUse.getMyCouponUseId();
    	} catch (Exception e) {
    		e.printStackTrace();
    		throw e;
    	}
    }
    
    
	
    
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
	public Map<String, Object> saveRepayType(Long userId, String repayTypeIdStr,String queryProjectId, String divisionType,String divisionTypeDetail, String packageSpec) throws Exception{
		
		try {
			Status status = Status.success;
			
			Map<String, Object> map = new HashMap<String, Object>();
			if(!ValidateUtil.validateInteger(repayTypeIdStr, false, 1, 4)){
				
				map.put("status", Status.rewardsTypeNullity);
				return map;
			}
			if(!ValidateUtil.validateInteger(queryProjectId, false, 0, null)){
				
				map.put("status", Status.projectidNullity);
				return map;
			}
			Byte repayTypeId = Byte.valueOf(repayTypeIdStr);
			
			//屠宰配送
			if(repayTypeId == OrderConstant.REWARDS_2){
				
				if(!ValidateUtil.validateString(divisionType, false, 1, null)){
					
					map.put("status", Status.divisionTypeNullity);
					return map;
				}
				if(!ValidateUtil.validateInteger(divisionTypeDetail, true, 1, null)){
					
					map.put("status", Status.divisionTypeDetailNullity);
					return map;
				}
				if(!ValidateUtil.validateInteger(packageSpec, true, 1, null)){
					
					map.put("status", Status.packageSpecNullity);
					return map;
				}
				
			}
			
			Long projectId = Long.valueOf(queryProjectId);
			
			//查询是否参与了该期
			MyEarningsExample example = new MyEarningsExample();
			MyEarningsExample.Criteria criteria = example.createCriteria();
			
			criteria.andUserIdEqualTo(userId);
			criteria.andPaincbuyProjectIdEqualTo(projectId);
			List<MyEarnings> myEarningList = myEarningsDao.selectByExample(example);
			
			if(MyUtils.isListEmpty(myEarningList)){
				
				map.put("status", Status.myJoinedProjectNotExist);
				return map;
			}
			
			MyEarnings myEarnings = myEarningList.get(0);
			
			String nDays = sysConfigService.queryOneValue(SysConstant.CONFIRM_REWARDS_BEFORE_N_DAYS);
			
			Date date = new Date();
			
			Date endDate = myEarnings.getEndTime();
			if(StringUtils.isNotEmpty(nDays)){
				
				endDate = MyUtils.dateFormat(MyUtils.addDate3(myEarnings.getEndTime(), -(Integer.valueOf(nDays))) + " 00:00:00",0);
			}
			//已超过最终的确认时间
			if(date.after(endDate)){
				
				map.put("status", Status.cannotModifyRepayType);
				return map;
			}
			//已确认处理了，不能修改
			if(myEarnings.getDealStatus() == CommConstant.DEAL_STATUS_1){
				
				map.put("status", Status.repayAlreadyDealed);
				return map;
			}
			
			//是否存在屠宰配送生成的未取消的订单？
			OrderExample orderExample = new OrderExample();
			OrderExample.Criteria criteria2 = orderExample.createCriteria();
			
			criteria2.andRelationIdEqualTo(projectId);
			criteria2.andUserIdEqualTo(userId);
//			criteria2.andTypeEqualTo(OrderConstant.REWARDS_2);
//			criteria2.andStatusNotEqualTo(OrderConstant.ORDER_STATUS_0);
			
			List<Order> orderList = orderDao.selectByExample(orderExample);
			
			//可以没有订单，因为可以赠送猪仔，不会生成订单的
//			if(MyUtils.isListEmpty(orderList)){
//				
//				map.put("status", Status.myJoinedProjectNotExist);
//				return map;
//			}
			for (Order order : orderList) {
				if((order.getType() == OrderConstant.REWARDS_2 || order.getType() == OrderConstant.REWARDS_3)&& order.getStatus() != OrderConstant.ORDER_STATUS_0){
					map.put("status", Status.cannotModifyRepayTypeBeforeCancelOrder);
					return map;
				}
			}
			
			
			
			//屠宰配送
			if(repayTypeId == OrderConstant.REWARDS_2){
				
				map = this.calcSlaughterFee(myEarnings.getNum() - myEarnings.getPresentNum(), divisionType, packageSpec);
				
				status = (Status)map.get("status");
				
				if(Status.success != status){
					
					return map;
				}
				
				//查询默认的收货地址
				UserAddress address = userService.getUserIdIs(userId);
				
				map.put("userAddress", address);
				
				map.put("myEarnings", myEarnings);
				
				map.put("order", MyUtils.isListEmpty(orderList) ? null : orderList.get(0));
				
				map.put("nDays", nDays);
				
			//领活猪,生成订单
			}else if(repayTypeId == OrderConstant.REWARDS_3){
				
				status = Status.success;
				
				//查询默认的收货地址
				UserAddress address = userService.getUserIdIs(userId);
				
				map.put("myEarnings", myEarnings);
				
				map.put("userAddress", address);
				
				map.put("order", orderList.get(0));
				
				map.put("nDays", nDays);
				
			}else{
				
				//更新
				MyEarnings updateEarnings = new MyEarnings();
				updateEarnings.setEarningsId(myEarnings.getEarningsId());
				updateEarnings.setDealType(repayTypeId);
				updateEarnings.setDealTime(date);
				updateEarnings.setBeforeDealType(myEarnings.getBeforeDealType());
				
				myEarningsDao.updateByPrimaryKeySelective(updateEarnings);
			}
			
			PanicbuyProjectExample projectExample = new PanicbuyProjectExample();
			PanicbuyProjectExample.Criteria criteria3 = projectExample.createCriteria();
			criteria3.andPaincbuyProjectIdEqualTo(projectId);
			List<PanicbuyProject> projectList = panicbuyProjectDao.selectByExample(projectExample);
			map.put("proj_this", projectList!=null?projectList.get(0):null);
			
			map.put("status", status);
			return map;
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 计算屠宰的一切费用
	 * @param totalNum
	 * @param divisionType
	 * @param packageSpec
	 * @return
	 */
	public Map<String, Object> calcSlaughterFee(Integer totalNum,String divisionType, String packageSpecStr) throws Exception{
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		//查询配置：粗分割和细分割以及包装
		List<SysConfig> sysList = sysConfigService.queryListForRewardsType();
		
		if(MyUtils.isListEmpty(sysList) || sysList.size() != 6){
			
			dataMap.put("status", Status.configDataNotExist);
			return dataMap;
		}
		//分割费
		BigDecimal divisionFee = null;
		//包装费
		BigDecimal packageFee = null;
		//单只重量
		BigDecimal perWeight = null;
		//配送费
		BigDecimal sendFee = null;
		//规格
		BigDecimal packageSpec = null;
		for (SysConfig sc : sysList) {
			
			if(SysConstant.DIVISION_THICK_FEE.equals(sc.getCode()) && sc.getCode().equals(divisionType)){
				
				divisionFee = new BigDecimal(sc.getValue());
				
				dataMap.put("divisionTypeByte", 1);
			}else if(SysConstant.DIVISION_THIN_FEE.equals(sc.getCode()) && sc.getCode().equals(divisionType)){
				
				divisionFee = new BigDecimal(sc.getValue());
				
				dataMap.put("divisionTypeByte", 2);
			}else if(SysConstant.PER_WEIGHT.equals(sc.getCode())){
				
				perWeight = new BigDecimal(sc.getValue());
			}else if(SysConstant.SLAUGHTER_EXPRESS_FEE.equals(sc.getCode())){
				
				sendFee = new BigDecimal(sc.getValue());
			}else if(SysConstant.PACKAGE_SPECS.equals(sc.getCode())){
				
				String[] specs = sc.getValue().split(",");
				
				for (int i = 0; i < specs.length; i++) {
					
					if(packageSpecStr.equals(specs[i])){
						
						packageSpec = new BigDecimal(specs[i]);
						break;
					}
				}
				
			}else{
				
				packageFee = new BigDecimal(sc.getValue());
			}
		}
		
		//粗分割是没有包装费的，这里将重量重置为0，算出的运费是0
		if(SysConstant.DIVISION_THICK_FEE.equals(divisionType)){
			
			perWeight = BigDecimal.ZERO;
		}
		//单只分割费
		BigDecimal singleDivisionMoney = divisionFee;
		
		//单只包装数
		int packageNum = 0;
		
		if(null != packageSpec && packageSpec.intValue() > 0){
			
			packageNum = perWeight.multiply(BigDecimal.valueOf(500)).divide(packageSpec,2,BigDecimal.ROUND_HALF_UP).intValue();
			
			if(perWeight.intValue() % packageSpec.intValue() > 0){
				
				packageNum ++;
			}
			
		}
		
		//单只真空包装费 = 单只重量(斤 = 500g) / 包装规格（克）* 包装费 
		BigDecimal singlePackageMoney = BigDecimal.valueOf(packageNum).multiply(packageFee);
		
		//单只配送费 
		BigDecimal singleSendMoney = sendFee;
		
		//单只总费用 
		BigDecimal singleTotalMoney = singleDivisionMoney.add(singleSendMoney).add(singlePackageMoney);
		
		BigDecimal totalMoney = (singleDivisionMoney.add(singleSendMoney).add(singlePackageMoney)).multiply(BigDecimal.valueOf(totalNum));
		
		dataMap.put("singleDivisionMoney", singleDivisionMoney);
		dataMap.put("singlePackageMoney", singlePackageMoney);
		dataMap.put("singleSendMoney", singleSendMoney);
		dataMap.put("singleTotalMoney", singleTotalMoney);
		//总分割费
		dataMap.put("divisionMoney", singleDivisionMoney.multiply(BigDecimal.valueOf(totalNum)));
		//总包装费 
		dataMap.put("packageMoney", singlePackageMoney.multiply(BigDecimal.valueOf(totalNum)));
		//总配送费 
		dataMap.put("sendMoney", singleSendMoney.multiply(BigDecimal.valueOf(totalNum)));
		//总费
		dataMap.put("totalMoney", totalMoney);
		//单只重量
		dataMap.put("perWeight", perWeight);
		//重量
		dataMap.put("weight", perWeight.multiply(BigDecimal.valueOf(totalNum)));
		//单只包装数
		dataMap.put("packageNum", packageNum);
		//规格
		dataMap.put("packageSpec", packageSpec);
		dataMap.put("status", Status.success);
		return dataMap;
	}
	
	
	/**
	 * 更新处理类型
	 * @param updateEarnings
	 * @throws Exception
	 */
	public void updateDealType(MyEarnings updateEarnings) throws Exception{
		
		try {
			
			myEarningsDao.updateDealType(updateEarnings);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		}
		
	}
    
}
