package com.bjwg.main.dao;

import com.bjwg.main.model.Comment;
import com.bjwg.main.model.CommentExample;
import java.util.List;

public interface CommentDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_comment
     *
     * @mbggenerated
     */
    int countByExample(CommentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_comment
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long commentId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_comment
     *
     * @mbggenerated
     */
    int insert(Comment record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_comment
     *
     * @mbggenerated
     */
    int insertSelective(Comment record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_comment
     *
     * @mbggenerated
     */
    List<Comment> selectByExample(CommentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_comment
     *
     * @mbggenerated
     */
    Comment selectByPrimaryKey(Long commentId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_comment
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Comment record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bjwg_comment
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Comment record);
}