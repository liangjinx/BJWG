package com.bjwg.main.controller.pc;

import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.base.Pages;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.dao.UserExtDao;
import com.bjwg.main.model.Comment;
import com.bjwg.main.model.DictDetail;
import com.bjwg.main.model.Info;
import com.bjwg.main.model.PanicbuyProject;
import com.bjwg.main.model.Pay;
import com.bjwg.main.model.Slide;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.model.rating;
import com.bjwg.main.service.CommentService;
import com.bjwg.main.service.CommonService;
import com.bjwg.main.service.DictService;
import com.bjwg.main.service.InfoService;
import com.bjwg.main.service.OrderService;
import com.bjwg.main.service.PanicbuyProjectService;
import com.bjwg.main.service.SlideService;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.insertXML;
import com.bjwg.main.util.selectXML;


/**
 * @author Carter
 * @version 创建时间：Sep 14, 2015 2:24:50 PM
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_index_controller")
@Scope("prototype")
public class IndexController extends BaseController {

	
	

	
	
	@Autowired
	UserService userService;
	
	@Autowired
	PanicbuyProjectService panicbuyProjectService;
	
	@Autowired
	InfoService infoService;
	
	@Autowired
	DictService dictService;
	
	@Autowired
	SlideService slideService;
	
	@Autowired
	SysConfigService sysConfigService;
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	CommonService commonService;
	
	/**
	 * @return 
	 * @return
	 */


	
	
	
	@RequestMapping(value = "/pc", method = { RequestMethod.GET,RequestMethod.POST })
	public String index(String inviteCode) {

		try {
			
			
	
			
			request.setAttribute(CommConstant.SESSION_INVITECODE, inviteCode);
			
			//查询当期正在进行的项目
			PanicbuyProject currentProj = panicbuyProjectService.selectCurrent(null);
			request.setAttribute("curProj", currentProj);
			
			
			
			//查询下期预告
			PanicbuyProject nextProj = panicbuyProjectService.selectNext(null);
			
			
			request.setAttribute("nextProj", nextProj);
			
			//查询新闻资讯4条
			Pages<Info> page = new Pages<Info>();
			page.setCurrentPage(1);
			page.setPerRows(4);
			infoService.queryPage(null, page);
			request.setAttribute("news", page.getRoot());
			
			//查询轮播图
			List<Slide> slides = slideService.queryIndex();
			request.setAttribute("slides", slides);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/pc/index";
	}
	
	
	

	
	
	
	
	/**
	 * 正在抢购的猪仔
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/inShopping", method = { RequestMethod.GET,RequestMethod.POST })
	public String inShopping(String cnav){
		try {

			String select =(String)request.getParameter("select");
			System.out.println("----"+select);
			if ("rating".equals(select)) {
				request.setAttribute("flag","s" );
			}
			
			
			//查询当期正在进行的项目
			PanicbuyProject currentProj = panicbuyProjectService.selectCurrent(null);

		System.out.println("ccc"+currentProj);
			
			
			
			if(currentProj==null){
				
				request.setAttribute("ratings", null);
			}
			else{
				
			int pid=new Long(currentProj.getPaincbuyProjectId()).intValue();
			List<rating> ratings=selectXML.selectXML(request,pid);
			if(ratings==null){
		
				insertXML.insertXML(request,pid,currentProj.getNum());
				
				 ratings=selectXML.selectXML(request,pid);
			}

			request.setAttribute("ratings", ratings);}
			request.setAttribute("curProj", currentProj);
			
			request.setAttribute("yearRate", sysConfigService.queryOneValue(SysConstant.YEAR_RETURN_RATE));
			
			if(currentProj!=null){
				//查询评论
				Pages<Comment> page = new Pages<Comment>();
				page.setCurrentPage((cnav != null && cnav.equals("3")) ? currentPage : 1);
				page.setPerRows(6);
				commentService.queryPage(currentProj.getPaincbuyProjectId(), page);
				request.setAttribute("commentList", page.getRoot());
				request.setAttribute("pager_cmt", MyUtils.calcPagerNum(6, page.getCountRows(), page.getCurrentPage(), 6));
				
				//查询购买记录
				Pages<Pay> page1 = new Pages<Pay>();
				page1.setCurrentPage((cnav != null && cnav.equals("4")) ? currentPage : 1);
				page1.setPerRows(6);
				panicbuyProjectService.queryPagePayRecord(currentProj.getPaincbuyProjectId(), page1);
				request.setAttribute("buyRdList", page1.getRoot());
				
				request.setAttribute("pager_buy", MyUtils.calcPagerNum(6, page1.getCountRows(), page1.getCurrentPage(), 6));
				
			
			if(panicbuyProjectService.selectTop20(currentProj.getPaincbuyProjectId()).size()>6){
				
				//查询本期排行前20
				request.setAttribute("top20", panicbuyProjectService.selectTop20(currentProj.getPaincbuyProjectId()).subList(0, 5));
			}
			
			else{
				//查询本期排行前20
				request.setAttribute("top20", panicbuyProjectService.selectTop20(currentProj.getPaincbuyProjectId()));
			}
			
				
				//用户协议
				request.setAttribute("protocol", commonService.selectProtocol("BJWG_SERVICE_PROTOCOL.TYPE.USER"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/pc/inShopping";
	}
	
	
	/**
	 * 新增评论
	 * @param content
	 * @return
	 * @throws JSONException
	 */
	@RequestMapping(value = "/pc/pv/addComment", method = { RequestMethod.GET,RequestMethod.POST },produces = "application/json; charset=utf-8")
	@ResponseBody
	public String addComment(String content) throws JSONException{
		try {
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			//查询当期正在进行的项目
			PanicbuyProject currentProj = panicbuyProjectService.selectCurrent(null);
			
			Comment comment = new Comment();
			comment.setUserId(user.getUserId());
			comment.setCtime(new Date());
			comment.setProjectId(currentProj.getPaincbuyProjectId());
			comment.setContent(content);
			
			Status status = commentService.add(comment);
			
			this.putJsonStatus(status);
		} catch (Exception e) {
			e.printStackTrace();
			this.putJsonStatus(Status.serverError);
		}
		return this.outputJson();
	}
	
	
	
	/**
	 * 预热中准备抢购的猪仔
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/nextShopping", method = { RequestMethod.GET,RequestMethod.POST })
	public String nextShopping(){
		try {
			
			//查询下期预告
			PanicbuyProject nextProj = panicbuyProjectService.selectNext(null);
			request.setAttribute("nextProj", nextProj);
			if(null != nextProj){
				request.setAttribute("leftTime", nextProj.getBeginTime().getTime());
			}
			request.setAttribute("yearRate", sysConfigService.queryOneValue(SysConstant.YEAR_RETURN_RATE));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/pc/nextShopping";
	}

	@RequestMapping(value = "/pnv/index", method = { RequestMethod.GET,RequestMethod.POST })
	public String indext() {
		try {
			//查询当期正在进行的项目
			PanicbuyProject currentProj = panicbuyProjectService.selectCurrent(null);
			request.setAttribute("curProj", currentProj);
			
			//查询下期预告
			PanicbuyProject nextProj = panicbuyProjectService.selectNext(null);
			request.setAttribute("nextProj", nextProj);
			
			//查询当期抢购数量前20名单
			/*List<Map<String, Object>> top20 = panicbuyProjectService.selectTop20();
			request.setAttribute("top20", top20);*/
			
			//查询新闻资讯4条
			Pages<Info> page = new Pages<Info>();
			page.setCurrentPage(1);
			page.setPerRows(4);
			infoService.queryPage(null, page);
			request.setAttribute("news", page.getRoot());
			
			//查询轮播图
			List<Slide> slides = slideService.queryIndex();
			request.setAttribute("slides", slides);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/pc/index_";
	}
	
	/**
	 * 新闻资讯
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/pc/pnv/news", method = { RequestMethod.GET,RequestMethod.POST })
	public String news(Byte type) throws Exception{
		try {
			Pages<Info> page = new Pages<Info>();
			
			page.setCurrentPage(currentPage);
			page.setPerRows(6);
			
			infoService.queryPage(type, page);
			
			List<DictDetail> categories = dictService.queryList("BJWG_INFO.TYPE");
			
			this.request.setAttribute("news", page.getRoot());
			this.request.setAttribute("categories", categories);
			this.request.setAttribute("type", type);
			this.request.setAttribute("pagerArg", MyUtils.calcPagerNum(6, page.getCountRows(), currentPage, 3));
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "/pc/news";
	}
	
	/**
	 * 新闻详情
	 * @param newsId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pc/pnv/newsDetail", method = { RequestMethod.GET,RequestMethod.POST })
	public String newsDetail(Long newsId) throws Exception{
		try {
			List<Info> newsList = infoService.selectByPrimaryKey(newsId);
			Info news=null,lastNews=null,nextNews = null;
			if(newsList.size()==3){
				lastNews = newsList.get(0);
				news = newsList.get(1);
				nextNews = newsList.get(2);
			} else if (newsList.size()==2) {
				if(newsList.get(0).getInfoId().longValue()==newsId.longValue()){
					news = newsList.get(0);
					nextNews = newsList.get(1);
				} else {
					lastNews = newsList.get(0);
					news = newsList.get(1);
				}
			} else if(newsList.size()==1) {
				news = newsList.get(0);
			}
			
			List<DictDetail> categories = dictService.queryList("BJWG_INFO.TYPE");
			
			this.request.setAttribute("news", news);
			this.request.setAttribute("lastNews", lastNews);
			this.request.setAttribute("nextNews", nextNews);
			this.request.setAttribute("categories", categories);
			this.request.setAttribute("type", news!=null?news.getType():null);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "/pc/newsDetail";
	}
	
	
	@RequestMapping(value = "/pc/pnv/judgeLogin", method = { RequestMethod.GET,RequestMethod.POST })
	public String judgeLogin(){
		UserLoginModel userLoginModel = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
		if(userLoginModel==null){
			return "/pc/register";
		}
		else{
			
			  return "redirect:/pc/pv/user/farm";
			  
		}
		
		
		
		
	}
	
	
	
	
	/**
	 * 润民简介
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/runminIntro", method = { RequestMethod.GET,RequestMethod.POST })
	public String runminIntro(){
		return "/pc/runminIntro";
	}
	
	/**
	 * 平台说明
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/platfarmIntro", method = { RequestMethod.GET,RequestMethod.POST })
	public String platfarmIntro(){
		return "/pc/platfarmIntro";
	}
	
	/**
	 * 实体门店
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/breedProcess", method = { RequestMethod.GET,RequestMethod.POST })
	public String outlet(){
		return "/pc/breedProcess";
	}
	
	/**
	 * 常见问题
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/question", method = { RequestMethod.GET,RequestMethod.POST })
	public String question(){
		return "/pc/question";
	}
	
	/**
	 * 安全保障
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/protocol", method = { RequestMethod.GET,RequestMethod.POST })
	public String protocol(){
		return "/pc/protocol";
	}
	
	/**
	 * 联系我们
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/connect", method = { RequestMethod.GET,RequestMethod.POST })
	public String connect(){
		return "/pc/connect";
	}
	
	
	/**
	 * 产品介绍
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/products", method = { RequestMethod.GET,RequestMethod.POST })
	public String products(){
		return "/pc/products";
	}


	
	/**
	 * 微信版框架页
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/pc/pnv/mobileFarm", method = { RequestMethod.GET,RequestMethod.POST })
	public String mobileFarm(){
		
		return "/pc/mobileFarm";
	}
	
	/**
	 * 实时猪场
	 * @return
	 */
	@RequestMapping(value = "/pc/pnv/realFarm", method = { RequestMethod.GET,RequestMethod.POST })
	public String realFarm(){
		return "/pc/realFarm";
	}
	
	
}

