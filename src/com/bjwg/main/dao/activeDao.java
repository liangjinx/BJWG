package com.bjwg.main.dao;

import java.util.List;


import com.bjwg.main.model.Active;
import com.bjwg.main.model.ActiveOrder;



public interface activeDao {
    
	Active selectByPrimaryKey(Long activeId);
	
    List<Active> selectList();
}