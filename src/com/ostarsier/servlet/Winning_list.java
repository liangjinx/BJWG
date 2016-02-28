package com.ostarsier.servlet;

import java.awt.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.jms.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.model.UserLoginModel;
import com.rm.utils.DBString;

public class Winning_list extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		Statement str = null;
		
		HttpSession userSession = request.getSession(false);
		
	
		
		/*userSession = request.getSession();*/
		try {
			Class.forName("com.mysql.jdbc.Driver");
			DBString dbString = new DBString();
			Connection conn = DriverManager.getConnection(dbString.getMysql_jdbc(), dbString.getMysql_uername(), dbString.getMysql_password());
			str = conn.createStatement();
			String sql = "select * from bjwg_lottery_record limit 50";
			ResultSet rs = str.executeQuery(sql);
			ArrayList<String> list_phone = new ArrayList<String>();
			ArrayList<String> list_prize = new ArrayList<String>();
			ArrayList<String> my_list_prize = new ArrayList<String>();
			ArrayList<String> my_list_exchange_code = new ArrayList<String>();
			int num = 0;
			while (rs.next()) {
				String phone = rs.getString("phone");
				String phone1 = phone.substring(0, 3);
				String phone2 = phone.substring(8, 11);
				String phone3 = phone1 + "*****" + phone2;
				list_phone.add(phone3);
				list_prize.add(rs.getString("prize"));
			}
			
			
			System.out.println("id="+userSession.getAttribute("user_id"));
			if(userSession.getAttribute("user_id")!=null){
				String sql1 = "select * from bjwg_lottery_record where user_id = " + userSession.getAttribute("user_id");
				System.out.println(sql1);
				ResultSet rs1 = str.executeQuery(sql1);
				while (rs1.next()) {
					my_list_prize.add(rs1.getString("prize"));
					my_list_exchange_code.add(rs1.getString("exchange_code"));
					
				}
				//获取抽奖次数
				String sql2 = "SELECT * FROM bjwg_lottery_num where user_id = " + userSession.getAttribute("user_id") ;
				ResultSet rs2 = str.executeQuery(sql2);
				while (rs2.next()) {
					num = rs2.getInt("num");
				}
			}
			else{
				request.getRequestDispatcher("loginLottery.jsp").forward(request, response);
			
			}
		
			
		
			int count = 0;
			//查询我的收益表，获得用户名下的猪仔总数
			String sql4 = "select * from bjwg_my_earnings where user_id = " + userSession.getAttribute("user_id") + " and earnings_id > 1092";
			ResultSet rs4 = str.executeQuery(sql4);
			while (rs4.next()) {
				count += Integer.parseInt(rs4.getString("num"))-Integer.parseInt(rs4.getString("present_num"));
				
			}
			//处理没有购买猪仔的用户有一次抽奖机会
			count = count +1 - num;
			
			userSession.setAttribute("list_phone", list_phone);
			userSession.setAttribute("list_prize", list_prize);
			userSession.setAttribute("my_list_prize", my_list_prize);
			userSession.setAttribute("my_list_exchange_code", my_list_exchange_code);
			userSession.setAttribute("num", num);
			System.out.println("num"+num);
			userSession.setAttribute("count", count);
			
		} catch (Exception e1) {
			
			e1.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
