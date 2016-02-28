package com.bjwg.main.model;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bjwg.main.base.BaseVo;
public class Provalue extends BaseVo{
 	/**
	 * 
	 */
	private static final long serialVersionUID = -4553160220940348458L;
	/** 	 * 	 *the columnName is PRO_NAME 	 */ 	private String proName; 	/** 	 * 	 *the columnName is PRO_TIME 	 */ 	private String proValue; 	/** 	 * 	 *the columnName is CTIME 	 */ 	private Date ctime;
 	public void setProName(String proName){ 		this.proName=proName; 	} 	public String getProName(){ 		return this.proName; 	}
 	public void setCtime(Date ctime){ 		this.ctime=ctime; 	} 	public Date getCtime(){ 		return this.ctime; 	}

 	/** 	/** 	 *分别封装不为空值的字段和值 	 */ 	public Map<String, List> obtainNotNullColumn(){ 		Map<String, List> map = new HashMap<String, List>(); 		List<Object> list = new ArrayList<Object>(); 		List<String> sList = new ArrayList<String>(); 		if(proName != null){
 			sList.add("PRO_NAME"); 			list.add(proName); 		} 		if(proValue != null){
 			sList.add("PRO_VALUE"); 			list.add(proValue); 		} 		if(ctime != null){
 			sList.add("CTIME"); 			list.add(ctime); 		} 		map.put("columns", sList); 		map.put("values", list); 		return map;
	}
	public String getProValue() {
		return proValue;
	}
	public void setProValue(String proValue) {
		this.proValue = proValue;
	}
}