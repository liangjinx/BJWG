package com.bjwg.main.util;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.service.SysConfigService;

/** 
 * @ClassName: SMSUtil 
 * @Description: TODO短信接口工具类
 * @author Carter
 * @date 2015-4-14 下午04:11:32  
 */ 
public class SMSUtil
{
	
	public static final Logger  logger = LoggerFactory.getLogger("LOGISTICS-COMPONENT"); 
	
	/**
	 * @param mobilePhone
	 * @param str
	 * @throws HttpException
	 * @throws IOException
	 */
	public static boolean sendOne(String mobilePhone, String str) throws HttpException, IOException
	{
		String testProject = ToolKit.getInstance().getSingleConfig("test");
		
		
//		if("yes".equals(testProject)){
//			
//			ConsoleUtil.println("mobilePhone:" + mobilePhone+"	content："+str);
//			
//			return true;
//		}
		
		HttpClient httpClient = new HttpClient();
		httpClient.setConnectionTimeout(6*1000);

        String content=java.net.URLEncoder.encode(str, "utf-8");
        
        SysConfigService sysConfigService = (SysConfigService)SpringFactory.getBean("sysConfigServiceImpl");
        
        String sms_url = null;
        String sms_uid = null;
        String sms_auth = null;
        
        try {
			List<SysConfig> confList = sysConfigService.queryList(new ArrayList<String>(Arrays.asList(SysConstant.SMS_URL,SysConstant.SMS_UID,SysConstant.SMS_AUTH)));
			
			ConsoleUtil.println("testProject5--"+confList.size());
			for (SysConfig sysConfig : confList) {
				
				if(SysConstant.SMS_URL.equals(sysConfig.getCode())){
					sms_url = sysConfig.getValue();
				}else if(SysConstant.SMS_UID.equals(sysConfig.getCode())){
					sms_uid = sysConfig.getValue();
				}else{
					sms_auth = sysConfig.getValue();
				}
			}
			
//        	sms_uid = "800751";
//        	sms_url = "http://210.5.158.31/hy/";
//        	sms_auth = "a7801afbc644ee4c99b5a366151c1c3e";
			//ConsoleUtil.println("testProject6--"+sms_uid+"-"+sms_url+"-"+sms_auth);
			if("yes".equals(testProject)){
				
				if(StringUtils.isNotEmpty(sms_uid)){
				
					PostMethod postMethod = new PostMethod(sms_url);
					
					NameValuePair[] data = {
							new NameValuePair("uid", sms_uid),
							new NameValuePair("auth", sms_auth),
							new NameValuePair("mobile", mobilePhone),
							new NameValuePair("expid", "0"),
							new NameValuePair("msg",content ),
							new NameValuePair("encode","utf-8")};
					postMethod.setRequestBody(data);
					int statusCode = httpClient.executeMethod(postMethod);
					
					if (statusCode == HttpStatus.SC_OK) {
						String sms = postMethod.getResponseBodyAsString();
						ConsoleUtil.println("result:" + sms+"	phone："+mobilePhone);
						return sms.startsWith("0,");
					}
					ConsoleUtil.println("statusCode="+statusCode);	
				}
			}else{
				
				//String url = "http://222.73.117.158/msg/";// 应用地址
				//String account = "vipszrm";// 账号
				//String pswd = "Tch123456";// 密码
				//String mobile = "18665876989";// 手机号码，多个号码使用","分割
				//String msg = "亲爱的用户，您的验证码是123456，5分钟内有效。";// 短信内容
				boolean needstatus = true;// 是否需要状态报告，需要true，不需要false
				String product = null;// 产品ID
				String extno = null;// 扩展码
				
				try {
					String returnString = HttpSender.batchSend(sms_url, sms_uid, sms_auth, mobilePhone, str, needstatus, product, extno);
					ConsoleUtil.println("statusCode=" + returnString);	
					return true;
					// TODO 处理返回值,参见HTTP协议文档
				} catch (Exception e) {
					// TODO 处理异常
					e.printStackTrace();
				}
				
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取sms配置出错");
		}
		return false;
	}
	
	
	
	public static void main(String[] args) throws IOException {
		SMSUtil.sendOne("13164788105", "您的验证码为:1232");
		 
	}
} 