package com.bjwg.main.dao;

import com.bjwg.main.model.OrderAddress;
import com.bjwg.main.model.OrderAddressExample;
import java.util.List;

public interface OrderAddressDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order_address
     *
     * @mbggenerated
     */
    int countByExample(OrderAddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order_address
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long orderId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order_address
     *
     * @mbggenerated
     */
    int insert(OrderAddress record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order_address
     *
     * @mbggenerated
     */
    int insertSelective(OrderAddress record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order_address
     *
     * @mbggenerated
     */
    List<OrderAddress> selectByExample(OrderAddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order_address
     *
     * @mbggenerated
     */
    OrderAddress selectByPrimaryKey(Long orderId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order_address
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(OrderAddress record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order_address
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(OrderAddress record);
}