package com.bjwg.main.dao;

import com.bjwg.main.model.Order;
import com.bjwg.main.model.OrderExample;
import java.util.List;

public interface OrderDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order
     *
     * @mbggenerated
     */
    int countByExample(OrderExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long orderId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order
     *
     * @mbggenerated
     */
    int insert(Order record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order
     *
     * @mbggenerated
     */
    int insertSelective(Order record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order
     *
     * @mbggenerated
     */
    List<Order> selectByExample(OrderExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order
     *
     * @mbggenerated
     */
    Order selectByPrimaryKey(Long orderId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Order record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_order
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Order record);
}