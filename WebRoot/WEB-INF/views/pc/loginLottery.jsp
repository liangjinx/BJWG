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
    <title>润民金融双11抽奖活动</title>

    <link href="<%=basePath %>resources/css/style.css" rel="stylesheet" type="text/css">
</head>

<script type="text/javascript">
    	function myfuncion(){
    		$.ajax({
			type : 'POST',
			url : 'Winning_list',
			dataType : 'json',
			cache : false,
			error : function() {
				// alert('出错了！'); 
				return false;
			},
			success : function(responseText) {
				 window.location.href = "indexLottery.jsp"; 
			}
		});
    	}
    	window.onload=myfuncion;
    	setInterval(refresh,100);

    	//只刷新一次
    	function refresh(){
    		url = location.href;
    		console.log(url);
   			 var once = url.split("#");
    		if (once[1] != 1) {
        	url += "#1";
        	self.location.replace(url);
        	window.location.reload();
    		}
		}
    </script>

<body>
<%
    HttpSession userSession = request.getSession();

    %>
${user_id}
<div class="body_content" style="background-image:url(<%=basePath %>resources/images/turnplate-bg.png);background-size:100% 100%;">
    <div class="header">
        <img src="<%=basePath %>resources/images/turnplate-logo.png" alt="">
    </div>

    <!--图片区-->
    <div class="ballon">
        <img src="<%=basePath %>resources/images/turnplate-balloon.png"/>
    </div>

    <div class="content">
        <!--抽奖区-->
        <div class="turnplate">
            <!--<div></div>-->
            <img id="lotteryBg" src="<%=basePath %>resources/images/turnplate-turnplate.png"/>
            <img id="lotteryBtn" src="<%=basePath %>resources/images/turnplate-btn.png"/>
        </div>
        <!--记录区-->
        <div class="user">
            
            <div class="user_welcome">
             	    <div class="user_welcome_input"> 
             	    	账号 : <input type="text" name="username" id="username">
             	    </div>
             	    <div class="divMsg" id="divMsg_phone"></div>
            		<div class="user_welcome_input">
            			密码 : <input type="password" name="password" id="password">
            		</div>
            		<div class="divMsg" id="divMsg_password"></div>
            		<div class="button">
            			<button id="login">登录</button>
            			<button id="reset">重置</button>
            		</div>
            		
            </div>
            <div class="user_record" id="breakNews">
                <p>中奖人员名单</p>
                <ul class="listContainer" id="breakNewsList">
                    <%
			    List list_phone=null;
			    List list_prize=null;
			    if(userSession.getAttribute("list_phone")!=null){  
			       list_phone = (List)session.getAttribute("list_phone");  
			       list_prize = (List)session.getAttribute("list_prize");
			       for(int i=0;i<list_phone.size() ;i++){  
			           out.print("<li>"+list_phone.get(i)+"&nbsp;&nbsp;&nbsp;&nbsp; "+list_prize.get(i)+"<li>"); 
			       }
			    }
			    %>
                </ul>
            </div>
        </div>
    </div>

    <div class="footer">
        <div class="turnplate_rule">
            <p class="title" style="padding-bottom: 10px;margin-left: 0px;font-size: 21px;line-height: 2.5;">抽奖规则</p>
            <p>(1)在八戒王国online平台上注册的所有新老用户都有一次抽奖机会。</p>
            <p>(2)10月19日至11月11日期间购买猪仔的用户，还有另外的抽奖机会，每购买一头猪仔有一次抽奖机会。例如，购买10头猪仔在（1）的基础上另有10次机会。</p>
            <p>(3)抽奖时间为11月11日当天。</p>
            <p>(4)本次活动100%中奖。</p>
            <p>(5)用户在11月11日当天，通过PC端和手机浏览器登陆八戒王国官方网站www.bajiewg.com，进入抽奖页面点击抽奖，即可获得抽奖码。抽奖码是唯一的兑奖凭证。</p>
            <p>(6)深圳地区用户抽中八戒王国特色公仔,可兑换500g八戒王国生态猪肉(冷鲜肉)。</p>
            <p>(7)深圳地区以外的用户抽中猪肉礼包，只能兑换八戒王国特色公仔。</p>
        </div>
        <div class="award_rule">
            <p class="title" style="padding-bottom: 10px;margin-left: 0px;font-size: 21px;line-height: 2.5;">奖项设置</p>
            <p>(1)"运气王"1名,可获得iPhone6s手机一部。</p>
            <p>(2)"运气王"2名,可获得iPad mini一台。</p>
            <p>(3)"幸运奖"(只限深圳地区),可获得润民生态猪肉礼包一份。</p>
            <style>
            	.award_rule table{
            		width: 60%; 
            		text-align: center; 
            		font-size:16px; 
            		color: white; 
            		margin-left:40px; 
            		border: 1px solid white;
            		border-collapse:collapse;  
					border-spacing:0;  
            	}
            	.award_rule tr{
            		width: 100%;
            		height: 32px;
            	}
            	.award_rule td{
            		border: 1px solid white;
            	}
            </style>
            <table>
            	<tr><td style="width: 28%">幸运奖</td><td>猪肉礼包</td></tr>
            	<tr><td>一等奖</td><td>1000g八戒王国生态猪肉（冷鲜肉）</td></tr>
            	<tr><td>二等奖</td><td>500g八戒王国生态猪肉（冷鲜肉）</td></tr>
            	<tr><td>三等奖</td><td>300g八戒王国生态猪肉（冷鲜肉）</td></tr>
            </table>
            
            <p>(4)"纪念奖",可获得八戒王国特色公仔一只，限量1000只。</p>
        </div>
        <div class="exchange_rule">
            <p class="title" style="padding-bottom: 10px;margin-left: 0px;font-size: 21px;line-height: 2.5;">兑奖方式</p>
            <p>(1)iPhone 6s、iPad mini：用户中奖后，八戒王国客服人员会致电用户，提醒用户已经中奖，同时登记相关中奖信息，确认无误后将奖品快递上门。</p>
            <p>(2)八戒王国特色公仔：非深圳地区用户，联系客服进行中奖信息登记，公司将奖品快递送货上门（免运费）；深圳地区用户请到公司领取，兑奖时出示抽奖码即可，若有需要可快递上门（需自行支付运费）。</p>
            <p>(3)猪肉礼包：用户提前一天联系八戒王国客服人员，登记预约，凭抽奖码到公司领取。（猪肉礼包目前仅限深圳地区用户领取）。</p>
        </div>
        <div class="time_rule">
            <p class="title" style="margin-left: 0px;font-size: 21px;line-height: 2.5;">兑奖时间</p>
            <p>以上奖品,兑奖时间为2015年11月13日至11月30日。</p>
        </div>
    </div>

    <div class="company_info">
        <p>八戒王国电脑端网址:<a href="http://www.bajiewg.com">http://www.bajiewg.com</a></p>
        <p>八戒王国商城网址:<a href="http://shop.szrunmin.com">http://shop.szrunmin.com</a></p>
        <p>如有任何疑问,请联系八戒王国客户,电话为 :  0755-8357 9888 &nbsp;QQ : 805767304</p>
        <p>活动最终解释权归八戒王国所有</p>
    </div>
</div>
</body>
<script src="<%=basePath %>resources/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/js/jQueryRotate.2.2.js" type="text/javascript"></script>
<script src="<%=basePath %>resources/js/textScroll.js" type="text/javascript"></script>
<script>
    var scroll2 = new ScrollText("breakNewsList","pre2","next2",true,70,true);
    scroll2.LineHeight = 24;
</script>

<script type="text/javascript">
	$(function() {
		$("#lotteryBtn").click(function() {
			alert("您还没有登录，登录后便可以抽奖！");
		});
	});
	
	//回车触发登录事件
	$(document).ready(function(){ 
		$("#password").keydown(function(e){ 
		var curKey = e.which; 
		if(curKey == 13){ 
			login();
			return false; 
			} ;
		});
		$("#username").keydown(function(e){ 
		var curKey = e.which; 
		if(curKey == 13){ 
			login();
			return false; 
			};
		});  
		$("#username").focus();
	}); 
	
	$(function() {
		//重置按钮事件
		$("#reset").click(function() {
			$("#username").val("");
			$("#password").val("");
			$(".divMsg").empty();
		});
		//登录按钮事件
		$("#login").click(function() {
			login();
		});
	});
	
	
	function login(){
	//清空div内容
		$(".divMsg").empty();
		
		if(!checkMobile($("#username").val())){
			return false;
		}
		if(!checkPassword($("#password").val())){
			return false;
		}
		
		$.ajax({
				type:"post",
				url:'LoginServlet',
				data:"username="+$("#username").val()+"&password="+$("#password").val(),
				success:function(responseText){
	
					if(responseText=="True"){
		
						 window.location.href="indexLottery.jsp";
					}else if(responseText=="phone_no_exist"){
						$("#divMsg_phone").show().html("账号不存在");
						$("#username").focus();
					}else if(responseText=="password_error"){
						$("#divMsg_password").show().html("密码错误");
						$("#password").focus();
					}else if(responseText=="password_null"){
						$("#divMsg_password").show().html("密码为空");
						$("#password").focus();
					}else if(responseText=="phone_null"){
						$("#divMsg_phone").show().html("账号为空");
						$("#username").focus();
					}
				}
			});
	
	}
	//手机验证
	function checkMobile(str) {
	    var re = /^[1][3,4,5,7,8][0-9]{9}$/;
	    if (!re.test(str)) {
	       $("#divMsg_phone").show().html("请输入正确的手机号");
	       $("#username").focus();
	       return false;
	    }
	    return true;
	}
  	//密码验证
    function checkPassword(str){
	    var re = /^[0-9a-zA-Z]{6,16}$/;
	    if(!re.test(str)){
	    	$("#divMsg_password").show().html("请输入6-16位的字母、数字或符号");
	    	$("#password").focus();
	        return false;
	    }
	    return true;          
	}
</script>
</html>