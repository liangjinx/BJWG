package com.bjwg.main.controller.pc;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjwg.main.base.BaseController;
import com.bjwg.main.base.PhoneBaseData;
import com.bjwg.main.constant.CommConstant;
import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.model.Area_V2;
import com.bjwg.main.model.UserAddress;
import com.bjwg.main.model.UserLoginModel;
import com.bjwg.main.service.UserService;
import com.bjwg.main.util.MyUtils;
import com.bjwg.main.util.StringUtils;

/**
 * @author Carter
 * @version 创建时间：Sep 14, 2015 2:35:18 PM
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
@Controller("pc_useraddress_controller")
@Scope("prototype")
@RequestMapping("/pc/pv/address")
public class UserAddressController extends BaseController {

	@Autowired
	UserService userService;
	
	/**
	 * 地址管理
	 * @return
	 */
	@RequestMapping(value = "/addressManage", method = { RequestMethod.GET, RequestMethod.POST })
	public String manageAddress() {

		try {
			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);

			List<UserAddress> addressList = userService.getUserId(user.getUserId());
			List<UserAddress> userList = new ArrayList<UserAddress>();

			if (!MyUtils.isListEmpty(addressList)) {
				for (UserAddress userAddress : addressList) {
					// 拼接地址
					String provinceName = PhoneBaseData.getInstance().getArea_V2Name(userAddress.getProvince()+"");
					String cityName = PhoneBaseData.getInstance().getArea_V2Name(userAddress.getCity()+"");

					String address = userAddress.getAddress();
					if (provinceName == "null" || provinceName == null) {
						provinceName = "";
					}
					if (cityName == "null" || cityName == null) {
						cityName = "";
					}
					if (provinceName.equals(cityName)) {
						cityName = "";
					}
					userAddress.setAddress(provinceName + cityName + address);

					userList.add(userAddress);
				}
			}

			request.setAttribute("addressList", userList);
			
			//查询省份列表
			List<Area_V2> areas = PhoneBaseData.getInstance().getProvinceList();
			request.setAttribute("provinceList", areas);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("管理上门地址页面信息错误", e);
		}
		return "/pc/address/addressManage";
	}
	
	/**
	 * 删除
	 * @param addressIdXg
	 * @return
	 */
	@RequestMapping(value = "/del", method = { RequestMethod.GET, RequestMethod.POST })
	public String delete(Integer addressId){
		try {
			
			Map<String, Object> map = userService.delete(addressId);
			
			Status status = (Status) map.get("status");

			if (status == Status.success) {
				// 成功返回管理上门地址页面
				return "redirect:/pc/pv/address/addressManage";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除上门地址信息  出错", e);
		}
		return "error";
	}
	
	/**
	 * 默认地址设置
	 * @param userAddress
	 * @return
	 */
	@RequestMapping(value = "/editDefault", method = { RequestMethod.GET, RequestMethod.POST })
	public String editDefault(UserAddress userAddress){
		try {
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
		
					if (status == Status.success) {
						return "redirect:/pv/address/addressManage";
					}
				}
			}else {
				return "redirect:/pv/address/addressManage";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("修改上门默认地址信息  出错", e);
		}
		return "error";
	}
	
	/**
	 * 编辑页
	 * @param addressIdXg
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/edit", method = { RequestMethod.GET, RequestMethod.POST })
	public String editAddress(Long addressId) {
		try {
			
			List<Area_V2> areas = PhoneBaseData.getInstance().getProvinceList();
			request.setAttribute("provinceList", areas);
			//根据id查询
			UserAddress address = userService.getAddressId(addressId);
			/*String provinceName = PhoneBaseData.getInstance().getArea_V2Name(address.getProvince()+"");
			String cityName = PhoneBaseData.getInstance().getArea_V2Name(address.getCity()+"");*/
			/*request.setAttribute("provinceName", provinceName);
			request.setAttribute("cityName", cityName);*/
			request.setAttribute("address", address);
			List<Area_V2> citys = PhoneBaseData.getInstance().getCityList(address.getProvince());
			request.setAttribute("cityList", citys);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("跳转编辑上门地址信息  出错", e);
		}
		return "/pc/address/addressEdit";
	}
	
	/**
	 * 新增保存
	 * @param userAddress
	 * @return
	 */
	@RequestMapping(value = "/saveAddress", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveUserAddress(UserAddress userAddress) {
		try {

			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);

			userAddress.setUserId(user.getUserId());
			
			List<UserAddress> addressList = userService.getUserId(user.getUserId());
			
			if(addressList !=null && addressList.size()>=10){
				return "redirect:/pc/pv/address/addressManage";
			}
			
			//将原默认地址清除
			if(userAddress.getIsDefault()!=null && 1 == userAddress.getIsDefault()){
				UserAddress addrDefault = new UserAddress();
				addrDefault.setIsDefault((byte)0);
				addrDefault.setUserId(user.getUserId());
				userService.updateDefaultByUserId(addrDefault);
				userAddress.setIsDefault((byte)1);
			} else {
				//判断是否第一次填写上门地址
				if (!MyUtils.isListEmpty(addressList)) {
					// 1 默认地址 ， 0 不是默认地址
					userAddress.setIsDefault((byte) 0);
					
				}else{
					userAddress.setIsDefault((byte) 1);
				}
			}

			Map<String, Object> map = userService.insert(userAddress);
			Status status = (Status) map.get("status");
			if (status == Status.success) {
				return "redirect:/pc/pv/address/addressManage";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("保存上门地址信息  出错", e);
		}
		// 提示失败信息
		return "redirect:/pc/pv/address/addressManage";
	}
	
	/**
	 * 编辑保存
	 * @param userAddress
	 * @return
	 */
	@RequestMapping(value = "/saveEditAddress", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveEditAddress(UserAddress userAddress) {
		try {

			UserLoginModel user = (UserLoginModel) request.getSession().getAttribute(CommConstant.SESSION_MANAGER);

			userAddress.setUserId(user.getUserId());
			
			//将原默认地址清除
			if(userAddress.getIsDefault()!=null&&userAddress.getIsDefault().intValue()==1){
				UserAddress addrDefault = new UserAddress();
				addrDefault.setIsDefault((byte)0);
				addrDefault.setUserId(user.getUserId());
				userService.updateDefaultByUserId(addrDefault);
/*				Status statusXg = (Status) mapXg.get("status");
				if (statusXg == Status.success) {
					userAddress.setIsDefault((byte)1);
				}*/
			} else {
				userAddress.setIsDefault((byte)0);
			}

			Map<String, Object> map = userService.update(userAddress);
			Status status = (Status) map.get("status");
			if (status == Status.success) {
				return "redirect:/pc/pv/address/addressManage";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("保存上门地址信息  出错", e);
		}
		// 提示失败信息
		return "redirect:/pc/pv/address/addressManage";
	}
	
	/**
	 * 根据省查询市 v2
	 * 
	 * @param area_id
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/jsonCityV2", method = { RequestMethod.POST, RequestMethod.GET })
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
	
}





















