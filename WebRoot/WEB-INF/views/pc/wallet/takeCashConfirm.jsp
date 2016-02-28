<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="提现确认" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<style>
	::-ms-clear,::-ms-reveal{display:none;}
	.btn-submit{
		height:41px;line-height:41px;width:120px;font-size:16px;text-align:center;color:#fff;border:none;
		background-color:#FF6600;
		border-radius:2px;
		font-family: "Microsoft Yahei","微软雅黑";
		cursor:pointer;
	}
	.btn-submit:active{background-color:#DF5A01;}
	.pig_row_withdraw{float:left;}
	.pig_row_withdraw .tips{width:958px;height:41px;line-height:41px;background:#feffe5;border:1px solid #d6d898;color:#666;margin:13px 0 0 11px;text-indent:36px;}
	.pig_row_withdraw ul{margin:33px 0 0 68px;color:#333;font-size:16px;}
	.pig_row_withdraw .s1{width:112px;text-align:right;}
	.pig_row_withdraw .info{height:40px;line-height:40px;margin-bottom:22px;}
	.pig_row_withdraw .info .card_info{width:348px;height:36px;line-height:36px;border:1px solid #fedda6;vertical-align:middle;margin-left:7px;font-size:14px;}
	.pig_row_withdraw .card_info span{vertical-align: top;text-indent:10px;}
	.pig_row_withdraw .info .info_1{width:140px;overflow:hidden;}
	.pig_row_withdraw .info img{ width: 15px; height: 15px; margin-top: -2px; margin-right: 2px; vertical-align: middle;}
	.pig_row_withdraw .info .info_2{width:62px;border-left:1px solid #fedda6;border-right:1px solid #fedda6;}
	.pig_row_withdraw .balance,.pig_row_withdraw .time{height:34px;line-height:34px;}
	.pig_row_withdraw .balance a{color:#FF6600;}
	.pig_row_withdraw .password{margin-top:28px;}
	.pig_row_withdraw .password .s1{vertical-align:top;margin-top:35px;}
	.pig_row_withdraw .password .s2{color:#666;font-size:14px;}
	.pig_row_withdraw .password p{line-height:28px;}
	.pig_row_withdraw .password a{font-size:16px;color:#FF6600;margin-left:10px;}
	.pig_row_withdraw .password .card_pass{width:233px;height:39px;line-height:39px;border:none;border:1px solid #999;letter-spacing: 26px;text-indent: 14px;}
	.pig_row_withdraw .password .pass_wrap{position:relative;}
	/*.pig_row_withdraw .password label{
		position:absolute;top:0;left:0;width:235px;height:41px;line-height:41px;letter-spacing: 26px;text-indent: 14px;
		background:#fff url(resources/images/pc/card_pass.png) no-repeat center center;cursor:pointer;font-size:30px;
		z-index:9;
	}
	.pig_row_withdraw .password label.int_focus{outline:#FF6600 1px solid;}*/
	.pig_row_withdraw .sure{padding-left:117px;margin:80px 0 262px;}
	.pig_row_withdraw .sure a{margin-left:24px;color:#666666;}
	.pig_row_withdraw .sure a:hover{text-decoration: underline;}
</style>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
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
<jsp:include page="../user/nav.jsp">
	<jsp:param value="2" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->

<div class="right_main clearfix">
	<div class="my_pig_tit bg_f6"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="账户总览"/>
        <div class="pig_tit"><p>账户总览</p></div>
    </div><!--my_pig_tit -->
	<div class="pig_tit_box">
    	<img src="resources/images/pc/point1.png" alt="点"/><p>确认提现信息</p><img src="resources/images/pc/point1.png" alt="点"/>
    </div>
    <div class="pig_row_withdraw">
    	<div class="tips">
    		提现资金将在 <b>1个工作日内</b> 到达您的银行账户
    	</div>
    	<div class="cont">
    		<input type="hidden" id="cardId" value="${cardId}">
	        <input type="hidden" id="money" value="${money}">
	        <c:set var="tmpcount" value="${fn:length(cardNo)}"/>
    		<ul>
    			<li class="item info">
    				<span class="s1 dib">银行卡信息：</span>
    				<span class="s2 dib">
    					<input type="radio" checked name="card" class="card"/>
    					<div class="dib card_info">
    						<!-- <span class="dib info_1"><img src="resources/images/pc/d-icon-jsyh.png" alt="建设银行" /></span> -->
    						<span class="dib info_1"><img src="resources/images/pc/bankicon/bank-${bankCard.bankCode}.png" alt="${bankCard.bank }" />${bankCard.bank }</span>
    						<span class="dib info_2">**${fn:substring(cardNo,tmpcount-4,tmpcount)}</span>
    						<span class="dib info_3">限额：无</span>
    					</div>
    				</span>
    			</li>
    			<li class="item balance">
    				<span class="s1 dib">提现余额：</span>
    				<span class="s2 dib"><a>${money}</a>元</span>
    			</li>
    			<li class="item time">
    				<span class="s1 dib">到账时间：</span>
    				<span class="s2 dib">24小时内</span>
    			</li>
    			<li class="item password">
    				<span class="s1 dib">支付密码：</span>
    				<span class="s2 dib">
    					<p>您在安全环境下，请放心使用</p>
    					<div class="pass_wrap">
    						<input type="password" maxlength="6" class="card_pass" id="pwd"/><a href="javascript:alert('忘记支付密码请联系客服0755-8357 9888，进行密码找回!');">忘记密码？</a>
    						<!--<label for="card_pass"></label>-->
    					</div>
    					<p>请输入6位支付密码</p>
    				</span>
    			</li>
    			<li class="item sure">
    				<input type="button" value="确认提现" class="btn-submit" id="btnsub"/>
    				<a href="javascript:history.back(-1);">返回修改</a>
    			</li>
    		</ul>
    	</div>
    </div>
 	
 	<div class="clear"></div>
</div>
<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>

<script>
    $(function(){
        $('#btnsub').click(function(){
        var self = $(this);
        
        var pwd = $('#pwd').val();
        if(pwd=='' || pwd.length!=6 || !/^[0-9]*$/.test(pwd)){
				alert('请正确输入支付密码');
				return;
		}
        
        self.attr('disabled','disabled');
        $.ajax({
        type: 'POST',
        dataType: 'json',
        url: __base_path__+'pc/pv/wallet/takeCashSubmit',
        cache: false,
        data: {
            cardId:$('#cardId').val(),
            money:$('#money').val(),
            password:$('#pwd').val()
        },
        success: function(data){
            if(data.msg == 'success'){
                alert('提现申请成功')
                window.location.href=__base_path__+"pc/pv/wallet/home";
            } else {
                alert(data.data.text);
                self.removeAttr('disabled');
            }
        },
        error: function(){
            alert('error');
        }
    });
        })
    })
</script>

</html>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>提现确认</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <script language="JavaScript" src="resources/js/jquery-1.11.1.min.js"></script>
    <script>
        $(function(){
            $('#btnsub').click(function(){
            var self = $(this);
            
            self.attr('disabled','disabled');
            $.ajax({
            type: 'POST',
            dataType: 'json',
            url: 'pv/wallet/takeCashSubmit',
            cache: false,
            data: {
                cardId:$('#cardId').val(),
                money:$('#money').val(),
                password:$('#pwd').val()
            },
            success: function(data){
                if(data.msg == 'success'){
                    alert('提现申请成功')
                    window.location.href="pv/wallet/home";
                } else {
                    alert(data.data.text);
                    self.removeAttr('disabled');
                }
            },
            error: function(){
                alert('error');
            }
        });
            })
        })
    </script>
  </head>
  
  <body>
    <h3>提现确认</h3>
    <div>
        <input type="hidden" id="cardId" value="${cardId}">
        <input type="hidden" id="money" value="${money}">
        <c:set var="tmpcount" value="${fn:length(cardNo)}"/>
        <div>银行卡信息: ${bank} ****${fn:substring(cardNo,tmpcount-4,tmpcount)}</div>
        <div>提现金额: ${money}</div>
        <div>支付密码<input type="text" id="pwd"></div>
        <button type="button" id="btnsub">确认提现</button>
    </div>
  </body>
</html>
--%>
