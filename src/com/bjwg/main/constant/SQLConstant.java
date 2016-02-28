package com.bjwg.main.constant;

/**
 * SQL常量类
 * @author Allen
 * @version 创建时间：2015-4-3 下午05:52:01
 * @Modified By:Allen
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class SQLConstant
{
    /**
     * 增
     */
    public static final int INSERT = 1;
    /**
     * 删
     */
    public static final int DELETE = 2;
    /**
     * 改
     */
    public static final int UPDATE = 3;
    /**
     * 查
     */
    public static final int SELECT = 4;
    
    /**
	 * qq用户表
	 */
	public static final String TBL_QQUSER = "HZD_QQUSER";
	/**
	 * 微信用户表
	 */
	public static final String TBL_WEIXINUSER = "HZD_WEIXINUSER";
	/**
	 * 用户表
	 */
	public static final String TBL_USER = "HZD_USER";
	/**
	 * 手机验证码表
	 */
	public static final String TBL_VERIFY_PHONE="HZD_VERIFY_PHONE";
	/**
	 * 店铺表
	 */
	public static final String TBL_SHOP="HZD_SHOP";
	/**
	 * 店铺服务表
	 */
	public static final String TBL_SERVICE="HZD_SERVICE";
	/**
	 * 拨号记录表
	 */
	public static final String TBL_CALL="HZD_CALL";
	/**
	 * 轮播图表
	 */
	public static final String TBL_SHOPSLIDE="HZD_SHOPSLIDE";
	/**
	 * 收藏表
	 */
	public static final String TBL_FAVORITE="HZD_FAVORITE";
	/**
	 * 纠错表
	 */
	public static final String TBL_SHOPERROR="HZD_SHOPERROR";
	/**
	 * 评论表
	 */
	public static final String TBL_COMMENT="HZD_COMMENT";
	/**
	 * 地区表
	 */
	public static final String TBL_AREA="HZD_AREA_V2";
	/**
	 * 营业表
	 */
	public static final String TBL_OPENTIME="HZD_OPENTIME";
	/**
	 * 首页推荐表
	 */
	public static final String TBL_INDEX_RECOMMEND="HZD_INDEX_RECOMMEND";
	/**
	 * 意见反馈表
	 */
	public static final String TBL_OPINION="HZD_OPINION";
	
    
    /**
     * 商户序列
     */
    public static final String HZD_SHOP_SEQ = "HZD_SHOP_SEQ.nextval";
    /**
     * 服务序列
     */
    public static final String HZD_SERVICE_SEQ = "HZD_SERVICE_SEQ.nextval";
    
    
}
