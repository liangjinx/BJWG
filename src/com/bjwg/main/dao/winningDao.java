package com.bjwg.main.dao;

import java.util.List;


import com.bjwg.main.model.ActiveWinning;



public interface winningDao {
    

	
    List<ActiveWinning> selectList(Long activeId);
    
    int insertWinning(ActiveWinning activeWinning);
    
    int selectCount(Long activeId);
}