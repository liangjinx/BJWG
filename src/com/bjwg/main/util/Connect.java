package com.bjwg.main.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class Connect {

	//请求网站资源返回字符串
	public static String getUrlString(String url) {
		String result = null;
        try {
	        URL getUrl = new URL(url);
	        HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
	        connection.connect();
	        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));
	        result = reader.readLine();
	        reader.close();
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
	}
	
	/**
	 * 发送http get请求
	 * @param paramsValue
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public static String get(String urlWithParams) throws Exception{
		try {
			HttpGet httpGet = new HttpGet(urlWithParams);
			RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(30000).setConnectTimeout(30000).build();//设置请求和传输超时时间30秒
			httpGet.setConfig(requestConfig);
			CloseableHttpResponse  response = HttpClients.createDefault().execute(httpGet);
			//通信成功
			if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
				HttpEntity entity = response.getEntity();  
		        BufferedReader reader = new BufferedReader(new InputStreamReader(entity.getContent(), "UTF-8"));  
		        String line = null,result = "";  
		        while ((line = reader.readLine()) != null) {
		        	result += line;
		        } 
		        EntityUtils.consume(entity);
		        return result;
			}else{
				throw new Exception(response.getStatusLine().getStatusCode()+"");
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
	/**
	 * 发送http post请求
	 * @param paramsValue
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public static String post(List<NameValuePair> paramsValue,String url) throws Exception{
		try {
			HttpPost httpPost = new HttpPost(url);
			httpPost.setEntity(new UrlEncodedFormEntity(paramsValue,"UTF-8"));
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
		        return result;
			}else{
				throw new Exception(response.getStatusLine().getStatusCode()+"");
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
	
	/**
	 * 发送http post请求(请求类型为json)
	 * @param json
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public static String post(JSONObject json,String url) throws Exception{
		try {
			HttpPost httpPost = new HttpPost(url);
			StringEntity s = new StringEntity(json.toString(),"UTF-8");    
			s.setContentType("application/json");    
			httpPost.setEntity(s);
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
		        return result;
			}else{
				throw new Exception(response.getStatusLine().getStatusCode()+"");
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
	
	public static void main(String[] args) {
		
	}	
}
