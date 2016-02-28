<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>润民金融双11抽奖活动后台列表</title>

    <link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
   		 HttpSession userSession = request.getSession();
    %>
		
<div style="width: 80%; height: auto; margin: 0 auto; font-size: 16px; text-align: center;">
<style>
	.table tr{
		width: 100%;
		height: 36px;
	}
	.table td{
		border-bottom: 1px solid white;
	}
</style>
	<table class="table">
		<%
		 List list_prize=null;
		 if(userSession.getAttribute("list_prize")!=null){
		 	List list_record_id = (List)session.getAttribute("list_record_id");
			list_prize = (List)session.getAttribute("list_prize");
			List list_exchange_code = (List)session.getAttribute("list_exchange_code");
			List list_time = (List)session.getAttribute("list_time");
			List list_type = (List)session.getAttribute("list_type");
			out.print("<tr>"); 
				out.print("<td width='10%'><b>奖品名字</b></td>"); 
				out.print("<td width='20%'><b>兑换码</b></td>"); 
				out.print("<td width='25%'><b>抽奖时间</b></td>"); 
				out.print("<td width='10%'><b>是否兑换奖？</b></td>");
				out.print("<td width='25%'><b>兑换时间</b></td>");  
				out.print("<td width='10%'><b>操作</b></td>");
				
			out.print("</tr>"); 
			for(int i=0;i<list_prize.size() ;i++){ 
			int id = (Integer)list_record_id.get(i); 
			out.print("<tr>");  
				out.print("<td width='10%'>"+id+list_prize.get(i)+"</td>"); 
				out.print("<td width='20%'>"+list_exchange_code.get(i)+"</td>"); 
				out.print("<td width='25%'>"+list_time.get(i)+"</td>");
				String istype = "";
				if((Integer)list_type.get(i) == 0){
					istype = "未兑换";
				}else if((Integer)list_type.get(i) == 1){
					istype = "已兑换";
				}
				out.print("<td width='10%'>"+istype+"</td>");
				out.print("<td width='25%'>"+/* list_time.get(i) */"</td>");
				out.print("<td width='10%'><a href='exchange?record_id="+id+"'>已兑换</a></td>");  
				
			out.print("</tr>");  
			
			}
		}
		%>
	</table>
</div>

</body>

</html>