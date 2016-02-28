package com.bjwg.main.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.dao.MyEarningsDao;
import com.bjwg.main.dao.PanicbuyProjectDao;
import com.bjwg.main.dao.PayDao;
import com.bjwg.main.dao.ServiceProtocolDao;
import com.bjwg.main.dao.UserDao;
import com.bjwg.main.model.Comment;
import com.bjwg.main.model.CommentExample;
import com.bjwg.main.model.Info;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.MyEarningsExample;
import com.bjwg.main.model.PanicbuyProject;
import com.bjwg.main.model.PanicbuyProjectExample;
import com.bjwg.main.model.Pay;
import com.bjwg.main.model.PayExample;
import com.bjwg.main.model.User;
import com.bjwg.main.service.MyEarningsService;
import com.bjwg.main.service.PanicbuyProjectService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.util.MyUtils;
import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * 抢购项目service
 * @author Administrator
 *
 */
@Service
public class PanicbuyProjectServiceImpl implements PanicbuyProjectService{
	
	@Resource
	private PanicbuyProjectDao panicbuyProjectDao;
	@Resource
	private ServiceProtocolDao serviceProtocolDao;
	@Resource
	private UserDao userDao;
	@Autowired
	private MyEarningsDao myEarningsDao;
	@Autowired
	private SysConfigService sysConfigService;
	@Autowired
	private PayDao payDao;

	/**
    *
    * @mbggenerated
    */
   public int countByExample(PanicbuyProjectExample example) throws Exception{
	   return panicbuyProjectDao.countByExample(example);
   }

	/**
	 * 查询当前期的项目
	 * @return
	 * @throws Exception
	 */
	public PanicbuyProject selectCurrent(Long projectId) throws Exception{
		
		PanicbuyProjectExample example = new PanicbuyProjectExample();
		PanicbuyProjectExample.Criteria criteria = example.createCriteria();
		//当前进行中的，要进行时分比较，不需要过滤是否售完的情况
		Date currentTime = new Date();
		criteria.andBeginTimeLessThanOrEqualTo(currentTime);
		criteria.andEndTimeGreaterThanOrEqualTo(currentTime);
		
//		criteria.andStatusEqualTo(CommConstant.PROJECT_STATUS_1);
		if(null != projectId && 0 < projectId){
			
			criteria.andPaincbuyProjectIdEqualTo(projectId);
		}
		
		List<PanicbuyProject> list = panicbuyProjectDao.selectByExample(example);
		
		return MyUtils.isListEmpty(list) ? null : list.get(0);
	}
	
	/**
	 * 查询下期项目
	 * @param projectId
	 * @return
	 * @throws Exception
	 */
	@Override
	public PanicbuyProject selectNext(Long projectId) throws Exception{
		
		PanicbuyProjectExample example = new PanicbuyProjectExample();
		PanicbuyProjectExample.Criteria criteria = example.createCriteria();
		
		if(null != projectId && 0 < projectId){
			criteria.andPaincbuyProjectIdEqualTo(projectId);
		}
		
		Date currentTime = new Date();
		//根据当前时间最近的项目
		criteria.andBeginTimeGreaterThan(currentTime);
		example.setOrderByClause("  begin_time asc limit 0,1");
		
		List<PanicbuyProject> list = panicbuyProjectDao.selectByExample(example);
		
		return MyUtils.isListEmpty(list) ? null : list.get(0);
	}
	
	@Override
	public List<User> selectTop20(Long projectId) throws Exception {
		PanicbuyProject proj = panicbuyProjectDao.selectByPrimaryKey(projectId);
		if(proj != null){

			Map<String, Object> queryMap = new HashMap<String, Object>();
			queryMap.put("relationId", proj.getPaincbuyProjectId());
			Pages<User> pages = new Pages<User>();
			pages.setPerRows(20);
			pages.setCurrentPage(1);
			queryMap.put("page", pages);
			return userDao.selectCurrentProjectTop(queryMap);
		}
		return null;
	}
	
	/**
	 * 查询当前进行的项目，没有则查询下一期的
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> selectCurrentOrNext() throws Exception{

		PanicbuyProjectExample example = new PanicbuyProjectExample();
		PanicbuyProjectExample.Criteria criteria = example.createCriteria();
		
		PanicbuyProject project = this.selectCurrent(null);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		String nextProjectDescription = sysConfigService.queryOneRemark(SysConstant.NEXT_PROJECT_DESCRIPTION);
		
		dataMap.put("nextProjectDescription", nextProjectDescription);
		
		//查询下一期的
		if(null == project){
			
			Date currentTime = new Date();
			//根据当前时间最近的项目
			criteria.andBeginTimeGreaterThanOrEqualTo(currentTime);
			example.setOrderByClause("  begin_time asc limit 0,1");
			
			List<PanicbuyProject> list = panicbuyProjectDao.selectByExample(example);
			
			project = MyUtils.isListEmpty(list) ? null : list.get(0);
			
			if(null != project){
				
				//下一期
				dataMap.put("type", "next");
				dataMap.put("project", project);
				
				//下一期的开始时间包括时分
				//倒计时换算成秒数
				dataMap.put("leftTime", project.getBeginTime().getTime());//MyUtils.calcSecs(new Date(), nextBeginTime));
			}else{
				
				//无
				return dataMap;
			}
			
		}else{
			
			//当前期
			dataMap.put("type", "current");
			dataMap.put("project", project);
		}
		
		return dataMap;
	}
	
	/**
     *  进入抢购页面所需的数据
     *  包含抢购项目信息、服务协议、本期排行
     * @param projectId
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectPanicutBuyInit(Long projectId) throws Exception{
		
		if(null == projectId){
			
			return null;
		}
		
		PanicbuyProject panicbuyProject = panicbuyProjectDao.selectByPrimaryKey(projectId);
		
		if(null == panicbuyProject){
			
			return null;
		}
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("project", panicbuyProject);
		
		//查询服务协议
		/*ServiceProtocolExample spExample = new ServiceProtocolExample();
		ServiceProtocolExample.Criteria spCriteria = spExample.createCriteria();
		
		spCriteria.andRelationIdEqualTo(projectId);
		spCriteria.andRelationTypeEqualTo(TypeConstant.SP_TYPE_PANICUTBUY);
		List<ServiceProtocol> spList = serviceProtocolDao.selectByExample(spExample);
		
		if(!MyUtils.isListEmpty(spList)){
			
			dataMap.put("sp", spList.get(0));
		}*/
		
		//本期排行，前10名
		Map<String, Object> queryMap = new HashMap<String, Object>();
		
		queryMap.put("relationId", projectId);
		queryMap.put("top", 6);
		
		List<User> userlist = userDao.selectCurrentProjectTop(queryMap);
		userlist=userlist.size()>5?userlist.subList(0, 5):userlist;
		
		if(!MyUtils.isListEmpty(userlist)){
			
			dataMap.put("topUserList", userlist);
		}
		
		return dataMap;
	}
	
	
	/**
	 * 更新抢购数量
	 * @param projectId
	 * @return
	 * @throws Exception
	 */
	public void updatePanicutBuyLeftNum(Long projectId,Short num) throws Exception{
		
		try {
			
			Map<String, Object> paramsMap = new HashMap<String, Object>();
			
			paramsMap.put("projectId", projectId);
			
			paramsMap.put("num", num);
			
			panicbuyProjectDao.updateLeftNum(paramsMap);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	/**
	 * 查询快出栏的30天中，没有选择回报方式的记录
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<MyEarnings> selectLast30DaysEarnings(Long userId) throws Exception{
		
		if(null == userId || userId <= 0){
			
			return null;
		}
		Date date = new Date();
		
		MyEarningsExample example = new MyEarningsExample();
		MyEarningsExample.Criteria criteria = example.createCriteria();
		
		criteria.andUserIdEqualTo(userId);
		criteria.andDealTypeIsNull();
		
		String days = sysConfigService.queryOneValue(SysConstant.CONFIRM_REWARDS_BEFORE_N_DAYS);
		
		Date date2 = MyUtils.dateFormat4(MyUtils.addDate3(date, 30) , 0);
		criteria.andEndTimeLessThanOrEqualTo(date2);
		
		date2 = MyUtils.dateFormat4(MyUtils.addDate3(date, Integer.valueOf(days)) , 0);
		
		criteria.andEndTimeGreaterThanOrEqualTo(date2);
		
		List<MyEarnings> list = myEarningsDao.selectByExample(example);
		
		if(!MyUtils.isListEmpty(list)){
			
			
			for (MyEarnings myEarnings : list) {
				
				myEarnings.setOverTime(MyUtils.dateFormat4(MyUtils.addDate3(myEarnings.getEndTime(), -(Integer.valueOf(days))) , 0));
				
				myEarnings.setFmtTime(MyUtils.dateFormat4(myEarnings.getOverTime(), 0));
			}
			
		}
		return list;
	}
	
	
	public List<PanicbuyProject> selectByExample(PanicbuyProjectExample example){
		
		return panicbuyProjectDao.selectByExample(example);
	}

    public PanicbuyProject selectByPrimaryKey(Long paincbuyProjectId){
    	
    	return panicbuyProjectDao.selectByPrimaryKey(paincbuyProjectId);
    }
    
    @Override
    public void queryPagePayRecord(Long projectId, Pages<Pay> pages) throws Exception{
		try {
			
			PayExample example = new PayExample();
			PayExample.Criteria criteria = example.createCriteria();
			
			criteria.andGmtPayTimeIsNotNull();
			criteria.andProjectIdEqualTo(projectId);
			
			example.setOrderByClause("pay.total_money desc");
			
			int count = payDao.countByExampleForRd(example);
			pages.setCountRows(count);
			example.setPage(pages);
			
			List<Pay> list = payDao.selectPayRecord(example);
			
			pages.setRoot(list);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
    }
    
}
























