package com.bjwg.main.filter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Map;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.filter.OncePerRequestFilter;

import com.bjwg.main.util.StringUtils;

/**
 * 过滤器
 * @author Allen
 * @version 创建时间：2015-4-7 下午02:12:04
 * @Modified By:Allen
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class SecurityFilter extends OncePerRequestFilter
{
    
    //不需要过滤的url
    private static final String[] noNeedFilterUrl = {"index.jsp","/resources/" ,"home.jsp","user_agreement.jsp"};

	@Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain arg2) throws ServletException, IOException
    {
        //是否需要过滤?
        if(noNeedFiltedUrl(request))
        {
        	String uri = request.getRequestURI();
        	
        	 
        	arg2.doFilter(new MyRequestWrapper(request), response);
        		
    	}else{
        		
    		//请求的资源无效
    		request.getRequestDispatcher("/index.jsp").forward(request, response);
    	}
        	
    }
    
    /**
     * 无需顾虑的url
     * @param request
     * @return
     */
    private boolean noNeedFiltedUrl(HttpServletRequest request){
        
        String contextPath = request.getContextPath();
        
        String currentUrl = request.getRequestURI();//取得根目录的相对路径
        
        if(StringUtils.isNotEmpty(currentUrl)){
            
            for (String s : noNeedFilterUrl)
            {
                
                if(currentUrl.startsWith(contextPath + s) || currentUrl.endsWith(s) || currentUrl.equals(contextPath + "/")){
                    
                    return true;
                }
                
            }
        }
        
        return false;
    }
}
