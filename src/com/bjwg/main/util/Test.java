/*package com.bjwg.main.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;

*//**
 * @author Allen
 * @version 创建时间：2015-9-25 下午05:31:53
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 *//*

public class Test
{
    public static final String GET_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";// 获取access
    public static final String UPLOAD_IMAGE_URL = "";// 上传多媒体文件
    public static final String UPLOAD_FODDER_URL = "https://api.weixin.qq.com/cgi-bin/media/uploadnews";
    public static final String GET_USER_GROUP = "https://api.weixin.qq.com/cgi-bin/groups/get"; // url
    public static final String SEND_MESSAGE_URL = "https://api.weixin.qq.com/cgi-bin/message/mass/sendall";
    public static final String APP_ID = "wxa549b28c24cf341e";
    public static final String SECRET = "78d8a8cd7a4fa700142d06b96bf44a37";


    *//**
     * 发送消息
     * 
     * @param uploadurl
     *            apiurl
     * @param access_token
     * @param data
     *            发送数据
     * @return
     *//*
    public static String sendMsg(String url, String token, String data)
    {
        org.apache.commons.httpclient.HttpClient client = new org.apache.commons.httpclient.HttpClient();
        String sendurl = String.format("%s?access_token=%s", url, token);
        PostMethod post = new PostMethod(sendurl);
        post
                .setRequestHeader(
                        "User-Agent",
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:30.0) Gecko/20100101 Firefox/30.0");

        post.setRequestHeader("Host", "file.api.weixin.qq.com");
        post.setRequestHeader("Connection", "Keep-Alive");
        post.setRequestHeader("Cache-Control", "no-cache");
        String result = null;
        try
        {
            post.setRequestBody(data);
            int status = client.executeMethod(post);
            if (status == HttpStatus.SC_OK)
            {
                String responseContent = post.getResponseBodyAsString();
                System.out.println(responseContent);
                JsonParser jsonparer = new JsonParser();// 初始化解析json格式的对象
                JsonObject json = jsonparer.parse(responseContent)
                        .getAsJsonObject();
                if (json.get("errcode") != null
                        && json.get("errcode").getAsString().equals("0"))
                {
                    result = json.get("errmsg").getAsString();
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            return result;
        }
    }

    public static void main(String[] args) throws Exception
    {
        String accessToken = getToken(GET_TOKEN_URL, APP_ID, SECRET);// 获取token在微信接口之一中获取
        if (accessToken != null)// token成功获取
        {
            System.out.println(accessToken);
            File file = new File("f:" + File.separator + "2000.JPG"); // 获取本地文件
            String id = uploadImage(UPLOAD_IMAGE_URL, accessToken, "image",
                    file);// java微信接口之三—上传多媒体文件 可获取
            if (id != null)
            {
                 // 构造数据
                 Map map = new HashMap();
                 map.put("thumb_media_id", id);
                 map.put("author", "wxx");
                 map.put("title", "标题");
                 map.put("content", "测试fdsfdsfsdfssfdsfsdfsdfs");
                 map.put("digest", "digest");
                 map.put("show_cover_pic", "0");
 
                 Map map2 = new HashMap();
                 map2.put("thumb_media_id", id);
                 map2.put("author", "wxx");
                 map2.put("content_source_url", "");
                 map2.put("title", "标题");
                 map2.put("content", "测试fdsfdsfsdfssfdsfsdfsdfs");
                 map2.put("digest", "digest");
 
                 Map map3 = new HashMap();
                 List<Map> list = new ArrayList<Map>();
                 list.add(map);
                 list.add(map2);
                 map3.put("articles", list);
 
                 Gson gson = new Gson();
                 String result = gson.toJson(map3);// 转换成json数据格式
                 String mediaId = uploadFodder(UPLOAD_FODDER_URL, accessToken,
                         result);
                 if (mediaId != null)
                 {
                     String ids = getGroups(GET_USER_GROUP, accessToken);// 在java微信接口之二—获取用户组
                     if (ids != null)
                     {
                         String[] idarray = ids.split(",");// 用户组id数组
                         for (String gid : idarray)
                         {
                             
                             JsonObject jObj = new JsonObject();
                             JsonObject filter = new JsonObject();
                             filter.addProperty("group_id", gid);
                             jObj.add("filter", filter);
  
  
                             JsonObject mpnews = new JsonObject();
                             mpnews.addProperty("media_id", mediaId);
                             jObj.add("mpnews", mpnews);
  
                             jObj.addProperty("msgtype", "mpnews"); 
                             System.out.println(jObj.toString());
 
                             String result2 = sendMsg(SEND_MESSAGE_URL,
                                     accessToken, jObj.toString());
                             System.out.println(result2);
                         }
                     }
                 }
 
             }
         }
     }
 }
*/