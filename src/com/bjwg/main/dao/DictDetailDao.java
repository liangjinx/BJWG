package com.bjwg.main.dao;

import com.bjwg.main.model.DictDetail;
import com.bjwg.main.model.DictDetailExample;
import java.util.List;

public interface DictDetailDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_dict_detail
     *
     * @mbggenerated
     */
    int countByExample(DictDetailExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_dict_detail
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long dictDetailId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_dict_detail
     *
     * @mbggenerated
     */
    int insert(DictDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_dict_detail
     *
     * @mbggenerated
     */
    int insertSelective(DictDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_dict_detail
     *
     * @mbggenerated
     */
    List<DictDetail> selectByExample(DictDetailExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_dict_detail
     *
     * @mbggenerated
     */
    DictDetail selectByPrimaryKey(Long dictDetailId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_dict_detail
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(DictDetail record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_dict_detail
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(DictDetail record);
}