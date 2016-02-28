package com.bjwg.main.constant;

/**
 * 常用的常量
 * @author Allen
 * @version 创建时间：2015-4-7 上午09:42:44
 * @Modified By:Allen
 * Version: 1.0
 * jdk : 1.6
 * 类说明：登录成功的常量
 */
public class CommConstant
{
    
    /**
     * 通用成功标识
     */
    public static String SUCCESS = "success";
    /**
     * 用户登录成功标识
     */
    public static String SESSION_MANAGER_LOGIN_FLAG = "session_manager_login";
    /**
     * 用户当前拥有的权限
     */
    public static String SESSION_MANAGER_AUTHORITY_LINK = "session_manager_authority";
    /**
     * session中保存的用户资料信息   对象
     */
    public static String SESSION_MANAGER = "session_manager";
    /**
     * session中保存的微信用户信息   对象
     */
    public static String SESSION_WX_USER = "session_wx_user";
    /**
     * session中保存的当前用户授权的菜单
     */
    public static String SESSION_MANAGER_AUTHORITY_MENU = "session_manager_authority_menu";
    /**
     * session 中保存附近热门店铺
     */
    public static String SESSION_MANAGER_HOT = "session_shop_manager";
    /**
     * 	session 中保存分类信息  对象
     */
    public static String SESSION_CATEGORY = "session_category";
    /**
     * session 中保存首页推荐信息
     */
    public static String SESSION_RECOMMEND = "session_recommend";
    /**
     * 用户地址信息
     */
    public static String SESSION_USRTAREA = "userArea";
    /**
     * 用户最后一次的地址信息
     */
    public static String LAST_SESSION_USRTAREA = "user_last_area";
    /**
     * session中保存的用户资料信息   qq用户对象
     */
    public static String SESSION_QQ_USER = "session_qq_user";
    /**
     * session中保存的app请求登录时的参数值
     */
    public static String SESSION_APP_PARAM = "app_param";
    /**
     * session中app_param保存的跳转地址
     */
    public static String REDIRECT_URL = "redirectUri";
    /**
     * session中app_param保存的来源
     */
    public static String SOURCE = "source";
    /**
     * session中保存的app的token
     */
    public static String SESSION_APP_TOKEN = "token";
    /**
     * session中保存的app的tag
     */
    public static String SESSION_APP_TAG = "tag";
    /**
     * session中保存的user_id
     */
    public static String SESSION_USER_ID = "user_id";
    /**
     * session中保存的shop_id
     */
    public static String SESSION_SHOP_ID = "shop_id";
    /**
     * session中保存的用户是否设置了支付密码标志
     */
    public static String SESSION_USER_SET_PAY_PASSWORD = "is_user_set_pay_pw";
    
    /**
     * session中保存的用户登录类型
     */
    public static String SESSION_LOGIN_TYPE = "login_type";
    
    /**
     * session中保存的access_token
     */
    public static String SESSION_ACCESS_TOKEN = "access_token";
    
    /**
     * session中保存的openId
     */
    public static String SESSION_OPENID = "openId";
    /**
     * cookie中保存的lastBulletinId
     */
    public static String COOKIE_LASTBULLETINID = "lastBulletinId";
    /**
     * session中保存的参与的所有期
     */
    public static String SESSION_ALL_I_JOIN_PROJECT = "all_i_join_project";
    /**
     * session中保存的邀请码
     */
    public static String SESSION_INVITECODE = "invite_code";
    /**
     * 邀请码前缀
     */
    public static String INVITECODE_PREFIX = "rm";
    /**
     * 真 - true - 1
     */
    public static short TRUE = 1;
    /**
     * 假 - false - 0
     */
    public static short FALSE = 0;
    /**
     * 开关，关闭平台
     */
    public static String SWITCH_CLOSE = "close";
    
    /**
     * 公告状态 0 - 不显示
     */
    public static byte BUTTIN_STATUS_PAST = 0;
    /**
     * 公告状态 1 - 显示
     */
    public static byte BUTTIN_STATUS_ING = 1;
    /**
     * 公告类型 1
     */
    public static short BUTTIN_TYPE_1 = 1;
    /**
     * 添加好友 0：未处理
     */
    public static byte ADD_FREINDS_0 = 0;
    /**
     * 添加好友 1：同意
     */
    public static byte ADD_FREINDS_1 = 1;
    /**
     * 添加好友2：不同意
     */
    public static byte ADD_FREINDS_2 = 2;
    /**
     * 抢购项目状态 0：未开始
     */
    public static byte PROJECT_STATUS_0 = 0;
    /**
     * 抢购项目状态 1：进行中
     */
    public static byte PROJECT_STATUS_1 = 1;
    /**
     * 抢购项目状态 2：已过期
     */
    public static byte PROJECT_STATUS_2 = 2;
    /**
     * 用户设置项 收益自动存入钱包中
     */
    public static byte SETTING_TYPE_1 = 1;
    /**
     * 处理状态 0 -未处理
     */
    public static byte DEAL_STATUS_0 = 0;
    /**
     * 处理状态 1 -已处理
     */
    public static byte DEAL_STATUS_1 = 1;
    
    /**
     * 券状态 0 -未使用
     */
    public static byte COUPON_STATUS_0 = 0;
    /**
     * 券状态 1 -使用部分
     */
    public static byte COUPON_STATUS_1 = 1;
    /**
     * 券状态 2 -使用完
     */
    public static byte COUPON_STATUS_2 = 2;
}
