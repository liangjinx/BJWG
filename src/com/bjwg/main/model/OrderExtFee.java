package com.bjwg.main.model;

import java.math.BigDecimal;

import com.bjwg.main.base.BaseVo;

/**
 * 订单额外费用表
 * @ClassName: OrderExtFee 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Administrator
 * @date 2015-9-19 上午10:50:37
 */
public class OrderExtFee extends BaseVo{
    /**
	 * 
	 */
	private static final long serialVersionUID = -4477912438701349688L;

	/**
     *
     * @mbggenerated
     */
    private Long orderId;

    /**
     * 费用总额
     * @mbggenerated
     */
    private BigDecimal payMoney;

    /**
     * 数量
     * @mbggenerated
     */
    private Integer num;

    /**
     * 单只屠宰配送费
     * @mbggenerated
     */
    private BigDecimal slaughterFee;

    /**
     * 单只分割费
     * @mbggenerated
     */
    private BigDecimal divisionFee;

    /**
     * 分割类型  1:粗分2:细分
     * @mbggenerated
     */
    private Byte divisionType;

    /**
     * 分割方式 1:两分体2:四分体3:六分体（粗分才有）
     * @mbggenerated
     */
    private Byte divisionMode;

    /**
     * 单包装费
     * @mbggenerated
     */
    private BigDecimal packageFee;

    /**
     * 规格  1:300g/盒2:500g/盒
     * @mbggenerated
     */
    private Integer spec;

    /**
     * 重量
     * @mbggenerated
     */
    private BigDecimal weight;

    /**
     * 包装数量
     * @mbggenerated
     */
    private Integer packageNum;

    /**
     *
     * @mbggenerated
     */
    private String remark;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.order_id
     *
     * @return the value of bjwg_order_ext_fee.order_id
     *
     * @mbggenerated
     */
    public Long getOrderId() {
        return orderId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.order_id
     *
     * @param orderId the value for bjwg_order_ext_fee.order_id
     *
     * @mbggenerated
     */
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.pay_money
     *
     * @return the value of bjwg_order_ext_fee.pay_money
     *
     * @mbggenerated
     */
    public BigDecimal getPayMoney() {
        return payMoney;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.pay_money
     *
     * @param payMoney the value for bjwg_order_ext_fee.pay_money
     *
     * @mbggenerated
     */
    public void setPayMoney(BigDecimal payMoney) {
        this.payMoney = payMoney;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.num
     *
     * @return the value of bjwg_order_ext_fee.num
     *
     * @mbggenerated
     */
    public Integer getNum() {
        return num;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.num
     *
     * @param num the value for bjwg_order_ext_fee.num
     *
     * @mbggenerated
     */
    public void setNum(Integer num) {
        this.num = num;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.slaughter_fee
     *
     * @return the value of bjwg_order_ext_fee.slaughter_fee
     *
     * @mbggenerated
     */
    public BigDecimal getSlaughterFee() {
        return slaughterFee;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.slaughter_fee
     *
     * @param slaughterFee the value for bjwg_order_ext_fee.slaughter_fee
     *
     * @mbggenerated
     */
    public void setSlaughterFee(BigDecimal slaughterFee) {
        this.slaughterFee = slaughterFee;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.division_fee
     *
     * @return the value of bjwg_order_ext_fee.division_fee
     *
     * @mbggenerated
     */
    public BigDecimal getDivisionFee() {
        return divisionFee;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.division_fee
     *
     * @param divisionFee the value for bjwg_order_ext_fee.division_fee
     *
     * @mbggenerated
     */
    public void setDivisionFee(BigDecimal divisionFee) {
        this.divisionFee = divisionFee;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.division_type
     *
     * @return the value of bjwg_order_ext_fee.division_type
     *
     * @mbggenerated
     */
    public Byte getDivisionType() {
        return divisionType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.division_type
     *
     * @param divisionType the value for bjwg_order_ext_fee.division_type
     *
     * @mbggenerated
     */
    public void setDivisionType(Byte divisionType) {
        this.divisionType = divisionType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.division_mode
     *
     * @return the value of bjwg_order_ext_fee.division_mode
     *
     * @mbggenerated
     */
    public Byte getDivisionMode() {
        return divisionMode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.division_mode
     *
     * @param divisionMode the value for bjwg_order_ext_fee.division_mode
     *
     * @mbggenerated
     */
    public void setDivisionMode(Byte divisionMode) {
        this.divisionMode = divisionMode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.package_fee
     *
     * @return the value of bjwg_order_ext_fee.package_fee
     *
     * @mbggenerated
     */
    public BigDecimal getPackageFee() {
        return packageFee;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.package_fee
     *
     * @param packageFee the value for bjwg_order_ext_fee.package_fee
     *
     * @mbggenerated
     */
    public void setPackageFee(BigDecimal packageFee) {
        this.packageFee = packageFee;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.spec
     *
     * @return the value of bjwg_order_ext_fee.spec
     *
     * @mbggenerated
     */
    public Integer getSpec() {
        return spec;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.spec
     *
     * @param spec the value for bjwg_order_ext_fee.spec
     *
     * @mbggenerated
     */
    public void setSpec(Integer spec) {
        this.spec = spec;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.weight
     *
     * @return the value of bjwg_order_ext_fee.weight
     *
     * @mbggenerated
     */
    public BigDecimal getWeight() {
        return weight;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.weight
     *
     * @param weight the value for bjwg_order_ext_fee.weight
     *
     * @mbggenerated
     */
    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.package_num
     *
     * @return the value of bjwg_order_ext_fee.package_num
     *
     * @mbggenerated
     */
    public Integer getPackageNum() {
        return packageNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.package_num
     *
     * @param packageNum the value for bjwg_order_ext_fee.package_num
     *
     * @mbggenerated
     */
    public void setPackageNum(Integer packageNum) {
        this.packageNum = packageNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_order_ext_fee.remark
     *
     * @return the value of bjwg_order_ext_fee.remark
     *
     * @mbggenerated
     */
    public String getRemark() {
        return remark;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_order_ext_fee.remark
     *
     * @param remark the value for bjwg_order_ext_fee.remark
     *
     * @mbggenerated
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}