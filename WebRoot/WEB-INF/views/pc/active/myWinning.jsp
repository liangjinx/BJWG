<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="__page_name__" value="查询奖号" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/public.css"/>

	<style>
	.active_div{
	width:1200px;
	height:500px;
background:url(<%=basePath%>/resources/images/pc/active_back.png);
   margin-left:16%;
	background-repeat: no-repeat;

}

.active_div h1{
	text-align: center;	
}
	
		#showT{
		color:white;
		
		}
        
        td{
          font-size:20px;
        width: 30px;
        }
        #titalc{
        font-size:20px;
        width:220px;
        }
    </style>
    
     <script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<script src="resources/js/pc/active.js"></script>
<script>
	
</script>
    
</head>
<body>

	<!--banner_box -->
	<jsp:include page="../header.jsp"></jsp:include>
	<!--banner_box -->
	<!--导航栏-->
	<jsp:include page="../nav.jsp">
		<jsp:param value="6" name="nav"/>
	</jsp:include>

<div id="indexDiv" class="active_div">

<h1><img src="resources/images/pc/active_text.png" alt="活动主题"/></h1>
   <div id="showT">
    <c:if test="${empty myWinningCode1}">
      您还未购买抢猪头抽奖号码
    
    
    </c:if>
   <c:if test="${!empty myWinningCode1}">
       
         <table>
          <tr>
          <td id="titalc"> 您抢猪头的中奖编号为:</td>
         <c:forEach items="${myWinningCode1}" var="code">
          
             <td>${code.orderId}</td> &nbsp;    &nbsp;       
       </c:forEach>
        </tr>
         </table>
 
   </c:if>
     <c:if test="${empty myWinningCode2}">
      您还未购买抢猪腿抽奖号码
    
    
    </c:if>
   <c:if test="${!empty myWinningCode2}">
       
         <table>
          <tr>
          <td id="titalc"> 您抢猪腿的中奖编号为:</td>
         <c:forEach items="${myWinningCode2}" var="code">
          
             <td>${code.orderId}</td> &nbsp;    &nbsp;       
       </c:forEach>
        </tr>
         </table>
 
   </c:if>
</div>
</div>	

	<jsp:include page="../footer.jsp"></jsp:include>

</body>

</html>