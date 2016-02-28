package com.bjwg.main.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjwg.main.constant.MessageConstant;
import com.bjwg.main.constant.OrderConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.dao.activeDao;
import com.bjwg.main.dao.activeOrderDao;
import com.bjwg.main.dao.winningDao;
import com.bjwg.main.model.Active;
import com.bjwg.main.model.ActiveOrder;
import com.bjwg.main.model.ActiveWinning;
import com.bjwg.main.model.Order;
import com.bjwg.main.model.OrderExample;
import com.bjwg.main.model.Pay;
import com.bjwg.main.service.ActiveService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.MyUtils;




@Service
public class ActiveServiceImpl implements ActiveService{

	@Autowired
	activeDao activeDao;
	@Autowired
	activeOrderDao activeOrderDao;
	@Autowired
	winningDao winningDao;
	
	@Override
	public Active selectByPrimaryKey(Long activeId) {

		return activeDao.selectByPrimaryKey(activeId);
	}

	@Override
	public List<Active> selectList() {
		
		return activeDao.selectList();
	}

	@Override
	public  int insertOrder(ActiveOrder activeOrder){
		
		return activeOrderDao.insertOrder(activeOrder);
	}

	@Override
	public ActiveOrder selectByorderId(Long orderId) {
		return activeOrderDao.selectByPrimaryKey(orderId);
	}

	@Override
	public  List<ActiveOrder> selectByCode(String code) {
		return activeOrderDao.selectByCode(code);
	}

	@Override
	public int updateStatus(ActiveOrder activeOrder) {
		
		return activeOrderDao.updateStatus(activeOrder);
	}

	@Override
	public List<ActiveOrder> selectMywinningCode(ActiveOrder activeOrder) {
		
		
		return activeOrderDao.selectMywinningCode(activeOrder);
	}

	@Override
	public List<ActiveOrder> selectWinningCode(ActiveOrder activeOrder) {

		return activeOrderDao.selectWinningCode(activeOrder);
	}

	@Override
	public int deleteAll(Long activeId) {

		
		return activeOrderDao.deleteAll(activeId);
	}

	@Override
	public int insertWinning(ActiveWinning activeWinning) {
	
		return winningDao.insertWinning(activeWinning);
	}

	@Override
	public List<ActiveWinning> selectWinningList(Long activeId) {
		
		
		return winningDao.selectList(activeId);
	}

	@Override
	public int selectCount(Long activeId) {
		int i=winningDao.selectCount(activeId);
		
		if(i>0){
			
		}else{
			i=0;
		}
		
		return i;
	}
	
	
	
	
	
	/**
	 * 支付宝回调
	 */

	@Override
	public Status updateOrderAlipay(String out_trade_no, String trade_no,
			JSONObject jsonObject) throws Exception {


		try {
			
		
			//查询订单信息
			List<ActiveOrder> activeOrders=activeOrderDao.selectByCode(out_trade_no);
			

			
			if(!MyUtils.isListEmpty(activeOrders)){
				//ConsoleUtil.println(new Date() +"   updateOrderAlipay --> order_id:"+activeOrde.getOrderId()+",user_id:"+activeOrde.getUserId()+",order_code:"+activeOrde.getOrderCode()+",order_status:"+activeOrde.getStatus());
				
				for (ActiveOrder activeOrder:activeOrders) {
					
					//修改订单状态
					ActiveOrder updateOrder = new ActiveOrder();
					updateOrder.setOrderId(activeOrder.getOrderId());
					updateOrder.setStatus((byte)2);
			      activeOrderDao.updateStatus(updateOrder);
					
				}
				
					
						return Status.success;
				}
				
				return Status.dataNotExists;
			
			
		} catch (Exception e) {
			e.printStackTrace();
	
			throw e;
		
		}
	
	}

	
	/**
	 * 银联支付
	 * @param out_trade_no 订单编号
	 * @param trade_no 银联流水号
	 * @param jsonObject
	 * @return
	 * @throws Exception
	 */
	@Override
	public Status updateOrderUnionpay(String out_trade_no, String trade_no, JSONObject jsonObject) throws Exception{
		try {
			

			//查询订单信息
			List<ActiveOrder> activeOrders=activeOrderDao.selectByCode(out_trade_no);
			

			
			if(!MyUtils.isListEmpty(activeOrders)){
				//ConsoleUtil.println(new Date() +"   updateOrderAlipay --> order_id:"+activeOrde.getOrderId()+",user_id:"+activeOrde.getUserId()+",order_code:"+activeOrde.getOrderCode()+",order_status:"+activeOrde.getStatus());
				
				for (ActiveOrder activeOrder:activeOrders) {
					
					//修改订单状态
					ActiveOrder updateOrder = new ActiveOrder();
					updateOrder.setOrderId(activeOrder.getOrderId());
					updateOrder.setStatus((byte)2);
			      activeOrderDao.updateStatus(updateOrder);
					
				}
				
					
						return Status.success;
				}
				
				return Status.dataNotExists;
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}
	
	

}
