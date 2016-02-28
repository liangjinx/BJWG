package com.bjwg.main.dao;

import com.bjwg.main.model.PresentFreinds;
import com.bjwg.main.model.PresentFreindsExample;
import java.util.List;

public interface PresentFreindsDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_present_freinds
     *
     * @mbggenerated
     */
    int countByExample(PresentFreindsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_present_freinds
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long presentId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_present_freinds
     *
     * @mbggenerated
     */
    int insert(PresentFreinds record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_present_freinds
     *
     * @mbggenerated
     */
    int insertSelective(PresentFreinds record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_present_freinds
     *
     * @mbggenerated
     */
    List<PresentFreinds> selectByExample(PresentFreindsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_present_freinds
     *
     * @mbggenerated
     */
    PresentFreinds selectByPrimaryKey(Long presentId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_present_freinds
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(PresentFreinds record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_present_freinds
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(PresentFreinds record);
}