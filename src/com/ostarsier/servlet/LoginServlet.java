package com.ostarsier.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.bjwg.main.model.User;

import com.rm.utils.DBUtils;

public class LoginServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		User user = (User)request.getSession().getAttribute("Userlottery");
	
		if(user!=null){
			String username = user.getUsername();
			String password = user.getPassword();
			Connection conn = DBUtils.getConnection();
			ResultSet rs = null;
			Statement str = null;
			try {
				
				Integer user_id = null;
				str = conn.createStatement();
				rs = str.executeQuery("select * from bjwg_user where phone = '" + username + "'");
				if (rs.next()) {
					user_id = rs.getInt("user_id");
				
				rs.beforeFirst();
					while (rs.next()) {
					HttpSession userSession=request.getSession();
							userSession.setAttribute("user_id", user_id);
							userSession.setAttribute("username", username);
                     response.sendRedirect("indexLottery.jsp");		
						
					}
					
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DBUtils.closeResources(conn, null, rs);
			}
			
			
			
			
			
		}
		System.out.println("登录时最好的选择");
		
	
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		PrintWriter out = response.getWriter();
		if (username == null || username == "" || !isMobile(username)) {
			
			out.write("phone_null");
			response.sendRedirect("loginLottery.jsp");
			return;
		}
		Connection conn = DBUtils.getConnection();
		ResultSet rs = null;
		Statement str = null;
		try {
			
			Integer user_id = null;
			str = conn.createStatement();
			rs = str.executeQuery("select * from bjwg_user where phone = '" + username + "'");
			if (!rs.next()) {
				out.write("phone_no_exist");
				return;
			} else {
				if (password == null || password == "") {
					out.write("password_null");
					return;
				}
				rs.beforeFirst();
				while (rs.next()) {
					user_id = rs.getInt("user_id");
				
					if (!rs.getString("password").trim().equals(encrypt(password.trim()))) {
						out.write("password_error");
						return;
					} else {
				
						HttpSession userSession=request.getSession();
						userSession.setAttribute("user_id", user_id);
						userSession.setAttribute("username", username);
				out.write("True");
					}
				}
				
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DBUtils.closeResources(conn, null, rs);
		}

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	
	/**
	 * 手机号验证
	 * 
	 * @param str
	 * @return 验证通过返回true
	 */
	public static boolean isMobile(String str) {
		Pattern p = null;
		Matcher m = null;
		boolean b = false;
		p = Pattern.compile("^[1][3,4,5,7,8][0-9]{9}$"); // 验证手机号
		m = p.matcher(str);
		b = m.matches();
		return b;
	}

	/**
	 * 密码验证
	 * 
	 * @param str
	 * @return 验证通过返回true
	 */
	 public static boolean checkPassword(String str) { Pattern p = null;
		 Matcher m = null;
		 boolean b = false;
		 p = Pattern.compile("^[0-9a-zA-Z]{6,16}$"); // 验证密码为6-16位数的数字，字母或者符合 m =
		 p.matcher(str);
		 b = m.matches(); 
		 return b; 
	 }
	
	public static String encrypt(String pwd){
		 String pwjm;
		 pwjm=getMD5(pwd);
		 pwjm=getMD5(pwjm+"6d6630c5a8d0384aba30133b10375cec");  //两次加密,再加字符串
		 return pwjm;
	}

	public static String getMD5(String info)
		{
		  try
		  {
		    MessageDigest md5 = MessageDigest.getInstance("MD5");
		    md5.update(info.getBytes("UTF-8"));
		    byte[] encryption = md5.digest();
		      
		    StringBuffer strBuf = new StringBuffer();
		    for (int i = 0; i < encryption.length; i++)
		    {
		      if (Integer.toHexString(0xff & encryption[i]).length() == 1)
		      {
		        strBuf.append("0").append(Integer.toHexString(0xff & encryption[i]));
		      }
		      else
		      {
		        strBuf.append(Integer.toHexString(0xff & encryption[i]));
		      }
		    }	      
		    return strBuf.toString();
		  }
		  catch (NoSuchAlgorithmException e)
		  {
		    return "";
		  }
		  catch (UnsupportedEncodingException e)
		  {
		    return "";
		  }
		}

}
