<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="banner_box">
	<div class="center">
    	<div class="f_left banner_left">
    	<a class="banner_a f_left"  href="javascript:;" onclick="AddFavorites('“八戒王国”不一样的猪场','http://www.bajiewg.com/');return false;">
    		<img src="resources/images/pc/collect.png" alt="收藏" title="收藏"/>
    	</a>
        <a class="banner_a f_left" href="http://weibo.com/5207751727/profile?topnav=1&wvr=6" target="_blank">
        	<img src="resources/images/pc/micro_blog.png" alt="微博" title="微博"/>
        </a>
        <a class="banner_a f_left" href="http://wpa.qq.com/msgrd?v=3&amp;uin=805767304&amp;site=qq&amp;menu=yes" target="_blank">
        	<img src="resources/images/pc/qq.png?p=2:961864966" alt="点击qq咨询" title="点击qq咨询"/>
        </a>
        <a class="banner_a f_left" id="wechat_code">
			<img src="resources/images/pc/wechat_img.png" alt="微信" />
        	<div class="banner_code_box wechat_code_box">
	         	<div class="code_tit"><img src="resources/images/pc/code_tit.png" alt="tel:0755-83579888"/></div>
	            <div class="code_box">
	            	<img src="resources/images/pc/wx_gong.png" alt="微信公众号"/>
	                <div class="code_main z_font_box">
						<p class="code_main_p">扫描二维码<br><span class="z_font">八戒王国online</span></p>
						<!-- <p class="code_main_span">Android   iPhone   iPad</p> -->
					</div>
	            </div>
            </div>
        </a>
        <a class="banner_phone"><img src="resources/images/pc/phone_img.png" class="f_left"><span>0755-8357&nbsp;9888</span></a>
        </div>
        <div class="f_right banner_right">       
        <a class="banner_a f_right" id="code_but_box"><img src="resources/images/pc/code_img.png" alt="二维码" title=""/>
        	
        	<div class="banner_code_box">
         	<div class="code_tit"><img src="resources/images/pc/code_tit.png" alt=""/></div>
            <div class="code_box">
            	<img src="resources/images/pc/wx_gong.png" alt="二维码"/>
                <div class="code_main"><p class="code_main_p">扫描二维码<br>直接下载APP</p><p class="code_main_span">Android   iPhone   iPad</p></div>
            </div>
            </div>
        </a>        
        <a class="banner_a f_right"><span>手机下载</span></a>
        <!--<script type="text/javascript">
        	alert('${sessionScope[CommConstant.SESSION_MANAGER] }');
        </script>
        --><c:choose>
        	<c:when test="${sessionScope[CommConstant.SESSION_MANAGER] == null or sessionScope[CommConstant.SESSION_MANAGER]=='session_manager'}">
        		<a class="banner_a f_right" href="pc/pnv/regPage"><span>注册</span></a>
        		<a class="banner_a f_right" href="pc/pnv/loginPage"><span>登录</span></a>  
        	</c:when>
        	<c:otherwise>
        		<span class="z_after_login f_right">欢迎您, ${sessionScope[CommConstant.SESSION_MANAGER].nickname}&nbsp;&nbsp;<a href="pc/pnv/login_out" class="z_logout">退出登录</a>&nbsp;&nbsp;</span>
        	</c:otherwise>
        </c:choose>   
       </div>
        <div class="clear"></div>
    </div>
    <script type="text/javascript" src="http://v2.jiathis.com/code/jia.js" charset="utf-8"></script>
</div>
<!--<script src="resources/js/jquery-1.11.1.min.js"></script>
-->
<script>
	//收藏
	function AddFavorites(title, url) {
        try {
              window.external.addFavorite(url, title);
              }
        catch (e) {
            try {
                   window.sidebar.addPanel(title, url, "");
            }
            catch (e) {
                 alert("抱歉，您所使用的浏览器无法完成此操作。\n\n加入收藏失败，请使用Ctrl+D进行添加");
            }
          }
	}
</script>