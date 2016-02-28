<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="mypig_left_nav">
	<div class="my_pig_user">
    	<img src="${sessionScope[CommConstant.SESSION_MANAGER].headImg}" alt="用户图片"/>
        <p class="p_18 t_center">${sessionScope[CommConstant.SESSION_MANAGER].nickname}</p>
    </div>
    <div class="my_user_tit"><img src="resources/images/pc/my_pig_user2.png" alt="个人中心"/><p>个人中心</p></div>
    <div class="mypig_nav">
    	<ul>
        	<li><a class="${param.nav==1?'this_a':''}" href="pc/pv/user/farm"><img src="resources/images/pc/pig_nav1.png" alt="我的猪场"/>我的猪场</a></li>
            <li><a class="${param.nav==2?'this_a':''}" href="pc/pv/wallet/home"><img src="resources/images/pc/pig_nav2.png" alt="账户总览"/>账户总览</a></li>
            <li><a class="${param.nav==3?'this_a':''}" href="pc/pv/order/list"><img src="resources/images/pc/pig_nav3.png" alt="我的订单"/>我的订单</a></li>
            <li><a class="${param.nav==4?'this_a':''}" href="pc/pv/user/friend"><img src="resources/images/pc/pig_nav4.png" alt="我的好友"/>我的好友</a></li>
            <li><a class="${param.nav==5?'this_a':''}" href="pc/pv/user/ticket"><img src="resources/images/pc/pig_nav5.png" alt="我的猪肉券"/>我的猪肉券</a></li>
            <li><a class="${param.nav==6?'this_a':''}" href="pc/pv/user/msg"><img src="resources/images/pc/pig_nav6.png" alt="站内信"/>站内信</a></li>
            <li><a class="${param.nav==7?'this_a':''}" href="pc/pv/address/addressManage"><img src="resources/images/pc/pig_nav7.png" alt="收货地址"/>收货地址</a></li>
            <li><a class="${param.nav==8?'this_a':''}" href="pc/pv/user/personalSetting"><img src="resources/images/pc/pig_nav8.png" alt="基本设置"/>基本设置</a></li>            
        </ul>
    </div>
</div>
