package com.bjwg.main.listener;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.bjwg.main.util.ConsoleUtil;

/**
 * @author Carter
 * @version 创建时间：Sep 9, 2015 10:55:10 AM
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：由于在页面上不好引用常量, 这里将各常量初始化在app作用域中
 */
@WebListener
public class ConstantInitListener implements ServletContextListener{

	private static final String[] constClass = {
		"com.bjwg.main.constant.CommConstant"
	};
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		ConsoleUtil.println("-- application const init... --");
		ServletContext servletContext = arg0.getServletContext();
		
		for (String cname : constClass) {
			ConsoleUtil.println("-- write com.bjwg.main.constant.CommConstant to application scope --");
			Map<String, Object> map_CommConstant = new HashMap<String, Object>();
			try {
				Class<?> class1 = Class.forName(cname);
				Field[] fields = class1.getDeclaredFields();
				for(Field field : fields){
					map_CommConstant.put(field.getName(), field.get(null));
				}
				
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			servletContext.setAttribute(cname.substring(cname.lastIndexOf(".")+1), map_CommConstant);
		}
	}
}

