package com.bjwg.main.util;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



/**
 * 元数据转换成bean对象
 * @author :Allen  
 * @CreateDate : 2015-3-12 下午02:06:24 
 * @lastModified : 2015-3-12 下午02:06:24 
 * @version : 1.0
 * @jdk：1.6
 */
public class BeanConvertUtils {

	
	/**
	 * 将jdbc结果集转成javaBean
	 * @param <T>
	 * @param list
	 * @param clazz
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T>List<T> convertToBean(List<Map<String, Object>> list ,Class<T> clazz){
		
		List<T> l = null;
		
		if(!MyUtils.isListEmpty(list)){
			
			l = new ArrayList<T>();
			
			// 获得共有方法
            Method[] ms = clazz.getMethods();
            
            // 必须有无参的构造函数
            T obj = null;
			
			String setMethodName = null;
			
			String[] s = null;
			
			Class[] parameterTypes = null;
			
			
			for (Map<String, Object> lm : list) {
				
				try {
					
					obj = clazz.newInstance();
					
				} catch (Exception e1) {
					
					e1.printStackTrace();
				}
				
				for (Map.Entry<String, Object>  o: lm.entrySet()) {
					
					try {
						
						setMethodName = o.getKey().toLowerCase();
						
						s = setMethodName.split("_");
						
						/*
						 * 数据库表列名 和 po属性取名一定要按照规则来，否则字段映射不到
						 * 数据库列名：两个单词间使用"_"分割，单词首字母小写。
						 * po属性名：两个单词不用分割，且第一个单词首字母小写，第二个单词首字母大写。
						 * 如：数据库 列名：p_id  对应 po属性名：pId
						 */
						
						String t1 = null;
						
						for (int j = 0; j < s.length; j++) {
							
							  if(j == 0){
								  
								  t1 = s[0];
							  }else{
								  
								  t1 += StringUtils.firstToUpperCase(s[j]);
							  }
						}
						
						setMethodName = "set" + StringUtils.firstToUpperCase(t1);
						
						
						/*
						 * 字段类型 -> java类型 -> Oracle 类型 ：
						 * 
						 * int -> BigDecimal -> NUMBER
						 * char -> String -> CHAR
						 * long -> String -> LONG
						 * Number -> BigDecimal -> NUMBER
						 * varchar(2) -> String -> VARCHAR2
						 * timestamp -> oracle.sql.TIMESTAMP -> TIMESTAMP
						 * date -> java.sql.Timestamp -> DATE
						 * BLOB -> oracle.sql.BLOB ->BLOB
						 * 
						 */
						for (Method m : ms) {
							
							if(setMethodName.equals(m.getName())){
								
								if(o.getValue() instanceof Calendar){
									
									m.invoke(obj, new Date(((Calendar)o.getValue()).getTime().getTime()));
								}else if(o.getValue() instanceof java.sql.Date){
									
									m.invoke(obj, (Date)o.getValue());
								}else if(o.getValue() instanceof Date){
									
									m.invoke(obj, (Date)o.getValue());
								}else if(o.getValue() instanceof java.sql.Timestamp){
									
									m.invoke(obj, (Date)o.getValue());
									
								}else if(o.getValue() instanceof oracle.sql.TIMESTAMP){
									
									m.invoke(obj, (Date)((oracle.sql.TIMESTAMP)o.getValue()).timestampValue());
									
								}else if(o.getValue() instanceof BigDecimal){
									
									try {
										
										parameterTypes = m.getParameterTypes();
									    
									    if(parameterTypes[0].isAssignableFrom(Long.class))
									    {
									        
									        m.invoke(obj, ((BigDecimal)o.getValue()).longValue());
									        
									    }else if(parameterTypes[0].isAssignableFrom(Integer.class))
									    {
									        
									        m.invoke(obj, ((BigDecimal)o.getValue()).intValue());
									        
									    }else if(parameterTypes[0].isAssignableFrom(Double.class))
									    {
									        
									        m.invoke(obj, ((BigDecimal)o.getValue()).doubleValue());
									        
									    }else if(parameterTypes[0].isAssignableFrom(Float.class))
									    {
									        
									        m.invoke(obj, ((BigDecimal)o.getValue()).floatValue());
									    }else if(parameterTypes[0].isAssignableFrom(Short.class))
									    {
									    	
									    	m.invoke(obj, ((BigDecimal)o.getValue()).shortValue());
									    }
										
									} catch (Exception e) {
										
										//oracle 数字返回都是bigDecimal类型的，没有想到更好的处理方式
										m.invoke(obj, ((BigDecimal)o.getValue()).intValue());
									}
									
								}else{
									
									m.invoke(obj, o.getValue());
								}
								
							}
						}
						
					} catch (Exception e) {
						
						e.printStackTrace();
					}
					
				}
				
				l.add(obj);
				
			}
			
		}
		
		return l;
	}
	
	
	
	
	public static void main(String[] args) {
		
		/*  测试 结果集 反射 成bean对象  */
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		ConsoleUtil.println("开始时间："+System.currentTimeMillis());
		for(int i = 0 ; i<3 ; i++){
			
			map = new HashMap<String, Object>();
			
			map.put("id", i);
			
			map.put("username", "wang"+i);
			
			map.put("password", "123"+i);
			
			map.put("register_Time", new java.sql.Timestamp(new Date().getTime()));
			
			map.put("ip", "192.168.1.23"+i);
			
			map.put("security_Code", "dsae32dfdsdfds123MN:"+i);
			
			list.add(map);
		}
		ConsoleUtil.println("开始时间："+System.currentTimeMillis());
		
//		List<Customer> l = convertToBean(list, Customer.class);
		
//		ConsoleUtil.println(l);
		
		ConsoleUtil.println("开始时间："+System.currentTimeMillis());
	}
	
}
