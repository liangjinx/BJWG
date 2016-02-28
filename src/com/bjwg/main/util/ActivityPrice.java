package com.bjwg.main.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author chen
 * @version 创建时间：2015-6-27 下午02:57:38
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明： 活动价格区间判断
 */

public class ActivityPrice {
	
	/**
	 * 
	 * @param info
	 * @param salesNum
	 * @param priceCS
	 * @return
	 */
	public static Double isInScope(String info,Long salesNum, Double priceCS){
		
		Map<Long, Double> map = new TreeMap<Long, Double>();
		List<Long> nums = new ArrayList<Long>();
		JSONArray array = JSONArray.fromObject(info);
		for (int i = 0; i < array.size(); i++) {
			JSONObject object = array.getJSONObject(i);
			map.put( object.getLong("num"), object.getDouble("price"));
			nums.add( object.getLong("num") );
		}
		//价格区间判断
		nums.add(0l);
		map.put(0l, priceCS);
		
		Collections.sort(nums,new Comparator<Long>() {
			@Override
			public int compare(Long o1, Long o2) {
				// TODO Auto-generated method stub
				return o2.compareTo(o1);
			}
		});
		ConsoleUtil.println(nums);
		
		long key = MyUtils.isInScope(nums, salesNum);
		Double price = map.get(key);
		
		return price;
	}


	/**
	 * 根据价格判断
	 * @param info
	 * @param salesNum
	 * @param price 
	 * @return
	 *//*
	public static Long actPrice(String info,String salesNum, Long priceCS){
		
		Map<Long, Long> map = new TreeMap<Long, Long>();
		
		List<Long> nums = new ArrayList<Long>();
		
		JSONArray array = JSONArray.fromObject(info);
		
		for (int i = 0; i < array.size(); i++) {
			JSONObject object = array.getJSONObject(i);
			
			map.put( object.getLong("num"), object.getLong("price"));
			
			nums.add( object.getLong("num") );
		}
		//价格区间判断
		nums.add(0l);
		map.put(0l, priceCS);
		Collections.sort(nums);
		ConsoleUtil.println(nums);
		
		boolean falg = false;
		Long val = null;
		for (int i = 0; i < nums.size(); i++) {
			if( i+1 <= nums.size() -1 ){
				String scope = "["+nums.get(i) +"," +nums.get(i+1)+"]";
				falg = MyUtils.isInScope( scope , salesNum );
				ConsoleUtil.println( i+"-----------" +falg);
				
			}else{
				String scope = "["+nums.get(i) +"," +nums.get(nums.size()-1)+"]";
				falg = MyUtils.isInScope( scope , salesNum );
				ConsoleUtil.println( i+"-----------" +falg);
			}
			
			if(i == 0 ){
				val = nums.get(i+1);
			}else{
				val = nums.get(i);
			}
			if(falg)
				break;
		}
		
		Long price = map.get(val);
		
		return price;
	}*/

}
