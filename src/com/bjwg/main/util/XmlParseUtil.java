package com.bjwg.main.util;

import net.sf.json.JSONObject;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * xml数据解析工具
 * 
 * @author Allen
 * @version 创建时间：2015-6-13 上午09:40:26
 * @Modified By:Administrator Version: 1.0 jdk : 1.6 类说明：
 */
public class XmlParseUtil {

	/**
	 * 解析支付宝异步通知回来的xml数据
	 * 
	 * @return
	 */
	public static JSONObject parseAlipayNotifyData(String xml) {

		JSONObject object = new JSONObject();

		if (StringUtils.isNotEmpty(xml)) {

			try {

				Document document = DocumentHelper.parseText(xml);
				Element root = document.getRootElement();

				Element e = null;
				for (int i = 0; i < root.elements().size(); i++) {
					e = (Element)root.elements().get(i);
					object.put(e.getName(), e.getText());
					ConsoleUtil.println(e.getText());
				}

			} catch (DocumentException e) {
				e.printStackTrace();
			}

		}

		return object;
	}
	/**
	 * 解析支付宝异步通知回来的xml数据
	 * 
	 * @return
	 */
	public static JSONObject parseAlipayNotifyData(Document document) {
		
		JSONObject object = new JSONObject();
		
		if (document != null) {
			
			try {
				
				Element root = document.getRootElement();
				Element e = null;
				for (int i = 0; i < root.elements().size(); i++) {
					e = (Element)root.elements().get(i);
					object.put(e.getName(), e.getText());
					ConsoleUtil.println(e.getName()+"-"+e.getText());
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		return object;
	}

	public static void main(String[] args) {
		String xml = "<notify_data><notify>" +
						"<payment_type>1</payment_type>" +
						"<subject>收银台{1283134629741}</subject>" +
						"<trade_no>2014040311001004370000361525</trade_no>" +
						"<buyer_email>dinglang@a.com</buyer_email>" +
						"<gmt_create>2010-08-3010:17:24</gmt_create>" +
						"<notify_type>trade_status_sync</notify_type>" +
						"<quantity>1</quantity>" +
						"<out_trade_no>1283134629741</out_trade_no>" +
						"<notify_time>2010-08-3010:18:15</notify_time>" +
						"<seller_id>2088101000137799</seller_id>" +
						"<trade_status>TRADE_FINISHED</trade_status>" +
						"<is_total_fee_adjust>N</is_total_fee_adjust>" +
						"<total_fee>1.00</total_fee>" +
						"<gmt_payment>2010-08-3010:18:26</gmt_payment>" +
						"<seller_email>chenf003@yahoo.cn</seller_email>" +
						"<gmt_close>2010-08-3010:18:26</gmt_close>" +
						"<price>1.00</price>" +
						"<buyer_id>2088102001172352</buyer_id>" +
						"<notify_id>509ad84678759176212c247c46bec05303</notify_id>" +
						"<use_coupon>N</use_coupon>" +
						"<refund_status>REFUND_SUCCESS</refund_status>" +
						"<gmt_refund>2008-10-2919:38:25</gmt_refund>" +
					"</notify></notify_data>";
//		parseAlipayNotifyData(xml);
		try {
			Document document = DocumentHelper.parseText(xml);
			parseAlipayNotifyData(document);
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
