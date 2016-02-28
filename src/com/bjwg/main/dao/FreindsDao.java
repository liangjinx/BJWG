package com.bjwg.main.dao;

import com.bjwg.main.model.Freinds;
import com.bjwg.main.model.FreindsExample;
import java.util.List;
import java.util.Map;

public interface FreindsDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_freinds
     *
     * @mbggenerated
     */
    int countByExample(FreindsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_freinds
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long myUserId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_freinds
     *
     * @mbggenerated
     */
    int insert(Freinds record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_freinds
     *
     * @mbggenerated
     */
    int insertSelective(Freinds record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_freinds
     *
     * @mbggenerated
     */
    List<Freinds> selectByExample(FreindsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_freinds
     *
     * @mbggenerated
     */
    Freinds selectByPrimaryKey(Long myUserId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_freinds
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Freinds record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_freinds
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Freinds record);

	void updateStatus(Map<String, Object> paramMap) throws Exception;
	
	int delete(Map<String, Long> map) throws Exception;
}