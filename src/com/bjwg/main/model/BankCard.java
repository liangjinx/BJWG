package com.bjwg.main.model;

import com.bjwg.main.base.BaseVo;

/**
 * 个人银行卡记录
 * @ClassName: BankCard 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author Administrator
 * @date 2015-9-9 上午09:05:55
 */
public class BankCard extends BaseVo{
    /**
	 * 
	 */
	private static final long serialVersionUID = 5380982337308580287L;

	/**
     *
     * @mbggenerated
     */
    private Long cardId;

    /**
     * 卡号
     * @mbggenerated
     */
    private String cardNo;

    /**
     * 持卡人名称
     * @mbggenerated
     */
    private String accountName;

    /**
     * 卡类型
     * @mbggenerated
     */
    private Short cardType;

    /**
     * 银行代号
     * @mbggenerated
     */
    private String bankCode;

    /**
     * 银行名称
     * @mbggenerated
     */
    private String bank;

    /**
     * 身份证号
     * @mbggenerated
     */
    private String idCard;

    /**
     *
     * @mbggenerated
     */
    private Long userId;

    /**
     * 联系电话
     * @mbggenerated
     */
    private String link;
    
    /**
     * 省份
     */
    private Long province;
    /**
     * 城市
     */
    private Long city;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.CARD_ID
     *
     * @return the value of BJWG_BANK_CARD.CARD_ID
     *
     * @mbggenerated
     */
    public Long getCardId() {
        return cardId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.CARD_ID
     *
     * @param cardId the value for BJWG_BANK_CARD.CARD_ID
     *
     * @mbggenerated
     */
    public void setCardId(Long cardId) {
        this.cardId = cardId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.CARD_NO
     *
     * @return the value of BJWG_BANK_CARD.CARD_NO
     *
     * @mbggenerated
     */
    public String getCardNo() {
        return cardNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.CARD_NO
     *
     * @param cardNo the value for BJWG_BANK_CARD.CARD_NO
     *
     * @mbggenerated
     */
    public void setCardNo(String cardNo) {
        this.cardNo = cardNo == null ? null : cardNo.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.ACCOUNT_NAME
     *
     * @return the value of BJWG_BANK_CARD.ACCOUNT_NAME
     *
     * @mbggenerated
     */
    public String getAccountName() {
        return accountName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.ACCOUNT_NAME
     *
     * @param accountName the value for BJWG_BANK_CARD.ACCOUNT_NAME
     *
     * @mbggenerated
     */
    public void setAccountName(String accountName) {
        this.accountName = accountName == null ? null : accountName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.CARD_TYPE
     *
     * @return the value of BJWG_BANK_CARD.CARD_TYPE
     *
     * @mbggenerated
     */
    public Short getCardType() {
        return cardType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.CARD_TYPE
     *
     * @param cardType the value for BJWG_BANK_CARD.CARD_TYPE
     *
     * @mbggenerated
     */
    public void setCardType(Short cardType) {
        this.cardType = cardType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.BANK_CODE
     *
     * @return the value of BJWG_BANK_CARD.BANK_CODE
     *
     * @mbggenerated
     */
    public String getBankCode() {
        return bankCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.BANK_CODE
     *
     * @param bankCode the value for BJWG_BANK_CARD.BANK_CODE
     *
     * @mbggenerated
     */
    public void setBankCode(String bankCode) {
        this.bankCode = bankCode == null ? null : bankCode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.BANK
     *
     * @return the value of BJWG_BANK_CARD.BANK
     *
     * @mbggenerated
     */
    public String getBank() {
        return bank;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.BANK
     *
     * @param bank the value for BJWG_BANK_CARD.BANK
     *
     * @mbggenerated
     */
    public void setBank(String bank) {
        this.bank = bank == null ? null : bank.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.ID_CARD
     *
     * @return the value of BJWG_BANK_CARD.ID_CARD
     *
     * @mbggenerated
     */
    public String getIdCard() {
        return idCard;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.ID_CARD
     *
     * @param idCard the value for BJWG_BANK_CARD.ID_CARD
     *
     * @mbggenerated
     */
    public void setIdCard(String idCard) {
        this.idCard = idCard == null ? null : idCard.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.USER_ID
     *
     * @return the value of BJWG_BANK_CARD.USER_ID
     *
     * @mbggenerated
     */
    public Long getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.USER_ID
     *
     * @param userId the value for BJWG_BANK_CARD.USER_ID
     *
     * @mbggenerated
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column BJWG_BANK_CARD.LINK
     *
     * @return the value of BJWG_BANK_CARD.LINK
     *
     * @mbggenerated
     */
    public String getLink() {
        return link;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column BJWG_BANK_CARD.LINK
     *
     * @param link the value for BJWG_BANK_CARD.LINK
     *
     * @mbggenerated
     */
    public void setLink(String link) {
        this.link = link == null ? null : link.trim();
    }

	public Long getProvince() {
		return province;
	}

	public void setProvince(Long province) {
		this.province = province;
	}

	public Long getCity() {
		return city;
	}

	public void setCity(Long city) {
		this.city = city;
	}
}