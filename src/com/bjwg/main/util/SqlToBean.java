package com.bjwg.main.util;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 库表生成javaBean工具类(待完善)
 * @author :Allen  
 * @CreateDate : 2015-3-12 下午05:05:45 
 * @lastModified : 2015-3-12 下午05:05:45 
 * @version : 1.0
 * @jdk：1.6
 * @description: 目前也可以使用，但是po里面的属性类型要手动修改
 */
public class SqlToBean {
	private Connection conn = null;    //保存链接路径
	private Statement stmt = null;     //建立连接
	private ResultSetMetaData meta = null;  //保存表属性信息
	private ResultSet rs = null;  //查询结果集
	private OutputStreamWriter osw = null;
	private BufferedWriter bw = null;
	private FileOutputStream fos = null;
	private static StringBuffer coding = new StringBuffer();  //字符串缓冲区
	private String driver = null;    //数据库包名
	private String url = null;          //路径名
	private String table = null;        //表空间名
	private String password = null;     //密码
	private String tableName = null;    //表名
	
	private static StringBuffer special = new StringBuffer("");
	
	public SqlToBean(String driver, String url, String table, String password, String tableName) {
	  this.driver = driver;
	  this.url = url;
	  this.table = table;
	  this.password = password;
	  this.tableName = tableName;
	}

	private String getCoding(StringBuffer code) {
	  return code.toString();
	}
	
	private StringBuffer createGenerate(String property) {
	  String prop = property.toLowerCase();
	  coding.append("\r \t/**");
	  coding.append("\r \t *");
	  coding.append("\r \t *the columnName is "+property.toUpperCase());
	  coding.append("\r \t */");
	  
	  String[] s = prop.split("_");
		
//	  prop = s[0] + (s.length > 1 ? StringUtils.firstToUpperCase(s[1]) : "");
	  
	  for (int i = 0; i < s.length; i++) {
		
		  if(i == 0){
			  
			  prop = s[0];
		  }else{
			  
			  prop += StringUtils.firstToUpperCase(s[i]);
		  }
	  }
	  
	  
	  coding.append("\r \tprivate String " + prop + ";");
	  
	  special.append("\r \t\tif("+prop+" != null){").append("\n\r \t\t\t").append("sList.add(\""+property.toUpperCase()+"\");").append("\r \t\t\tlist.add("+prop+");").append("\r \t\t}");
	  
	  
	  return coding;
	}
	
	private StringBuffer createMethod(String[] str){
		
		String t1 = null;
		String[] s = null;
	  for(int i=0;i<str.length;i++){
	    //str[i].charAt(0) - 32)转成大写   思路
	    str[i] = str[i].toLowerCase();
	    
	    s = str[i].split("_");
	    
//	    t1 = "";
//	    t1 = s[0] + (s.length > 1 ? StringUtils.firstToUpperCase(s[1]) : "");
	    
	    for (int j = 0; j < s.length; j++) {
			
			  if(j == 0){
				  
				  t1 = s[0];
			  }else{
				  
				  t1 += StringUtils.firstToUpperCase(s[j]);
			  }
		}
		
	    coding.append("\r \tpublic void set" + (StringUtils.firstToUpperCase(t1))+"(String " + t1 +"){");
	    coding.append("\r \t\tthis."+t1 + "=" + t1 + ";");
	    coding.append("\r \t}");
	    coding.append("\r \tpublic String get" + StringUtils.firstToUpperCase(t1)+"(){");
	    coding.append("\r \t\treturn this."+t1 +  ";");
	    coding.append("\r \t");
	    coding.append("}\n");
	  }
	  return coding;
	}
	
	private StringBuffer createMethod2(String[] str){
		
		String t1 = null;
		String[] s = null;
		for(int i=0;i<str.length;i++){
			//str[i].charAt(0) - 32)转成大写   思路
			str[i] = str[i].toLowerCase();
			
			s = str[i].split("_");
			
			t1 = s[0] + (s.length > 1 ? StringUtils.firstToUpperCase(s[1]) : "");
			
			coding.append("\r \tpublic void set" + (StringUtils.firstToUpperCase(t1))+"(String " + t1 +"){");
			coding.append("\r \t\tthis."+t1 + "=" + t1 + ";");
			coding.append("\r \t}");
			coding.append("\r \tpublic String get" + StringUtils.firstToUpperCase(t1)+"(){");
			coding.append("\r \t\treturn this."+t1 +  ";");
			coding.append("\r \t");
			coding.append("}\n");
		}
		return coding;
	}
	/*
	 * 关闭与数据库的所有链接
	 * */
	private void destroy() {
	  try {
	    if(conn != null){
	      conn.close();
	      conn = null;
	    }
	    if(stmt != null){
	      stmt.close();
	      stmt = null;
	    }
	    if(rs != null){
	      rs.close();
	      rs = null;
	    }
	
	    if(bw != null){
	      bw.close();
	      bw = null;
	    }
	    if(fos != null) {
	      fos.close();
	      fos = null;
	    }
	    if(osw != null) {
	      osw.close();
	      osw = null;
	    }
	
	  } catch (SQLException e) {
	    e.printStackTrace();
	  }  catch (IOException e) {
	    e.printStackTrace();
	  }
	}
	/*
	 * 数据库连接发生异常就关闭链接
	 * */
	private  void connect () {
	  try {
	    Class.forName(driver);
	    conn = DriverManager.getConnection(url,table,password);
	    stmt = conn.createStatement();
	
	    rs = stmt.executeQuery("select  * from " + tableName ); //查询下确定结果集是那个表的
	    meta = rs.getMetaData();                         //调用结果集的记录表信息的方法
	  } catch (ClassNotFoundException e) {
	    e.printStackTrace();
	    try {
	      if(conn != null){
	        conn.close();
	        conn = null;
	      }
	      if(stmt != null){
	        stmt.close();
	        stmt = null;
	      }
	      if(rs != null){
	        rs.close();
	        rs = null;
	      }
	    } catch (SQLException e1) {
	      e.printStackTrace();
	    }
	  }  catch (SQLException e) {
	    e.printStackTrace();
	    try {
	      if(conn != null){
	        conn.close();
	        conn = null;
	      }
	      if(stmt != null){
	        stmt.close();
	        stmt = null;
	      }
	      if(rs != null){
	        rs.close();
	        rs = null;
	      }
	    } catch (SQLException e1) {
	      e.printStackTrace();
	    }
	  } 
	
	}
	
	private String[] getColumenName() {
	  /*得到表的所有列名以字符串数组的形式返回
	   * */
	  int count;
	  String[] str = null;
	  try {
	    count = meta.getColumnCount();
	    String[] strColumenName = new String[count];
	    for(int i = 1;i <= count; i++) {
//	    	ConsoleUtil.println(meta.getColumnName(i) + "\t--"  + meta.getScale(i) + "\t--" + meta.getColumnClassName(i) + "\t--" + meta.getColumnTypeName(i) + "\t--" + meta.getColumnType(i));
	      strColumenName[i-1] = meta.getColumnName(i);
	    }
	    str = strColumenName;
	  } catch (SQLException e) {
	    e.printStackTrace();
	  }
	  return str;
	}
	
	
	/*
	private String[] getJdbcType() {
		
		  int count;
		  String[] str = null;
		  try {
		    count = meta.getColumnCount();
		    String[] strColumenName = new String[count];
		    for(int i = 1;i <= count; i++) {
		    	ConsoleUtil.println(meta.getColumnName(i) + "\t--"  + meta.getScale(i) + "\t--" + meta.getColumnClassName(i) + "\t--" + meta.getColumnTypeName(i) + "\t--" + meta.getColumnType(i));
		      strColumenName[i-1] = meta.getColumnName(i);
		    }
		    str = strColumenName;
		  } catch (SQLException e) {
		    e.printStackTrace();
		  }
		  return str;
	}*/
	
	/**
	 * 写入指定的文件中
	 * @param message
	 */
	private void writeData(String message,String className,String projectUrl,String pacakeName) {
		
		String packageUrl = pacakeName.replace(".", "\\");
		
		String fileUrl = projectUrl + packageUrl+"\\"+className+".java";
		
		File file = new File(fileUrl);
		
		try {
			//若没有创建包，则自动创建
			FileUtils.createFile(file);
			
			fos = new FileOutputStream(file);
			osw = new OutputStreamWriter(fos);
			bw = new BufferedWriter(osw);
			bw.write(message);
			bw.flush();
			
		} catch (Exception e) {
			
		}
		
	
	}
	
	public StringBuffer createClassName(String className){
	  coding.append("public class " + className + "{\n");
	  return coding;
	}

	
	/*
	 * 字段类型 -> java类型 -> Oracle 类型 ：
	 * 
	 * int -> BigDecimal -> NUMBER
	 * char -> String -> CHAR
	 * long -> String -> LONG
	 * Number -> BigDecimal -> NUMBER
	 * varchar(2) -> String -> VARCHAR2
	 * timestamp -> oracle.sql.TIMESTAMP -> TIMESTAMP
	 * date -> java.sql.Timestamp -> DATE
	 * BLOB -> oracle.sql.BLOB ->BLOB
	 * 
	 */
	
	
	public static void main(String[] args) {
		
		
		
		String driverClass = "oracle.jdbc.driver.OracleDriver";
		
		String url = "jdbc:oracle:thin:@192.168.1.7:1521:orcl";
		
		String username = "scott";
		
		String passwd ="tiger";
		
		//数据库表名(可修改)
		String tableName = "HZD_PROVALUE";
		
		//要映射的java类名(可修改)
		String className = "Provalue";
		
		//工程路径(可修改)
		String projectUrl="D:\\O2O\\O2O_MAIN\\src\\";
		
		//包名(可修改)
		String packageName="com.bjwg.main.model";
		
		SqlToBean sqlToBean = new SqlToBean(driverClass,url,username,passwd,tableName);
//	  	SqlToBean sqlToBean = new SqlToBean("org.gjt.mm.mysql.Driver","jdbc:mysql://117.79.84.144:3306/wordpress","wangjun","wangjun123","wp_users");
		
		//连接数据库
		sqlToBean.connect();
		
		coding.append("package "+packageName+";\n\n\n");
		coding.append("import java.util.ArrayList;\r");
		coding.append("import java.util.Date;\r");
		coding.append("import java.util.HashMap;\r");
		coding.append("import java.util.List;\r");
		coding.append("import java.util.Map;\r");
		
		sqlToBean.createClassName(className);
		
		//获取表的字段
		String[] str ;
		
		str = sqlToBean.getColumenName();
		
		for(int i = 0;i<str.length ;i++) {
			
			sqlToBean.createGenerate(str[i]);
		}
		coding.append("\n");
		
		sqlToBean.createMethod(str);
		
		coding.append("\n");
		
		String s = "\r \t/**\r \t/**\r \t *分别封装不为空值的字段和值\r \t */\r \tpublic Map<String, List> obtainNotNullColumn(){" ;
		
		s += "\r \t\tMap<String, List> map = new HashMap<String, List>();";
		s += "\r \t\tList<Object> list = new ArrayList<Object>();";
		s += "\r \t\tList<String> sList = new ArrayList<String>();";
 		
		s += special.toString();
		
		s += "\r \t\tmap.put(\"columns\", sList);";
		s += "\r \t\tmap.put(\"values\", list);";
		s += "\r \t\treturn map;";
		s += "\n\t}";
		
		coding.append(s);
		
		coding.append("\n");
		
		coding.append("}");
		
		
		
		//写入文件
		sqlToBean.writeData(sqlToBean.getCoding(coding),className,projectUrl,packageName);
		
		sqlToBean.destroy();
	}

}
