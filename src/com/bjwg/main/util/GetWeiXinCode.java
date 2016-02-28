package com.bjwg.main.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.bjwg.main.constant.LoginConstants;

/**
 * @author chen
 * @version 创建时间：2015-4-14 上午11:22:06
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：获取微信的code 
 */

public class GetWeiXinCode {
	
	//第三方发起微信授权登录请求，微信用户允许授权第三方应用后，微信会拉起应用或重定向到第三方网站，并且带上授权临时票据code参数
     public static String  GetCodeRequest = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect"; 
     /**
      * 获取code
      * @return
      */
         public static String getCodeRequest(){ 
   
             String result = null; 

//             GetCodeRequest  = GetCodeRequest.replace("APPID", urlEnodeUTF8(LoginConstants.appId)); 
//   
//             GetCodeRequest  = GetCodeRequest.replace("REDIRECT_URI",urlEnodeUTF8(LoginConstants.REDIRECT_URI)); 
//   
//             GetCodeRequest = GetCodeRequest.replace("SCOPE", LoginConstants.SCOPE); 
//   
             result = GetCodeRequest; 

             return result; 

         } 
   
         /**
          * 重定向地址，需要进行UrlEncode
          * @param str
          * @return
          */
         public static String urlEnodeUTF8(String str){ 
   
             String result = str; 

             try { 

                 result = URLEncoder.encode(str,"UTF-8"); 

             } catch (Exception e) { 

                 e.printStackTrace(); 
             } 
             return result; 
         } 
     
     /**
      * 处理
      * @param url
      * @return
      */
     public static String getUrl(String url){
         String result = null;
         try {
             // 根据地址获取请求
        	 URL getUrl = new URL(url);// 拼凑get请求的URL字串，使用URLEncoder.encode对特殊和不可见字符进行编码
        	// 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
        	// 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
        	 HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
        	 // 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到
             // 服务器
        	 connection.connect();
        	 // 取得输入流，并使用Reader读取
        	 BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));//设置编码,否则中文乱码
             
        	 result = reader.readLine();
        	 //打印
        	 /*while ((lines = reader.readLine()) != null){
              	lines = new String(lines.getBytes(), "utf-8");
                  ConsoleUtil.println(lines);
              }*/
        	 reader.close();
             // 断开连接
             connection.disconnect();
         } catch (Exception e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
         }
         return result;
     }
     
     public static void main(String[] args) throws Exception { 

         ConsoleUtil.println(getCodeRequest()); 
         
 		String getURL = "https://api.weixin.qq.com/sns/userinfo?access_token=OezXcEiiBSKSxW0eoylIeKwK92Gl8VCuabif72YKlfWfG_bZc6cuuM3sOneXs_6uHW2m6p799ULdlc2y81rtVoYVWNWSdSzUbTx4fLbi4Ao11NbbYNi9bgEwEvIm36gRlbIXLv_KVkhuWVOaeKlaAw&openid=ookLxt3Zi8O3JVLRFS8vzLA6qOpQ";//"https://open.weixin.qq.com/connect/qrconnect?appid="+appID + "&redirect_uri=" + URLEncoder.encode("http://m.hzd.com", "utf-8") 
 				//+"&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect";
 		ConsoleUtil.println(getUrl(getURL));
         

     } 
         
}
