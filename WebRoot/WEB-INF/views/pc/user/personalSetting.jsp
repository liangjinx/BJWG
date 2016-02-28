<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="__page_name__" value="基本设置" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/user/personalSetting.js"></script>
<script src="resources/js/ajaxfileupload.js"></script>
<script src="resources/js/uploadFile.js"></script>
</head>
<body class="body_bg">
<!--banner_box -->
<jsp:include page="../header.jsp"></jsp:include>
<!--banner_box -->
<!--导航栏-->
<jsp:include page="../nav.jsp">
	<jsp:param value="5" name="nav"/>
</jsp:include>
<!-- 导航栏-->
<!--中间部分 -->
<div class="center mypig_center">
<!--mypig_left_nav -->
<jsp:include page="nav.jsp">
	<jsp:param value="8" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt=""/>
        <div class="pig_tit"><p>您的基本信息</p></div>
    </div><!--my_pig_tit -->
<div class="basicinfo_b" id="basicInfoModifyPanel">
	<div class="basicinfo_ts"><p class="p_16">亲爱的${sessionScope[CommConstant.SESSION_MANAGER].nickname}，请填写真实的资料，有助于好友找到你哦</p></div>
    <div class="basicinfo_main">
    	<p class="p_16">当前头像: </p> <a><img id="headImg" src="${sessionScope[CommConstant.SESSION_MANAGER].headImg}" alt="用户图片"/><div class="p_tit">编辑头像</div>
    	<input type="file" class="z_upimages" id="inputfile" accept="image/*" capture="camera" name="imgFile" onchange="uploadFileAjax(this,'<%=basePath%>pc/pv/user/uploadHeadImgAjax','user_info_pc');">
    	</a>
    </div>
    <form>
	    <div class="basicinfo_main">
	    	<p class="p_16 h_36">* 昵称: </p><input type="text" name="nickName" class="basicinfo_input" value="${sessionScope[CommConstant.SESSION_MANAGER].nickname}" maxLength=15/>
	    </div>
	    <div class="basicinfo_main">
	    	<p class="p_16 h_36">* 性别: </p>
	        <input type="radio" name="sex" value="1" class="basicinfo_radio" ${sessionScope[CommConstant.SESSION_MANAGER].sex==1?'checked':'' }/><label>男</label>
	        <input type="radio" name="sex" value="2" class="basicinfo_radio" ${sessionScope[CommConstant.SESSION_MANAGER].sex==2?'checked':'' }/><label>女</label>
	    </div>
	    <div class="z_ps_box" style=" background: none;">
			<input type="button" value="提交" class="z_personal_submit" id="btnBasicInfoModify" />    
	    </div>
    </form>
	<div class="clear"></div>
</div><!--basicinfo_b -->   
<div class="mypig_body">
	<div class="pig_tit_box">
    	<img src="resources/images/pc/point1.png" alt="点"/><p>您的账户安全</p><img src="resources/images/pc/point1.png" alt="点"/>
    </div>
    <!-- 登录密码修改 -->    	
  	<div class="account_box m_top20" id="loginPwdModifyPanel">	
    	<div class="account_box_tit">
        	<img src="resources/images/pc/basicinfo_img1.png" alt="已设置" class="account_box_img"/>
            <div class="account_box_p p_20">登录密码</div>
            <div class="account_tit_p"><p>安全性高的密码可以使账号更安全。建议您定期更换密码，且设置一个包含数字和字母，并长度超过6位以上的密码。</p></div>
        	<div class="account_tit_but"><a class="btnPanelShow">修改</a></div>
        </div><!--account_box_tit -->
        <div class="innerElement">
        <div class="account_sub_tit">为了保证您的账户安全，不建议支付密码与登录密码相同</div>
        <div class="basicinfo_main basicinfo_top14">
    		<p class="p_16 h_36 width_230">输入旧密码: </p><input type="password" name="oldpwd" class="basicinfo_input" maxLength=20 onkeyup="this.value=this.value.replace(/[^a-z0-9]+$/g,'');" />
    	</div>
        <div class="basicinfo_main">
    		<p class="p_16 h_36 width_230">设置新密码: </p><input type="password" name="newpwd" class="basicinfo_input" maxLength=20 onkeyup="this.value=this.value.replace(/[^a-z0-9]+$/g,'');" />
    	</div>
    	<div class="basicinfo_main">
    		<p class="p_16 h_36 width_230">再次输入新密码: </p><input type="password" name="newpwd2" class="basicinfo_input" maxLength=20 onkeyup="this.value=this.value.replace(/[^a-z0-9]+$/g,'');" />
    	</div>
        <input type="button" value="提交" class="basicinfo_but" id="btnLoginPwdModify"/>
        </div>
    </div> <!--account_box -->   
    <!-- 支付密码修改 -->
    <div class="account_box" id="payPwdModifyPanel">
    	<div class="account_box_tit">
        	<img src="resources/images/pc/${(newPayPwd!=null and newPayPwd)?'basicinfo_img2.png':'basicinfo_img1.png' }" alt="已设置" class="account_box_img"/>
            <div class="account_box_p p_20">支付密码</div>
            <div class="account_tit_p">安全性高的密码可以使账号更安全</div>
        	<div class="account_tit_but"><a class="btnPanelShow">修改</a></div>
        </div><!--account_box_tit -->
        <div class="innerElement">
        <div class="account_sub_tit">为了保证您的账户安全，不建议支付密码与登录密码相同</div>
        <div class="basicinfo_main basicinfo_top14" ${(newPayPwd!=null and newPayPwd)?'style="display:none"':'' }">
    		<p class="p_16 h_36 width_230">输入旧密码: </p><input type="password" name="oldpwd" class="basicinfo_input" maxLength=6 onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
    	</div>
        <div class="basicinfo_main">
    		<p class="p_16 h_36 width_230">设置新密码: </p><input type="password" name="newpwd" class="basicinfo_input" maxLength=6 onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
    	</div>
    	<div class="basicinfo_main">
    		<p class="p_16 h_36 width_230">再次输入新密码: </p><input type="password" name="newpwd2" class="basicinfo_input" maxLength=6 onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
    	</div>
        <input type="button" value="提交" class="basicinfo_but" id="btnPayPwdModify"/>
        </div>
    </div> <!--account_box -->  
    <!-- 邮箱修改 -->
    <div class="account_box" id="emailPanel">
    	<div class="account_box_tit">
        	<img src="resources/images/pc/${(email==null || email=='')?'basicinfo_img2.png':'basicinfo_img1.png' }" alt="已设置" class="account_box_img"/>
            <div class="account_box_p p_20">设置邮箱</div>
            <div class="account_tit_p"></div>
        	<div class="account_tit_but"><a class="btnPanelShow">修改</a></div>
        </div><!--account_box_tit -->
       <div class="innerElement">
        <div class="basicinfo_main basicinfo_top50 " ${(email==null || email=='')?'style="display:none"':'' }>
    		<p class="p_16 h_36 width_230">原邮箱: </p><p class="mailbox_p">${email}</p>
    	</div>
        <div class="basicinfo_main">
    		<p class="p_16 h_36 width_230">设置新邮箱: </p><input type="text" name="email" class="basicinfo_input"/>
    	</div>
        <input type="button" value="提交" class="basicinfo_but" id="btnEmailModify"/>
        </div>
    </div> <!--account_box -->  
    <!-- 手机号修改 -->
    <div class="account_box" id="mobileModifyPanel">
    	<div class="account_box_tit">
        	<img src="resources/images/pc/basicinfo_img1.png" alt="已设置" class="account_box_img"/>
            <div class="account_box_p p_20">手机绑定</div>
            <div class="account_tit_p"></div>
        	<div class="account_tit_but"><a class="btnPanelShow">修改</a></div>
        </div><!--account_box_tit -->
        <div class="innerElement">
       	<img src="resources/images/pc/binding_img.png" alt="手机绑定" class="binding_img"/>
        <div class="basicinfo_main step1_element">
    		<p class="p_16 h_36 width_230">原号码: </p><p class="mailbox_p">${mobile}</p>
    		<input type="hidden" name="mobile" value="${mobile }" />
    	</div>
        <div class="basicinfo_main step1_element">
    		<p class="p_16 h_36 width_230">手机验证码: </p><input type="text" name="oldVerifyCode" class="basicinfo_input basic_input" maxLength=4/>
            <div class="auth_code_box" id="btnOldMobileVerifyCodeGet">获取验证码</div>
    	</div>
        <input type="button" value="下一步" class="basicinfo_but step1_element" id="next"/>
        
        <div class="basicinfo_main step2_element" style="display:none">
    		<p class="p_16 h_36 width_230">新手机号码: </p><input type="text" name="newMobile" class="basicinfo_input basic_input" maxLength=11 onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
    	</div>
    	<div class="basicinfo_main step2_element" style="display:none">
    		<p class="p_16 h_36 width_230">手机验证码: </p><input type="text" name="newVerifyCode" class="basicinfo_input basic_input" maxLength=4 onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
            <div class="auth_code_box" id="btnNewMobileVerifyCodeGet">获取验证码</div>
    	</div>
    	<input type="button" value="完成" style="display:none" class="basicinfo_but step2_element" id="btnMobileModifyFinish"/>
    	</div>
    </div> <!--account_box -->  
    
        
    <div class="clear"></div>    
</div><!--basicinfo_b -->
</div>


<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>

</html>




<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>基本设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script type="text/javascript" src="<%=basePath %>resources/js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath %>resources/js/pc/user/personalSetting.js"></script>
  </head>
  
  <body>
    <h3>基本设置</h3>
    <div>头像:${sessionScope[CommConstant.SESSION_MANAGER].headImg}</div>
    <div>昵称:${sessionScope[CommConstant.SESSION_MANAGER].nickname}</div>
    <div>
    	性别:
    	<select name="sex">
    		<option value="1">男</option>
    		<option value="0" ${sessionScope[CommConstant.SESSION_MANAGER].sex ==0 ? 'selected' :''}>女</option>
    	</select>
    </div>
    <hr>
    <div id="loginPwdModifyPanel">
    <div>请输入旧密码<input type="text" name="oldpwd"/></div>
    <div>请输入新密码<input type="text" name="newpwd"/></div>
    <div>请输入新密码2<input type="text" name="newpwd2"/></div>
    <button type="button" id="btnLoginPwdModify">登录密码修改提交</button>
    </div>
    <hr>
    <div id="payPwdModifyPanel">
    <div ${newPayPwd?'style="display:none"':'' }><div>请输入旧密码<input type="text" name="oldpwd"/></div></div>
    <div>请输入新密码<input type="text" name="newpwd"/></div>
    <div>请输入新密码2<input type="text" name="newpwd2"/></div>
    <button type="button" id="btnPayPwdModify">支付密码修改提交</button>
    </div>
    <hr>
    <div id="emailPanel">
    <div>${email}</div>
    <div>邮箱<input type="text" name="email"/></div>
    <button type="button" id="btnEmailModify">邮箱修改提交</button>
    </div>
    <hr>
    <div id="mobileModifyPanel">
    <div>${mobile}</div>
    <div>
    	<input type="hidden" value="${mobile}" name="mobile">
    	<div>旧手机验证码<input type="text" name="oldVerifyCode"/><button type="button" id="btnOldMobileVerifyCodeGet">获取验证码</button></div>
    	<button type="button" id="next">下一步</button>
    	<div>新手机号<input type="text" name="newMobile"/></div>
    	<div>手机验证码<input type="text" name="newVerifyCode"/><button type="button" id="btnNewMobileVerifyCodeGet">获取验证码</button></div>
    	<button type="button" id="btnMobileModifyFinish">手机号修改提交</button>
    </div>
    </div>
  </body>
</html>

















-->