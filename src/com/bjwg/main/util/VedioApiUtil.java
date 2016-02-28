package com.bjwg.main.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.StatusConstant.Status;

/**
 * @author Allen
 * @version 创建时间：2015-10-15 下午07:46:22
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public class VedioApiUtil {

	
	public static Map<String, Object> getVedioMap() throws Exception{
		
		
		JSONObject json = new JSONObject();
		
		JSONObject sysJson = new JSONObject();
		
		//随机整数数值
		String id = RandomUtils.getNum(6);
		
		json.put("id", id);
		
		List<NameValuePair> paramsValue = new ArrayList<NameValuePair>();
		
		//id
		paramsValue.add(new BasicNameValuePair("id", id));
		
		String key = ToolKit.getInstance().getSingleConfig("YS_web_key");
		
		paramsValue.add(new BasicNameValuePair("appKey", key));
		
	    String time = null;
	    
	    Status status = Status.success;
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    
		try {
			//1、请求萤石服务器获取时间戳
			time = Connect.post(paramsValue, ToolKit.getInstance().getSingleConfig("YS_get_time_api_url"));
			
			ConsoleUtil.println(">>请求萤石服务器获取时间戳返回数据："+time);
			
			//2、解析返回值，获取时间戳
			JSONObject object = JSONObject.fromObject(time);
			
			JSONObject result = object.getJSONObject("result");
			
			String code = result.getString("code");
			
			if("200".equals(code)){
				
				JSONObject data = result.getJSONObject("data");
				
				if(data.containsKey("serverTime")){
					
					time = data.getLong("serverTime")+"";
				}else{
					
					status = Status.requestYSGetTimeFail;
				}
				
				ConsoleUtil.println("解析数据获得到的时间戳为："+time);
			}
			
		} catch (Exception e1) {
			
			e1.printStackTrace();
			
			status = Status.requestYSGetTimeFail;
			
		}
		
		if(StringUtils.isNotEmpty(time)){
			
			//sign加密规则：
			/*
			{   
			 "id": "123456",
			    "system": {
			        "key": "116622259fed4920a3e8957e13dc2346",
			        "sign": "8845c7ad6066c9cf1df170afd7dd5f06",
			        "time": 1415843917,
			        "ver": "1.0"
			    },
			    "method": " squareVideoListByUser",
				"params": {      
					"pageStart":"0",
					"pageSize":"2"
			    }
			}
			说明："params"内的参数按字母排序后以逗号分隔开，拼接上method、time、secret即可，如下所示：
				sign=md5(“accessToken:f88c4dbb354711c9bf6597a4987dce90,deviceId:123456789,phone:18899998888,
						userId:ghhc4dbb354711c9bf6597a4987dce90,method:getDevice,time:1404443389,secret:yuc4dbb354sdsdfj77d76lkd86”)
			*/
			String sign = MD5.GetMD5Code("pageSize:10,pageStart:0,method:squareVideoListByUser,time:"+time+",secret:"+ToolKit.getInstance().getSingleConfig("YS_web_secretkey"));
			
			sysJson.put("key", key);
			
			sysJson.put("sign", sign);
			
			sysJson.put("time", time);
			
			sysJson.put("ver", "1.0");
			
			json.put("system", sysJson);
			
			json.put("method", "squareVideoListByUser");
			
			JSONObject paramsJson = new JSONObject();
			
			paramsJson.put("pageStart", "0");
			
			paramsJson.put("pageSize", "10");
			
			json.put("params", paramsJson);
			
			ConsoleUtil.println(json.toString());
			
			String url = ToolKit.getInstance().getSingleConfig("YS_api_url");
			
			try {
				
				//3、请求获取视频列表信息
				String s = Connect.post(json, url);
				
				ConsoleUtil.println(">>请求萤石服务器获取视频信息返回结果："+s);
				
				JSONObject result = JSONObject.fromObject(s).getJSONObject("result");
				
				if("200".equals(result.getString("code"))){
					
					JSONArray dataArr =  result.getJSONArray("data");
					
					if(dataArr.size() > 0){
						
						Pages pages = new Pages();
						
						JSONObject pageObj = result.getJSONObject("page");
						
						pages.setPerRows(2);
						
						pages.setCurrentPage(pageObj.getInt("page"));
						
						pages.setCountRows(pageObj.getInt("total"));
						
						List<JSONObject> list = JSONArray.toList(dataArr);
						
						pages.setRoot(list);
						
						map.put("pages", pages);
						
					}
					
				}
				
			} catch (Exception e) {
				
				e.printStackTrace();
				
				status = Status.requestYSVedioListFail;
			}
			
		}
		map.put("status", status);
		
		return map;
	}
	
	
	public static void main(String[] args) throws Exception{
		
		VedioApiUtil.getVedioMap();
	}
}
