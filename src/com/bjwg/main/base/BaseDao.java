package com.bjwg.main.base;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.bjwg.main.util.BeanConvertUtils;
import com.bjwg.main.util.MyUtils;

/**
 * @author chen
 * @version 创建时间：2015-3-30 上午10:20:02
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明： BaseDao 的实现层   
 */
@Repository
public class BaseDao<T>{
	
	@Autowired
	public JdbcTemplate jdbcTemplate;
	
	public String sql = null;
	
	public Object[] obj = null;
	
	
	/**
	 * 根据id查询实体对象
	 */
	public T getById(Integer id,Class<T> clazz) throws Exception {
		List<Map<String,Object>> list = jdbcTemplate.queryForList(sql,obj);
		T entry = null;
		if(!MyUtils.isListEmpty(list))
		{
			entry = BeanConvertUtils.convertToBean(list,clazz).get(0);
		}
		return entry;
	}
	
	/**
	 * 保存实体对象
	 */
	public int save( T entity ) throws Exception {
		return jdbcTemplate.update(sql,obj);
	}
	
	/**
	 * 删除实体对象
	 */
	public int delete( Integer id) throws Exception {
		return jdbcTemplate.update(sql,new Object[]{id});
	}
	
	/**
	 * 多条件删除
	 * @param sql
	 * @param obj
	 * @return
	 */
	public int delete(String sql,Object... obj)
	{
		return jdbcTemplate.update(sql,obj);
	}
	
	
	/**
	 * 修改实体对象
	 */
	public int edit( T entity ) throws Exception {
		return jdbcTemplate.update(sql,obj);
	}

	/**
	 * 查询实体对象
	 */
	public List<T> getQuery(Class<T> clazz) {
		List<Map<String,Object>> list = jdbcTemplate.queryForList(sql);
		List<T> entry = BeanConvertUtils.convertToBean(list,clazz);
		return entry;
	}

	/**
	 * 条件查询实体对象
	 */
	public List<T> findQuery( T entity, Class<T> clazz) {
		List<Map<String,Object>> list = jdbcTemplate.queryForList(sql,obj);
		List<T> entry = BeanConvertUtils.convertToBean(list,clazz);
		return entry;
	}

	/**
     * 拼接分页查询的sql语句
     * @return
     */
    public String pageSql(String sql){
        
        sql = "SELECT * FROM ( SELECT A.*, ROWNUM RN FROM (" + sql +") A WHERE ROWNUM <= ? ) WHERE RN >=?";
        
        return sql;
    }
    /**
	 * 
	 * 根据条件查询多条记录(记录不存在返回null)
	 */
	public List<Map<String, Object>> findSome(String sql, Object[] obj)
	{
		List<Map<String, Object>> results=jdbcTemplate.queryForList(sql,obj);
		if(MyUtils.isNotEmpty(results))
		{
			return results;
		}
		return null;
	}
	
	/**
     * top sql语句
     * @return
     */
    public String topSql(String sql,Integer top){
    	
    	sql = "SELECT * FROM ( " + sql +" ) Where RowNum <= "+top;
    	
    	return sql;
    }
}
