package com.bjwg.main.util;

import java.util.List;
import java.util.Map;
/**
 * 小工具类
 * 单例
 * @author :Allen  
 * @CreateDate : 2015-3-13 下午01:46:23 
 * @lastModified : 2015-3-13 下午01:46:23 
 * @version : 1.0
 * @jdk：1.6
 */
public class ToolKit {

	
	private static ToolKit instance;
	
	//缓存配置项
	private static Map<String, List<String>> configInfoMap;
	
	private ToolKit(){
		
		configInfoMap = BaseConfigUtil.getConfigInfo();
	}
	
	public static ToolKit getInstance(){
		
		if(instance == null){
			try {
				
				instance = new ToolKit();
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
		
		return instance;
	}

	
	//获取缓存配置
	public String getSingleConfig(String name){
		try{
			
			return configInfoMap.containsKey(name) ? configInfoMap.get(name).get(0) : null;
			
		}catch(Exception e){
			
			ConsoleUtil.println("获取缓存配置 出错:"+e);
		}
		
		return null;
	}
	
	public static void main(String[] args){
		ToolKit toolKit=ToolKit.getInstance();
		
		ConsoleUtil.println(toolKit.getSingleConfig("shop_goods_path"));
		
	}

	
}
