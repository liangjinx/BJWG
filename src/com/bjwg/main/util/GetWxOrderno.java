package com.bjwg.main.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

/**
 * 获取微信预订单id
 * @ClassName: GetWxOrderno 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Administrator
 * @date 2015-6-13 下午05:19:13
 */
public class GetWxOrderno {
	public static DefaultHttpClient httpclient;

	static {
		httpclient = new DefaultHttpClient();
		httpclient = (DefaultHttpClient) HttpClientConnectionManager.getSSLInstance(httpclient);
	}

	@SuppressWarnings({ "unused", "rawtypes" })
	public static String getPayNo(String url, String xmlParam) {
		DefaultHttpClient client = new DefaultHttpClient();
		client.getParams().setParameter(ClientPNames.ALLOW_CIRCULAR_REDIRECTS, true);
		HttpPost httpost = HttpClientConnectionManager.getPostMethod(url);
		String prepay_id = "";
		try {
			httpost.setEntity(new StringEntity(xmlParam, "UTF-8"));
			HttpResponse response = httpclient.execute(httpost);
			String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");
			Map<String, Object> dataMap = new HashMap<String, Object>();
			ConsoleUtil.println("---------------\n获取预付款订单号："+jsonStr+"，请求参数："+xmlParam);

			Map map = doXMLParse(jsonStr);
			if (jsonStr.indexOf("FAIL") != -1) {
				String return_code = (String) map.get("return_code");
				String result_code = (String) map.get("result_code");
				String err_code = (String) map.get("err_code");
				if(StringUtils.isEmptyNo(result_code) || result_code.indexOf("FAIL") > -1){
					prepay_id = "error_"+err_code;
				}
				return prepay_id;
			}
			prepay_id = (String) map.get("prepay_id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		ConsoleUtil.println(">>获取微信预付款订单号："+prepay_id);
		return prepay_id;
	}

	/**
	 * 解析xml,返回第一级元素键值对。如果第一级元素有子节点，则此节点的值是子节点的xml数据。
	 * 
	 * @param strxml
	 * @return
	 * @throws JDOMException
	 * @throws IOException
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Map doXMLParse(String strxml) throws Exception {
		if (null == strxml || "".equals(strxml)) {
			return null;
		}

		Map m = new HashMap();
		InputStream in = String2Inputstream(strxml);
		SAXBuilder builder = new SAXBuilder();
		Document doc = builder.build(in);
		Element root = doc.getRootElement();
		List list = root.getChildren();
		Iterator it = list.iterator();
		while (it.hasNext()) {
			Element e = (Element) it.next();
			String k = e.getName();
			String v = "";
			List children = e.getChildren();
			if (children.isEmpty()) {
				v = e.getTextNormalize();
			} else {
				v = getChildrenText(children);
			}

			m.put(k, v);
		}

		// 关闭流
		in.close();

		return m;
	}

	/**
	 * 获取子结点的xml
	 * 
	 * @param children
	 * @return String
	 */
	@SuppressWarnings("rawtypes")
	public static String getChildrenText(List children) {
		StringBuffer sb = new StringBuffer();
		if (!children.isEmpty()) {
			Iterator it = children.iterator();
			while (it.hasNext()) {
				Element e = (Element) it.next();
				String name = e.getName();
				String value = e.getTextNormalize();
				List list = e.getChildren();
				sb.append("<" + name + ">");
				if (!list.isEmpty()) {
					sb.append(getChildrenText(list));
				}
				sb.append(value);
				sb.append("</" + name + ">");
			}
		}

		return sb.toString();
	}

	public static InputStream String2Inputstream(String str) {
		return new ByteArrayInputStream(str.getBytes());
	}

	public static void main(String[] args) throws Exception {
		Map<String,String> map = GetWxOrderno.doXMLParse("<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[appid and openid not match]]></return_msg></xml>");
		for (Map.Entry<String,String> m : map.entrySet()) {
			
			ConsoleUtil.println(m.getKey()+"--"+m.getValue());
		}
	}
}