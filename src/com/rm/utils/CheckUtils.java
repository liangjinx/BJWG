package com.rm.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CheckUtils {
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
	 
	 /**
		 * 密码加密
		 * 
		 */
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
