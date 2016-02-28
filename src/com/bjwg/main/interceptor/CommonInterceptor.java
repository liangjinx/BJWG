package com.bjwg.main.interceptor;
/**
 * @author chen
 * @version 创建时间：2015-4-10 下午04:44:35
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bjwg.main.cache.UserCacheTask;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.RedirectConstant;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.security.UserMananger;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.CookieHelper;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.StringUtils;
  
@Repository
public class CommonInterceptor implements HandlerInterceptor {  
  
	public Logger logger = LoggerFactory.getLogger("LOGISTICS-COMPONENT"); 
      
	/**
	 * 需要验证过滤的url
	 * wpv各个字母的含义说明:
	 * 	w:微信端
	 *  p:pc端
	 *  v:验证登录
	 *  nv:不验证登录
	 *  e:验证加密
	 *  ne:不验证加密
	 *  规则：端+验证登录+验证加密
	 */
	private static final String[] wpNeedFilterUrl = {"/wpv/","/pc/pv/"};
    
    public CommonInterceptor() {
    }  
  
    /** 
     * 在业务处理器处理请求之前被调用 
     * 如果返回false 
     *     从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链 
     *  
     * 如果返回true 
     *    执行下一个拦截器,直到所有的拦截器都执行完毕 
     *    再执行被拦截的Controller 
     *    然后进入拦截器链, 
     *    从最后一个拦截器往回执行所有的postHandle() 
     *    接着再从最后一个拦截器往回执行所有的afterCompletion() 
     */  
    @Override  
    public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {  
    	
//    	logger.info("==============执行顺序: 1、preHandle================");  
        request.setCharacterEncoding("UTF-8");  
        response.setCharacterEncoding("UTF-8");  
        response.setContentType("text/html;charset=UTF-8");  
        
        String inviteCode = request.getParameter("inviteCode");
        
        Date date = new Date();
        
        ConsoleUtil.println(date + "   "+ request.getHeader("user-agent") +"\n    filter---->filter-openid:"+request.getSession().getAttribute(CommConstant.SESSION_OPENID) +",filter-weixinUser:"+request.getSession().getAttribute(CommConstant.SESSION_WX_USER));
        
        if(StringUtils.isNotEmpty(inviteCode)){
        	
        	//简单检测一下邀请码的规则。前缀为“rm”，长度为12位
        	if(inviteCode.startsWith(CommConstant.INVITECODE_PREFIX) && inviteCode.length() == 12){
        		
        		ConsoleUtil.println("inviteCode:"+inviteCode);
        		
        		request.getSession().setAttribute(CommConstant.SESSION_INVITECODE, inviteCode);
        	}
        }
        	
    	//当前这些链接需要拦截(pc端和微信端)
    	if(this.wpNeedValideFiltedUrl(request)){
    		
    		UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
    		
    		ConsoleUtil.println("拦截器中获取session中的user："+user);
    		
    		//token先从cookie中取
			Cookie cookie = CookieHelper.getCookieByName(request, CommConstant.SESSION_APP_TOKEN);
        		
			String token = null;
			
			if(null != cookie){
				
				token = cookie.getValue();
			}
			//再从session中取
			if(StringUtils.isEmptyNo(token)){
				
				token = (String)request.getSession().getAttribute(CommConstant.SESSION_APP_TOKEN);
			}
			boolean gotoLogin = false;

			
			ConsoleUtil.println("获取的token："+token);
			
			if(StringUtils.isNotEmpty(token)){
				
				UserLoginModel loginModel = UserMananger.getInst().getUser(token);
				
				if(null != loginModel){
					
					Date expireTime = loginModel.getExpiredTime();
					
					//超时了
					if(expireTime.before(new Date())){
						
						request.getSession().removeAttribute(CommConstant.SESSION_APP_TOKEN);
						request.getSession().removeAttribute(CommConstant.SESSION_MANAGER);
						UserMananger.getInst().removeUser(token);
						
						gotoLogin = true;
					}
					
					//token未失效，但是session中已经没有了（模拟的场景为：关闭了浏览器）
					if(!gotoLogin){
						
						if(null == request.getSession().getAttribute(CommConstant.SESSION_MANAGER)){
							
							request.getSession().setAttribute(CommConstant.SESSION_MANAGER,loginModel);
							request.getSession().setAttribute(CommConstant.SESSION_APP_TOKEN,token);
						}
					}
				}else{
					
					gotoLogin = true;
				}
				
        	}else{
        		
        		gotoLogin = true;
        	}
			
			//跳转登录
			if(gotoLogin){
				if(isPC(request)){
					response.sendRedirect(request.getContextPath() + "/pc/pnv/loginPage");
				}else {
					request.getRequestDispatcher("/redirect?redirectType="+RedirectConstant.REDIRECT_LOGIN).forward(request, response);
				}
    			return false;
			}
        }
        
        return true;
    }  
  
    //在业务处理器处理请求执行完成后,生成视图之前执行的动作   
    @Override  
    public void postHandle(HttpServletRequest request,  
            HttpServletResponse response, Object handler,  
            ModelAndView modelAndView) throws Exception {  
//    	logger.info("==============执行顺序: 2、postHandle================");  
//    	ConsoleUtil.println("==============执行顺序: 2、postHandle================");  
    }  
  
    /** 
     * 在DispatcherServlet完全处理完请求后被调用  
     *  
     *   当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion() 
     */  
    @Override  
    public void afterCompletion(HttpServletRequest request,  
            HttpServletResponse response, Object handler, Exception ex)  
            throws Exception {  
//    	logger.info("==============执行顺序: 3、afterCompletion================");  
//    	ConsoleUtil.println("==============执行顺序: 3、afterCompletion================");  
    }  
  
    
    /**
     * 需验证登录的url(微信端和pc端)
     * @param request
     * @return
     */
    private boolean wpNeedValideFiltedUrl(HttpServletRequest request){
        
        String contextPath = request.getContextPath();
        
      //取得根目录的相对路径
        String currentUrl = request.getRequestURI();
        
        if(StringUtils.isNotEmpty(currentUrl)){
            
            for (String s : wpNeedFilterUrl)
            {
            	if(currentUrl.startsWith(contextPath + s) || currentUrl.endsWith(s)){
            		ConsoleUtil.println("current url need filter：" + currentUrl);
            		return true;
            	}
            }
        }
        return false;
    }
    
    /**
     * @param request
     * @return
     */
    private boolean isPC(HttpServletRequest request){
    	String contextPath = request.getContextPath();
        
        //取得根目录的相对路径
          String currentUrl = request.getRequestURI();
          
          if(StringUtils.isNotEmpty(currentUrl)){
              
              for (String s : wpNeedFilterUrl)
              {
              	if(currentUrl.startsWith(contextPath + s) || currentUrl.endsWith(s)){
              		ConsoleUtil.println("current url need filter：" + currentUrl);
              		if(s.equals("/pc/pv/")){
              			return true;
              		}
              	}
              }
          }
          return false;
    }
    
    /**
     * 需要自动登录的url
     * @param request
     * @return
     
    private boolean needAutoLoginUrl(HttpServletRequest request){
    	
    	String contextPath = request.getContextPath();
    	//取得根目录的相对路径
    	String currentUrl = request.getRequestURI();
    	if(StringUtils.isNotEmpty(currentUrl)){
    		
    		for (String s : autoLoginUrl)
    		{
    			if(currentUrl.startsWith(contextPath + s)){
    				
    				ConsoleUtil.println("current auto login url：" + currentUrl);
    				
    				return true;
    			}
    		}
    	}
    	
    	return false;
    }*/
    
}  
