package com.ostarsier.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rm.utils.DBString;
import com.rm.utils.getRandomCharAndNumr;

public class AwardServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//不在抽奖时间内
	try {
		Date start_date=sdf.parse("2015-11-10 18:00:11");
		Date now_date=sdf.parse(sdf.format(new Date()));
		Date end_date=sdf.parse("2015-11-11 18:00:00");
		String isLogin= "";
		if(start_date.getTime() > now_date.getTime() || now_date.getTime() > end_date.getTime()){
			System.out.println("请在抽奖活动时间内抽奖！");
			String msg = "请在抽奖活动时间内抽奖！";
			String isTime = "no_time";
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("{\"isTime\":\""+isTime+"\",\"msg\":\""+msg+"\",\"angle\":\""+270+"\"}");
			return;
		}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		//没有登录的处理
		HttpSession userSession = request.getSession();
		System.out.println(userSession);
		if(userSession.getAttribute("username") == null){ 
			System.out.println("用户还没有登录");
			String msg = "请登录后再抽奖吧！";
			String isLogin = "no_login";
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("{\"isLogin\":\""+isLogin+"\",\"msg\":\""+msg+"\",\"angle\":\""+270+"\"}");
			return;
		}
		//登录后的处理
		Object[][] prizeArr = new  Object[][]{
				//id,min,max，prize【奖项】,v【中奖率】
				{1,30,31,"纪念奖",20},
				{2,60,61,"幸运奖三",15},
				{3,90,91,"幸运奖二",10},
				{4,120,121,"幸运奖一",5},
				{5,150,151,"大福星",0},
				{6,180,181,"运气王",0},
				{7,210,211,"纪念奖",20},
				{8,240,241,"幸运奖三",15},
				{9,270,271,"幸运奖二",10},
				{10,300,301,"幸运奖一",5},
				{11,330,331,"大福星",0},
				{12,360,1,"运气王",0},
		};
		Object result[] = award(prizeArr);//抽奖后返回角度和奖品等级
		
		
		String sql2 = "";
		int num = 0;
		int count = 0;
		Statement str = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			DBString dbString = new DBString();
			Connection conn = DriverManager.getConnection(dbString.getMysql_jdbc(), dbString.getMysql_uername(), dbString.getMysql_password());
			str = conn.createStatement();
			String sql1 = "select * from bjwg_lottery_num where user_id = '" + userSession.getAttribute("user_id") + "'";
			ResultSet rs = str.executeQuery(sql1);
			if(rs.next()){
				rs.beforeFirst();	
				while (rs.next()) {
					num = rs.getInt("num") +1;
				}
				//updata
				sql2 = "update bjwg_lottery_num set num = '" + num + "' where user_id = " +  userSession.getAttribute("user_id");
			}else{
				//insert
				sql2 = "insert into bjwg_lottery_num(num, user_id) values('1','"+ userSession.getAttribute("user_id") +"');";
			}
			
			//查询我的收益表，获得用户名下的猪仔总数
			String sql4 = "select * from bjwg_my_earnings where user_id = " + userSession.getAttribute("user_id") +" and earnings_id > 1092";
			ResultSet rs4 = str.executeQuery(sql4);
			while (rs4.next()) {
				count += Integer.parseInt(rs4.getString("num"))-Integer.parseInt(rs4.getString("present_num"));
				
			}
			//处理没有购买猪仔的用户有一次抽奖机会
			count = count +1;
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// num 抽奖次数+1后
		// count 猪仔总数
		System.out.println(num +"----------" + count);
		
		if(num > count){
			//没有抽奖机会处理
			num = 99;
			result[2] = "您好！你没有抽奖机会";
		}else{
			//有抽奖机会处理
			//抽奖记录跟抽奖次数插入数据库开始
			try {
				
				String time=sdf.format(new Date());
				String exchange_code = getRandomCharAndNumr.getRandomCharAndNumrMethod(10);
				String sql = "insert into bjwg_lottery_record(prize,time,exchange_code,type,user_id,phone) values ('"+ result[2] +"','"+ time +"','"+ exchange_code +"','0','"+userSession.getAttribute("user_id")+"','"+userSession.getAttribute("username")+"');";
				int rs_num = str.executeUpdate(sql);
				if(rs_num > 0){
					System.out.println("抽奖记录保存成功");
				}

				int rs_num1 = str.executeUpdate(sql2);
				if(rs_num1 > 0){
					System.out.println("抽奖次数更新成功");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			//抽奖记录跟抽奖次数插入数据库结束
		}
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("{\"angle\":\""+result[0]+"\",\"msg\":\""+result[2]+"\",\"num\":\""+num+"\"}");
		System.out.println("转动角度:"+result[0]+"\t奖项ID:"+result[1]+"\t提示信息:"+result[2]);
	}
	
	
	//抽奖并返回角度和奖项
	public Object[] award(Object[][] prizeArr){
		//概率数组
		Integer obj[] = new Integer[prizeArr.length];
		for(int i=0;i<prizeArr.length;i++){
			obj[i] = (Integer) prizeArr[i][4];
		}
		Integer prizeId = getRand(obj); //根据概率获取奖项id
		//旋转角度
		int angle = new Random().nextInt((Integer)prizeArr[prizeId][2]-(Integer)prizeArr[prizeId][1])+(Integer)prizeArr[prizeId][1];
		String msg = (String) prizeArr[prizeId][3];//提示信息
		return new Object[]{angle,prizeId,msg};
	}
	//根据概率获取奖项
	public Integer getRand(Integer obj[]){
		Integer result = null;
		try {
			int  sum = 0;//概率数组的总概率精度 
			for(int i=0;i<obj.length;i++){
				sum+=obj[i];
			}
			for(int i=0;i<obj.length;i++){//概率数组循环 
				int randomNum = new Random().nextInt(sum);//随机生成1到sum的整数
				if(randomNum<obj[i]){//中奖
					result = i;
					break;
				}else{
					sum -=obj[i];
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
