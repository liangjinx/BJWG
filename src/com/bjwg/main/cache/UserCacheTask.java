package com.bjwg.main.cache;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimerTask;

import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.security.UserMananger;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.MyUtils;


/**
 * @author jun
 * @version 创建时间：2015-7-20 上午10:27:58
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：用户缓存定时器
 */
public class UserCacheTask extends TimerTask{

	@Override
	public void run() {
		
		Map<String, UserLoginModel> userCache = UserMananger.getInst().getLoginList();
		
		Map<String, UserLoginModel> userCachePhone = UserMananger.getInst().getPhoneLoginList();
		
		Date date = new Date();
		
		if(null != userCache){
			
			List<String> tokens = new ArrayList<String>();
			
			for (Map.Entry<String, UserLoginModel> user : userCache.entrySet()) {
				
				UserLoginModel model = user.getValue();
				//已过期
				if(model.getExpiredTime().before(date)){
					
					tokens.add(user.getKey());
				}
			}
			
			if(!MyUtils.isListEmpty(tokens)){
				
				for (String token : tokens) {
				
					ConsoleUtil.println("微信、pc端移除token："+token);
					
					userCache.remove(token);
				}
			}
		}
		
		if(null != userCachePhone){
			
			List<String> driverIds = new ArrayList<String>();
			
			for (Map.Entry<String, UserLoginModel> user : userCachePhone.entrySet()) {
				
				UserLoginModel model = user.getValue();
				//已过期
				if(model.getExpiredTime().before(date)){
					
					driverIds.add(user.getKey());
				}
			}
			
			if(!MyUtils.isListEmpty(driverIds)){
				
				for (String driverId: driverIds) {
					
					userCachePhone.remove(driverId);
				}
			}
		}
		
	}

}
