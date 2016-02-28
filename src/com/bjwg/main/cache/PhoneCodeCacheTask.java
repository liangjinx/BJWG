package com.bjwg.main.cache;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimerTask;

import com.bjwg.main.util.ConsoleUtil;

/**
 * @author jun
 * @version 创建时间：2015-7-22 下午06:04:11
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：手机验证码缓存定时器
 */
public class PhoneCodeCacheTask extends TimerTask{

	@Override
	public void run() {
		List<Map<String,Map<String,Object>>> cache=PhoneCodeCache.getCache();
		for(Map<String,Map<String,Object>> c:cache){
			Set<String> keySet = c.keySet();
			List<String> phones=new ArrayList<String>();
			for(String phone:keySet){
				Map<String,Object> code=c.get(phone);
				Long time=(Long)code.get("time");
				if(time!=null){
					Long t=System.currentTimeMillis()-time;
					//大于5分钟的删掉
					if(t>(5*60*1000L)){
//						if(t>(60000L)){//测试用: 大于60秒
						phones.add(phone);
					}
				}
			}
			for(String p:phones){
				ConsoleUtil.println("PhoneCodeCacheTask移除手机验证码缓存:"+p+"...");
				if(c.containsKey(p))c.remove(p);
			}
		}
	}

}
