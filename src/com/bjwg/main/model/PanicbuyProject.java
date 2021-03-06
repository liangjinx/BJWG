package com.bjwg.main.model;

import java.math.BigDecimal;
import java.util.Date;

import com.bjwg.main.base.BaseVo;

/**
 * 抢购项目
 * @author Administrator
 *
 */
public class PanicbuyProject extends BaseVo{
    /**
	 * 
	 */
	private static final long serialVersionUID = 5837968584320148177L;

	/**
     *
     * @mbggenerated
     */
    private Long paincbuyProjectId;

    /**
     * 名称
     * @mbggenerated
     */
    private String name;

    /**
     * 简介
     * @mbggenerated
     */
    private String summary;

    /**
     * 图片
     * @mbggenerated
     */
    private String imgs;

    /**
     * 创建时间
     * @mbggenerated
     */
    private Date ctime;

    /**
     * 类型 默认为1
     * @mbggenerated
     */
    private Byte type;

    /**
     * 状态0:未开始1:进行中2:已结束
     * @mbggenerated
     */
    private Byte status;

    /**
     * 单价
     * @mbggenerated
     */
    private BigDecimal price;

    /**
     * 总数量
     * @mbggenerated
     */
    private Short num;

    /**
     * 剩余数量
     * @mbggenerated
     */
    private Short leftNum;

    /**
     * 单只总价
     * @mbggenerated
     */
    private BigDecimal totalMoney;

    /**
     * 开始抢购时间
     * @mbggenerated
     */
    private Date beginTime;

    /**
     * 结束抢购时间
     * @mbggenerated
     */
    private Date endTime;
    
    /**
     * 自定义详情页HTML
     */
    private String detail;

    

    public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	/**
     * 其他费用详情（json）
     * @mbggenerated
     */
    private String otherFeeDetail;

    /**
     * 单只其他总费用
     * @mbggenerated
     */
    private BigDecimal otherFee;

    /**
     * 品种
     * @mbggenerated
     */
    private Byte variety;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.paincbuy_project_id
     *
     * @return the value of bjwg_panicbuy_project.paincbuy_project_id
     *
     * @mbggenerated
     */
    public Long getPaincbuyProjectId() {
        return paincbuyProjectId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.paincbuy_project_id
     *
     * @param paincbuyProjectId the value for bjwg_panicbuy_project.paincbuy_project_id
     *
     * @mbggenerated
     */
    public void setPaincbuyProjectId(Long paincbuyProjectId) {
        this.paincbuyProjectId = paincbuyProjectId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.name
     *
     * @return the value of bjwg_panicbuy_project.name
     *
     * @mbggenerated
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.name
     *
     * @param name the value for bjwg_panicbuy_project.name
     *
     * @mbggenerated
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.summary
     *
     * @return the value of bjwg_panicbuy_project.summary
     *
     * @mbggenerated
     */
    public String getSummary() {
        return summary;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.summary
     *
     * @param summary the value for bjwg_panicbuy_project.summary
     *
     * @mbggenerated
     */
    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.imgs
     *
     * @return the value of bjwg_panicbuy_project.imgs
     *
     * @mbggenerated
     */
    public String getImgs() {
        return imgs;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.imgs
     *
     * @param imgs the value for bjwg_panicbuy_project.imgs
     *
     * @mbggenerated
     */
    public void setImgs(String imgs) {
        this.imgs = imgs == null ? null : imgs.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.ctime
     *
     * @return the value of bjwg_panicbuy_project.ctime
     *
     * @mbggenerated
     */
    public Date getCtime() {
        return ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.ctime
     *
     * @param ctime the value for bjwg_panicbuy_project.ctime
     *
     * @mbggenerated
     */
    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.type
     *
     * @return the value of bjwg_panicbuy_project.type
     *
     * @mbggenerated
     */
    public Byte getType() {
        return type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.type
     *
     * @param type the value for bjwg_panicbuy_project.type
     *
     * @mbggenerated
     */
    public void setType(Byte type) {
        this.type = type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.status
     *
     * @return the value of bjwg_panicbuy_project.status
     *
     * @mbggenerated
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.status
     *
     * @param status the value for bjwg_panicbuy_project.status
     *
     * @mbggenerated
     */
    public void setStatus(Byte status) {
        this.status = status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.price
     *
     * @return the value of bjwg_panicbuy_project.price
     *
     * @mbggenerated
     */
    public BigDecimal getPrice() {
        return price;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.price
     *
     * @param price the value for bjwg_panicbuy_project.price
     *
     * @mbggenerated
     */
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.num
     *
     * @return the value of bjwg_panicbuy_project.num
     *
     * @mbggenerated
     */
    public Short getNum() {
        return num;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.num
     *
     * @param num the value for bjwg_panicbuy_project.num
     *
     * @mbggenerated
     */
    public void setNum(Short num) {
        this.num = num;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.left_num
     *
     * @return the value of bjwg_panicbuy_project.left_num
     *
     * @mbggenerated
     */
    public Short getLeftNum() {
        return leftNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.left_num
     *
     * @param leftNum the value for bjwg_panicbuy_project.left_num
     *
     * @mbggenerated
     */
    public void setLeftNum(Short leftNum) {
        this.leftNum = leftNum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.total_money
     *
     * @return the value of bjwg_panicbuy_project.total_money
     *
     * @mbggenerated
     */
    public BigDecimal getTotalMoney() {
        return totalMoney;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.total_money
     *
     * @param totalMoney the value for bjwg_panicbuy_project.total_money
     *
     * @mbggenerated
     */
    public void setTotalMoney(BigDecimal totalMoney) {
        this.totalMoney = totalMoney;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.begin_time
     *
     * @return the value of bjwg_panicbuy_project.begin_time
     *
     * @mbggenerated
     */
    public Date getBeginTime() {
        return beginTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.begin_time
     *
     * @param beginTime the value for bjwg_panicbuy_project.begin_time
     *
     * @mbggenerated
     */
    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.end_time
     *
     * @return the value of bjwg_panicbuy_project.end_time
     *
     * @mbggenerated
     */
    public Date getEndTime() {
        return endTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.end_time
     *
     * @param endTime the value for bjwg_panicbuy_project.end_time
     *
     * @mbggenerated
     */
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }


    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.other_fee_detail
     *
     * @return the value of bjwg_panicbuy_project.other_fee_detail
     *
     * @mbggenerated
     */
    public String getOtherFeeDetail() {
        return otherFeeDetail;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.other_fee_detail
     *
     * @param otherFeeDetail the value for bjwg_panicbuy_project.other_fee_detail
     *
     * @mbggenerated
     */
    public void setOtherFeeDetail(String otherFeeDetail) {
        this.otherFeeDetail = otherFeeDetail == null ? null : otherFeeDetail.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.other_fee
     *
     * @return the value of bjwg_panicbuy_project.other_fee
     *
     * @mbggenerated
     */
    public BigDecimal getOtherFee() {
        return otherFee;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.other_fee
     *
     * @param otherFee the value for bjwg_panicbuy_project.other_fee
     *
     * @mbggenerated
     */
    public void setOtherFee(BigDecimal otherFee) {
        this.otherFee = otherFee;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column bjwg_panicbuy_project.variety
     *
     * @return the value of bjwg_panicbuy_project.variety
     *
     * @mbggenerated
     */
    public Byte getVariety() {
        return variety;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column bjwg_panicbuy_project.variety
     *
     * @param variety the value for bjwg_panicbuy_project.variety
     *
     * @mbggenerated
     */
    public void setVariety(Byte variety) {
        this.variety = variety;
    }
}