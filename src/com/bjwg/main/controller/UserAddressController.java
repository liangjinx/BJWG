package com.bjwg.main.controller;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.LoginConstants;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Area_V2;
import com.bjwg.main.model.User;
import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.service.UserService;
import com.bjwg.main.util.ConsoleUtil;
import com.bjwg.main.util.GetWeiXinCode;
import com.bjwg.main.util.JsonUtils;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.StringUtils;

/**
 * @author chen
 * @version 创建时间：2015-6-13 上午09:18:15
 * @Modified By:Administrator Version: 1.0 jdk : 1.6 类说明：上门地址controller
 */

@Controller
@RequestMapping("/wpv")
@Scope("prototype")
public class UserAddressController extends BaseController {

	@Resource
	private UserService userService;
	@Resource
	private SysConfigService sysConfigService;
	
	
	/**
	 * 跳转确定订单页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/uaconfirmOrder",method = {RequestMethod.POST,RequestMethod.GET})
	public String confirmOrder(String order,HttpServletRequest request){
		try {
			//返回用的
			if(StringUtils.isEmptyNo(order)){
				order = (String) request.getSession().getAttribute("order");
			}else{
				request.getSession().setAttribute("order", order);
			}
			
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			if(null != user){
				//上门地址
				UserAddress address = null;
				String addressId = request.getParameter("addressId");
				if(StringUtils.isNotEmpty(addressId)){
					address = userService.getAddressId(Long.valueOf(addressId));
				}else{
					address = userService.getUserIdIs(user.getUserId());
				}
				//上门地址
				String provinceName = "";
				String cityName = "";
				if(null != address){
					 provinceName = PhoneBaseData.getInstance().getArea_V2Name(address.getProvince()+"");
					 cityName = PhoneBaseData.getInstance().getArea_V2Name(address.getCity()+"");
					 if (provinceName == null) {
						provinceName = "";
					}
					if (cityName == null) {
						cityName = "";
					}
				}
				request.setAttribute("provinceName", provinceName);
				request.setAttribute("cityName", cityName);
				request.setAttribute("address", address);
				
				//购物车  解析json
				if(StringUtils.isNotEmpty(order))
				{
					DecimalFormat fmt=new DecimalFormat("0.##");
					request.setAttribute("totalAmount", fmt.format("0"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转选择确定订单页面信息错误", e);
		}
		return "order/confirm_an_order";
	}
	

	/**
	 * 选择地址
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uavisit", method = { RequestMethod.GET, RequestMethod.POST })
	public String visitAddress(HttpServletRequest request) {
		try {
			this.setAttr(request);
			
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			Long userId = user.getUserId();
			List<UserAddress> addressList = userService.getUserId(userId);

			if (!MyUtils.isListEmpty(addressList)) {
				for (UserAddress userAddress : addressList) {
					// 拼接地址
					userAddress.setAddress(MyUtils.getCompleteAddress(userAddress.getProvince(), userAddress.getCity(), userAddress.getAddress()));
				}
			}
			request.setAttribute("addressList", addressList);
				
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转选择上门地址页面信息错误", e);
			this.notifyMsg(request, Status.serverError);
		}
		return "/address/visit_address";
	}

	/**
	 * 管理上门地址页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uamanageList", method = { RequestMethod.GET, RequestMethod.POST })
	public String manageAddress(HttpServletRequest request) {

		try {
			this.setAttr(request);
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);

			List<UserAddress> addressList = userService.getUserId(user.getUserId());

			if (!MyUtils.isListEmpty(addressList)) {
				for (UserAddress userAddress : addressList) {
					// 拼接地址
					String provinceName = PhoneBaseData.getInstance().getArea_V2Name(userAddress.getProvince()+"");
					String cityName = PhoneBaseData.getInstance().getArea_V2Name(userAddress.getCity()+"");
					String address = userAddress.getAddress();
					if (provinceName == null) {
						provinceName = "";
					}
					if (cityName == null) {
						cityName = "";
					}
					if (provinceName.equals(cityName)) {
						cityName = "";
					}
					userAddress.setAddress(provinceName + cityName + address);
				}
			}

			request.setAttribute("addressList", addressList);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转管理上门地址页面信息错误", e);
		}
		return "/address/manage_address";
	}

	/**
	 * 跳转新增上门地址页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uanewsAddress", method = { RequestMethod.GET, RequestMethod.POST })
	public String addUserAddress(HttpServletRequest request) {
		this.setAttr(request);
		try {

			List<Area_V2> areas = PhoneBaseData.getInstance().getProvinceList();
			request.setAttribute("province", areas);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转新增上门地址页面信息错误", e);
		}
		return "/address/news_address";
	}

	/**
	 * 根据省查询市 v2
	 * 
	 * @param area_id
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/uajsonCityV2", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public void jsonCity(String areaId, HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			response.addHeader("Access-Control-Allow-Origin", "*");
				
			Long aId = StringUtils.isNotEmpty(areaId) ? Long.valueOf(areaId) : 0l;
			
			List<Area_V2> list = PhoneBaseData.getInstance().getCityList(aId);

			JSONArray array = new JSONArray();

			if (!MyUtils.isListEmpty(list)) {

				array = JSONArray.fromObject(list);
			}

			PrintWriter out = response.getWriter();

			out.write("{\"des\":" + array + "}");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("根据省查询市出错v2", e);
		}
	}

	/**
	 * 保存用户上门地址
	 * 
	 * @param userAddress
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uasaveNews", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveUserAddress(UserAddress userAddress, HttpServletRequest request) {
		try {
			this.setAttr(request);
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);

			userAddress.setUserId(user.getUserId());
			//第一次填写上门地址
			List<UserAddress> addressList = userService.getUserId(user.getUserId());
			if (!MyUtils.isListEmpty(addressList)) {
				// 1 默认地址 ， 0 不是默认地址
				userAddress.setIsDefault((byte) 0);
				
			}else{
				userAddress.setIsDefault((byte) 1);
			}

			Map<String, Object> map = userService.insert(userAddress);
			Status status = (Status) map.get("status");
			if (status == Status.success) {
				
				return manageAddress(request);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("保存上门地址信息  出错", e);
		}
		// 提示失败信息
		return "/address/news_address";
	}

	/**
	 * 编辑上门地址
	 * 
	 * @param addressId
	 *            上门地址id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uagetEdit", method = { RequestMethod.GET, RequestMethod.POST })
	public String editAddress(Long addressIdXg, HttpServletRequest request) {
		try {
			this.setAttr(request);
			List<Area_V2> areas = PhoneBaseData.getInstance().getProvinceList();
			request.setAttribute("province", areas);
			//根据id查询
			UserAddress address = userService.getAddressId(addressIdXg);
			String provinceName = PhoneBaseData.getInstance().getArea_V2Name(address.getProvince()+"");
			String cityName = PhoneBaseData.getInstance().getArea_V2Name(address.getCity()+"");
			if (provinceName == null) {
				provinceName = "";
			}
			if (cityName == null) {
				cityName = "";
			}
			request.setAttribute("provinceName", provinceName);
			request.setAttribute("cityName", cityName);
			request.setAttribute("address", address);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转编辑上门地址信息  出错", e);
		}
		return "/address/edit_address";
	}

	/**
	 * 保存编辑后的上门地址信息
	 * 
	 * @param userAddress
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uasaveEdit", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveEdit(UserAddress userAddress, HttpServletRequest request) {
		Long addressId = 1l;
		try {
			this.setAttr(request);
			
			addressId = userAddress.getAddressId();
			
			Map<String, Object> map = userService.update(userAddress);

			Status status = (Status) map.get("status");

			if (status == Status.success) {
				// 成功返回管理上门地址页面
				return manageAddress(request);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("保存上门地址信息  出错", e);
		}
		// 提示失败信息
		return editAddress(addressId, request);
	}
	
	/**
	 * 删除上门地址 
	 * @param addressId  上门地址id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uadel", method = { RequestMethod.GET, RequestMethod.POST })
	public String delete(Integer addressIdXg, HttpServletRequest request){
		try {
			this.setAttr(request);
			Map<String, Object> map = userService.delete(addressIdXg);
			
			Status status = (Status) map.get("status");

			if (status == Status.success) {
				// 成功返回管理上门地址页面
				return manageAddress(request);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除上门地址信息  出错", e);
		}
		return "error";
	}
	
	/**
	 * 修改上门地址默认地址
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uaeditDefault", method = { RequestMethod.GET, RequestMethod.POST })
	public String editDefault(UserAddress userAddress, HttpServletRequest request ){
		try {
			this.setAttr(request);
			//修改默认值
			String addressIdIs = request.getParameter("addressIdIs");
			if(StringUtils.isNotEmpty(addressIdIs))
			{
				userAddress.setIsDefault((byte)0);
				Map<String, Object> mapXg = userService.update(userAddress);
				Status statusXg = (Status) mapXg.get("status");
				if (statusXg == Status.success) 
				{
					userAddress.setIsDefault((byte)1);
					userAddress.setAddressId(Long.valueOf(addressIdIs));	
					Map<String, Object> map = userService.update(userAddress);
		
					Status status = (Status) map.get("status");
		
					this.notifyMsg(request, status);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("修改上门默认地址信息  出错", e);
			this.notifyMsg(request, Status.serverError);
		}
		return manageAddress(request);
	}
	/**
	 * 修改上门地址默认地址json
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uaeditDefaultJson", method = { RequestMethod.GET, RequestMethod.POST } ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public String editDefaultJson(HttpServletRequest request){
		org.json.JSONObject jsonObject = new org.json.JSONObject();
		try {
			//修改默认值
			String addressIdIs = request.getParameter("addressIdIs");

			UserLoginModel user = (UserLoginModel)request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
			
			Long userId = null != user ? user.getUserId() : null;
			
			ConsoleUtil.println("/wpnv/uaeditDefaultJson -- > user:"+user + " --> userId:"+userId);
			
			if(StringUtils.isNotEmpty(addressIdIs) && null != userId && userId > 0)
			{
				UserAddress userAddress = new UserAddress();
				userAddress.setIsDefault((byte)0);
				userAddress.setUserId(userId);
				userService.updateDefaultByUserId(userAddress);
				
				userAddress.setIsDefault((byte)1);
				userAddress.setAddressId(Long.valueOf(addressIdIs));
				userAddress.setUserId(null);
				userService.update(userAddress);
				
				jsonObject = JsonUtils.getJsonObject(Status.success);
			}else{
				
				jsonObject = JsonUtils.getJsonObject(Status.paramFormatError);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("修改上门默认地址信息json 出错", e);
			jsonObject = JsonUtils.getJsonObject(Status.serverError);
		}
		
		return jsonObject.toString();
	}
	/**
	 * 编辑并获取收货微信地址
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uaeditAndGetWXAddress", method = { RequestMethod.GET, RequestMethod.POST })
	public String editAndGetWXAddress(HttpServletRequest request){
		try {
			
			/*String appid = "wx265a5bf049bf66c2";
			String signtype = "SHA1";
			String timestamp = Sha1Util.getTimeStamp();
			String currTime = MyUtils.getYYYYMMDDHHmmss(4);
			//8位日期
			String strTime = currTime.substring(8, currTime.length());
			//四位随机数
			String strRandom = RandomUtils.getNumAndWord(4);
			//10位序列号,可以自行调整。
			String noncestr = strTime + strRandom;
			
			//对所有待签名参数按照字段名的 ASCII 码从小到大排序
			SortedMap<String, String> packageParams = new TreeMap<String, String>();
			packageParams.put("appid", appid);
			packageParams.put("url", ToolKit.getInstance().getSingleConfig("projectUrl")+ "userAddress/editAndGetWXAddress"); //);
			packageParams.put("timestamp", timestamp);
			packageParams.put("noncestr", noncestr);
			
			String access_token = (String)request.getSession().getAttribute("access_token");
			ConsoleUtil.println(">>>编辑并获取收货微信地址token："+access_token);
			packageParams.put("accesstoken", access_token);
			
			String addrsign = Sha1Util.createSHA1Sign(packageParams);
			request.setAttribute("appId", appid);
			request.setAttribute("signType", signtype);
			request.setAttribute("addrSign", addrsign);
			request.setAttribute("timeStamp", timestamp);
			request.setAttribute("nonceStr", noncestr);*/
			
			/*String theUrl = request.getRequestURL().toString();
			Sign sign = new Sign(theUrl, provalueService);
			Map<String, String> ret = sign.getVal();
			
			ConsoleUtil.println("微信用户是否获取到了sign信息："+!MyUtils.isMapEmpty(ret));
			
			if (!MyUtils.isMapEmpty(ret)) {
				request.setAttribute("js_timestamp", ret.get("timestamp"));
				request.setAttribute("js_nonceStr", ret.get("nonceStr"));
				request.setAttribute("js_signature", ret.get("signature"));
				request.setAttribute("js_url", ret.get("url"));
				request.setAttribute("js_jsapi_ticket",ret.get("jsapi_ticket"));
				request.setAttribute("js_token", ret.get("token"));
			}
			
			return "address/wxAddress";
			*/
			
			String type = request.getParameter("type");
			UserAddress address = null;
			if("1".equals(type)){
				
				
				
				String addressId = request.getParameter("addressId");
				if(StringUtils.isNotEmpty(addressId)){
					address = userService.getAddressId(Long.valueOf(addressId));
					request.setAttribute("address", address);
				}
				return "address/test_address1";
				
			}else if("2".equals(type)){
				
				
				String addressId = request.getParameter("addressId");
				if(StringUtils.isNotEmpty(addressId)){
					address = userService.getAddressId(Long.valueOf(addressId));
					request.setAttribute("address", address);
				}
				return "address/test_address2";
			}else if("3".equals(type)){
				
				String provinceName = request.getParameter("provinceName");
				String cityName = request.getParameter("cityName");
				
				String[] ss = PhoneBaseData.getInstance().getAreaCode(provinceName, cityName);
				
				Long provinceId = Long.valueOf(PhoneBaseData.getInstance().getAreaId(ss[0]));
				Long cityId = Long.valueOf(PhoneBaseData.getInstance().getAreaId(ss[1]));
				
				address = new UserAddress();
				String contactMan = request.getParameter("contactMan");
				String contactPhone = request.getParameter("contactPhone");
				String address1 = request.getParameter("address");
				address.setContactMan(contactMan);
				address.setContactPhone(contactPhone);
				address.setAddress(address1);
				
				ConsoleUtil.println("address:"+address.getAddress() +","+address.getContactMan()+","+address.getContactPhone()+","+address.getCity()+","+address.getProvince());
				ConsoleUtil.println("address1:"+provinceId+","+cityId);
				
				address.setCity(cityId == null ? provinceId : cityId);
				address.setProvince(provinceId);
				
				UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);
				address.setUserId(user.getUserId());
				address.setIsDefault((byte)1);
				UserAddress userAddress = userService.getUserIdIs(user.getUserId());
				if(userAddress != null){
					userAddress.setIsDefault((byte)0);
					userService.update(userAddress);
				}
				Map<String, Object> map = userService.insert(address);
				/*AreaService areaService = PhoneBaseData.getAreaService();
				
				Area_V2Example v2Example = new Area_V2Example();
				Area_V2Example.Criteria criteria = v2Example.createCriteria();
				
				if(StringUtils.isNotEmpty(cityName)){
					criteria.andNameLike("%" + cityName + "%");
				}
				List<Area_V2> list = areaService.q*/
				
				return manageAddress(request);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("编辑并获取收货微信地址  出错", e);
		}
		return "error";
	}
	
	/**/
	@RequestMapping(value = "/uagetAccessToken", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public void getAccessToken(HttpServletRequest request,HttpServletResponse response) throws Exception{
		StringBuffer tooken_url = new StringBuffer();
		tooken_url.append("https://api.weixin.qq.com/sns/oauth2/access_token?appid=");
		String[] wxs = sysConfigService.queryWxAppidAndAppKey();
		tooken_url.append(wxs[0]).append("&secret=").append(wxs[1]);
		String code = request.getParameter("code");
		ConsoleUtil.println("code:"+code);
		tooken_url.append("&code=").append(code).append("&grant_type=authorization_code");
		// 通过code换取网页授权access_token
		String json = GetWeiXinCode.getUrl(tooken_url.toString());
		ConsoleUtil.println("json:"+json);
		JSONObject jsonObject = JSONObject.fromObject(json);
		ConsoleUtil.println(jsonObject.getString("access_token"));
	}
	
}
