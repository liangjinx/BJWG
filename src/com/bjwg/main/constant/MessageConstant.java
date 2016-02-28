package com.bjwg.main.constant;
/**
 * 消息常量类
 * @author Allen
 * @version 创建时间：2015-4-3 下午05:19:56
 * @Modified By:Allen
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class MessageConstant
{
    
    /**
     * 操作成功
     */
    public static final String SUCCESS = "操作成功";
    /**
     * 用户名或密码不正确
     */
    public static final String MANAGER_USERNAME_OR_PSW_IS_WRONG = "用户名或密码不正确";
    
    /**
     * 用户被禁止
     */
    public static final String MANAGER_IS_FORBID = "用户被禁止";
    
    
    /**
     * 消息类型 - 1 - 系统消息
     */
    public static final byte SYS_MESSAGE_1 = 1;
    /**
     * 消息类型 - 2 - 推送消息
     */
    public static final byte SYS_MESSAGE_2 = 2;
    /**
     * 消息关联的类型 - 1 - 订单
     */
    public static final byte MSG_RELATION_ID_ORDER = 1;
    /**
     * 消息关联的类型 - 2 - 我的收益
     */
    public static final byte MSG_RELATION_ID_EARNINGS = 2;
    /**
     * 消息关联的类型 - 3 - 我的券
     */
    public static final byte MSG_RELATION_ID_COUPON = 3;
    /**
     * 消息状态 - 0 - 未读
     */
    public static final byte MSG_UNREAD = 0;
    /**
     * 消息状态- 1 - 已读
     */
    public static final byte MSG_READ = 1;

}
