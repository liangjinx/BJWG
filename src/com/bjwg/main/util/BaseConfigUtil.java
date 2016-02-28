package com.bjwg.main.util;


import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;


public class BaseConfigUtil {

	private static final String base_path = "/com/bjwg/main/config/project_config.xml";
	
	
	
	public static Map<String, List<String>> getConfigInfo(){
		
		try{
			
			ConsoleUtil.println(">>>>开始加载project_config.xml文件");
			
			InputStream inputStream = BaseConfigUtil.class.getResourceAsStream(base_path);
			
			SAXReader reader = new SAXReader();
			
			Document document = reader.read(inputStream);
			
			return getConfigInfo(document);
			
		}catch(Exception e){
			e.printStackTrace();
			ConsoleUtil.println("获取配置文件出错:"+e);
		}
		
		return null;
		
	}



	private static Map<String, List<String>> getConfigInfo(Document document) {
		
		Map<String, List<String>> configMap = new HashMap<String, List<String>>();
		try{
			
//			List<Node> list = document.selectNodes("//configInfo/info");
			
			Element element = document.getRootElement();
			
			List<String> list = null;
			String key = null;
			for(Element l : (List<Element>)element.elements()){
				
				key = l.attributeValue("name");
				if(configMap.containsKey(key)){
					configMap.get(key).add(l.attributeValue("value"));
					configMap.get(key).add(l.attributeValue("title"));
				}else{
					list = new ArrayList<String>();
					list.add(l.attributeValue("value"));
					list.add(l.attributeValue("title"));
					configMap.put(key, list);
				}
				
			}
			
			ConsoleUtil.println(">>>>加载project_config.xml文件结束");
			
		}catch(Exception e){
			
			ConsoleUtil.println("解析配置文件出错:"+e);
		}
		
		return configMap;
	}
	
	
	public static void main(String[] args) throws Exception{
	
		
		BaseConfigUtil.getConfigInfo();
		
		
	}
	
}
