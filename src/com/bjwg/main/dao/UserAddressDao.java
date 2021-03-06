package com.bjwg.main.dao;

import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.UserAddressExample;
import java.util.List;

public interface UserAddressDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_user_address
     *
     * @mbggenerated
     */
    int countByExample(UserAddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_user_address
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long addressId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_user_address
     *
     * @mbggenerated
     */
    int insert(UserAddress record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_user_address
     *
     * @mbggenerated
     */
    int insertSelective(UserAddress record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_user_address
     *
     * @mbggenerated
     */
    List<UserAddress> selectByExample(UserAddressExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_user_address
     *
     * @mbggenerated
     */
    UserAddress selectByPrimaryKey(Long addressId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_user_address
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(UserAddress record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_user_address
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(UserAddress record);
    
    /**
     * 更新默认选择
     * @param record
     * @return
     */
    int updateDefaultByUserId(UserAddress record);
}