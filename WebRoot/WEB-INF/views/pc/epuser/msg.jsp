<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="__page_name__" value="站内信" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<jsp:include page="../meta.jsp"></jsp:include>
<link rel="stylesheet" href="resources/css/pc/base.css"/>
<link rel="stylesheet" href="resources/css/pc/main.css"/>
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/pc/public.js"></script>
<style>
.paging{  float: right; margin-right: 15px;}
</style>
<script type="text/javascript">
    	$(function(){
    		$('.delMsg').click(function(){
    		var r=confirm("确认删除?");
			if(r){
				$('#messageId').val($(this).parent().attr('data-msg'));
    			$('#form').attr('action',__base_path__+'pc/pv/user/msgDel').submit();
			}
    		});
    		
    		$('.btnPsnAllDelete').click(function(){
    		var r=confirm("确认全部删除?");
			if(r){
				$('#messageId').val('');
    			$('#form').attr('action',__base_path__+'pc/pv/user/msgDel').submit();
			}
    		})
    	})
</script>
</head>
<body class="body_bg">
<input type="hidden" name="cnav" value="${param.cnav }"/>
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
	<jsp:param value="6" name="nav"/>
</jsp:include>
<!--mypig_left_nav -->
<div class="right_main">
	<div class="my_pig_tit bg_f6"><!--my_pig_tit -->
    	<img src="resources/images/pc/nav_tit_bg.png" alt="" class="my_pig_tit_bg" alt="系统消息" />
        <div class="pig_tit" id="letter_tit_but"><p>系统消息</p></div>
        <div class="pig_tit pig_tit2" id="pig_system_but"><p>猪场公告</p></div>
    </div><!--my_pig_tit -->
<div class="mypig_body">

<div class="letter_system"><!--letter_system -->
	<form id="form" method="post" action="">
    	<input type="hidden" id="messageId" name="messageId" value=""/>
    </form>
	<div class="basicinfo_ts m_top30"><p class="p_16">Hi~你一共收到了${msgCount}条系统消息，请注意查看。如遇到问题，请拨打八戒王国online官方电话 0755-83579888。<a class="delete_all_but btnPsnAllDelete">删除全部</a></p></div>
	<ul class="letter_ul">
		<c:forEach items="${msgList}" var="msg">
			<li data-msg="${msg.messageId}">
        		<img src="resources/images/pc/letter1.png" alt="站内信" class="letter_img"/>
            	<div class="p_tit">${msg.content}</div>
            	<a class="letter_but delMsg"></a>
            	<div class="p_time"><fmt:formatDate value="${msg.ctime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
        	</li>
        </c:forEach>
    </ul>
    <c:if test="${pager_msg.pageCount>0 }">
    	<jsp:include page="../pager.jsp">
			<jsp:param name="pagerConfigArg" value="pager_msg"/>
			<jsp:param name="otherQueryArg" value="cnav=psn"/>
		</jsp:include>
	</c:if>
</div><!--letter_system -->
<div class="pig_system"><!--pig_system -->
	<div class="basicinfo_ts m_top30"><p class="p_16">Hi~你一共收到了${bulletinCount}条猪场公告，请注意查看。如遇到问题，请拨打八戒王国online官方电话 0755-83579888。<!--<a class="delete_all_but">删除全部</a></p>--></div>
	<ul class="letter_ul">
		<c:forEach items="${bulletinList}" var="bulletin">
			<li>
        		<img src="resources/images/pc/letter1.png" alt="站内信" class="letter_img"/>
            	<div class="p_tit z_msg_h30">${bulletin.title }</div>
            	<div class="p_time">
            		<div class="z_msg_lcon"> ${bulletin.content}</div>
            		<div class="z_msg_rcon"><fmt:formatDate value="${bulletin.ctime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
            	</div>
        	</li>
        </c:forEach>
    </ul>
    <c:if test="${pager_blt.pageCount>0 }">
    	<jsp:include page="../pager.jsp">
			<jsp:param name="pagerConfigArg" value="pager_blt"/>
			<jsp:param name="otherQueryArg" value="cnav=blt"/>
		</jsp:include>
	</c:if>
</div><!--pig_system -->  
   
   
<div class="clear"></div>   
</div><!--mypig_body -->    

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
	$('#pig_system_but').click(function(){	
		$('.my_pig_tit_bg').animate({'left':'185px'},0);	
		$('.letter_system').css('display','none');
		$('.pig_system').css('display','block');
		$('.my_pig_tit .pig_tit').css('color','#333');
		$(this).css('color','#fff');		
		
		})
	$('#letter_tit_but').click(function(){	
		$('.my_pig_tit_bg').animate({'left':'0px'},0);	
		$('.pig_system').css('display','none');
		$('.letter_system').css('display','block');
		$('.my_pig_tit .pig_tit').css('color','#333');
		$(this).css('color','#fff');		
		
		})
		
	/*$('.letter_but').click(function(){
		$(this).parent().remove();
		})*/
		if($('[name=cnav]').val()=='psn'){
			$('#letter_tit_but').trigger('click');
		}
		if($('[name=cnav]').val()=='blt'){
			$('#pig_system_but').trigger('click');
		}
	})
</script>
</html>









<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>系统消息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<script language="JavaScript" src="<%=basePath %>resources/js/jquery-1.11.1.min.js"></script>
  </head>
  
  <body>
    <h3>系统消息</h3>
    <a href="pv/user/bulletin">查看猪场公告</a>
    <form id="form" method="post" action="">
    	<input type="hidden" id="messageId" name="messageId" value=""/>
    </form>
    <div>
    	<c:forEach items="${msgList}" var="msg">
    		<div data-msg="${msg.messageId}">
    			<div>id: ${msg.messageId}</div>
    			<div>time: <fmt:formatDate value="${msg.ctime}" pattern="yyyy-MM-dd hh:mm:ss"/></div>
    			<div>status: ${msg.status}</div>
    			<div>content: ${msg.content}</div>
    			<a href="javascript:;" class="delMsg">删除</a>
    		</div>
    		<hr>
    	</c:forEach>
    </div>
    <script type="text/javascript">
    	$(function(){
    		$('.delMsg').click(function(){
    			$('#messageId').val($(this).parent().attr('data-msg'));
    			$('#form').attr('action','pv/user/msgDel').submit();
    		})
    	})
    </script>
  </body>
</html>
--%>