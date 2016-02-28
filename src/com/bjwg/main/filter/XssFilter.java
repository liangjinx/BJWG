package com.bjwg.main.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.sun.org.omg.SendingContext.CodeBasePackage.URLHelper;



public class XssFilter implements Filter {
	private String filterChar;
	private String replaceChar;
	private String splitChar;
	private String excludeUrls;
	FilterConfig filterConfig = null;
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterChar=filterConfig.getInitParameter("FilterChar");
		this.replaceChar=filterConfig.getInitParameter("ReplaceChar");
		this.splitChar=filterConfig.getInitParameter("SplitChar");
		this.excludeUrls=filterConfig.getInitParameter("excludeUrls");
		this.filterConfig = filterConfig;
	}

	public void destroy() {
		this.filterConfig = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException {
		if(isExcludeUrl(request)){
			chain.doFilter(request, response);
		}else{
			chain.doFilter(new XssHttpServletRequestWrapper((HttpServletRequest) request,filterChar,replaceChar,splitChar), response);
		}
	}
	
	
	private boolean isExcludeUrl(ServletRequest request){
		boolean exclude=false;
		HttpServletRequest req = (HttpServletRequest)request;
		if(StringUtils.isNotBlank(excludeUrls)){
			 String[]excludeUrl=excludeUrls.split(splitChar);
			 if(excludeUrl!=null&&excludeUrl.length>0){
				 for(String url:excludeUrl){
					 if(req.getRequestURI().startsWith(url)){
						 exclude=true;
					 }
				 }
			 }
		}
		return exclude;
	}

}
