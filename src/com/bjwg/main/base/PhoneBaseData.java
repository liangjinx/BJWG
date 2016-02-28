package com.bjwg.main.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.bjwg.main.model.Area_V2;
import com.bjwg.main.model.UserArea;
import com.bjwg.main.service.AreaService;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.SpringFactory;
import com.bjwg.main.util.StringUtils;


/**
 * 手机端基础数据管理类
 * @author :Allen  
 * @CreateDate : 2015-3-20 下午01:54:19 
 * @lastModified : 2015-3-20 下午01:54:19 
 * @version : 1.0
 * @jdk：1.6
 */
public class PhoneBaseData
{	
	private static PhoneBaseData instance;
	
	//地区name对应id		V2
	private static Map<String, String> nameIdMap_V2 = new HashMap<String, String>();
	//地区id对应name		V2
	private static Map<String, String> idNameMap_V2 = new HashMap<String, String>();
	//百度code对应主键id V2
	private static Map<String, String> codeIdMap_V2 = new HashMap<String, String>();
	//百度code对应主键id V2
	private static Map<String, String> idCodeMap_V2 = new HashMap<String, String>();
	//V2-所有的省份 所对应的所有城市
	private static Map<Long,List<Area_V2>> province2CityMap = new HashMap<Long, List<Area_V2>>();
	//省份列表
	private static List<Area_V2> provinceList = new ArrayList<Area_V2>();
	
	@Autowired
	private static AreaService areaService;
	
	private PhoneBaseData(){}
	
	public static PhoneBaseData getInstance(){
		
		if(instance == null){
			try {
				
				instance = new PhoneBaseData();
				
				areaService = getAreaService();
				
				getArea();
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
		
		return instance;
	}
	
	/**
	 * 查询并封装基本数据
	 * @throws Exception
	 */
	private static void getArea() throws Exception{
		
		List<Area_V2> list2 = areaService.query_v2();
		
		parseArea_v2(list2);
	}
	
	/**
	 * 根据百度code获取名称
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public String getAreaName(String code) throws Exception{
		
		if(StringUtils.isNotEmpty(code)){
			
			if(null != codeIdMap_V2 && codeIdMap_V2.size() > 0){
				
				return idNameMap_V2.get(codeIdMap_V2.get(code));
			}
			
		}
		
		return ""; 
	}
	
	
	/**
	 * 通过名称获取百度code
	 * @param provice
	 * @param city
	 * @return
	 * @throws Exception
	 */
	public String[] getAreaCode(String provice,String city) throws Exception{
		
		String[] s = new String[]{"",""};
		
		if(null != nameIdMap_V2 && nameIdMap_V2.size() > 0){
			
			s[0] = idCodeMap_V2.get(nameIdMap_V2.get(provice));
			
			s[1] = idCodeMap_V2.get(nameIdMap_V2.get(city));
			
		}
		
		return s;
	}
	

	/**
	 * 解析地区信息 V2
	 * @param list
	 * @throws Exception
	 */
	private static void parseArea_v2(List<Area_V2> list) throws Exception
	{
		if(!MyUtils.isListEmpty(list))
		{
			for (Area_V2 area : list)
			{	
				idNameMap_V2.put(area.getAreaId()+"", area.getName());
				nameIdMap_V2.put(area.getName(), area.getAreaId()+"");
				codeIdMap_V2.put(area.getBaiduCode()+"", area.getAreaId()+"");
				idCodeMap_V2.put(area.getAreaId()+"", area.getBaiduCode()+"");
				//存放所有的省份对应的城市
				if(area.getParent().intValue() == 0){
					province2CityMap.put(area.getAreaId(), new ArrayList<Area_V2>());
					provinceList.add(area);
				}
			}
			//封装省份对应的城市
			for (Area_V2 area : list)
			{	
				if(province2CityMap.containsKey(area.getParent())){
					province2CityMap.get(area.getParent()).add(area);
				}
			}
		}
	}
	
	
	/**
	 * V2 百度code获取主键id
	 * @param code
	 * @throws Exception 
	 */
	public String getAreaId(String code) throws Exception
	{
		if(StringUtils.isNotEmpty(code) && null != codeIdMap_V2)
		{
			//v2的百度code获取主键id
			return codeIdMap_V2.get(code);
		}
		return null;
	}
	/**
	 * V2 id获取百度code
	 * @param code
	 * @throws Exception 
	 */
	public String getAreaCode(String id) throws Exception
	{
		if(StringUtils.isNotEmpty(id) && null != idCodeMap_V2)
		{
			return idCodeMap_V2.get(id);
		}
		return null;
	}
	
	/**
	 * 根据百度code获取id
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public String getArea_V2Name(String code) throws Exception{
		
		if(StringUtils.isNotEmpty(code) && null != idNameMap_V2){
			
			return idNameMap_V2.get(code);
		}
		
		return ""; 
	}


	/**
	 * 获取省份集合
	 * @return
	 */
	public List<Area_V2> getProvinceList() {
		
		return provinceList;
	}
	/**
	 * 根据省份获取所有的城市
	 * @param province
	 * @return
	 */
	public List<Area_V2> getCityList(Long province) {
		if(null != province2CityMap){
			
			return province2CityMap.get(province);
		}
		return null;
	}

	
	public static AreaService getAreaService() {
		
		return (AreaService)SpringFactory.getBean("areaService");
	}
	
	
	public static void main(String[] args) {
		
		
		
	}

	
	
	
}
































