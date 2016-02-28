package com.bjwg.main.service;

import java.util.List;

import net.sf.json.JSONObject;

import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Active;
import com.bjwg.main.model.ActiveOrder;
import com.bjwg.main.model.ActiveWinning;




public interface ActiveService {
	/**
	 * 
	 * @param activeId
	 * @return
	 */
	Active selectByPrimaryKey(Long activeId);
	
	
	/**
	 * 查询中奖的list
	 */
	
	List<ActiveWinning> selectWinningList(Long activeId);
	
	
	/**
	 * 
	 * @return
	 */
	  List<Active> selectList();
	  /**
	   * 
	   * @return
	   */
	   int insertOrder(ActiveOrder activeOrder);
	   /**
	    * 
	    */
	   ActiveOrder selectByorderId(Long orderId);
	   
	   /**
	    * 
	    * 
	    */
	   
	   List<ActiveOrder>  selectByCode(String code);
	   /**
	    * 
	    * 
	    * @param activeOrder
	    * @return
	    */
	   int updateStatus(ActiveOrder activeOrder);
	   
	   /**
	    * 产看个人中奖号码
	    */
	   List<ActiveOrder> selectMywinningCode(ActiveOrder activeOrder);
	   /**
	    * 总的开奖号码
	    */
	   List<ActiveOrder> selectWinningCode(ActiveOrder activeOrder);
	   /**
	    * 一期结束删除数据
	    */
	   
	   int deleteAll(Long activeId);
	   /**
	    * 插入中奖纪录
	    */
	   int insertWinning(ActiveWinning activeWinning);
	   
	   /**
	    * 查询中奖期数
	    */
	   int selectCount(Long activeId);
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   /**
	    * 
	    */

      /**
       * 支付宝
       */
	   
		public Status updateOrderAlipay(String out_trade_no, String trade_no, JSONObject jsonObject) throws Exception;


	Status updateOrderUnionpay(String out_trade_no, String trade_no,
			JSONObject jsonObject) throws Exception;


}
