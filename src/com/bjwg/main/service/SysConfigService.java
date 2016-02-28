package com.bjwg.main.service;

import java.util.List;

import com.bjwg.main.model.SysConfig;

/**
 * 系统配置service
 * @author Administrator
 *
 */
public interface SysConfigService {

	/**
	 * 查询所有
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public List<SysConfig> queryList() throws Exception;
	/**
	 * 根据parentCode查询
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	public List<SysConfig> queryList(String parentCode) throws Exception;
	/**
	 * 根据code查询
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public SysConfig queryOne(String code) throws Exception;
	/**
	 * 根据code查询
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public String queryOneValue(String code) throws Exception;
	
	/**
	 * 根据code查询
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public String queryOneRemark(String code) throws Exception;
	
	/**
	 * 根据codeList查询
	 * @param codeList
	 * @return
	 * @throws Exception
	 */
	public List<SysConfig> queryList(List<String> codeList) throws Exception;
	
	/**
	 * 查询回报方式要用的配置项：粗细分割费、真空包装费
	 * @param codeList
	 * @return
	 * @throws Exception
	 */
	public List<SysConfig> queryListForRewardsType() throws Exception;
	
	/**
	 * 获取微信的appid和appkey
	 * @param codeList
	 * @return
	 * @throws Exception
	 */
	public String[] queryWxAppidAndAppKey() throws Exception;
	
	/**
	 * 获取支付的支付的信息、partner\seller\partnerKey
	 * @param codeList
	 * @return
	 * @throws Exception
	 */
	public String[] queryAlipayKey() throws Exception;
}
