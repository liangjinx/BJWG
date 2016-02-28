<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="我的猪场" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script type="text/javascript" src="resources/js/draggabilly.pkgd.min.js"></script>
<script type="text/javascript" src="resources/js/myJs.js"></script>

<script type="text/javascript">
 $(function(){
   $("#hb").click(function(){
   alert("温馨提示：2015年10月1日之前在财大狮平台购买仔猪的用户，请到购买页面选择相应回报方式。2015年10月1日后在本平台购买的用户，可在本平台选择收益方式！");
   });
   
 
 });


</script>


<style>
	.selected_li{
		border: 2px solid green;
	}
.piggery{width:980px;height: 140px;position:absolute; margin-top: 300px;}
	
.pig_box {
	width:70px;
	height:70px;
	position:absolute;
	-webkit-user-select:none;
	user-select:none;
}

.pig {
	width:100%;
	height:100%;/*BJWG/WebRoot/resources/images/pig_2.png*/
	background:url(/resources/images/pc/pig_2.png) no-repeat -12px 0px;
	background-repeat:no-repeat;
	background-size:610px;
	/*background:url(images/back.gif) no-repeat;*/
	cursor:pointer;
}

.pig_box .pigsay {
	background: rgba(255,255,255,.9);
	border-radius: 50px;
	color: #222;
	line-height: 16px;
	padding: 2px 15px;
	position: absolute;
	right: 0;
	bottom: 65px;
	min-width: 102px;
	width: auto;
	min-height: 36px;
	font-size: 1rem;
	visibility: hidden;
	z-index: 100;
}

.pig_box .pigsay.visible {
	visibility: visible;
}

.pig_box .pigsay:after {
	content: '';
	position: absolute;
	bottom: -4px;
	left: 25px;
	width: 0;
	height: 0;
	border-left: 6px solid transparent;
	border-right: 6px solid transparent;
	border-top: 4px solid rgba(255,255,255,.75);
}


.pig_box.pig_lt .pig {
	background-position: -12px -66px;
}

.pig_box.pig_rt .pig {
	background-position: -12px 0px;
}

.pig_box.pig_rt .pigsay:after {
	left: auto;
	right: 25px;
}
	
	
		
</style>
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
	<jsp:param value="1" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="mypig_box"><!--mypig_box -->
	
	 <div class="clear"></div>
        <div class="piggery">
		</div>
		<div class="pig_zl"></div>
     <div class="clear"></div>
        
    	<div class="mypig_xq">
        	<ul>
        		<c:choose>
        			<c:when test="${farmData.allCount != null && farmData.allCount != 0}">
        				<li><p>我的猪仔总数：${farmData.allCount}只</p></li>
        				<li><p>我的总收益：${totalEr}</p></li>
                		<li class="this_li"><p>${farmData.projectName }</p></li>
                		<li><p><a href="pc/pv/user/myEarning?projectId=${farmData.projectId }">本期收益：${farmData.profit }元</a></p></li>
               		 	<li><p>本期猪仔：${farmData.num - farmData.presentNum}只</p></li>
                		<li><p>养殖期：${growData.list[0].remark}</p></li>
                		
                		<li>
                		
            <c:choose>
             <c:when test="${growData['list'][0].beginTime gt begTime}">
                       	<p>
                				回报方式：
                			   	
                				<a href="pc/pv/order/paybackChoose?projectId=${farmData.projectId }&way=${farmData.way}&endTime=<fmt:formatDate value="${growData['list'][0].endTime}" pattern='yyyy-MM-dd' />">
                			
                				<c:choose>
    							<c:when test="${farmData.way == null}">
    								未选择
    							</c:when>
    							<c:when test="${farmData.way == 1}">
    								委托销售
    							</c:when>
    							<c:when test="${farmData.way == 2}">
    								屠宰配送
    							</c:when>
    							<c:when test="${farmData.way == 3}">
    								领取活猪
    							</c:when>
    							<c:when test="${farmData.way == 4}">
    								领猪肉券
    							</c:when>
    							<c:otherwise>
    								${farmData.way}
    							</c:otherwise>
    							</c:choose>
                				</a>
                			</p>
                		</c:when>
                			
                			
                			  <c:otherwise>
                       	<p>
                				回报方式：
                			   	
                				<a href="javascript:void(0)" id="hb">
                			
                				<c:choose>
    							<c:when test="${farmData.way == null}">
    								未选择
    							</c:when>
    							<c:when test="${farmData.way == 1}">
    								委托销售
    							</c:when>
    							<c:when test="${farmData.way == 2}">
    								屠宰配送
    							</c:when>
    							<c:when test="${farmData.way == 3}">
    								领取活猪
    							</c:when>
    							<c:when test="${farmData.way == 4}">
    								领猪肉券
    							</c:when>
    							<c:otherwise>
    								${farmData.way}
    							</c:otherwise>
    							</c:choose>
                				</a>
                			</p>
                		</c:otherwise>
                		</c:choose>
                		</li>
        			</c:when>
        			<c:otherwise>
        				<li><p>我的猪仔总数：0只</p></li>
        				<li><p>我的总收益：0.00元</p></li>
                		<li class="this_li"><p>(您没有猪仔)</p></li>
                		<li><p><a href="javascript:;">我的收益：0.00元</a></p></li>
               		 	<li><p>本期猪仔：0只</p></li>
                		<li><p>养殖期：(无)</p></li>
                		<li><p>回报方式：(无)</p></li>
        			</c:otherwise>
        		</c:choose>
            </ul>
        </div>
        <div class="mypig_period" style=" border-right:1px solid #ccc;">
        	<ul>
        		<c:forEach items="${farmData.allMyMyEarnings}" var="ear">
        			<li><a href="pc/pv/user/farm?earningsId=${ear.earningsId }">${ear.paincbuyProjectName }</a></li>
    			</c:forEach>
            </ul>
        </div>
        <div class="mypig_switch"></div>
        <div class="z_pigfarm_camera">
        	<img src="resources/images/pc/camera.png" alt="实时监控" />
        </div>
       
    </div><!--mypig_box -->
    
<div class="my_pig_tit bg_f6"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="我要预抢"/>
        <div class="pig_tit"><p>我要预抢</p></div>
</div><!--my_pig_tit -->

<div class="biao_box">
	<div class="biao_tit">
    	<img src="resources/images/pc/this_nav.png" alt="三角形"/><p>每期固定数量抢标 </p>${userExt.settingType == 1 ? '已选择此方式' :'' }
    </div>
    <div class="biao_box_p"><p class="p_tit" style="margin-top: 10px;">温馨提示：</p><p style=" height: auto; line-height:24px; margin-left: 200px; margin-right: 50px;">两种抢标方式只可选择一种；抢购成功需要在2小时内完成付款，否则视为放弃抢购。</p></div>
    <div class="biao_box_p biao_box_input">
    	<p class="p_tit">数量：</p>
    	<c:if test='${userExt.settingType eq 1 }'>
    		<input type="text" name="alwaysCount" class="input_text" value="${userExt.settingValue }" readonly/>
    		<input id="btnAlwaysBtn" type="button" value="取消" class="button"/>
    	</c:if>
    	<c:if test='${userExt.settingType ne 1}'>
    		<input type="text" name="alwaysCount" class="input_text" maxLength=9/>
    		<input id="btnAlwaysBtn" type="button" value="提交" class="button"/>
    	</c:if>
    </div>
</div>    <!--biao_box -->
    
<div class="biao_box biao_box2">
	<div class="biao_tit"> 
    	<img src="resources/images/pc/this_nav.png" alt="三角形"/><p>选择期数抢标</p>
    	<c:if test='${userExt.settingType eq 2}'>
    		&nbsp;已选择此方式
    	</c:if>
    </div>
    <c:choose>
    	<c:when test="${fn:length(preOrderList)>0 }">
    	<ul class="biaoqi_ul">
    	<c:forEach items="${preOrderList}" var="l">
	        <li data-id="${l.projectId }" data-num="${l.num }" <c:if test="${l.num > 0}">class="this_li"</c:if>>
	            	${l.name}
	            <c:if test="${l.num >  0}">/${l.num}</c:if>
	        </li>
    	</c:forEach>
    	</ul>
    	</c:when>
    	<c:otherwise>
    		<div class="z_no_yuqiang">暂时没有可以预抢的标哦。</div>
    	</c:otherwise>
    </c:choose>
    <div class="biao_box2_but">
    	<p>抢购数量：</p>
    	<input type="tel" name="" id="buyNum" class="input_text"/>
    	<input type="button" id="btnChooseSub" value="确定" class="button"/>
    </div>    
</div> <!--biao_box -->  

<div class="mypig_body m_top50">
	<img src="resources/images/pc/czjl.png" alt="成长记录" class="pig_czjl"/>
    <div class="pig_cz_tab">
    <table>
    	<tr class="this_tr">
    		<c:choose>
    			<c:when test="${fn:length(groupRecordList)>0 }">
    				<c:forEach items="${groupRecordList}" var="rd">
		        		<td style="width:3%"><img src="resources/images/pc/round2.png" alt="圆"/></td>
		        		<td style="width:97%">${rd.extend } ${rd.remark }</td>
		    		</c:forEach>
    			</c:when>
    			<c:otherwise>
    				<div class="z_pig_growup">暂无成长记录。</div>
    			</c:otherwise>
    		</c:choose>
        </tr>
    </table>
    </div>
</div>



 
<div class="clear"></div>
</div><!--right_main -->


<div class="clear"></div>
</div>

   
<!-- 中间部分-->
<!--底部 -->
<jsp:include page="../footer.jsp"></jsp:include>
<!--底部 -->
</body>
<script>
$(function(){
	var sw = true ;//开关
	$('.mypig_switch').click(function(){
		
		if(sw){
			$('.mypig_xq').css('display','block');
			$('.mypig_period').css('display','block');
			sw = false ;
			}else{
			$('.mypig_xq').css('display','none');
			$('.mypig_period').css('display','none');
			sw = true ;
				}
		
		});
		
	//固定抢标
	$('#btnAlwaysBtn').click(function(){
	
		var self = $(this);
		var count = $('[name=alwaysCount]').val().trim();
		
		if(self.val()=="取消"){
			count=0;
		} else{
			if(count == '' || count<=0 || !/^[0-9]*$/.test(count)){
				alert('请正确输入数量!');
				return;
			}
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/preOrderSave',
		    cache: false,
		    data: {
		    	settingType:1,
		    	num:count,
		    	cancel:count>0?false:true
		    },
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('操作成功');
		    		window.location.href=__base_path__+'/pc/pv/user/farm';
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
		});
	});
		
		
	$('.biaoqi_ul li').click(function(){
		var self=$(this);
		var num = self.attr('data-num');
		var projId = self.attr('data-id');
		
		//取消抢标
		if(num!=null && num >0){
			var r=confirm("确认取消?");
			if(r){
				$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/preOrderSave',
		    cache: false,
		    data: {
		    	settingType: 2,
		    	num: 0,
		    	cancel: true,
		    	projectId: projId
		    },
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('取消成功');
		    		window.location.href=__base_path__+'/pc/pv/user/farm';
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
			});
			}
			return;
		}
		
		$('.biaoqi_ul li').removeClass('selected_li');
		self.addClass('selected_li');
		$('#buyNum').val('').focus();
	});
	
	
	
	
	
	
	$('#btnChooseSub').click(function(){
		var self = $(this);
		var count = $('#buyNum').val();
		
		if($('.selected_li').length<=0){
			alert('请选择一期');
			return;
		}
		if(count == '' || count<=0 || !/^[0-9]*$/.test(count)){
			alert('请正确输入数量');
			return;
		}
		
		self.attr('disabled','disabled');
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    url: __base_path__+'pc/pv/user/preOrderSave',
		    cache: false,
		    data: {
		    	settingType: 2,
		    	num: count,
		    	cancel: false,
		    	projectId: $('.selected_li').attr('data-id')
		    },
		    success: function(data){
		    	if(data.msg == 'success'){
		    		alert('操作成功');
		    		window.location.href=__base_path__+'/pc/pv/user/farm';
		    	} else {
		    		alert(data.data.text);
		    		self.removeAttr('disabled');
		    	}
		    },
		    error: function(){
		    	alert('error');
		    }
		});
		
	});
	
});
</script>

<script>
		/* $(function(){
			//活动的猪的个数。如：10只猪
			var pigs = CreatePig(${farmData.allCount!=null?farmData.allCount:0})
		});
		 */
		$(function(){
			var height_ = 200,
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
			    scrollbar: true,
			    closeBtn: true, //false:不显示关闭按钮
				shift:1, //0-6的动画形式，-1不开启
			    content: $(".yubiao_notice") 	//调预抢弹窗
			    //content: $('.harvest')			//调成猪出售弹窗
			}); 
			layer.style(index,{
				'border-radius':'5px'   //修改layer最外层容器样式
			});
		});
		
	</script>




<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

  <head>
    <base href="<%=basePath%>">
    
    <title>我的猪场</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	

  </head>
  
  <body>
    <h3>我的猪场</h3>
    <div>
    	<div>总数:${farmData.allCount }</div>
    	<div><a href="pv/user/myEarning?projectId=${farmData.projectId }">本期收益:${farmData.profit }</a></div>
    	<div>本期名:${farmData.projectName }</div>
    	<div>本期数量:${farmData.num}</div>
    	<div>阶段:${farmData.phase}</div>
    	<div>
    		回报方式:
    		<c:choose>
    			<c:when test="${farmData.way == null}">
    				<a href="pv/order/paybackChoose?projectId=${farmData.projectId }">选择回报方式</a>
    			</c:when>
    			<c:otherwise>
    				${farmData.way }
    			</c:otherwise>
    		</c:choose>
    	</div>
    	<div>
    		我参与的所有期:
    		<c:forEach items="${farmData.allMyMyEarnings}" var="ear">
    			<a href="pv/user/farm?earningsId=${ear.earningsId }">${ear.paincbuyProjectName }</a> | 
    		</c:forEach>
    	</div>
    	<div>
    		本期成长记录:
    		<c:forEach items="${groupRecordList}" var="rd">
    			<div>${rd.extend } ${rd.remark }</div>
    		</c:forEach>
    	</div>
    	<hr>
    </div>
  </body>
</html>






















-->