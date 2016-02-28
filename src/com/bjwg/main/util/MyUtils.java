package com.bjwg.main.util;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.LoginConstants;
import com.bjwg.main.model.MyEarnings;
import com.bjwg.main.model.PagerArg;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserArea;
import com.bjwg.main.model.UserLoginModel;
import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * 工具类
 * 
 * @author Administrator
 * 
 */
public class MyUtils {

	public static final Logger  logger = LoggerFactory.getLogger("LOGISTICS-COMPONENT"); 
	
	/**
	 * 判断list是否为空
	 * 
	 * @param list
	 * @return
	 */
	public static boolean isNotEmpty(List<?> list) {
		return list != null && list.size() > 0;
	}

	/**
	 * 判断list是否为空
	 * 
	 * @param list
	 * @return null true
	 */
	public static boolean isListEmpty(List<?> list) {

		return list == null || list.size() == 0;
	}

	/**
	 * 判断map是否为空
	 * 
	 * @param list
	 * @return
	 */
	public static boolean isMapEmpty(Map<?, ?> map) {

		return map == null || map.size() == 0;
	}

	/**
	 * 判断integer是否大于0
	 * 
	 * @param i
	 * @return
	 */
	public static boolean isIntegerGtZero(Integer i) {

		return i != null && i.intValue() > 0;
	}

	/**
	 * 获取当前时间，未格式化
	 * 
	 * @return
	 */
	public static Date getCurrentDate() {

		return new Date();
	}

	/**
	 * 时间格式化
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static Date dateFormat(String dateStr) {

		return new Date(dateStr);
	}

	/**
	 * 格式化时间
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static Date dateFormat(String data, int mode) throws Exception {

		String format = "yyyy-MM-dd HH:mm:ss";
		switch (mode) {
		case 1:

			format = "yyyy/MM/dd HH:mm:ss";
			break;
		case 2:

			format = "yyyy.MM.dd HH:mm:ss";
			break;
		case 3:

			format = "yyyy年MM月dd日 HH:mm:ss";
			break;
		case 4:
			
			format = "yyyyMMddHHmmss";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.parse(data);
	}

	/**
	 * 获取当前时间yyyy-MM-dd HH:mm:ss
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String getYYYYMMDDHHmmss(int mode) {

		String format = "yyyy-MM-dd HH:mm:ss";
		switch (mode) {
		case 1:

			format = "yyyy/MM/dd HH:mm:ss";
			break;
		case 2:

			format = "yyyy.MM.dd HH:mm:ss";
			break;
		case 3:

			format = "yyyy年MM月dd日 HH:mm:ss";
			break;
		case 4:

			format = "yyyyMMddHHmmss";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(new Date());
	}

	/**
	 * 获取当前时间yyyy-MM-dd
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String getYYYYMMDD(int mode) {

		String format = "yyyy-MM-dd";
		switch (mode) {
		case 1:

			format = "yyyy/MM/dd";
			break;
		case 2:

			format = "yyyy.MM.dd";
			break;
		case 3:

			format = "yyyy年MM月dd日";
			break;
		case 4:

			format = "yyyyMMdd";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(new Date());
	}

	/**
	 * 获取当前时间yyyy-MM
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String getYYYYMM(int mode) {

		String format = "yyyy-MM";
		switch (mode) {
		case 1:

			format = "yyyy/MM";
			break;
		case 2:

			format = "yyyy.MM";
			break;
		case 3:

			format = "yyyy年MM月";
			break;
		case 4:

			format = "yyyyMM";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(new Date());
	}

	/**
	 * 格式化时间
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String dateFormat2(Date data, int mode) throws Exception {

		String format = "yyyy-MM-dd HH:mm:ss";
		switch (mode) {
		case 1:

			format = "yyyy/MM/dd HH:mm:ss";
			break;
		case 2:

			format = "yyyy.MM.dd HH:mm:ss";
			break;
		case 3:

			format = "yyyy年MM月dd日 HH:mm:ss";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(data);
	}

	/**
	 * 格式化时间 格式：n（分钟/小时/天）前
	 * 
	 * @param date
	 * @return
	 * @throws Exception
	 */
	public static String dateFormat3(Date date) throws Exception {
		Date now = new Date();
		long minute = 60;
		long hour = 3600;
		long day = 3600 * 24;
		long x = (now.getTime() - date.getTime()) / 1000;
		if (x < 60) {
			return "1分钟前";
		} else if (x > minute && x < hour) {
			return (int) x / minute + "分钟前";
		} else if (x > hour && x < day) {
			return x / hour + "小时前";
		} else if (x > day && x < (day * 15)) {
			return x / day + "天前";
		} else {
			return dateFormat2(date, 0);
		}
	}

	/**
	 * 格式化时间yyyy-MM-dd HH:mm
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String dateFormat3(Date data, int mode) throws Exception {

		String format = "yyyy-MM-dd HH:mm";
		switch (mode) {
		case 1:

			format = "yyyy/MM/dd HH:mm";
			break;
		case 2:

			format = "yyyy.MM.dd HH:mm";
			break;
		case 3:

			format = "yyyy年MM月dd日 HH:mm";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(data);
	}

	/**
	 * 格式化时间 格式：昨天 HH:mm、前天 HH:mm、日期(yyyy-MM-dd)
	 * 
	 * @param date
	 * @return
	 * @throws Exception
	 */
	public static String dateFormat4(Date date) throws Exception {
		long days = calcDays(new Date(), date);
		if (days == 0) {
			return "今天 " + dateFormat6(date, 0);
		} else if (days == -1) {
			return "昨天 " + dateFormat6(date, 0);
		} else if (days == -2) {
			return "前天 " + dateFormat6(date, 0);
		} else {
			return dateFormat3(date, 0);
		}
	}

	/**
	 * 格式化时间 格式：昨天 、前天、日期(yyyy-MM-dd)
	 * 
	 * @param date
	 * @return
	 * @throws Exception
	 */
	public static String dateFormat5(Date date) throws Exception {
		long days = calcDays(new Date(), date);
		if (days == 0) {
			return "今天 ";
		} else if (days == -1) {
			return "昨天 ";
		} else if (days == -2) {
			return "前天 ";
		} else {
			return dateFormat4(date, 0);
		}
	}

	/**
	 * 格式化时间
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static Date dateFormat4(String dateStr, int mode) throws Exception {

		String format = "yyyy-MM-dd";
		switch (mode) {
		case 1:

			format = "yyyy/MM/dd";
			break;
		case 2:

			format = "yyyy.MM.dd";
			break;
		case 3:

			format = "yyyy年MM月dd日";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.parse(dateStr);
	}

	/**
	 * 格式化时间
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String dateFormat4(Date date, int mode) throws Exception {

		String format = "yyyy-MM-dd";
		switch (mode) {
		case 1:

			format = "yyyy/MM/dd";
			break;
		case 2:

			format = "yyyy.MM.dd";
			break;
		case 3:

			format = "yyyy年MM月dd日";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(date);
	}

	/**
	 * 格式化时间 yyyy-MM
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String dateFormat5(Date data, int mode) throws Exception {

		String format = "yyyy-MM";
		switch (mode) {
		case 1:

			format = "yyyy/MM";
			break;
		case 2:

			format = "yyyy.MM";
			break;
		case 3:

			format = "yyyy年MM月";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(data);
	}

	/**
	 * 格式化时间 yyyy-MM
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static Date dateFormat5(String dataStr, int mode) throws Exception {

		String format = "yyyy-MM";
		switch (mode) {
		case 1:

			format = "yyyy/MM";
			break;
		case 2:

			format = "yyyy.MM";
			break;
		case 3:

			format = "yyyy年MM月";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.parse(dataStr);
	}

	/**
	 * 格式化时间 HH:mm
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String dateFormat6(Date data, int mode) throws Exception {

		String format = "HH:mm";
		switch (mode) {
		case 1:

			format = "HH/mm";
			break;
		case 2:

			format = "HH.mm";
			break;
		case 3:

			format = "HH时mm分";
			break;

		default:

			break;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(data);
	}
	/**
	 * 格式化时间 HH:mm:ss
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String dateFormat7(Date data, int mode) throws Exception {
		
		String format = "HH:mm:ss";
		switch (mode) {
		case 1:
			
			format = "HH/mm/ss";
			break;
		case 2:
			
			format = "HH.mm.ss";
			break;
		case 3:
			
			format = "HH时mm分ss秒";
			break;
			
		default:
			
			break;
		}
		
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		
		return dateFormat.format(data);
	}
	/**
	 * 格式化时间 HH
	 * 
	 * @param mode
	 *            格式
	 * @return
	 */
	public static String dateFormat8(Date data) throws Exception {
		
		String format = "HH";
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		
		return dateFormat.format(data);
	}

	/**
	 * 时间相加
	 * 
	 * @param date
	 * @param hours
	 *            小时
	 * @return
	 */
	public static Date addDate(Date date, int hours) {

		return new Date(date.getTime() + hours * 60 * 60 * 1000);

	}

	/**
	 * 时间相加
	 * 
	 * @param date
	 * @param minitues
	 *            分钟
	 * @return
	 */
	public static Date addDate2(Date date, int minitues) {

		return new Date(date.getTime() + minitues * 60 * 1000);

	}
	/**
	 * 时间相加
	 * 
	 * @param date
	 * @param sec
	 *            秒
	 * @return
	 */
	public static Date addDateSec(Date date, int sec) {
		
		return new Date(date.getTime() + sec * 1000);
		
	}

	/**
	 * 时间相加
	 * 
	 * @param date
	 * @param day
	 *            天
	 * @return
	 */
	public static String addDate3(Date date, int day) {
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(calendar.DATE, day);// 把日期往后增加一天.整数往后推,负数往前移动
		date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(date);
		return dateString;
	}
	/**
	 * 时间相加
	 * 
	 * @param date
	 * @param day
	 *            天
	 * @return
	 */
	public static String addDate4(Date date, int day) {
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(calendar.DATE, day);// 把日期往后增加一天.整数往后推,负数往前移动
		date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = formatter.format(date);
		return dateString;
	}

	/**
	 * 获取随机数
	 * 
	 * @param len
	 *            最大十位数
	 * @return
	 */
	public static int random(int len) {

		Random rdm = new Random(len);
		int intRd = Math.abs(rdm.nextInt());
		return intRd;
	}

	/**
	 * 将字符串封装成List<String>
	 * 
	 * @param s
	 *            字符串是以^符号进行连接的
	 * @return
	 */
	public static List<String> convertToList(String s) {

		String[] s1 = s.split("\\^");

		List<String> list = new ArrayList<String>();

		for (int i = 0; i < s1.length; i += 3) {

			list.add(s1[i]);
		}

		return list;
	}

	/**
	 * 将字符串封装成List<String[]>
	 * 
	 * @param s
	 *            字符串是以^符号进行连接的
	 * @return
	 */
	public static List<String[]> convertToList2(String s) {

		String[] s1 = s.split("\\^");

		List<String[]> list = new ArrayList<String[]>();

		String[] s2 = null;

		for (int i = 0; i < s1.length; i += 3) {

			s2 = new String[3];

			s2[0] = s1[i];
			s2[1] = s1[i + 1];
			s2[2] = s1[i + 2];

			list.add(s2);
		}

		return list;
	}

	/**
	 * 判断字符串是否为数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {

		Pattern pattern = Pattern.compile("[0-9]*");

		Matcher isNum = pattern.matcher(str);

		if (!isNum.matches()) {

			return false;
		}

		return true;
	}

	/**
	 * 正则表达式匹配
	 * 
	 * @param regex
	 * @param orginal
	 * @return
	 */
	@SuppressWarnings("unused")
	private static boolean isMatch1(String regex, String orginal) {

		if (orginal == null || orginal.trim().equals("")) {

			return false;
		}

		Pattern pattern = Pattern.compile(regex);

		Matcher isNum = pattern.matcher(orginal);

		return isNum.matches();
	}

	/**
	 * ip地址转成整数.
	 * 
	 * @param ip
	 * @return
	 */
	public static long ip2long(String ip) {
		String[] ips = ip.split("[.]");
		long num = 16777216L * Long.parseLong(ips[0]) + 65536L
				* Long.parseLong(ips[1]) + 256 * Long.parseLong(ips[2])
				+ Long.parseLong(ips[3]);
		return num;
	}

	/**
	 * 整数转成ip地址.
	 * 
	 * @param ipLong
	 * @return
	 */
	public static String long2ip(long ipLong) {
		// long ipLong = 1037591503;
		long mask[] = { 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000 };
		long num = 0;
		StringBuffer ipInfo = new StringBuffer();
		for (int i = 0; i < 4; i++) {
			num = (ipLong & mask[i]) >> (i * 8);
			if (i > 0)
				ipInfo.insert(0, ".");
			ipInfo.insert(0, Long.toString(num, 10));
		}
		return ipInfo.toString();
	}

	/**
	 * 计算分钟
	 * 
	 * @param s
	 * @return
	 */
	public static Integer calcMinute(String s) {

		String[] t = s.split(":");

		return Integer.valueOf(t[0]) * 60 + Integer.valueOf(t[1]);
	}

	/**
	 * 计算分钟
	 * 
	 * @param hours
	 *            小时
	 * @return
	 */
	public static String calcMinute(Integer s) {

		int t = s % 60;

		return s / 60 + ":" + ((t < 10) ? "0" + t : t);
	}
	/**
	 * 计算秒
	 * 
	 * @param s
	 * @return
	 */
	public static Integer calcSecs(String s) {

		String[] t = s.split(":");

		return Integer.valueOf(t[0]) * 60 * 60 + Integer.valueOf(t[1]) *60 + Integer.valueOf(t[2]);
	}

	/**
	 * 计算地球上任意两点(经纬度)距离
	 * 
	 * @param long1
	 *            第一点经度
	 * @param lat1
	 *            第一点纬度
	 * @param long2
	 *            第二点经度
	 * @param lat2
	 *            第二点纬度
	 * @return 返回距离 单位：米
	 */
	public static double Distance(double long1, double lat1, double long2,
			double lat2) {
		double a, b, R;
		R = 6378137; // 地球半径
		lat1 = lat1 * Math.PI / 180.0;
		lat2 = lat2 * Math.PI / 180.0;
		a = lat1 - lat2;
		b = (long1 - long2) * Math.PI / 180.0;
		double d;
		double sa2, sb2;
		sa2 = Math.sin(a / 2.0);
		sb2 = Math.sin(b / 2.0);
		d = 2
				* R
				* Math.asin(Math.sqrt(sa2 * sa2 + Math.cos(lat1)
						* Math.cos(lat2) * sb2 * sb2));
		return d;
	}

	/**
	 * 根据经纬度获取地址
	 * 
	 * @param longitude
	 * @param latitude
	 * @return
	 * @throws HttpException
	 * @throws IOException
	 */
	public static String getBaiduMapArea(double longitude, double latitude)
			throws HttpException, IOException {

		HttpClient client = new HttpClient();

		client.setConnectionTimeout(6 * 1000);
		// Latitude: Longitude:
		String url = ToolKit.getInstance().getSingleConfig(
				"baidu_map_interface")
				+ "?callback=renderReverse&location="
				+ latitude
				+ ","
				+ longitude
				+ "&output=json&pois=0&ak="
				+ ToolKit.getInstance().getSingleConfig("baidu_map_ak");
		// http://api.map.baidu.com/geocoder/v2/?ak=您的密钥&callback=renderReverse&location=39.983424,116.322987&output=json&pois=0
		GetMethod getMethod = new GetMethod(url);

		int statusCode = client.executeMethod(getMethod);

		if (statusCode == HttpStatus.SC_OK) {

			String sms = getMethod.getResponseBodyAsString();

			ConsoleUtil.println("result:" + sms);

			sms = sms.replaceAll("renderReverse&&renderReverse", "");

			sms = sms.substring(1, sms.length() - 1);

			ConsoleUtil.println("result:  0000  " + sms);

			return sms;
		}

		return null;
	}

	/**
	 * 解析百度地图返回的地区数据
	 * 
	 * @param sms
	 * @return
	 * @throws Exception
	 */
	public static String[] parseMapJson(String sms) throws Exception {

		net.sf.json.JSONObject object = net.sf.json.JSONObject.fromObject(sms);

		String[] citys = new String[4];
		if (object.getString("status").equals("0")) {

			Integer cityCode = object.getJSONObject("result")
					.getInt("cityCode");
			JSONObject obj = object.getJSONObject("result").getJSONObject(
					"addressComponent");

			String city = obj.getString("city");
			citys[0] = city;
			citys[1] = cityCode + "";
			citys[2] = obj.getString("province");
			citys[3] = object.getJSONObject("result").getString(
					"formatted_address");
			return citys;
		}

		return null;
	}

	/**
	 * 获取百度地图的经纬度
	 * 
	 * @param address
	 * @return
	 * @throws Exception
	 */
	public static String getBaiduMapResult(String address) throws Exception {

		HttpClient client = new HttpClient();

		client.setConnectionTimeout(6 * 1000);

		String url = ToolKit.getInstance().getSingleConfig(
				"baidu_map_interface")
				+ "?address="
				+ URLEncoder.encode(address)
				+ "&output=json&ak="
				+ ToolKit.getInstance().getSingleConfig("baidu_map_ak");
		// "http://api.map.baidu.com/geocoder/v2/?address="+URLEncoder.encode(address)+"&output=json&ak=DqTGazNxpb6tujm41W2ULrtb";
		GetMethod getMethod = new GetMethod(url);

		int statusCode = client.executeMethod(getMethod);

		if (statusCode == HttpStatus.SC_OK) {

			String sms = getMethod.getResponseBodyAsString();

			ConsoleUtil.println("result:" + sms);

			return sms;
		}

		return null;
	}

	/**
	 * 解析百度地图返回的经纬度数据
	 * 
	 * @param sms
	 * @return
	 * @throws Exception
	 */
	public static Double[] parseJson(String sms) throws Exception {

		net.sf.json.JSONObject object = net.sf.json.JSONObject.fromObject(sms);

		if (object.getString("status").equals("0")) {

			object = object.getJSONObject("result").getJSONObject("location");

			ConsoleUtil.println(object.getDouble("lng") + "-->"
					+ object.getDouble("lat"));

			Double[] d = new Double[] { object.getDouble("lng"),
					object.getDouble("lat") };

			return d;
		}

		return null;
	}

	/**
	 * 格式化距离显示
	 * 
	 * @param d
	 * @return
	 */
	public static String formatDistance(Double d) {

		int k = d.intValue() / 1000;

		int l = d.intValue() % 1000;

		if (k < 1) {

			k = d.intValue();

			if (k < 300)
				return "<300m";

			return k + "m";
		} else {

			l = l / 100;

			return k + "." + l + "km";
		}

	}
	
	 /**
     * 格式化距离显示
     * @param d
     * @return
     */
    public static String formatDistance2(Double d){
    	
    	int k = d.intValue() / 1000;
    	
    	int l = d.intValue() % 1000;
    	
    	if(k < 1){
    		
    		int s = l % 100;
    		
    		if(d.intValue()<300){
    			
    			return "<0.3km";
    		}
    		
    		return "0."+ (int)(d / 100) + "km";
    	}else{
    		
    		l = l / 100;
    		
    		return k + "." + l +"km";
    	}
    	
    }

	/**
	 * 返回正确的地址
	 * 
	 * @param d
	 * @return
	 */
	public static String getLocalHttpUrl(String s, String webroot) {

		if (StringUtils.isNotEmpty(s)) {

			if (s.startsWith("http://") || s.startsWith("https://")) {

				return s;
			} else {

				return webroot + s;
			}

		}

		return "";
	}

	/**
	 * 返回图片地址，没有则返回默认图片地址
	 * 
	 * @param d
	 * @return
	 */
	public static String getLocalHttpUrl(String s, String webroot,
			Integer categoryId, boolean flag) {

		if (StringUtils.isNotEmpty(s)) {

			if (s.startsWith("http://") || s.startsWith("https://")) {

				return s;
			} else {

				return webroot + s;
			}

		} else if (flag) {

			return webroot + "resources/images/index_sort" + categoryId
					+ ".png";
		}

		return "";
	}

	/**
	 * 图片服务器返回的图片地址，没有则返回默认图片地址 webroot 服务器 webroot2 图片服务器
	 * 
	 * @param sHOP_LOGO
	 * @return
	 */
	public static String getHeadImgUrl(String logo, String webroot,
			String webrootImg, Integer categoryId, String handle) {
		
		if (StringUtils.isNotEmpty(logo)) {
			
			if (logo.startsWith("http://") || logo.startsWith("https://")) {
				
				return logo;
			} else {
				
				return webrootImg + logo + handle;
			}
			
		} else {
			
			// 没有图片默认
			return webroot + "resources/images/defaul_headurl.png";
		}
		
	}
	/**
	 * 图片服务器返回的图片地址，没有则返回默认图片地址 webroot 服务器 webroot2 图片服务器
	 * 
	 * @param sHOP_LOGO
	 * @return
	 */
	public static String getImgUrl(String logo, String webroot,
			String webrootImg, Integer categoryId, String handle) {

		if (StringUtils.isNotEmpty(logo)) {

			if (logo.startsWith("http://") || logo.startsWith("https://")) {

				return logo;
			} else {

				return webrootImg + logo + handle;
			}

		} else {

			// 没有图片默认
			return webroot + "resources/images/index_sort" + categoryId
					+ ".png";
		}

	}

	/**
	 * 图片服务器返回的图片地址，没有则返回默认图片地址 webroot 服务器 webroot2 图片服务器
	 * 
	 * @param sHOP_LOGO
	 * @return
	 */
	public static String getImgUrl(String logo, String webroot,
			String webrootImg, Integer categoryId, String handle, boolean flag) {

		if (StringUtils.isNotEmpty(logo)) {

			if (logo.startsWith("http://") || logo.startsWith("https://")) {

				return logo;
			} else {

				return webrootImg + logo + handle;
			}

		} else if (flag) {

			// 没有图片默认
			return webroot + "resources/images/index_sort" + categoryId
					+ ".png";
		}

		return null;

	}

	/**
	 * 返回不同项目的图片地址，没有则返回默认图片地址
	 * 
	 * @return
	 */
	public static String getLocalHttpUrl(String s, String webroot,
			String webRoot2, int source, Integer categoryId, boolean flag) {

		String path = "";
		// 录入工具
		if (source < 3) {

			path = webRoot2;
		} else {

			path = webroot;
		}

		if (StringUtils.isNotEmpty(s)) {

			if (s.startsWith("http://") || s.startsWith("https://")) {

				return s;
			} else {

				return path + s;
			}

		} else if (flag) {

			// 没有图片默认
			return webroot + "resources/images/index_sort" + categoryId
					+ ".png";
		}

		return "";
	}

	/**
	 * 比较两个时间之间相差多少天
	 * 
	 * @param date1
	 *            较小的时间(null则默认为当前时间)
	 * @param date2
	 *            较大的时间(null则默认为当前时间)
	 * @return
	 * @throws ParseException
	 */
	public static int compareDate(Date date1, Date date2) throws ParseException {
		date1 = date1 == null ? new Date() : date1;
		date2 = date2 == null ? new Date() : date2;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		date1 = sdf.parse(sdf.format(date1));
		date2 = sdf.parse(sdf.format(date2));

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date1);
		long time1 = calendar.getTimeInMillis();
		calendar.setTime(date2);
		long time2 = calendar.getTimeInMillis();

		return Integer.parseInt(String.valueOf((time2 - time1)
				/ (1000 * 3600 * 24)));

	}

	/**
	 * 转换服务范围
	 * 
	 * @param s
	 * @return
	 */
	public static Integer convertArea(String s) {

		if ("500M".equals(s.toUpperCase()) || "500M以内".equals(s.toUpperCase())) {

			return 1;
		} else if ("1KM".equals(s.toUpperCase())
				|| "1KM以内".equals(s.toUpperCase())) {

			return 2;
		} else if ("3KM".equals(s) || "3KM以内".equals(s.toUpperCase())) {

			return 3;
		} else if ("5KM".equals(s) || "5KM以内".equals(s.toUpperCase())) {

			return 4;
		} else if ("全城".equals(s) || "全程以内".equals(s.toUpperCase())) {

			return 5;
		} else if ("不限".equals(s) || "不限以内".equals(s.toUpperCase())) {

			return 6;
		}
		return 0;
	}

	/**
	 * 转换服务范围
	 * 
	 * @param s
	 * @return
	 */
	public static String convertArea(Integer i) {

		switch (i) {
		case 1:

			return "500M";
		case 2:

			return "1KM";
		case 3:

			return "3KM";
		case 4:

			return "5KM";
		case 5:

			return "全城";
		case 6:

			return "不限";

		default:
			break;
		}

		return "";
	}

	/**
	 * 手机验证码
	 * 
	 * @return
	 */
	public static String getVerify() {
		// ,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
		String str = "0,1,2,3,4,5,6,7,8,9";
		String str2[] = str.split(",");// 将字符串以,分割
		int sum = 0;// 计数器
		for (int i = 0; i < str2.length; ++i) {
			++sum;
			if (0 == sum % 10) {
				ConsoleUtil.println("");// 没十个数据换行
			}
		}
		ConsoleUtil.println("");
		Random rand = new Random();// 创建Random类的对象rand
		int index = 0;
		String randStr = "";// 创建内容为空字符串对象randStr
		// Scanner scan = new Scanner(System.in);//创建Scanner类的对象
		// while (!scan.next().equals("#"))//判断从键盘输入的是否是字符#
		// {
		randStr = "";// 清空字符串对象randStr中的值
		for (int i = 0; i < 4; ++i) {
			index = rand.nextInt(str2.length - 1);// 在0到str2.length-1生成一个伪随机数赋值给index
			randStr += str2[index];// 将对应索引的数组与randStr的变量值相连接
		}
		ConsoleUtil.println("验证码：" + randStr);// 输出所求的验证码的值
		// }
		return randStr;
	}

	/**
	 * 获取len位随机数
	 * 
	 * @return
	 */
	public static String getRandomNumber(int len) {
		// ,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
		String str = "0,1,2,3,4,5,6,7,8,9";
		String str2[] = str.split(",");// 将字符串以,分割
		int sum = 0;// 计数器
		for (int i = 0; i < str2.length; ++i) {
			++sum;
			if (0 == sum % 10) {
				ConsoleUtil.println("");// 没十个数据换行
			}
			System.out.print(str2[i] + " ");
		}
		ConsoleUtil.println("");
		Random rand = new Random();// 创建Random类的对象rand
		int index = 0;
		String randStr = "";// 创建内容为空字符串对象randStr
		// Scanner scan = new Scanner(System.in);//创建Scanner类的对象
		// while (!scan.next().equals("#"))//判断从键盘输入的是否是字符#
		// {
		randStr = "";// 清空字符串对象randStr中的值
		for (int i = 0; i < len; ++i) {
			index = rand.nextInt(str2.length - 1);// 在0到str2.length-1生成一个伪随机数赋值给index
			randStr += str2[index];// 将对应索引的数组与randStr的变量值相连接
		}
		// ConsoleUtil.println("验证码：" + randStr);// 输出所求的验证码的值
		// }
		return randStr;
	}

	/**
	 * 判断是否为手机号
	 * 
	 * @param mobiles
	 * @return 是 true
	 */
	public static boolean isMobileNO(String mobiles) {
		Pattern p = Pattern
				.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
		Matcher m = p.matcher(mobiles);
		return m.matches();
	}

	/**
	 * 判断是否为手机号
	 * 
	 * @param mobiles
	 * @return 是 true
	 */
	public static boolean isMobileNO2(String mobiles) {
		Pattern p = Pattern.compile("^((1)+\\d{10})$");
		Matcher m = p.matcher(mobiles);
		return m.matches();
	}
	/**
	 * 判断是否为身份证号
	 * 
	 * @param mobiles
	 * @return 是 true
	 */
	public static boolean isIDCard(String idcard) {
		String rex = "^[0-9+]\\d{13,17}|[0-9+]\\d{13,17}x";
		Pattern pattern = Pattern.compile(rex);
		Matcher m = pattern.matcher("42028119891014111x");
		return m.matches();
	}

	
	
	/**
	 * 价格区间判断
	 * @param scope
	 * @param value
	 * @return
	 */
	public static long isInScope(List<Long> nums,Long salesNum) {
		
		for (int i = 0; i < nums.size(); i++) {
			
			//数量大于最大的区间的值
			if(salesNum >= nums.get(i).longValue()){
			
				return nums.get(i).longValue();
			}
				
		}
			
		return 0l;
		
	}
	
	/**
	 * 价格区间判断
	 * @param scope
	 * @param value
	 * @return
	 */
	public static boolean isInScope(String scope, String value) {
	    Pattern pattern = Pattern.compile("^(\\(|\\[)\\d+,\\s*\\d+(\\)|\\])$");
	    Matcher matcher = pattern.matcher(scope);
	    if (!matcher.find()) {
	      return false;
	    }
	    String[] scopes = scope.split(",");
	    Float valueF = Float.valueOf(value);
	    Float min = Float.valueOf(scopes[0].substring(1));
	    //最小值
	    if ("[".equals(String.valueOf(scopes[0].charAt(0)))) {
	      if (valueF < min)
	        return false;
		 }
	  //最大值
	    Float max = Float.valueOf(scopes[1].substring(0, scopes[1].length() - 1));
	    if ("]".equals(String.valueOf(scopes[1].charAt(scopes[1].length() - 1)))) {
	      if (valueF >= max)
	        return false;
	    }
	    /*if ("(".equals(String.valueOf(scopes[0].charAt(0)))) {
	      if (valueF <= min)
	        return false;
	    } else if ("[".equals(String.valueOf(scopes[0].charAt(0)))) {
	      if (valueF < min)
	        return false;
	    }
	    Float max = Float.valueOf(scopes[1].substring(0, scopes[1].length() - 1));
	    if (")".equals(String.valueOf(scopes[1].charAt(scopes[1].length() - 1)))) {
	      if (valueF >= max)
	        return false;
	    } else if ("]".equals(String.valueOf(scopes[1].charAt(scopes[1].length() - 1)))) {
	      if (valueF > max)
	        return false;
	    }
	     */
	    return true;
	  }

	/**
	 * 解析qq登录错误信息文本
	 * 
	 * @return
	 */
	public JSONObject ParseQQLoginErrorMsg(String result) {

		if (result.contains("callback") && result.contains("error")) {

			result = result.replace("callback", "").replace("(", "")
					.replace(")", "").replace(";", "");

			JSONObject object = JSONObject.fromObject(result.trim());

			return object;
		}

		return null;
	}

	/**
	 * app端传递的参数解析成json放入session中
	 * 
	 * @return
	 */
	public static void appParamsToJsonSetSession(HttpServletRequest request,
			String sessionKey) {

		Map<String, String[]> map = request.getParameterMap();

		JSONObject object = new JSONObject();

		if (map != null && map.size() > 0) {
			String value = null;
			String redirectUrl = null;
			if (map.containsKey(CommConstant.REDIRECT_URL)) {
				redirectUrl = map.get(CommConstant.REDIRECT_URL)[0];
			}
			String appendStr = "";
			for (Map.Entry<String, String[]> m : map.entrySet()) {
				value = m.getValue()[0];
				object.put(m.getKey(), value);
				if (!CommConstant.REDIRECT_URL.equals(m.getKey())) {
					appendStr += "&" + m.getKey() + "=" + value;
				}
			}
			if (StringUtils.isAllNotEmpty(redirectUrl, appendStr)) {
				redirectUrl += appendStr.replaceFirst("&", "?");
				object.put(CommConstant.REDIRECT_URL, redirectUrl);
			}
		}
		request.getSession().setAttribute(sessionKey, object.toString());
	}

	/**
	 * 从session中取得app端传递的参数解析成json
	 * 
	 * @return
	 */
	public static JSONObject appParamsToJsonFromSession(
			HttpServletRequest request, String sessionKey) {
		String appParam = (String) request.getSession()
				.getAttribute(sessionKey);
		JSONObject object = new JSONObject();
		if (StringUtils.isNotEmpty(appParam)) {
			object = JSONObject.fromObject(appParam);
		}
		return object;
	}

	/**
	 * 判断两个日期是否是同一天
	 * 
	 * @param date
	 * @param minitues
	 *            分钟
	 * @return
	 */
	public static boolean isSameDay(Date date, Date date2) {

		Calendar calDateA = Calendar.getInstance();
		calDateA.setTime(date);

		Calendar calDateB = Calendar.getInstance();
		calDateB.setTime(date2);

		return calDateA.get(Calendar.YEAR) == calDateB.get(Calendar.YEAR)
				&& calDateA.get(Calendar.MONTH) == calDateB.get(Calendar.MONTH)
				&& calDateA.get(Calendar.DAY_OF_MONTH) == calDateB
						.get(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 替换旧的jsonarray数据
	 * 
	 * @param jsonArr1
	 *            原始的array
	 * @param jsonArr2
	 *            新修改的array
	 * @param keyConstant
	 *            array中的obj其中的一个key，必须jsonArr1和jsonArr2中都有且一样
	 * @return
	 */
	public static JSONArray replaceIndexJsonObject(String jsonArr1,
			String jsonArr2, String keyConstant) {

		JSONArray array = JSONArray.fromObject(jsonArr1);
		// 修改后的数据
		JSONArray array2 = JSONArray.fromObject(jsonArr2);
		JSONObject jsonObject = null;
		JSONObject jsonObject2 = null;
		JSONArray array3 = new JSONArray();
		array3 = array;
		if (!array2.isEmpty()) {

			// 循环修改的数据
			for (int j = 0; j < array2.size(); j++) {

				jsonObject2 = array2.getJSONObject(j);

				// 取得修改的是哪个数据
				for (int k = 1; k < 5; k++) {

					String key = keyConstant + k;

					if (jsonObject2.containsKey(key)) {

						int count = 0;
						for (int i = 0; i < array.size(); i++) {

							jsonObject = array.getJSONObject(i);

							if (!jsonObject.containsKey(key)) {
								count++;
							} else {
								array3.remove(i);
								array3.add(i, jsonObject2);
							}
							if (count == array.size()) {
								array3.add(i, jsonObject2);
								break;
							}
						}
					}
				}
			}
		}
		return array3;
	}

	/**
	 * 将user对象放入到session中
	 * 
	 * @param date
	 * @param minitues
	 *            分钟
	 * @return
	 */
	public static void setSessionUser(HttpServletRequest request, UserLoginModel user) {

		JSONObject jsonObject = JSONObject.fromObject(user);

		request.getSession().setAttribute(CommConstant.SESSION_MANAGER,jsonObject.toString());
	}

	/**
	 * 将user对象放入到session中
	 * 
	 * @param date
	 * @param minitues
	 *            分钟
	 * @return
	 */
	public static User getSessionUser(HttpServletRequest request) {

		User user = null;
		String jsonString = (String) request.getSession().getAttribute(
				CommConstant.SESSION_MANAGER);
		if (StringUtils.isNotEmpty(jsonString)) {
			JSONObject jsonObject = JSONObject.fromObject(jsonString);
			user = (User) JSONObject.toBean(jsonObject, User.class);
		}
		return user;
	}

	/**
	 * 计算日期天数
	 * 
	 * @param date
	 * @param minitues
	 *            分钟
	 * @return
	 */
	public static long calcDays(Date date1, Date date2) {

		// 当前时间处理
		Calendar cal = Calendar.getInstance();
		cal.setTime(date1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);

		// 给定时间处理
		Calendar setCal = Calendar.getInstance();
		setCal.setTime(date2);
		setCal.set(Calendar.HOUR_OF_DAY, 0);
		setCal.set(Calendar.MINUTE, 0);
		setCal.set(Calendar.SECOND, 0);
		setCal.set(Calendar.MILLISECOND, 0);

		long dayDiff = (setCal.getTimeInMillis() - cal.getTimeInMillis())
				/ (1000 * 60 * 60 * 24);
//		ConsoleUtil.println(dayDiff);
		return dayDiff;
	}
	/**
	 * 计算日期天数(包括时分秒)
	 * 
	 * @param date
	 * @param minitues
	 *            分钟
	 * @return
	 */
	public static long calcDays2(Date date1, Date date2) {
		
		// 当前时间处理
		Calendar cal = Calendar.getInstance();
		cal.setTime(date1);
		
		// 给定时间处理
		Calendar setCal = Calendar.getInstance();
		setCal.setTime(date2);
		
		long dayDiff = (setCal.getTimeInMillis() - cal.getTimeInMillis())
		/ (1000 * 60 * 60 * 24);
		//ConsoleUtil.println(dayDiff);
		return dayDiff;
	}
	/**
	 * 计算日期秒数(包括时分秒)
	 * 
	 * @param date
	 * @param minitues
	 *            分钟
	 * @return
	 */
	public static long calcSecs(Date date1, Date date2) {
		
		// 当前时间处理
		Calendar cal = Calendar.getInstance();
		cal.setTime(date1);
		
		// 给定时间处理
		Calendar setCal = Calendar.getInstance();
		setCal.setTime(date2);
		
		long dayDiff = (setCal.getTimeInMillis() - cal.getTimeInMillis()) / (1000);
		//ConsoleUtil.println(dayDiff);
		return dayDiff;
	}

	/**
	 * 判断是否手机端
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static boolean isPhone(HttpServletRequest request) throws Exception {

		String u = request.getHeader("user-agent").toLowerCase();

		ConsoleUtil.println(u);

		Pattern pattern = Pattern
				.compile("/applewebkit.*mobile.*/ || /applewebkit/");
		Matcher m = pattern.matcher(u);

		// android终端或者uc浏览器
		if (u.indexOf("android") > -1 || u.indexOf("linux") > -1
		// 是否为iPhone或者QQHD浏览器
				|| u.indexOf("iphone") > -1 || u.indexOf("mac") > -1
				// 是否iPad
				|| u.indexOf("ipad") > -1
				// 是否为移动终端
				|| !!m.matches()) {

			return true;
			//return false;
		}

		return false;

		/*
		 * trident: u.indexOf('Trident') > -1, //IE内核 presto:
		 * u.indexOf('Presto') > -1, //opera内核 webKit: u.indexOf('AppleWebKit')
		 * > -1, //苹果、谷歌内核 gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML')
		 * == -1, //火狐内核 mobile: , ios: !!u.match(/\\(i[^;]+;( U;)? CPU.+Mac OS
		 * X/), //ios终端 android: , iPhone: , iPad: , webApp: u.indexOf('Safari')
		 * == -1 //是否web应该程序，没有头部与底部 }; } language:(navigator.browserLanguage ||
		 * navigator.language).toLowerCase() }
		 * 
		 * window.location.href="URL"
		 */

	}

	/**
	 * 判断是否IOS手机端
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static boolean isIosPhone(HttpServletRequest request)
			throws Exception {

		String u = request.getHeader("user-agent").toLowerCase();

		ConsoleUtil.println(u);

		Pattern pattern = Pattern.compile("/\\(i[^;]+;( U;)? CPU.+Mac OS X/");
		Matcher m = pattern.matcher(u);
		// return u.indexOf("iphone") > -1 || u.indexOf("ipad") > -1 ||
		// !!m.matches();
		return false;
	}
	/**
	 * 判断是否IOS手机端
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static boolean isIosPhone2(HttpServletRequest request)
	throws Exception {
		
		String u = request.getHeader("user-agent").toLowerCase();
		Pattern pattern = Pattern.compile("/\\(i[^;]+;( U;)? CPU.+Mac OS X/");
		Matcher m = pattern.matcher(u);
		return u.indexOf("iphone") > -1 || u.indexOf("ipad") > -1 || !!m.matches();
	}

	/**
	 * 判断是否为微信端
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static boolean isWx(HttpServletRequest request)
			throws Exception {

		String u = request.getHeader("user-agent").toLowerCase();

		ConsoleUtil.println(u);

		return u.indexOf("micromessenger") > -1;
	}
	/**
	 * 获取周几
	 * @param date
	 * @return
	 */
	public static int getWeek(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int week = cal.get(Calendar.DAY_OF_WEEK) - 1;
		//0表示周末
		if(week == 0){
			return 7;
		}
		return week;
	}
	
	
	/**
	 * 通过HttpServletRequest返回IP地址
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return ip String
	 * @throws Exception
	 */
	public static String getIpAddr(HttpServletRequest request) {

		String ipAddress = null;
		try {
			// ipAddress = this.getRequest().getRemoteAddr();
			ipAddress = request.getHeader("x-forwarded-for");
			if (ipAddress == null || ipAddress.length() == 0
					|| "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("Proxy-Client-IP");
			}
			if (ipAddress == null || ipAddress.length() == 0
					|| "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getHeader("WL-Proxy-Client-IP");
			}
			if (ipAddress == null || ipAddress.length() == 0
					|| "unknown".equalsIgnoreCase(ipAddress)) {
				ipAddress = request.getRemoteAddr();
				if (ipAddress.equals("127.0.0.1")) {
					// 根据网卡取本机配置的IP
					InetAddress inet = null;
					try {
						inet = InetAddress.getLocalHost();
					} catch (Exception e) {
						e.printStackTrace();
					}
					ipAddress = inet.getHostAddress();
				}
			}

			// 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
			if (ipAddress != null && ipAddress.length() > 15) { // "***.***.***.***".length()
																// = 15
				if (ipAddress.indexOf(",") > 0) {
					ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return ipAddress;
	}
	
	/**
	 * 通过ip地址获取经纬度
	 * @return
	 */
	public static UserArea getUserAreaForLatAndLong(HttpServletRequest request,UserArea userArea){
		
		String ip = getIpAddr(request);
		
		if(StringUtils.isNotEmpty(ip)){
			
			try {
				if(userArea == null){
					//部署线上
					String url ="http://api.map.baidu.com/location/ip?ak=DqTGazNxpb6tujm41W2ULrtb&coor=bd09ll&ip=125.94.97.127";
//					String url ="http://api.map.baidu.com/location/ip?ak=DqTGazNxpb6tujm41W2ULrtb&coor=bd09ll&ip="+ip;
					String jsonRes = Connect.getUrlString(url);
					logger.info("百度ip获取位置后   jsonRes：" + jsonRes);
					ConsoleUtil.println("百度ip获取位置后   jsonRes：" + jsonRes);
					JSONObject object = Json.string2json(jsonRes);
					userArea = new UserArea();
					// 详细内容
					JSONObject content = object.getJSONObject("content");
					userArea.setAddress(content.getString("address"));
					JSONObject detail = content.getJSONObject("address_detail");
					userArea.setCity(detail.getString("city"));
					String baiduCode = detail.getString("city_code");
					userArea.setCity_code(baiduCode);
					userArea.setProvince(detail.getString("province"));
					JSONObject point = content.getJSONObject("point");
					userArea.setLongitude(point.getDouble("x"));// 经度
					userArea.setLatitude(point.getDouble("y"));// 纬度
					userArea.setStatus(object.getString("status"));
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error("通过ip地址获取经纬度",e);
			}
		}
		return userArea;
	}
	
	/**
	 * 获取WEB—INF的绝对路径
	 * @return
	 * @throws Exception
	 */
	public static String getProjectWebInfoPath() throws Exception{
		
		//取得根目录路径  
	    String rootPath=MyUtils.class.getResource("/").getFile().toString(); 
	    ConsoleUtil.println(rootPath);
	    return rootPath.replace("/classes/", "");
	}
	/**
	 * 获取WebRoot的绝对路径
	 * @return
	 * @throws Exception
	 */
	public static String getProjectWebRootPath() throws Exception{
		
		//取得根目录路径  
		String rootPath=MyUtils.class.getResource("/").getFile().toString(); 
		ConsoleUtil.println(rootPath);
		return rootPath.replace("/WEB-INF/classes/", "");
	}
	/**
	 * 计算范围值，是否可获取对应的状态
	 * @return
	 * @throws Exception
	 */
	public static boolean calcRangeReturnStatus(String range,Integer compareValue) throws Exception{
		
		if(StringUtils.isEmptyNo(range)){
			
			return false;
		}
		String[] r = range.split("~");
		
		if(r.length < 2){
			
			if(compareValue >= Integer.valueOf(r[0])){
				
				return true;
			}
			
			return false;
		}else{
			
			if(Integer.valueOf(r[0]) <= compareValue && compareValue <= Integer.valueOf(r[1])){
				
				return true;
			}
			
			return false;
		}
		
	}
	/**
	 * 获取最大值
	 * @return
	 * @throws Exception
	 */
	public static Long obtainMax(List<MyEarnings> list) throws Exception{
		
		Long n = null;
		for (MyEarnings mer : list) {
			
			if(null == n){
				n = mer.getPaincbuyProjectId();
			}
			
			if(n < mer.getPaincbuyProjectId()){
				
				n = mer.getPaincbuyProjectId();
			}
		}
		
		return n;
	}
	
	/**
	 * 拼接完整的地址
	 * @return
	 * @throws Exception
	 */
	public static String getCompleteAddress(Long provinceId,Long cityId,String address) throws Exception{
		
		String provinceName = PhoneBaseData.getInstance().getArea_V2Name(provinceId+"");
		String cityName = PhoneBaseData.getInstance().getArea_V2Name(cityId+"");
		if (provinceName == null) {
			provinceName = "";
		}
		if (cityName == null) {
			cityName = "";
		}
		if (provinceName.equals(cityName)) {
			cityName = "";
		}
		address = provinceName + cityName + address;
		
		return address;
	}

	public void test(HttpServletRequest request) {

	}
	
	/**
	 * 计算分页栏分页数值
	 * @param perPages 页大小
	 * @param countRows 总记录数
	 * @param currentPage 当前页
	 * @param showPageNum 分页栏要显示的数值数量
	 * @return
	 */
	public static PagerArg calcPagerNum(int perPages, int countRows,int currentPage, int showPageNum){
		//Map<String, Object> result = new HashMap<String, Object>();
		int pageCount = (int) Math.ceil((double)countRows/perPages);
		int offset = (int) Math.floor((double)showPageNum/2);
		int beginPage = currentPage-offset;
		int endPage = currentPage+offset;
		if(beginPage<1){
			endPage += Math.abs(beginPage)+1;
			beginPage=1;
		}
		if(endPage>pageCount){
			endPage = pageCount;
		}
		if(endPage == pageCount){
			beginPage = endPage-offset*2;
			if(beginPage<1)
				beginPage=1;
		}
		if(beginPage == 1){
			endPage = 1+offset*2;
			if(endPage>pageCount)
				endPage=pageCount;
		}
		int lastPage = currentPage-1;
		int nextPage = currentPage+1;
		if(lastPage<beginPage){
			lastPage = beginPage;
		}
		if(nextPage>endPage){
			nextPage = endPage;
		}
		
		/*result.put("beginPage", beginPage);
		result.put("endPage", endPage);
		result.put("lastPage", lastPage);
		result.put("currentPage", currentPage);
		result.put("nextPage", nextPage);
		result.put("rowCount", countRows);
		result.put("pageCount",pageCount);
		return result;*/
		return new PagerArg(beginPage, endPage, lastPage, currentPage, nextPage, countRows, pageCount);
	}
	
	public static void main(String[] args) throws Exception {
		/*String rex = "^[0-9+]\\d{13,17}|[0-9+]\\d{13,17}x";
		Pattern pattern = Pattern.compile(rex);
		Matcher m = pattern.matcher("42028119891014111x");
		ConsoleUtil.println(m.matches());
		
		calcDays2(MyUtils.dateFormat("2015-07-06 10:00:00", 0), new Date());
		
		BigDecimal money = new BigDecimal(2);
		ConsoleUtil.println(money.multiply(new BigDecimal(100)).intValue());
		
		ConsoleUtil.println(dateFormat("20141030133525", 4));
		
		SortedMap<String, String> packageParams = new TreeMap<String, String>();
		
		packageParams.put("appid","wxbe1733e33bb01bdf");
		packageParams.put("attach","324764");
		packageParams.put("bank_type","CFT");
		packageParams.put("cash_fee","1");
		packageParams.put("fee_type","CNY");
		packageParams.put("is_subscribe","Y");
		packageParams.put("mch_id","1252770301");
		packageParams.put("nonce_str","172608RtuS");
		packageParams.put("openid","ouH5Awi4P38BF55zMVOjm0Vigw-U");
		packageParams.put("out_trade_no","1507094310");
		packageParams.put("result_code","SUCCESS");
		packageParams.put("return_code","SUCCESS");
		packageParams.put("sign","7A9E9B9CAF8760B2277B632C639FF090");
		packageParams.put("time_end","20150709172619");
		packageParams.put("total_fee","1");
		packageParams.put("trade_type","JSAPI");
		packageParams.put("transaction_id","1001450064201507090375450932");
		
		StringBuffer sb = new StringBuffer();
		Set es = packageParams.entrySet();
		Iterator it = es.iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			String k = (String) entry.getKey();
			String v = (String) entry.getValue();
			if (null != v && !"".equals(v) && !"sign".equals(k) && !"key".equals(k)) {
				sb.append(k + "=" + v + "&");
			}
			ConsoleUtil.println("sign - key :"+k+"- > value :"+v);
		}
		sb.append("key=pxx3wxYcTPyKdTSOLeLncIbBF18JuWcH");
		ConsoleUtil.println("md5 sb:" + sb);
		String sign = MD5.GetMD5Code(sb.toString(), "UTF-8").toUpperCase();
		ConsoleUtil.println("packge签名:" + sign);*/
		//企业代码+用户密码
//		String  s = "hzdhlzxhzd158";
//		ConsoleUtil.println(MD5.GetMD5Code(s));
//		
//		ConsoleUtil.println(ToolKit.getInstance().getSingleConfig("xxxx"));
		
		
//		String s1="[{\"categoryId\":90,\"userId\":105,\"shopId\":344828,\"serviceId\":1169,\"purchaseNum\":1,\"name\":\"水杯\",\"path\":\"/upload/2015-07-23/1437615657429411198.jpg\",\"price\":0.01,\"summary\":\"一个黄色的水杯\"}]";
//		
//		JSONArray array = JSONArray.fromObject(s1);
//		
//		for (int j = 0; j < array.size(); j++) {
//			
//			ConsoleUtil.println(array.getJSONObject(j).getLong("serviceId"));
//		}
		//对所有待签名参数按照字段名的 ASCII 码从小到大排序
		/*SortedMap<String, String> packageParams = new TreeMap<String, String>();
		packageParams.put("accesstoken", "OezXcEiiBSKSxW0eoylIeBFk1b8VbNtfWALJ5g6aMgZHaqZwK4euEskSn78Qd5pLsfQtuMdgmhajVM5QDm24W8X3tJ18kz5mhmkUcI3RoLm7qGgh1cEnCHejWQo8s5L3VvsFAdawhFxUuLmgh5FRA");
		packageParams.put("appid", "wx17ef1eaef46752cb");
		packageParams.put("url", "http://open.weixin.qq.com/");
		packageParams.put("timestamp", "1384841012");
		packageParams.put("noncestr", "123456");
		
		
		String addrsign = Sha1Util.createSHA1Sign(packageParams);
		
		
		String strSrc = "accesstoken=OezXcEiiBSKSxW0eoylIeBFk1b8VbNtfWALJ5g6aMgZHaqZwK4euEskSn78Qd5pLsfQtuMdgmhajVM5QDm24W8X3tJ18kz5mhmkUcI3RoLm7qGgh1cEnCHejWQo8s5L3VvsFAdawhFxUuLmgh5FRA&appid=wx17ef1eaef46752cb&noncestr=123456&timestamp=1384841012&url=http://open.weixin.qq.com/";		
		
		//ca604c740945587544a9cc25e58dd090f200e6fb
		//accesstoken=OezXcEiiBSKSxW0eoylIeBFk1b8VbNtfWALJ5g6aMgZHaqZwK4euEskSn78Qd5pLsfQtuMdgmhajVM5QDm24W8X3tJ18kz5mhmkUcI3RoLm7qGgh1cEnCHejWQo8s5L3VvsFAdawhFxUuLmgh5FRA&appid=wx17ef1eaef46752cb&noncestr=123456&timestamp=1384841012&url=http://open.weixin.qq.com/
		//accesstoken=OezXcEiiBSKSxW0eoylIeBFk1b8VbNtfWALJ5g6aMgZHaqZwK4euEskSn78Qd5pLsfQtuMdgmhajVM5QDm24W8X3tJ18kz5mhmkUcI3RoLm7qGgh1cEnCHejWQo8s5L3VvsFAdawhFxUuLmgh5FRA&appid=wx17ef1eaef46752cb&noncestr=123456&timestamp=1384841012&url=http://open.weixin.qq.com/
		
		ConsoleUtil.println(addrsign);	
		ConsoleUtil.println(addrsign.equalsIgnoreCase("ca604c740945587544a9cc25e58dd090f200e6fb"));
		
		SortedMap<String, String> finalpackage = new TreeMap<String, String>();
		String timestamp = String.valueOf(System.currentTimeMillis() / 1000);
		String prepay_id2 = "prepay_id=1101000000140415649af9fc314aa427";
		finalpackage.put("appid", "wxd930ea5d5a258f4f");  
		finalpackage.put("partnerid", "1900000109");
		finalpackage.put("prepayid", "1101000000140415649af9fc314aa427");
		finalpackage.put("package", "Sign=WXPay");
		finalpackage.put("noncestr", "1101000000140429eb40476f8896f4c9");  
		finalpackage.put("timestamp", "1398746574");  
		
		StringBuffer sb = new StringBuffer();
		Set es = finalpackage.entrySet();
		Iterator it = es.iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			String k = (String) entry.getKey();
			String v = (String) entry.getValue();
			if (null != v && !"".equals(v) && !"sign".equals(k) && !"key".equals(k)) {
				sb.append(k + "=" + v + "&");
			}
			ConsoleUtil.println("sign - key :"+k+"- > value :"+v);
		}
		//sb.append("key=pxx3wxYcTPyKdTSOLeLncIbBF18JuWcH");
		ConsoleUtil.println("md5 sb:" + sb);
		String sign = MD5.GetMD5Code(sb.toString().substring(0,sb.toString().length() - 1), "UTF-8").toUpperCase();
		ConsoleUtil.println("packge签名:" + sign);*/
		
		
		/*ConsoleUtil.println(MD5.GetMD5Code("bjwg"));
		
		JSONObject jo = new JSONObject();
		jo.put("28天断奶仔猪1头", 0);
		jo.put("仔猪喂养至出栏所需", 0);
		jo.put("饲料", 0);
		jo.put("疫苗", 0);
		jo.put("保健费用", 0);
		jo.put("疾病治疗中草药费用", 0);
		jo.put("人工成本", 0);
		jo.put("固定资产折旧等", 0);
		ConsoleUtil.println(jo.toString());
		
		ConsoleUtil.println(new BigDecimal(2).divide(new BigDecimal(150.0),4,BigDecimal.ROUND_HALF_UP));*/
		
		SimpleDateFormat df=new SimpleDateFormat("E（MM月dd日） a hh：mm");  
		System.out.println(df.format(new Date()));
		
		/*Calendar calendar = Calendar.getInstance(Locale.CHINA);
		calendar.setTime(new Date());
		System.out.println("周"+calendar.);*/
		System.out.println(MD5.GetMD5Code(MD5.GetMD5Code("123456")+ LoginConstants.LOGIN_PASSWORD_PARAM));
		
		String u = "mozilla/5.0 (iphone; cpu iphone os 7_1 like mac os x) applewebkit/537.51.2 (khtml, like gecko) mobile/11d167 micromessenger/6.2.2 nettype/3g+ language/zh_cn";
		
		Pattern pattern = Pattern.compile("/micromessenger");
		Matcher m = pattern.matcher(u);
		
		System.out.println(u.indexOf("micromessenger") > -1);
		
		
		
		
	}
}
