package com.bjwg.main.base;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * @author chen
 * @version 创建时间：2015-6-21 上午09:44:34
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：自定义标签。功能是将传入的参数进行urlEncode编码返回
 */

public class EncodeTag extends SimpleTagSupport{
	
	 private String urlEncode;  
	
	@Override
	public void doTag() throws JspException, IOException {
		
		if(urlEncode != null){
            
            JspWriter out = getJspContext().getOut();  
            
            try
            {
            	out.append( java.net.URLEncoder.encode( urlEncode+"" ,   "utf-8") );
                
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }
		
		super.doTag();
	}

	public String getUrlEncode() {
		return urlEncode;
	}

	public void setUrlEncode(String urlEncode) {
		this.urlEncode = urlEncode;
	}

}
