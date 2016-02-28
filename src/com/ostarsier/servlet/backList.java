package com.ostarsier.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rm.utils.DBUtils;

public class backList extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ArrayList<Integer> list_record_id =new ArrayList<Integer>();
		ArrayList<String> list_prize = new ArrayList<String>();
		ArrayList<String> list_time = new ArrayList<String>();
		ArrayList<String> list_exchange_code = new ArrayList<String>();
		ArrayList<Integer> list_type = new ArrayList<Integer>();
		
			Connection conn = DBUtils.getConnection();
			ResultSet rs = null;
			Statement str = null;
			
			String sql = "select * from bjwg_lottery_record";

			try {
				str = conn.createStatement();
				rs = str.executeQuery(sql);
				while (rs.next()) {
					list_record_id.add(rs.getInt("record_id"));
					list_prize.add(rs.getString("prize"));
					list_exchange_code.add(rs.getString("exchange_code"));
					list_time.add(rs.getString("time"));
					list_type.add(rs.getInt("type"));
				}
				
				HttpSession session=request.getSession();
				session.setAttribute("list_record_id", list_record_id);
				session.setAttribute("list_prize", list_prize);
				session.setAttribute("list_exchange_code", list_exchange_code);
				session.setAttribute("list_time", list_time);
				session.setAttribute("list_type", list_type);
				PrintWriter out = response.getWriter();
				out.write("True");
			} catch (Exception e) {
				e.printStackTrace();
			}
		
	}

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
