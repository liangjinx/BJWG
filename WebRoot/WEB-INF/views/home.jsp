<%@page import="com.bjwg.main.util.ToolKit"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
 	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="keywords" content="八戒王国online">
	<meta name="description" content="八戒王国online">
	<meta http-equiv="Pragma" content="no-cache" />
	<link rel="stylesheet" href="<%=basePath %>resources/css/public.css"/>
	<link rel="stylesheet" href="<%=basePath %>resources/css/home.css"/>
	<title> 首页 </title>
</head>
<body>
	<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
	<div class="home-wrap">
		<!-- 夜晚 加 night -->
		<div 
			<c:choose>
				<c:when test="${hours >= 6 && hours <= 18 }">
					class="home-container day"
				</c:when>
				<c:otherwise>
					class="home-container night"
				</c:otherwise>
			</c:choose>
		>
		
			<div class="camera">
				<a class="to-camera" href="<%=basePath %>wpnv/ixmonitoring"></a>
			</div>
			
			<div class="aster">
				<div class="sun">
					<c:choose>
						<c:when test="${hours >= 6 && hours <= 18 }">
							<img class="aster-sun" src="<%=basePath %>resources/images/sun.png" alt="" />
						</c:when>
						<c:otherwise>
							<img class="aster-sun" src="<%=basePath %>resources/images/moon.png" alt="" />
						</c:otherwise>
					</c:choose>
					<!-- 夜晚 
					-->
					<div class="small-cloud"></div>
				</div>
			</div>
			
			<div class="state-bar">
				<div class="bubble-panel num-desc">
					<a href="<%=basePath %>wpnv/ixpigNumDetail">
						<span class="bubble">总数</span>
						<span class="r-frame">
							${dataMap.totalNum }只
						</span>
					</a>
				</div>
				<div class="bubble-panel growing-state">
					<a href="<%=basePath %>wpnv/ixpigGrow?queryProjectId=${dataMap.projectId}">
						<sapn class="bubble">成长<br/>状态</sapn>
						<span class="r-frame">
							${dataMap.growStatus }%
						</span>
					</a>
				</div>
				<div class="bubble-panel gold-num">
					<a href="<%=basePath %>wpnv/ixRecentEarning">
						<sapn class="bubble"><img src="<%=basePath %>resources/images/king.png" alt="" /></sapn>
						<span class="r-frame">
							${dataMap.profit }
						</span>
					</a>
				</div>
				
			</div>
			
			<div class="prairie">
				
				<div class="prairie-bg-patch"></div>
				
				<div class="prairie-bg">
					<div class="mountain">
						<div class="big-cloud"></div>
						<!--<img width="100%" src="images/mount.png" alt="" />-->
					</div>
				
					<c:choose>
	    				<c:when test="${projectMap != null && projectMap.type eq 'current' }">
							<div class="buy-tips" onclick="javascript:location.href='<%=basePath %>wpnv/ixPanicutBuyInit?queryProjectId=${projectMap.project.paincbuyProjectId}'">
								<a href="javascript:void(0);" class="to-buy">
									${projectMap.project.name }
									<span id="buy_now">立即抢购</span>
								</a>
							</div>
						</c:when>
						<c:when test="${projectMap != null && projectMap.type eq 'next'  }">
							<div class="buy-tips time_reduce" data-countdown="${projectMap.leftTime == null ? 0 : projectMap.leftTime}" data-fresh="<%=basePath %>wpnv/ixhome">
								<a href="javascript:void(0);" class="to-buy">
									${projectMap.project.name }
									<span class="d_count_down" id="count_down"></span>
								</a>
							</div>
						</c:when>
					</c:choose>
					
					<div class="fly-pig">
						<i class="say-txt">猪哥要在这<br/>里守护小猪</i>
					</div>
					
					<i class="tree-1"></i>
					<i class="tree-2"></i>
					<i class="tree-3"></i>
					<i class="tree-4"></i>
					<i class="tree-5"></i>
					<!--<img src="images/pasture-bg-1.png" alt="" />-->
					
					
				</div>
				
				<div class="piggery">
					
				
				</div>
				
				<div class="prairie-bg-column">
					<!--<img width="" src="images/pasture-bg-2.png" alt="" />-->
				</div>
			
			</div>
		</div>
			<!-- 预抢弹窗 -->
			<c:if test="${bulletin != null }">
			<div class="yubiao_notice">
				<h4>${bulletin.title }</h4>
				<div>${bulletin.content }</div>
			</div> 
			</c:if>
			
			<%
			request.getSession().setAttribute("bull", "1");
			
			 %>
			
			
		<!-- 成猪出售 
		<c:if test="${meList != null && fn:length(meList) > 0}">
			<c:forEach items="${meList }" var="ml">
				<div class="harvest">
					<h4>${ml.paincbuyProjectName }</h4>
					<div>恭喜您场主，您${ml.paincbuyProjectName }的猪猪就要"出栏"了，请于<em><fmt:formatDate value="${ml.overTime}" pattern='yyyy-MM-dd' /></em>前选择回报方式！</div>
					<a href="<%=basePath %>wpv/orchooseRepayType?queryProjectId=${ml.paincbuyProjectId}&ml.endModifyTime=${fmtTime}">选择回报方式</a>
				</div>
			</c:forEach>
		</c:if>-->
			<%--
		<c:if test="${projectMap == null || projectMap.type eq 'next' }">
				下一期：${projectMap.project.name }
    			倒计时：${projectMap.leftTime }
    			<div>
					<p>标题：${bulletin.title }</p>
					<p>${bulletin.content }</p>
				</div>
  		</c:if>
			--%>
	</div>
	<jsp:include page="./footer.jsp">
		<jsp:param value="10001" name="pageIndex"/>
	</jsp:include>
	<script src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
    <script src="<%=basePath %>resources/js/draggabilly.pkgd.min.js"></script>
    <script src="<%=basePath %>resources/js/myJs.js"></script>
     <script src="<%=basePath %>resources/js/layer/layer.js" ></script>
    <script src="<%=basePath %>resources/js/time.js" ></script>
	<script type="text/javascript">
		$(function () {
	
			var num = ${(dataMap.totalNum == null || dataMap.totalNum <= 0) ? 0 : dataMap.totalNum};
		    var pigs = CreatePig(num > 10 ? 10 : num);
		});
		if(${bulletin != null}){
			$(function(){
				var height_ = 220,
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
					'border-radius':'5px'//修改layer最外层容器样式
				});
			});
		}
		if(${meList != null && fn:length(meList) > 0}){
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
				    //content: $(".yubiao_notice") 	//调预抢弹窗
				    content: $('.harvest')			//调成猪出售弹窗
				}); 
				layer.style(index,{
					'border-radius':'5px'//修改layer最外层容器样式
				});
			});
		}
	</script>
</body>
</html>
