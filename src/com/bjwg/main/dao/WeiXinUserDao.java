package com.bjwg.main.dao;

import com.bjwg.main.model.WeiXinUser;
import com.bjwg.main.model.WeiXinUserExample;
import java.util.List;

public interface WeiXinUserDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WEIXINUSER
     *
     * @mbggenerated
     */
    int countByExample(WeiXinUserExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WEIXINUSER
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(String unionid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WEIXINUSER
     *
     * @mbggenerated
     */
    int insert(WeiXinUser record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WEIXINUSER
     *
     * @mbggenerated
     */
    int insertSelective(WeiXinUser record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WEIXINUSER
     *
     * @mbggenerated
     */
    List<WeiXinUser> selectByExample(WeiXinUserExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WEIXINUSER
     *
     * @mbggenerated
     */
    WeiXinUser selectByPrimaryKey(String unionid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WEIXINUSER
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(WeiXinUser record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WEIXINUSER
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(WeiXinUser record);
}