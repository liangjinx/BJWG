package com.bjwg.main.test;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import net.sf.json.JSONObject;

import com.bjwg.main.cache.ProvalueCache;
import com.bjwg.main.model.Provalue;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.util.Json;

public class Sign {
	private String url;
//	ProvalueService service;
	SysConfigService service;
	
	public Sign( String theUrl, SysConfigService sysConfigService) {
		url = theUrl;
//		service = provalueService;
		service = sysConfigService;
	}

	
	public Map<String, String> getVal() throws Exception {
		String[] wxs = service.queryWxAppidAndAppKey();
		String jsapi_ticket = getTicket(wxs);
		String token = getToken(wxs);
        Map<String, String> ret = sign(jsapi_ticket, url, token);
        ret.put("appid", wxs[0]);
        ret.put("appSecret", wxs[1]);
        return ret;
	}
	
    public String getTicket(String[] wxs) throws Exception {
    	String ticket = "";
    	
    	//查询有无记录
    	//有记录就获取时间进行对比
//    	Provalue provalue_t = service.findProName("wxjssdk_ticket");
    	Provalue provalue_t = ProvalueCache.getProvalue("wxjssdk_ticket");
    	if(provalue_t!=null) {
    		long ctime = provalue_t.getCtime().getTime();
    		long theTime = new Date().getTime();
    		if(theTime - ctime < 7000000) { //有效期内直接返回
    			return provalue_t.getProValue();
    		}
    	}
    	
    	//重新请求
		String getTicketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token="+getToken(wxs);
    	String ticketString = getJsonString(getTicketUrl);
    	JSONObject ticketJson = Json.string2json(ticketString);
        ticket = ticketJson.getString("ticket");
        	
        //查找有无此条记录
        if(provalue_t == null) {
//        	Provalue provalue = new Provalue();
//        	provalue.setCtime(new Date());
//        	provalue.setProName("wxjssdk_ticket");
//        	provalue.setProValue(ticket);
//        	service.save(provalue);
        	ProvalueCache.put("wxjssdk_ticket", ticket, new Date(),"wxjssdk_ticket");
        } else { //如果有记录就更新
//        	provalue_t.setCtime(new Date());
//        	provalue_t.setProValue(ticket);
//        	service.update(provalue_t);
        	
        	ProvalueCache.put("wxjssdk_ticket", ticket, new Date(),"wxjssdk_ticket");
        }
		return ticket;
	}
    
    public String getToken(String[] wxs) throws Exception {
    	String token = "";
    	
    	//查询有无记录
    	//有记录就获取时间进行对比
//    	Provalue provalue2 = service.findProName("wxjssdk_token");
    	Provalue provalue2 = ProvalueCache.getProvalue("wxjssdk_token");
    	if(provalue2!=null) {
    		long ctime = provalue2.getCtime().getTime();
    		long theTime = new Date().getTime();
    		if(theTime - ctime < 7000000) { //有效期内直接返回
    			return provalue2.getProValue();
    		}
    	}
    	
    	
    	
    	//重新请求
		String getTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+wxs[0]+"&secret="+wxs[1];
    	String tokenString = getJsonString(getTokenUrl);
    	JSONObject tokenJson = Json.string2json(tokenString);
    	token = tokenJson.getString("access_token");
        	
        //查找有无此条记录
        if(provalue2 == null) {
//        	Provalue provalue = new Provalue();
//        	provalue.setCtime(new Date());
//        	provalue.setProName("wxjssdk_token");
//        	provalue.setProValue(token);
//        	service.save(provalue);
        	ProvalueCache.put("wxjssdk_token", token, new Date(),"wxjssdk_token");
        } else { //如果有记录就更新
//        	provalue2.setCtime(new Date());
//        	provalue2.setProValue(token);
//        	service.update(provalue2);
        	ProvalueCache.put("wxjssdk_token", token, new Date(),"wxjssdk_token");
        }
        	
        return token;
	}


	private static String getJsonString(String url) {
		String result = null;
        try {
	        URL getUrl = new URL(url);// 拼凑get请求的URL字串，使用URLEncoder.encode对特殊和不可见字符进行编码
	        HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
	        connection.connect();
	        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));//设置编码,否则中文乱码
	        result = reader.readLine();
	        reader.close();
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
	}
	

    public static Map<String, String> sign(String jsapi_ticket, String url, String token) {
        Map<String, String> ret = new HashMap<String, String>();
        String nonce_str = create_nonce_str();
        String timestamp = create_timestamp();
        String string1;
        String signature = "";

        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + jsapi_ticket +
                  "&noncestr=" + nonce_str +
                  "&timestamp=" + timestamp +
                  "&url=" + url;
        //ConsoleUtil.println(string1);

        try
        {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }
        
        ret.put("url", url);
        ret.put("jsapi_ticket", jsapi_ticket);
        ret.put("nonceStr", nonce_str);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);
        ret.put("token", token);
        
//        ConsoleUtil.println(url);

        return ret;
    }

    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }

    private static String create_nonce_str() {
        return UUID.randomUUID().toString();
    }

    private static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
}
