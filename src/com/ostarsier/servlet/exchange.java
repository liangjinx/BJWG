package com.ostarsier.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rm.utils.DBUtils;

public class exchange extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
			String record_id = request.getParameter("record_id");
		
			Connection conn = DBUtils.getConnection();
			Statement str = null;
			String sql = "update bjwg_lottery_record set type = 1 where record_id = " + record_id;
			
			try {
				str = conn.createStatement();
				int rs_num = str.executeUpdate(sql);
				if(rs_num > 0){
					response.setHeader("Content-type", "text/html;charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.write("<a href='backlist.jsp'>�޸ĳɹ��������б�ҳ��</a>");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
