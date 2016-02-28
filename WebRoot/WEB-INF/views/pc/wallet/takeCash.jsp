<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="提现" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<style>
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
	.pig_row_withdraw ul{margin:33px 0 0 0;color:#333;font-size:16px;padding-bottom:100px;}
	.pig_row_withdraw .s1{width:182px;text-align:right;vertical-align:top;}
	.pig_row_withdraw .info .add_card{display:block;width:244px;height:34px;line-height:34px;text-align:center;color:#FF6600;font-size:14px;border:1px dashed #cccccc;}
	.pig_row_withdraw .info .card_box{height:36px;line-height:36px;width:188px;border:1px solid #ddd;/* text-align:right; */padding-right:10px;cursor:pointer;}
	.pig_row_withdraw .info .current{border:1px solid #FF6600;}
	.pig_row_withdraw .info .cards{overflow:hidden;margin-top:30px;width:750px;}
	.pig_row_withdraw .info .card_li{margin:0 20px 20px 0;float:left;}
	.pig_row_withdraw .info i{ float: right; font-style:normal;}
	.pig_row_withdraw .info .current{border:1px solid #FF6600;}
	.pig_row_withdraw .info input{vertical-align: top;margin:14px 3px 0 0;}
	.pig_row_withdraw .balance{height:34px;line-height:34px;}
	.pig_row_withdraw .balance a{color:#FF6600;}
	.pig_row_withdraw .money{margin-top:10px;}
	.pig_row_withdraw .money .s1{vertical-align:top;margin-top:8px;}
	.pig_row_withdraw .money input{border:1px solid #ccc;width:122px;height:31px;line-height:31px;text-indent:1em;}
	.pig_row_withdraw .money P{font-size:14px;color:#999;line-height:1.7;}
	.pig_row_withdraw .money a{color:#FF6600;}
	.pig_row_withdraw .error-tips{padding-left:187px;height:20px;color:#FF6600;margin-top:5px;}
	.pig_row_withdraw .sure{padding-left:205px;margin:30px 0 50px;}
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
    	
    	<form method="post" action="" id="form">
    	
	    	<div class="cont">
	    		<ul>
	    			<li class="item info">
	    				<span class="s1 dib">请选择提现银行卡：</span>
	    				<span class="s2 dib">
	    					<a href="pc/pv/wallet/bandCardEdit" class="add_card">+添加银行卡</a>
	    					<div class="cards">
	    						<c:forEach items="${bankCardList}" var="bankCard" varStatus="status">
		    						<div class="card_li">
		    							<input type="radio" name="cardId" value="${bankCard.cardId}" class="card_int" id="card_gsyh_${status.index}" ${status.index==0?'checked':'' }/>
		    							<label for="card_gsyh_${status.index}" class="dib card_box current">
		    								<span class="z_bank_img_ti">
		    									<img src="resources/images/pc/bankicon/bank-${bankCard.bankCode }.png" alt="${bankCard.bank }" />
		    									${bankCard.bank }
		    								</span>
		    								<input type="hidden" name="cardNo" value="${bankCard.cardNo}">
		    								<c:set var="tmpcount" value="${fn:length(bankCard.cardNo)}"/>
		    								<i>**${fn:substring(bankCard.cardNo,tmpcount-4,tmpcount)}</i>
		    								<div class="clear"></div>
		    							</label>
		    						</div>
	    						</c:forEach>
	
	    					</div>
	    				</span>
	    			</li>
	    			<li class="item balance">
	    				<span class="s1 dib">可用余额:</span>
	    				<span class="s2 dib"><a>${wallet.money}</a>元</span>
	    			</li>
	    			<li class="item money">
	    				<span class="s1 dib">提现金额：</span>
	    				<span class="s2 dib">
	    					<input type="text" class="card_money" name="money"/>&nbsp;&nbsp;元
	    					<input type="hidden" name="maxMoney" value="${wallet.money}"/>
	    					<p>最多可提现金额：<a>${wallet.money}元</a></p>
	    				</span>
	    			</li>
	    			<li class="item error-tips"><!--您的余额不足，请重新输入提取金额--></li>
	    			<li class="item sure">
	    				<input type="button" id="btnSub" value="完成" class="btn-submit"/>
	    			</li>
	    		</ul>
	    	</div>
	    </form>
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
	
	/*银行卡选择样式*/
	$('.card_box').on('click', function(){
		$('.card_box').removeClass('current');
		$(this).addClass('current');
	})
	$('.card_int').on('click', function(){
		$('.card_box').removeClass('current');
		$(this).closest('.card_li').find('label').addClass('current');
	})
	
	$(function(){
		$('#btnSub').click(function(){
			
			var cardId = $(":input[name=cardId]:checked");
			if(cardId == null || cardId == '' || cardId.length <=0){
				alert("请选择银行卡");
				return ;
			}
			
			var money = $('[name=money]').val();
			var maxMoney = $('[name=maxMoney]').val();
			if(money =='' || !/^\d+(\.\d+)?$/.test(money)){
				alert('请正确输入提现金额');
				return;
			}
			if(parseFloat(money) > parseFloat(maxMoney)){
				alert('余额不足');
				return;
			}
			$('#form').attr('action',__base_path__+'pc/pv/wallet/takeCashConfirm').submit();		
		})
	
	})
	
	
	
</script>

</html>




<%--

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>提现</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->

  </head>
  
  <body>
    <h3>提现</h3>
    <div>
    <form method="post" action="pv/wallet/takeCashConfirm">
        <c:forEach items="${bankCardList}" var="bankCard">
            <div>
                <!--<div>银行名:${bankCard.bank }</div>
                <div>尾号:</div>
                <div>卡类型:${bankCard.cardType }</div>
                -->
                <c:set var="tmpcount" value="${fn:length(bankCard.cardNo)}"/>
                <input type="radio" name="cardId" value="${bankCard.cardId}">${bankCard.bank} ****${fn:substring(bankCard.cardNo,tmpcount-4,tmpcount)}
            </div>
        </c:forEach>
        <hr>
        <div>可用余额:${wallet.money}</div>
        <div>提现金额:<input type="text" name="money"/></div>
        <input type="submit" value="提交">
    </form>
    </div>
  </body>
</html>

















--%>










