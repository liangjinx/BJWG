package com.bjwg.main.dao;

import com.bjwg.main.model.FileUpload;
import com.bjwg.main.model.FileUploadExample;

import java.util.List;

public interface FileUploadDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_FILE_UPLOAD
     *
     * @mbggenerated
     */
    int countByExample(FileUploadExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_FILE_UPLOAD
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long uploadId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_FILE_UPLOAD
     *
     * @mbggenerated
     */
    int insert(FileUpload record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_FILE_UPLOAD
     *
     * @mbggenerated
     */
    int insertSelective(FileUpload record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_FILE_UPLOAD
     *
     * @mbggenerated
     */
    List<FileUpload> selectByExample(FileUploadExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_FILE_UPLOAD
     *
     * @mbggenerated
     */
    FileUpload selectByPrimaryKey(Long uploadId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_FILE_UPLOAD
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(FileUpload record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_FILE_UPLOAD
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(FileUpload record);
}