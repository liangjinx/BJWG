package com.bjwg.main.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.bjwg.main.constant.SQLConstant;

/**
 * sql语句工具类
 * @author Allen
 * @version 创建时间：2015-4-3 下午05:49:27
 * @Modified By:Allen
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class SqlUtil
{
    
    /**
     * 拼接sql语句
     * @param operateType sql类型
     * @param tblName 表名
     * @param columns 列名
     * @return
     */
    public static String appendSql(int operateType, String tblName, List<String> columns){
        
        StringBuffer sql = new StringBuffer();
        
        switch (operateType)
        {
            case SQLConstant.INSERT:
                
                sql.append("insert into ").append(tblName).append("(");
                
                for (int i = 0; i < columns.size(); i++)
                {
                    
                    sql.append(columns.get(i)).append(",");
                    
                }
                
                sql = new StringBuffer(sql.substring(0, sql.length() - 1));
                
                sql.append(")").append(" values (");
                
                for (int i = 0; i < columns.size(); i++)
                {
                    
                    sql.append("?,");
                    
                }
                
                sql = new StringBuffer(sql.substring(0, sql.length() - 1));
                
                sql.append(")");
                
                break;
            case SQLConstant.DELETE:
                
                sql.append("delete ").append(tblName).append(" where ");
                
                for (int i = 0; i < columns.size(); i++)
                {
                    
                    sql.append(columns.get(i)).append("= ?").append(" and");
                    
                }
                
                sql = new StringBuffer(sql.substring(0, sql.length() - 3));
                
                break;
                
            case SQLConstant.UPDATE:
                
                sql.append("update ").append(tblName).append(" set ");
                
                for (int i = 0; i < columns.size(); i++)
                {
                    
                    sql.append(columns.get(i)).append("= ?").append(" ,");
                    
                }
                
                sql = new StringBuffer(sql.substring(0, sql.length() - 1));
                
                break;
                
            case SQLConstant.SELECT:
                
                sql.append("select * from").append(tblName).append(" where ");
                
                for (int i = 0; i < columns.size(); i++)
                {
                    
                    sql.append(columns.get(i)).append("= ? and");
                    
                }
                
                sql = new StringBuffer(sql.substring(0, sql.length() - 3));
                
                break;

            default:
                
            break;
            
        }
        
        return sql.toString();
    }

    
    public static void main(String[] args)
    {
        
        SqlUtil sqlUtil = new SqlUtil();
        
//        String tblName = "O2O_Manager";
        
//        List<String> columns = new ArrayList<String>(Arrays.asList("username","password"));
        
        String tblName = "HZD_SHOP";
	    List<String> columns = new ArrayList<String>(Arrays.asList("shop_id","name","address"));
        
        ConsoleUtil.println(appendSql(SQLConstant.DELETE, tblName, columns));
        
    }
    
}
