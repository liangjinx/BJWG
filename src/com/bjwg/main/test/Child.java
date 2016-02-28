package com.bjwg.main.test;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContextBuilder;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import com.bjwg.main.util.ConsoleUtil;


/**
 * @author chen
 * @version 创建时间：2015-4-3 下午04:56:27
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public class Child {

	public static void main(String[] args) throws Exception {
		
//		ConsoleUtil.println(java.net.URLEncoder.encode("http://m.hzd.com/index/indexhome",   "utf-8"));
//		
//		ConsoleUtil.println(java.net.URLEncoder.encode("http://m.hzd.com/index/indexhome",   "utf-8"));
//		
//		ConsoleUtil.println(java.net.URLEncoder.encode("http://m.hzd.com/download.jsp",   "utf-8"));
		
		ConsoleUtil.println(java.net.URLEncoder.encode("http://wx.hzd.com/index/indexhome",   "utf-8"));
		
		//通过code获取access_token
		/*{
			"access_token":"OezXcEiiBSKSxW0eoylIeKwK92Gl8VCuabif72YKlfWfG_bZc6cuuM3sOneXs_6uHW2m6p799ULdlc2y81rtVoYVWNWSdSzUbTx4fLbi4Ao11NbbYNi9bgEwEvIm36gRlbIXLv_KVkhuWVOaeKlaAw",
			"expires_in":7200,
			"refresh_token":"OezXcEiiBSKSxW0eoylIeKwK92Gl8VCuabif72YKlfWfG_bZc6cuuM3sOneXs_6uDC4SGaZc94QYQqCM1MGVntQjKngWYDohF8973fAYLyHdREE_hHG3KI0_uqKCafYycDnOjSyv4ApgN7foStNRKQ",
			"openid":"ookLxt3Zi8O3JVLRFS8vzLA6qOpQ",
			"scope":"snsapi_login",
			"unionid":"o1-vRsk2TihN92Vd6qZMoKbab1hY"
		}*/
		
		
		//refresh_token拥有较长的有效期（30天），当refresh_token失效的后，需要用户重新授权。
		/*{
			"openid":"ookLxt3Zi8O3JVLRFS8vzLA6qOpQ",
			"access_token":"OezXcEiiBSKSxW0eoylIeKwK92Gl8VCuabif72YKlfWfG_bZc6cuuM3sOneXs_6uHW2m6p799ULdlc2y81rtVoYVWNWSdSzUbTx4fLbi4Ao11NbbYNi9bgEwEvIm36gRlbIXLv_KVkhuWVOaeKlaAw",
			"expires_in":7200,
			"refresh_token":"OezXcEiiBSKSxW0eoylIeKwK92Gl8VCuabif72YKlfWfG_bZc6cuuM3sOneXs_6uDC4SGaZc94QYQqCM1MGVntQjKngWYDohF8973fAYLyHdREE_hHG3KI0_uqKCafYycDnOjSyv4ApgN7foStNRKQ",
			"scope":"snsapi_base,snsapi_login,"
		}*/ 
		
//		weixinLogin();
//		ConsoleUtil.println(getAccess_token());
//		String token = getAccess_token();
		getSCList4("br5iIkq3lPqeUnBEivFlrEPdtYfFNOLrDMIlbtn0vSoDVTAUXItpg8M1rrimYdmrPatUDnYTz1zu3zIvp_NJ0ULJuhdGxWdIfvKsMiW5f-Q");
		getSCList3("br5iIkq3lPqeUnBEivFlrEPdtYfFNOLrDMIlbtn0vSoDVTAUXItpg8M1rrimYdmrPatUDnYTz1zu3zIvp_NJ0ULJuhdGxWdIfvKsMiW5f-Q");
	}
	
	//微信公众平台   正式
	/**
	 * /**
	 * 正式服务器：
	 *  AppID(应用ID) wxbe1733e33bb01bdf
		AppSecret(应用密钥) 1ce5279bf60a1ac26a62c2e0da39c677
	
	 {
	    "button": [
	        {
	            "type": "view", 
	            "name": "进入好站点", 
	            "url": "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxbe1733e33bb01bdf&redirect_uri=http%3A%2F%2Fwx.hzd.com%2Findex%2Findexhome&response_type=code&scope=snsapi_userinfo&state=456525#wechat_redirect"
	        }, 
	        {
	            "type": "view", 
	            "name": "下载安卓版", 
	            "url": "http://wx.hzd.com/download.jsp"
	        },
	        {
	            "type": "view", 
	            "name": "下载IOS版", 
	            "url": "https://itunes.apple.com/cn/app/hao-zhan-dian/id955711957?mt=8"
	        }
	        
	    ]
	}
	 
	 */
	
	
	/*{
	    "button": [
	        {
	            "type": "view", 
	            "name": "进入", 
	            "url": "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx265a5bf049bf66c2&redirect_uri=http%3A%2F%2Ftestweixin.hzd.com%2Fwpnv%2Fixindex&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect"
	        }
	    ]
	}*/
	
	//微信登录使用
	/**

	    * 获得ACCESS_TOKEN

	    * 

	    * @Title: getAccess_token

	    * @Description: 获得ACCESS_TOKEN

	    * @param @return 设定文件

	    * @return String 返回类型

	    * @throws

	    */

	   public static  String getAccess_token() {
		   
		   //https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET
		   
	       String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="
	    	   
//	    	   + "wxbe1733e33bb01bdf"+ "&secret=" + "1ce5279bf60a1ac26a62c2e0da39c677";
	    	   
//	    	   		+ "wx265a5bf049bf66c2"+ "&secret=" + "ba255676aca99338070ad58c147471c9";//allen
	       
//	               + "wx61286443bbef2e4f"+ "&secret=" + "39e8756c4f915a4382d56c831298db91";
	    	   
//	    	   + "wx9a5a12d1ba093451"+ "&secret=" + "4efb57970246e5400807da215c184ec9";//chen
	    	   + "wxce3d8247538410d5"+ "&secret=" + "196beb080ea42eb7aa39007af5af74b2";//bjwg

	       String accessToken = null;

	       try {

	           URL urlGet = new URL(url);

	           HttpURLConnection http = (HttpURLConnection) urlGet

	                   .openConnection();

	           http.setRequestMethod("GET"); // 必须是get方式请求

	           http.setRequestProperty("Content-Type",

	                   "application/x-www-form-urlencoded");

	           http.setDoOutput(true);

	           http.setDoInput(true);

	           System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒

	           System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒

	           http.connect();

	           InputStream is = http.getInputStream();

	           int size = is.available();

	           byte[] jsonBytes = new byte[size];

	           is.read(jsonBytes);

	           String message = new String(jsonBytes, "UTF-8");

	           JSONObject demoJson = new JSONObject(message);

	           accessToken = demoJson.getString("access_token");

	           ConsoleUtil.println(accessToken);

	           is.close();

	       } catch (Exception e) {

	           e.printStackTrace();

	       }

	       return accessToken;

	   }
	
	
	public static String weixinLogin() throws Exception{
		
		 String appID = "wxbe0f33707b7dd3cf";
		 String appSecret = "9c95717ff6edf5b5a598aca0f38525fb";
		// 拼凑get请求的URL字串，使用URLEncoder.encode对特殊和不可见字符进行编码
//		String getURL = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=1pmWyVCJn0AL6BdWTFUumE73q_X4lJujpRpDkhkkqeDer8yquR7z-bHIOu_KQt0ZPkz5Ijiz48zx3W4Rkkb3kmxAP_xVHPUmlu5DKXQI2Pw&openid=OPENID";//"https://open.weixin.qq.com/connect/qrconnect?appid="+appID + "&redirect_uri=" + URLEncoder.encode("http://m.hzd.com", "utf-8") 
//				+"&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect";
		 
		 String getURL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx61286443bbef2e4f&secret=39e8756c4f915a4382d56c831298db91&code=code&grant_type=authorization_code";
		 
		 
        URL getUrl = new URL(getURL);
        // 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
        
        // 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
        HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
        // 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到
        // 服务器
        connection.connect();
        // 取得输入流，并使用Reader读取
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));//设置编码,否则中文乱码
        ConsoleUtil.println("=============================");
        ConsoleUtil.println("Contents of get request");
        ConsoleUtil.println("=============================");
        String lines;
        while ((lines = reader.readLine()) != null){
        	lines = new String(lines.getBytes(), "utf-8");
            ConsoleUtil.println(lines);
        }
        reader.close();
        // 断开连接
        connection.disconnect();
        ConsoleUtil.println("=============================");
        ConsoleUtil.println("Contents of get request ends");
        ConsoleUtil.println("=============================");
		
		return "";
	}
	
	
	//获取素材列表
	public static  String getSCList(String accessToken) {
		   
		try {
			
			List<NameValuePair> paramsValue =new ArrayList<NameValuePair>();
			
//			paramsValue.add(new BasicNameValuePair("type", "news"));
//			paramsValue.add(new BasicNameValuePair("access_token", accessToken));
//			paramsValue.add(new BasicNameValuePair("offset", "0"));
//			paramsValue.add(new BasicNameValuePair("count", "0"));
			JSONObject object = new JSONObject();
	        object.put("type", "news");
//	        object.add(new BasicNameValuePair("access_token", accessToken));
	        object.put("offset", 0);
	        object.put("count", 0);
			
			
			String url =  "https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token=" + accessToken;
			HttpPost httpPost = new HttpPost(url);
//			httpPost.setEntity(new UrlEncodedFormEntity(paramsValue,"UTF-8"));
			
//			HttpEntity entity1 = new StringEntity(object.toString()); 
			HttpEntity entity1 = new StringEntity("{\"type\":\"news\",\"offset\":0,\"count\":0}"); 
			httpPost.setEntity(entity1);
			
			RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(30000).setConnectTimeout(30000).build();//设置请求和传输超时时间30秒
			httpPost.setConfig(requestConfig);
			CloseableHttpResponse  response = HttpClients.createDefault().execute(httpPost);
			//通信成功
			if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
				HttpEntity entity = response.getEntity();  
				BufferedReader reader = new BufferedReader(new InputStreamReader(entity.getContent(), "UTF-8"));  
				String line = null,result = "";  
				while ((line = reader.readLine()) != null) {
					result += line;
				} 
				EntityUtils.consume(entity);
				ConsoleUtil.println("拉取素材信息："+result);
				return result;
			}else{
				throw new Exception(response.getStatusLine().getStatusCode()+"");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//获取素材列表
	public static  void getSCList2(String accessToken) throws Exception{
		
        
      //创建连接
        URL url = new URL("https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token="+accessToken);
        HttpURLConnection connection = (HttpURLConnection) url
                .openConnection();
        connection.setDoOutput(true);
        connection.setDoInput(true);
        connection.setRequestMethod("POST");
        connection.setUseCaches(false);
        connection.setInstanceFollowRedirects(true);
        connection.setRequestProperty("Content-Type",
                "application/x-www-form-urlencoded");

        connection.connect();

        //POST请求
        DataOutputStream out = new DataOutputStream(
                connection.getOutputStream());
        
        JSONObject object = new JSONObject();
        object.put("type", "news");
        object.put("offset", 0);
        object.put("count", 0);

        out.writeBytes(object.toString());
        out.flush();
        out.close();

        //读取响应
        BufferedReader reader = new BufferedReader(new InputStreamReader(
                connection.getInputStream()));
        String lines;
        StringBuffer sb = new StringBuffer("");
        while ((lines = reader.readLine()) != null) {
            lines = new String(lines.getBytes(), "utf-8");
            sb.append(lines);
        }
        System.out.println("拉取素材信息："+sb);
        reader.close();
        // 断开连接
        connection.disconnect();
	}
	//获取素材列表
	public static  void getSCList3(String accessToken) throws Exception{
		
		
		String media_id = null;  
	    String url = "https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token=" + accessToken;  
	    JSONObject object = new JSONObject();
        object.put("type", "news");
        object.put("offset", "0");
        object.put("count", "0");
	      SSLContextBuilder builder = new SSLContextBuilder();  
	        builder.loadTrustMaterial(null, new TrustSelfSignedStrategy());  
	        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(  
	                builder.build(),SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);  
	        CloseableHttpClient client = HttpClients.custom().setSSLSocketFactory(  
	                sslsf).build();  
	    HttpPost httpPost = new HttpPost(url);  
	    StringEntity params = new StringEntity(object.toString(),"UTF-8");  
	    httpPost.setEntity(params);  
	    CloseableHttpResponse httpResponse = null;  
	    try {  
	        httpResponse = client.execute(httpPost);  
	        HttpEntity entity = httpResponse.getEntity();  
	        String jsonString = EntityUtils.toString(entity);  
//	        net.sf.json.JSONObject fromObject = net.sf.json.JSONObject.fromObject(jsonString);  
//	        Object media_idObject = fromObject.get("media_id");  
//	        if (media_idObject != null) {  
//	            media_id = media_idObject.toString();  
//	        }  
	        System.out.println("获取视频的media_id-返回值： "  
	                + jsonString);  
	    } catch (UnsupportedEncodingException e) {  
	        e.printStackTrace();  
	    } catch (ClientProtocolException e) {  
	        e.printStackTrace();  
	    } catch (IOException e) {  
	        e.printStackTrace();  
	    } finally {  
	        if(httpResponse != null){  
	            httpResponse.close();  
	        }  
	        if(client != null){  
	            client.close();  
	        }  
	    }  
	}
	
	
	/**
	 */
	public static void getSCList4(String accessToken) throws Exception{
			try {
				
				//这块是用来处理如果上传的类型是video的类型的
				JSONObject object=new JSONObject();
				object.put("type", "news");
			    object.put("offset", 0);
			    object.put("count", 0);
				
				// 拼装请求地址
				String uploadMediaUrl = "https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token=##ACCESS_TOKEN##";
				uploadMediaUrl = uploadMediaUrl.replace("##ACCESS_TOKEN##",
						accessToken);

				URL url = new URL(uploadMediaUrl);
				String result = null;
				String type="news"; //我这里写死
				/**
				 *  你们需要在这里根据文件后缀suffix将type的值设置成对应的mime类型的值
				 */
				HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("POST"); // 以Post方式提交表单，默认get方式
				con.setDoInput(true);
				con.setDoOutput(true);
				con.setUseCaches(false); // post方式不能使用缓存
				// 设置请求头信息
				con.setRequestProperty("Connection", "Keep-Alive");
				con.setRequestProperty("Charset", "UTF-8");
				
				// 设置边界,这里的boundary是http协议里面的分割符，不懂的可惜百度(http 协议 boundary)，这里boundary 可以是任意的值(111,2222)都行
				String BOUNDARY = "----------" + System.currentTimeMillis();
				con.setRequestProperty("Content-Type",
						"multipart/form-data; boundary=" + BOUNDARY);
				// 请求正文信息
				// 第一部分：
				
				StringBuilder sb = new StringBuilder();
				
				
				
				//这块是post提交type的值也就是文件对应的mime类型值
				sb.append("--"); // 必须多两道线 这里说明下，这两个横杠是http协议要求的，用来分隔提交的参数用的，不懂的可以看看http 协议头
				sb.append(BOUNDARY);
				sb.append("\r\n");
				sb.append("Content-Disposition: form-data;name=\"type\" \r\n\r\n"); //这里是参数名，参数名和值之间要用两次
				sb.append(type+"\r\n"); //参数的值
				
				//这块是上传video是必须的参数，你们可以在这里根据文件类型做if/else 判断
				sb.append("--"); // 必须多两道线
				sb.append(BOUNDARY);
				sb.append("\r\n");
//				sb.append("Content-Disposition: form-data;name=\"description\" \r\n\r\n");
				sb.append("Content-Disposition: form-data;name=\"\" \r\n\r\n");
				sb.append(object.toString()+"\r\n");
				
				/**
				 * 这里重点说明下，上面两个参数完全可以卸载url地址后面 就想我们平时url地址传参一样，
				 * http://api.weixin.qq.com/cgi-bin/material/add_material?access_token=##ACCESS_TOKEN##&type=""&description={} 这样，如果写成这样，上面的
				 * 那两个参数的代码就不用写了，不过media参数能否这样提交我没有试，感兴趣的可以试试
				 */
				
				sb.append("--"); // 必须多两道线
				sb.append(BOUNDARY);
				sb.append("\r\n");
				//这里是media参数相关的信息，这里是否能分开下我没有试，感兴趣的可以试试
//				sb.append("Content-Disposition: form-data;name=\"media\";filename=\""
//						+ fileName + "\";filelength=\"" + filelength + "\" \r\n");
				sb.append("Content-Type:application/octet-stream\r\n\r\n");
				System.out.println(sb.toString());
				byte[] head = sb.toString().getBytes("utf-8");
				// 获得输出流
				OutputStream out = new DataOutputStream(con.getOutputStream());
				// 输出表头
				out.write(head);
				// 文件正文部分
				// 结尾部分，这里结尾表示整体的参数的结尾，结尾要用"--"作为结束，这些都是http协议的规定
				byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
				out.write(foot);
				out.flush();
				out.close();
				StringBuffer buffer = new StringBuffer();
				BufferedReader reader = null;
				// 定义BufferedReader输入流来读取URL的响应
				reader = new BufferedReader(new InputStreamReader(
						con.getInputStream()));
				String line = null;
				while ((line = reader.readLine()) != null) {
					buffer.append(line);
				}
				if (result == null) {
					result = buffer.toString();
				}
				System.out.println(result);
				// 使用JSON-lib解析返回结果
				net.sf.json.JSONObject jsonObject = net.sf.json.JSONObject.fromObject(result);
				if (jsonObject.has("media_id")) {
					System.out.println("media_id:"+jsonObject.getString("media_id"));
				} else {
					System.out.println(jsonObject.toString());
				}
				System.out.println("json:"+jsonObject.toString());
			} catch (IOException e) {
				e.printStackTrace();
			} finally {

			}
		}
		
	/**
	 * 这里说下，在上传视频素材的时候，微信说不超过20M，我试了下，超过10M调通的可能性都比较小，建议大家上传视频素材的大小小于10M比交好
	 * @param accessToken
	 * @param file  上传的文件
	 * @param title  上传类型为video的参数
	 * @param introduction 上传类型为video的参数
	 */
	public void uploadPermanentMedia2(String accessToken,
			File file,String title,String introduction) throws Exception{
			try {
				
				//这块是用来处理如果上传的类型是video的类型的
				JSONObject j=new JSONObject();
				j.put("title", title);
				j.put("introduction", introduction);
				
				// 拼装请求地址
				String uploadMediaUrl = "http://api.weixin.qq.com/cgi-bin/material/add_material?access_token=##ACCESS_TOKEN##";
				uploadMediaUrl = uploadMediaUrl.replace("##ACCESS_TOKEN##",
						accessToken);

				URL url = new URL(uploadMediaUrl);
				String result = null;
				long filelength = file.length();
				String fileName=file.getName();
				String suffix=fileName.substring(fileName.lastIndexOf("."),fileName.length());
				String type="video/mp4"; //我这里写死
				/**
				 *  你们需要在这里根据文件后缀suffix将type的值设置成对应的mime类型的值
				 */
				HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("POST"); // 以Post方式提交表单，默认get方式
				con.setDoInput(true);
				con.setDoOutput(true);
				con.setUseCaches(false); // post方式不能使用缓存
				// 设置请求头信息
				con.setRequestProperty("Connection", "Keep-Alive");
				con.setRequestProperty("Charset", "UTF-8");
				
				// 设置边界,这里的boundary是http协议里面的分割符，不懂的可惜百度(http 协议 boundary)，这里boundary 可以是任意的值(111,2222)都行
				String BOUNDARY = "----------" + System.currentTimeMillis();
				con.setRequestProperty("Content-Type",
						"multipart/form-data; boundary=" + BOUNDARY);
				// 请求正文信息
				// 第一部分：
				
				StringBuilder sb = new StringBuilder();
				
				
				
				//这块是post提交type的值也就是文件对应的mime类型值
				sb.append("--"); // 必须多两道线 这里说明下，这两个横杠是http协议要求的，用来分隔提交的参数用的，不懂的可以看看http 协议头
				sb.append(BOUNDARY);
				sb.append("\r\n");
				sb.append("Content-Disposition: form-data;name=\"type\" \r\n\r\n"); //这里是参数名，参数名和值之间要用两次
				sb.append(type+"\r\n"); //参数的值
				
				//这块是上传video是必须的参数，你们可以在这里根据文件类型做if/else 判断
				sb.append("--"); // 必须多两道线
				sb.append(BOUNDARY);
				sb.append("\r\n");
				sb.append("Content-Disposition: form-data;name=\"description\" \r\n\r\n");
				sb.append(j.toString()+"\r\n");
				
				/**
				 * 这里重点说明下，上面两个参数完全可以卸载url地址后面 就想我们平时url地址传参一样，
				 * http://api.weixin.qq.com/cgi-bin/material/add_material?access_token=##ACCESS_TOKEN##&type=""&description={} 这样，如果写成这样，上面的
				 * 那两个参数的代码就不用写了，不过media参数能否这样提交我没有试，感兴趣的可以试试
				 */
				
				sb.append("--"); // 必须多两道线
				sb.append(BOUNDARY);
				sb.append("\r\n");
				//这里是media参数相关的信息，这里是否能分开下我没有试，感兴趣的可以试试
				sb.append("Content-Disposition: form-data;name=\"media\";filename=\""
						+ fileName + "\";filelength=\"" + filelength + "\" \r\n");
				sb.append("Content-Type:application/octet-stream\r\n\r\n");
				System.out.println(sb.toString());
				byte[] head = sb.toString().getBytes("utf-8");
				// 获得输出流
				OutputStream out = new DataOutputStream(con.getOutputStream());
				// 输出表头
				out.write(head);
				// 文件正文部分
				// 把文件已流文件的方式 推入到url中
				DataInputStream in = new DataInputStream(new FileInputStream(file));
				int bytes = 0;
				byte[] bufferOut = new byte[1024];
				while ((bytes = in.read(bufferOut)) != -1) {
					out.write(bufferOut, 0, bytes);
				}
				in.close();
				// 结尾部分，这里结尾表示整体的参数的结尾，结尾要用"--"作为结束，这些都是http协议的规定
				byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
				out.write(foot);
				out.flush();
				out.close();
				StringBuffer buffer = new StringBuffer();
				BufferedReader reader = null;
				// 定义BufferedReader输入流来读取URL的响应
				reader = new BufferedReader(new InputStreamReader(
						con.getInputStream()));
				String line = null;
				while ((line = reader.readLine()) != null) {
					buffer.append(line);
				}
				if (result == null) {
					result = buffer.toString();
				}
				// 使用JSON-lib解析返回结果
				net.sf.json.JSONObject jsonObject = net.sf.json.JSONObject.fromObject(result);
				if (jsonObject.has("media_id")) {
					System.out.println("media_id:"+jsonObject.getString("media_id"));
				} else {
					System.out.println(jsonObject.toString());
				}
				System.out.println("json:"+jsonObject.toString());
			} catch (IOException e) {
				e.printStackTrace();
			} finally {

			}
		}

}
