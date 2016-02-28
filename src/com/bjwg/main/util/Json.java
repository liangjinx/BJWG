package com.bjwg.main.util;

import net.sf.json.JSONObject;

public class Json {
	
	public static JSONObject string2json(String string) {
		JSONObject json = JSONObject.fromObject(string);
		
		return json;
	}
	
}
