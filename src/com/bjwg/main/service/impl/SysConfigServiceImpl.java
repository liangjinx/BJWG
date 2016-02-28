package com.bjwg.main.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.dao.SysConfigDao;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.model.SysConfigExample;
import com.bjwg.main.service.SysConfigService;
import com.bjwg.main.util.MyUtils;

@Service
public class SysConfigServiceImpl implements SysConfigService {

	@Resource
	private SysConfigDao sysConfigDao;
	
	/**
	 * 查询所有
	 * @param code
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<SysConfig> queryList() throws Exception{
		
		SysConfigExample example = new SysConfigExample();
		return sysConfigDao.selectByExample(example);
	}
	/**
	 * 根据parentCode查询
	 * @param parentCode
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<SysConfig> queryList(String parentCode) throws Exception{
		SysConfigExample example = new SysConfigExample();
		SysConfigExample.Criteria criteria = example.createCriteria();
		criteria.andParentCodeEqualTo(parentCode);
		return sysConfigDao.selectByExample(example);
	}
	/**
	 * 根据code查询
	 * @param code
	 * @return
	 * @throws Exception
	 */
	@Override
	public SysConfig queryOne(String code) throws Exception{
		SysConfigExample example = new SysConfigExample();
		SysConfigExample.Criteria criteria = example.createCriteria();
		criteria.andCodeEqualTo(code);
		List<SysConfig> list = sysConfigDao.selectByExample(example);
		return MyUtils.isListEmpty(list) ? null : list.get(0);
	}

	/**
	 * 根据code查询
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public String queryOneValue(String code) throws Exception{
		SysConfigExample example = new SysConfigExample();
		SysConfigExample.Criteria criteria = example.createCriteria();
		criteria.andCodeEqualTo(code);
		List<SysConfig> list = sysConfigDao.selectByExample(example);
		return MyUtils.isListEmpty(list) ? null : list.get(0).getValue();
	}
	/**
	 * 根据code查询
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public String queryOneRemark(String code) throws Exception{
		SysConfigExample example = new SysConfigExample();
		SysConfigExample.Criteria criteria = example.createCriteria();
		criteria.andCodeEqualTo(code);
		List<SysConfig> list = sysConfigDao.selectByExample(example);
		return MyUtils.isListEmpty(list) ? null : list.get(0).getRemark();
	}
	/**
	 * 根据codeList查询
	 * @param codeList
	 * @return
	 * @throws Exception
	 */
	public List<SysConfig> queryList(List<String> codeList) throws Exception{
		SysConfigExample example = new SysConfigExample();
		SysConfigExample.Criteria criteria = example.createCriteria();
		criteria.andCodeIn(codeList);
		List<SysConfig> list = sysConfigDao.selectByExample(example);
		return list;
	}
	/**
	 * 查询回报方式要用的配置项：粗细分割费、真空包装费
	 * @param codeList
	 * @return
	 * @throws Exception
	 */
	public List<SysConfig> queryListForRewardsType() throws Exception{
		List<String> codeList = new ArrayList<String>(Arrays.asList(SysConstant.DIVISION_THICK_FEE,
																	SysConstant.DIVISION_THIN_FEE,
																	SysConstant.PACKAGE_FEE,
																	SysConstant.PER_WEIGHT,
																	SysConstant.SLAUGHTER_EXPRESS_FEE,
																	SysConstant.PACKAGE_SPECS));
		SysConfigExample example = new SysConfigExample();
		SysConfigExample.Criteria criteria = example.createCriteria();
		criteria.andCodeIn(codeList);
		List<SysConfig> list = sysConfigDao.selectByExample(example);
		return list;
	}
	
	/**
	 * 获取微信的appid和appkey、parnterkey
	 * @param codeList
	 * @return
	 * @throws Exception
	 */
	public String[] queryWxAppidAndAppKey() throws Exception{
		
		List<SysConfig> list = this.queryList(new ArrayList<String>(Arrays.asList(SysConstant.WX_APP_ID,SysConstant.WX_APP_SECRET,SysConstant.WX_APP_PARTNER_KEY,SysConstant.WX_APP_PARTNER)));
		
		String appId = null;
		String appSecret = null;
		String appPartnerKey = null;
		String appPartner = null;
		for (SysConfig sysConfig : list) {
			if(SysConstant.WX_APP_ID.equals(sysConfig.getCode())){
				appId = sysConfig.getValue();
			}else if(SysConstant.WX_APP_PARTNER_KEY.equals(sysConfig.getCode())){
				appPartnerKey = sysConfig.getValue();
			}else if(SysConstant.WX_APP_PARTNER.equals(sysConfig.getCode())){
				appPartner = sysConfig.getValue();
			}else{
				appSecret = sysConfig.getValue();
			}
		}
		return new String[]{appId,appSecret,appPartnerKey,appPartner};
	}
	/**
	 * 获取支付的支付的信息、partner\seller\partnerKey
	 * @param codeList
	 * @return
	 * @throws Exception
	 */
	public String[] queryAlipayKey() throws Exception{
		
		List<SysConfig> list = this.queryList(new ArrayList<String>(Arrays.asList(SysConstant.ALIPAY_PARTNER,SysConstant.ALIPAY_PARTNER_KEY,SysConstant.ALIPAY_SELLER)));
		
		String partner = null;
		String seller = null;
		String partnerKey = null;
		for (SysConfig sysConfig : list) {
			if(SysConstant.ALIPAY_PARTNER.equals(sysConfig.getCode())){
				partner = sysConfig.getValue();
			}else if(SysConstant.ALIPAY_SELLER.equals(sysConfig.getCode())){
				seller = sysConfig.getValue();
			}else{
				partnerKey = sysConfig.getValue();
			}
		}
		return new String[]{partner,partnerKey,seller};
	}
}
