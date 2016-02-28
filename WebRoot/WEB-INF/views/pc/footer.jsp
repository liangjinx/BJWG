<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="footer_box">
	<div class="center">
    	 	<div class="footer_gz"><span>合作伙伴：</span>
    	 	</div>
    	 	
            <div class="footer_nav">
            	<a class="footer_logo"><img src="resources/images/pc/logo_img01.png" alt="logo"/></a>
                <p class="footer_nav_p">
                	<a href="pc/pnv/products">产品介绍</a><span>|</span>	
                	<a href="pc/pnv/inShopping">抢猪仔</a><span>|</span>
                	<a href="pc/pnv/realFarm">实时猪场</a><span>|</span>
                	
                	<c:if test="${empty path}">
	<a href="pc/pv/user/farm">我的猪场</a><span>|</span>      
	     </c:if>
           <c:if test="${!empty path}">
	<a href="pc/pv/epuser/farm">我的猪场</a><span>|</span>          
	 </c:if>
                	
                	
                	
                	
                	
                	<a href="pc/pnv/news">资讯导航</a><span>|</span>
                	<a href="pc/pnv/about">关于润民</a><span>|</span>
               <a href="javascript:void(0)">   <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
         document.write(unescape("%3Cspan id='cnzz_stat_icon_1256855228'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s95.cnzz.com/stat.php%3Fid%3D1256855228' type='text/javascript'%3E%3C/script%3E"));
         </script>  </a>
                </p>
                <br/>   <br/>
                   <br/>   <br/>   <br/>
                
                
              <span class="self_code"> 友情链接：<a href="http://www.wangdaishan.com/zt/" target="_blank">个人理财</a> &nbsp;&nbsp;&nbsp;&nbsp;
         <a href="http://www.yuanyoushe.com" target="_blank">原油论坛</a> &nbsp;&nbsp;&nbsp;&nbsp;
         <a href="http://yuanyoushe.com" target="_blank">原油社</a>  &nbsp;&nbsp;&nbsp;&nbsp; 
        <a href="http://www.hitaodao.com" target="_blank">海淘岛</a> &nbsp;&nbsp;&nbsp;&nbsp; 
     <a href="http://www.gxcfw.com.cn/" target="_blank">港信创富</a>&nbsp;&nbsp;&nbsp;&nbsp; 
   <a href="http://www.gxcfw.com.cn/" target="_blank">全球网站库</a>
              </span> 
              
              
               <!--  <p class="copyright">Copyright©2004-2015&nbsp;&nbsp;&nbsp;八戒王国online版权所有</p> -->
                <div class="clear"></div>
            </div>                      
        </div><!--footer_left -->
         <img src="resources/images/pc/wx_gong.png" alt="润民八戒王国公众号" class="footer_code"/><span class="footer_code3">关<br/>注<br/>我<br/>们</span>
          
      <div class="footer_code2">
        	<div class="footer_gz">
        	
            <!-- <a style="margin-left:40px;" href="http://weibo.com/5207751727/profile?topnav=1&wvr=6" target="_blank" ><img src="resources/images/pc/micro_blog2.png" /></a> -->
            <!-- <a><img src="resources/images/pc/wechat_img2.png"/></a> -->
            <!-- <a href="http://t.qq.com/bajiewgol?preview" target="_blank"><img src="resources/images/pc/collect2.png"/></a> -->
         
            <a style="margin-left:40px;" href="http://weibo.com/5207751727/profile?topnav=1&wvr=6" target="_blank" class="footer_gz_img footerimg1"></a>
            <a href="http://t.qq.com/bajiewgol?preview" target="_blank" class="footer_gz_img footerimg3"></a>
            <div class="clear"></div>
            </div> 
         
        
		
          


    
    	<div class="clear" > </div>        
    </div>
</div>
<div class="footer_banner">
	<div class="center">
    	<p><span class="copy_p">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copyright&nbsp;©&nbsp;2015 深圳润民互联网生态农业科技有限公司 All&nbsp;rights&nbsp;reserved.粤ICP备15081145号-1</span>
    <!--    <a href="LoginServlet">这，就是爱</a> -->
		<div class="clear"></div>    
    </div>
</div>
 