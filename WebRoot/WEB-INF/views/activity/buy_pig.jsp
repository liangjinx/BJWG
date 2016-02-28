<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%   
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>购买</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国">
<meta name="description" content="八戒王国">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath %>resources/css/enter.css"/>

<style>
	#allProjectForm { height: 100%;}
	.count_ul_tit { height: 30px; line-height: 30px;}
	.z_synthesize { color: #ff6600; text-decoration: underline;}
	.z_synthesize_box { display: none; width: 100%; background-color: #fff; overflow: hidden;}
	.z_synthesize_box h3 { width: 100%; height: 40px; line-height: 40px; margin-top: 10px; font-size: 16px; color: #615868; text-align: center;}
	.z_synthesize_content { width: 90%; height: auto; margin: 0 auto; padding: 10px 0 2px; border-top: 1px solid #dedede; border-bottom: 1px solid #dedede;}
	.z_synthesize_content p { line-height: 22px; font-size: 14px; color: #615868; text-align: left;}
	.z_synthesize_content p:nth-of-type(8) { margin-bottom: 10px;}
	.z_i_know { width: 100%; height: 40px; line-height: 40px; font-size: 16px; color: #ff6600; text-align: center;}
	.z_count_num { padding: 2px 5px; font-size: 12px; color: #615868; text-align: center;}
	.z_count_num em { padding: 0 5px;}
	.z_count_num em:nth-of-type(1) { color: #ff6600;}
	.position_r { position: relative;}
	.z_empty { position: absolute; top: 20%; left: 20%;  width: 60%;max-width:102px;}
	.z_empty_no { position: absolute; top: 20%; left: 20%; width: 60%;display: none;}
	.z_check_s { margin-top: -3px;}
</style>
</head>
<body>
<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png" alt="八戒王国" /></div>
<form action="<%=basePath %>wpv/orsubmit" id="allProjectForm" name="allProjectForm" method="post" onsubmit="return orderSubmit();">
	<input type="hidden" name="projectId" id="projectId" value="${queryProjectId }">

	<div class="bodyheight earning_bg"><!--bodyheight -->
		<p class="p_top">&nbsp;</p>
		<div class="center90 buy_pig_box"><!--buy_pig_box -->
	    	<div class="buy_pig_mian"><!--buy_pig_mian -->
	    	<ul class="buypig_ul">
	        	<li>
	            	<div class="img_box"><img src="${map.project.imgs }" alt="二师兄"/></div>
	            </li>
	            <li>
	            	<div class="buy_rt_tit">
	                	<p class="p_top">&nbsp;</p>
	                	<p class="mt10">${map.project.name}</p>
	                    <p class="p_color2 mt10">单价${map.project.totalMoney}/只<br><span class="z_synthesize" onclick="showComprehensiveCosts()">(含综合费用)</span></p>
	                    <!-- 已抢完 -->
	                    <img src="<%=basePath %>resources/images/buy-over.png" alt="猪仔已抢完" <c:choose><c:when test="${ map.project.leftNum > 0}">class="z_empty_no"</c:when><c:otherwise>class="z_empty"</c:otherwise></c:choose> />
	                    <!-- end 已抢完 -->
	                </div>
	            </li>
	        </ul>
	        <div class="clear"></div>
	        </div><!--buy_pig_mian -->
	   
	    <div class="count_buy_box">
	    	<ul class="count_ul">
	        	<li>
	            	<div class="count_ul_tit text_l">总价</div>
	                <p class="count_p">￥<span></span></p>
	            </li>
	            <li>
	            	<div class="count_rt_tit">
	                	<div class="count_ul_tit">购买数量</div>
	                    <div class="count_box">
	                    	<div class="count_m">-</div>
	                    	<input type="text" value="1" name="purchaseNum" id="purchaseNum" class="count_input" maxlength="4"/>
	                    	<div class="count_add">+</div>
	                    	<div class="z_count_num">
		                    	剩余<em>${ map.project.leftNum}</em>只<br/>/总数<em>${map.project.num }</em>只
		                    </div>
	                    </div>
	                </div>
	            </li>
	        </ul>
	         <div class="clear"></div>
	    </div>
	    <div class="clear"></div> 
	    <div class="center80">
	    	<button class="buy_but">购买</button>
	        <p class="fwxy_p">
	        	<input type="checkbox" name="chk" id="chk" checked class="z_check_s"/>&nbsp;同意
	        	<a href="<%=basePath %>wpnv/ixprotocol?code=BJWG_SERVICE_PROTOCOL.TYPE.PROJECT">
	        		<span>《服务协议》</span>
	        	</a>
	        </p>
	    </div>
	</div>
	   
	    <p class="p_top">&nbsp;</p>
		<div class="center90 buy_pig_box">
		
		
		
		
		<c:choose>
				<c:when test="${ratings != null }">
					<p class="buy_tab_tit">本期排行</p>
				    <table class="bqph_tab">
				    	<tr class="first_tr">
				        	<td style="width:20%;"><p>排名</p></td><td style="width:30%;"><p>昵称</p></td><td style="width:50%;"><p>数量</p></td>
				        </tr>
						<c:forEach items="${ratings }" var="tu" varStatus="status">
						<c:set var="nickLength" value="${fn:length(tu.phone)}"/>
					        <tr class="main_tr">
					        	<td>${status.count}</td><td><p>${fn:substring(tu.phone, 0, (nickLength>2)?3:nickLength)}*****</p></td><td>${tu.count}</td>
					        </tr>
						</c:forEach>
				    </table>
				</c:when>
				<c:otherwise>
					<p class="buy_tab_tit">暂无排行</p>
				</c:otherwise>
			</c:choose>
		 
		
		
		
		
		
		
		
		
		
		
			<%-- <c:choose>
				<c:when test="${map.topUserList != null }">
					<p class="buy_tab_tit">本期排行</p>
				    <table class="bqph_tab">
				    	<tr class="first_tr">
				        	<td style="width:20%;"><p>排名</p></td><td style="width:30%;"><p>昵称</p></td><td style="width:50%;"><p>数量</p></td>
				        </tr>
						<c:forEach items="${map.topUserList }" var="tu" varStatus="status">
						<c:set var="nickLength" value="${fn:length(tu.username)}"/>
					        <tr class="main_tr">
					        	<td>${index.status+1}</td><td><p>${fn:substring(tu.username, 0, (nickLength>2)?3:nickLength)}*****</p></td><td>${tu.extend1}</td>
					        </tr>
						</c:forEach>
				    </table>
				</c:when>
				<c:otherwise>
					<p class="buy_tab_tit">暂无排行</p>
				</c:otherwise>
			</c:choose> --%>
		</div> 
	</div><!--bodyheight -->
	<div class="z_synthesize_box">
		<h3>单只综合费用详情</h3>
		<div class="z_synthesize_content">
			${map.project.otherFeeDetail }
			<%--
				<p>28天断奶仔猪1头</p>
				<p>仔猪喂养至出栏所需：</p>
				<p>饲料</p>
				<p>疫苗</p>
				<p>保健费用</p>
				<p>疾病治疗中草药费用</p>
				<p>人工成本</p>
				<p>固定资产折旧等</p>
			--%>
		</div>
		<div class="z_i_know">我知道了</div>
	</div>
</form>
</body>
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpnv/ixhome" name="backUrl"/>
</jsp:include>
<script src="<%=basePath %>resources/js/layer/layer.js"></script>
<script>
	$(function(){
		var price = ${map.project.totalMoney};//单价		
		var input_val = $('.count_input').val();//数量
		var value = price*input_val;//总价
		$('.count_p span').text(value);
		
		$('.count_m').click(function(){//减
			input_val--;
			if( input_val <= 0 ){
				input_val = 1;
				value = price*input_val;
				$('.count_input').val(input_val);
				$('.count_p span').text(value);
			}else{
				if(input_val > 9999 ){
					input_val = 9999;
				}
				$('.count_input').val(input_val);
				value = price*input_val;
				$('.count_p span').text(value);
			}
		})
		$('.count_add').click(function(){//加
			input_val++;
			if(input_val > 9999 ){
				input_val = 9999;
			}
			value = price*input_val;
			$('.count_p span').text(value);
			$('.count_input').val(input_val);
		})
		// 直接输入数量 
		$('.count_input').change(function(){
			input_val = $('.count_input').val();//数量
			if(input_val >= 0){
				value = price*input_val;
				$('.count_p span').text(value);
				$('.count_input').val(input_val);
			}else{
				alert('请正确输入数量！');
			}
		});
	})
		
	function orderSubmit(){
		var purchaseNum = $("#purchaseNum").val();
		if(purchaseNum <= 0 || isNaN(purchaseNum)){
			alert("购买数量至少为1");
			return false;
		}
		if($("#chk:checked").length <= 0){
			alert("请选择是否同意服务协议");
			return false;
		}
		//$("#allProjectForm").submit();
		$(":button").attr("disabled",true);
		return true;
	}
	
	function showComprehensiveCosts(){
		var height_ = 290,
			layer_width = $(window).width()*80/100,
			window_heigit = $(window).height(),
			offset = 'auto';
			
		if(window_heigit <= height_) offset = "0px";
		if(layer_width>=640) layer_width = "640*90/100";
		
		var index = layer.open({
		    type: 1,
		    title:false,
		    shade: 0.6,
		    area: [layer_width+'px', height_+'px'],
		    offset: offset,
		    scrollbar:true,
		    closeBtn: false, //不显示关闭按钮
			shift:1, //0-6的动画形式，-1不开启
		    content: $(".z_synthesize_box") 
		}); 
		layer.style(index,{
			'border-radius':'3px'//修改layer最外层容器样式
		});
		
		$('.z_i_know').on('click',function(){
			layer.closeAll();
		});
	}
</script>

</html>

