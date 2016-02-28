package com.bjwg.main.dao;

import java.util.List;

import com.bjwg.main.model.Active;
import com.bjwg.main.model.ActiveOrder;



public interface activeOrderDao {
    /**
     * 
     */
	ActiveOrder selectByPrimaryKey(Long orderId);
	  /**
     * 
     */
    List<ActiveOrder> selectList();
    /**
     * 
     */
   int insertOrder(ActiveOrder activeOrder);
   /**
    * 
    */
   List<ActiveOrder>  selectByCode(String code);
    
    /**
     * 
     * 
     * 
     */
    int updateStatus(ActiveOrder activeOrder);
    /**
     * 
     */
   List<ActiveOrder> selectMywinningCode(ActiveOrder activeOrder);
   
   /**
    * 
    * 
    */
   List<ActiveOrder> selectWinningCode(ActiveOrder activeOrder);
   
   /**
    * 
    * 
    */
   
   int deleteAll(Long activeId);
}