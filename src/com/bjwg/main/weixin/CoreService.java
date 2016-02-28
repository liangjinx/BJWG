package com.bjwg.main.weixin;  
  
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.MyUtils;
  
/** 
 * 核心服务类 
 *  
 * @author liufeng 
 * @date 2013-05-20 
 */  
@Service
public class CoreService {  
    /** 
     * 处理微信发来的请求 
     *  
     * @param request 
     * @return 
     */  
    public static Map<String, String> processRequest(HttpServletRequest request) {  
    	
    	Map<String, String> resultMap = new HashMap<String, String>();
        String respMessage = null;  
        String type = "xml";  
        try {  
            // 默认返回的文本消息内容  
            String respContent = "";//"请求处理异常，请稍候尝试！";  
  
            // xml请求解析  
            Map<String, String> requestMap = MessageUtil.parseXml(request);  
  
            if(!MyUtils.isMapEmpty(requestMap)){
            	
            	// 发送方帐号（open_id）  
            	String fromUserName = requestMap.get("FromUserName");  
            	// 公众帐号  
            	String toUserName = requestMap.get("ToUserName");  
            	// 消息类型  
            	String msgType = requestMap.get("MsgType");  
            	
            	// 回复文本消息  
            	TextMessage textMessage = new TextMessage();  
            	textMessage.setToUserName(fromUserName);  
            	textMessage.setFromUserName(toUserName);  
            	textMessage.setCreateTime(new Date().getTime());  
            	textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);  
            	textMessage.setFuncFlag(0);  
            	
            	// 文本消息  
            	if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_TEXT)) {  
            		respContent = "您发送的是文本消息！";  
            	}  
            	// 图片消息  
            	else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_IMAGE)) {  
            		respContent = "您发送的是图片消息！";  
            	}  
            	// 地理位置消息  
            	else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LOCATION)) {  
            		respContent = "您发送的是地理位置消息！";  
            	}  
            	// 链接消息  
            	else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LINK)) {  
            		respContent = "您发送的是链接消息！";  
            	}  
            	// 音频消息  
            	else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_VOICE)) {  
            		respContent = "您发送的是音频消息！";  
            	}  
            	// 事件推送  
            	else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {  
            		// 事件类型  
            		String eventType = requestMap.get("Event");  
            		// 订阅  
            		if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {  
            			respContent = "感谢您的关注，因微信功能开发需要，此公众号喜迁新址，请入住新居--HZD好站点，给您带来不便请谅解。 " ;//"谢谢您的关注！";  
            		}  
            		// 取消订阅  
            		else if (eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) {  
            			// TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息  
            		}  
            		// 自定义菜单点击事件  
            		else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {  
            			// TODO 自定义菜单权没有开放，暂不处理该类消息  
            			
            			//定位信息
            		}else if(eventType.equalsIgnoreCase(MessageUtil.REQ_MESSAGE_TYPE_LOCATION)){
            			
            			type = MessageUtil.REQ_MESSAGE_TYPE_LOCATION;
            			resultMap.put("longtitude", requestMap.get("Longitude"));
            			resultMap.put("latitude", requestMap.get("Latitude"));
            			resultMap.put("open_id", fromUserName);
            		}  
            	}  
            	
            	if(type.equals("xml")){
            		
            		textMessage.setContent(respContent);  
            		respMessage = MessageUtil.textMessageToXml(textMessage);
            		resultMap.put("respMessage", respMessage);
            		ConsoleUtil.println("转换成xml格式的数据："+respMessage);
            	}
            	
            	resultMap.put("type", type);
            }
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
  
        return resultMap;  
    }  
}  