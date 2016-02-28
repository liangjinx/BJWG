package com.bjwg.main.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.bjwg.main.constant.StatusConstant.Status;

public class JsonUtils {
	
	public static JSONArray create() {
		
		return null;
	}
	
	//construct json and output it	
	public static String jsonTest(int status, String msg, JSONObject jsonObject, JSONArray jsonArray) throws JSONException{
		JSONObject json=new JSONObject();
		JSONArray jsonMembers = new JSONArray();
		JSONObject member1 = new JSONObject();
		member1.put("loginname", "zhangfan");
		member1.put("password", "userpass");
		member1.put("email","10371443@qq.com");
		member1.put("sign_date", "2007-06-12");
		jsonMembers.put(member1);
		
		json.put("status", status);
		json.put("msg", msg);
		if(jsonArray==null)
			json.put("data", jsonObject);
		if(jsonObject==null)
			json.put("data", jsonArray);

		return json.toString();
	}
	
	//construct json from String and resolve it.
	public String jsonTest2() throws JSONException{
		String jsonString="{\"users\":[{\"loginname\":\"zhangfan\",\"password\":\"userpass\",\"email\":\"10371443@qq.com\"},{\"loginname\":\"zf\",\"password\":\"userpass\",\"email\":\"822393@qq.com\"}]}";
		JSONObject json= new JSONObject(jsonString);
		JSONArray jsonArray=json.getJSONArray("users");
		String loginNames="loginname list:";
		for(int i=0;i<jsonArray.length();i++){
			JSONObject user=(JSONObject) jsonArray.get(i);
			String userName=(String) user.get("loginname");
			if(i==jsonArray.length()-1){
				loginNames+=userName;
			}else{
				loginNames+=userName+",";
			}
		}
		return loginNames;
	}

	
	
	/**
	 * 取得一个json对象
	 * @param status
	 * @param msg
	 * @param data
	 * @return
	 * @throws JSONException
	 */
	public static JSONObject getJsonObject(int status,String msg,Object data)
	{
		JSONObject jsonObject=new JSONObject();
		try
		{
			jsonObject.put("status", status)
							.put("msg", msg);
			
			JSONObject text = new JSONObject();
			text.put("text", data);
			
			jsonObject.put("data", text);
			
			
		} catch (JSONException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return jsonObject;
	}
	
	/**
	 * 取得一个json对象
	 * @param jsonResult
	 * @return
	 * @throws JSONException
	 */
	public static JSONObject getJsonObject(Status jsonResult)
	{
		int status=jsonResult.getStatus();
		
		String code=jsonResult.getCode();
		
		String msg=jsonResult.getMsg();
		
		return getJsonObject(status,code,msg);
	}
	
	/**
	 * 取得一个json对象
	 * @param jsonResult
	 * @param data
	 * @return
	 * @throws JSONException
	 */
	public static JSONObject getJsonObject(Status jsonResult,Object data) throws JSONException
	{
		int status=jsonResult.getStatus();
		
		String code=jsonResult.getCode();
		
		return getJsonObject(status,code,data);
	}
	
	/**
	 * 封装json对象
	 * @param jsonResult
	 * @param data
	 * @return
	 * @throws JSONException
	 */
	public static void getJsonObject(Status jsonResult,JSONObject obj) throws JSONException
	{
		int status=jsonResult.getStatus();
		
		String code=jsonResult.getCode();
		
		String msg=jsonResult.getMsg();
		
		JSONObject text = new JSONObject();
		
		text.put("text", msg);
		
		obj.put("status", status).put("msg", code).put("data", text);
		
	}
	
	
	/**
	 * 将jdbc查询结果的字段名格式化为小写
	 * @param map
	 * @return
	 */
	public static Map<String, Object> keyToLowerCase(Map<String, Object> map)
	{
		if(map==null)return null;
		Map<String, Object> result=new HashMap<String, Object>();
		
		Iterator<Entry<String, Object>> iterator = map.entrySet().iterator();
		while(iterator.hasNext())
		{
			Entry<String, Object> entry=iterator.next();
			result.put(entry.getKey().toLowerCase(), entry.getValue());
		}
		return result;
	}
	
	/**
	 * 将jdbc查询结果的字段名格式化为小写
	 * @param obj
	 * @return
	 */
	public static List<Map<String, Object>> keyToLowerCase(List<Map<String, Object>> list)
	{
		if(list==null)return null;
		List<Map<String, Object>> result=new ArrayList<Map<String,Object>>();
		for(Map<String, Object> map: list)
		{
			result.add(keyToLowerCase(map));
		}
		return result;
	}

}


















