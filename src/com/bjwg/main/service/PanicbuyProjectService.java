package com.bjwg.main.service;

import java.util.List;
import java.util.Map;

import com.bjwg.main.base.Pages;
import com.bjwg.main.model.Message;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.PanicbuyProject;
import com.bjwg.main.model.PanicbuyProjectExample;
import com.bjwg.main.model.Pay;
import com.bjwg.main.model.User;

/**
 * 抢购项目service
 * @author Administrator
 *
 */
public interface PanicbuyProjectService {

	/**
    *
    * @mbggenerated
    */
   public int countByExample(PanicbuyProjectExample example) throws Exception;
	/**
	 * 查询当前期的项目
	 * @return
	 * @throws Exception
	 */
	public PanicbuyProject selectCurrent(Long projectId) throws Exception;
	/**
	 * 查询当前进行的项目，没有则查询下一期的
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCurrentOrNext() throws Exception;
	
	List<PanicbuyProject> selectByExample(PanicbuyProjectExample example);

    PanicbuyProject selectByPrimaryKey(Long paincbuyProjectId);

    /**
     *  进入抢购页面所需的数据
     *  包含抢购项目信息、服务协议、本期排行
     * @param projectId
     * @return
     * @throws Exception
     */
	public Map<String, Object> selectPanicutBuyInit(Long projectId) throws Exception;
	/**
	 * 更新抢购数量
	 * @param projectId
	 * @return
	 * @throws Exception
	 */
	public void updatePanicutBuyLeftNum(Long projectId,Short num) throws Exception;
	
	/**
	 * 查询下期项目
	 * @param projectId
	 * @return
	 * @throws Exception
	 */
	PanicbuyProject selectNext(Long projectId) throws Exception;
	
	/**
	 * 查询快出栏的30天中，没有选择回报方式的记录
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public List<MyEarnings> selectLast30DaysEarnings(Long userId) throws Exception;
	
	/**
	 * 分页查询交易记录
	 * @param projectId
	 * @param pages
	 * @throws Exception
	 */
	void queryPagePayRecord(Long projectId, Pages<Pay> pages) throws Exception;
	
	/**
	 * 查询交易量前20
	 * @param projectId
	 * @return
	 * @throws Exception
	 */
	List<User> selectTop20(Long projectId) throws Exception;
}
