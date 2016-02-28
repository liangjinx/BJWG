package com.bjwg.main.model;

import com.bjwg.main.base.Pages;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class WalletChangeExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    protected Pages page;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public WalletChangeExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public void setPage(Pages page) {
        this.page=page;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public Pages getPage() {
        return page;
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andWalletChangeIdIsNull() {
            addCriterion("wlc.WALLET_CHANGE_ID is null");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdIsNotNull() {
            addCriterion("wlc.WALLET_CHANGE_ID is not null");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdEqualTo(Long value) {
            addCriterion("wlc.WALLET_CHANGE_ID =", value, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdNotEqualTo(Long value) {
            addCriterion("wlc.WALLET_CHANGE_ID <>", value, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdGreaterThan(Long value) {
            addCriterion("wlc.WALLET_CHANGE_ID >", value, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdGreaterThanOrEqualTo(Long value) {
            addCriterion("wlc.WALLET_CHANGE_ID >=", value, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdLessThan(Long value) {
            addCriterion("wlc.WALLET_CHANGE_ID <", value, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdLessThanOrEqualTo(Long value) {
            addCriterion("wlc.WALLET_CHANGE_ID <=", value, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdIn(List<Long> values) {
            addCriterion("wlc.WALLET_CHANGE_ID in", values, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdNotIn(List<Long> values) {
            addCriterion("wlc.WALLET_CHANGE_ID not in", values, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdBetween(Long value1, Long value2) {
            addCriterion("wlc.WALLET_CHANGE_ID between", value1, value2, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletChangeIdNotBetween(Long value1, Long value2) {
            addCriterion("wlc.WALLET_CHANGE_ID not between", value1, value2, "walletChangeId");
            return (Criteria) this;
        }

        public Criteria andWalletIdIsNull() {
            addCriterion("wlc.WALLET_ID is null");
            return (Criteria) this;
        }

        public Criteria andWalletIdIsNotNull() {
            addCriterion("wlc.WALLET_ID is not null");
            return (Criteria) this;
        }

        public Criteria andWalletIdEqualTo(Long value) {
            addCriterion("wlc.WALLET_ID =", value, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdNotEqualTo(Long value) {
            addCriterion("wlc.WALLET_ID <>", value, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdGreaterThan(Long value) {
            addCriterion("wlc.WALLET_ID >", value, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdGreaterThanOrEqualTo(Long value) {
            addCriterion("wlc.WALLET_ID >=", value, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdLessThan(Long value) {
            addCriterion("wlc.WALLET_ID <", value, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdLessThanOrEqualTo(Long value) {
            addCriterion("wlc.WALLET_ID <=", value, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdIn(List<Long> values) {
            addCriterion("wlc.WALLET_ID in", values, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdNotIn(List<Long> values) {
            addCriterion("wlc.WALLET_ID not in", values, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdBetween(Long value1, Long value2) {
            addCriterion("wlc.WALLET_ID between", value1, value2, "walletId");
            return (Criteria) this;
        }

        public Criteria andWalletIdNotBetween(Long value1, Long value2) {
            addCriterion("wlc.WALLET_ID not between", value1, value2, "walletId");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNull() {
            addCriterion("wlc.USER_ID is null");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNotNull() {
            addCriterion("wlc.USER_ID is not null");
            return (Criteria) this;
        }

        public Criteria andUserIdEqualTo(Long value) {
            addCriterion("wlc.USER_ID =", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotEqualTo(Long value) {
            addCriterion("wlc.USER_ID <>", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThan(Long value) {
            addCriterion("wlc.USER_ID >", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThanOrEqualTo(Long value) {
            addCriterion("wlc.USER_ID >=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThan(Long value) {
            addCriterion("wlc.USER_ID <", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThanOrEqualTo(Long value) {
            addCriterion("wlc.USER_ID <=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdIn(List<Long> values) {
            addCriterion("wlc.USER_ID in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotIn(List<Long> values) {
            addCriterion("wlc.USER_ID not in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdBetween(Long value1, Long value2) {
            addCriterion("wlc.USER_ID between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotBetween(Long value1, Long value2) {
            addCriterion("wlc.USER_ID not between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyIsNull() {
            addCriterion("wlc.BEFORE_MONEY is null");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyIsNotNull() {
            addCriterion("wlc.BEFORE_MONEY is not null");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyEqualTo(BigDecimal value) {
            addCriterion("wlc.BEFORE_MONEY =", value, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyNotEqualTo(BigDecimal value) {
            addCriterion("wlc.BEFORE_MONEY <>", value, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyGreaterThan(BigDecimal value) {
            addCriterion("wlc.BEFORE_MONEY >", value, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("wlc.BEFORE_MONEY >=", value, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyLessThan(BigDecimal value) {
            addCriterion("wlc.BEFORE_MONEY <", value, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyLessThanOrEqualTo(BigDecimal value) {
            addCriterion("wlc.BEFORE_MONEY <=", value, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyIn(List<BigDecimal> values) {
            addCriterion("wlc.BEFORE_MONEY in", values, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyNotIn(List<BigDecimal> values) {
            addCriterion("wlc.BEFORE_MONEY not in", values, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("wlc.BEFORE_MONEY between", value1, value2, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andBeforeMoneyNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("wlc.BEFORE_MONEY not between", value1, value2, "beforeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyIsNull() {
            addCriterion("wlc.CHANGE_MONEY is null");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyIsNotNull() {
            addCriterion("wlc.CHANGE_MONEY is not null");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyEqualTo(BigDecimal value) {
            addCriterion("wlc.CHANGE_MONEY =", value, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyNotEqualTo(BigDecimal value) {
            addCriterion("wlc.CHANGE_MONEY <>", value, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyGreaterThan(BigDecimal value) {
            addCriterion("wlc.CHANGE_MONEY >", value, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("wlc.CHANGE_MONEY >=", value, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyLessThan(BigDecimal value) {
            addCriterion("wlc.CHANGE_MONEY <", value, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyLessThanOrEqualTo(BigDecimal value) {
            addCriterion("wlc.CHANGE_MONEY <=", value, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyIn(List<BigDecimal> values) {
            addCriterion("wlc.CHANGE_MONEY in", values, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyNotIn(List<BigDecimal> values) {
            addCriterion("wlc.CHANGE_MONEY not in", values, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("wlc.CHANGE_MONEY between", value1, value2, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andChangeMoneyNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("wlc.CHANGE_MONEY not between", value1, value2, "changeMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyIsNull() {
            addCriterion("wlc.AFTER_MONEY is null");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyIsNotNull() {
            addCriterion("wlc.AFTER_MONEY is not null");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyEqualTo(BigDecimal value) {
            addCriterion("wlc.AFTER_MONEY =", value, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyNotEqualTo(BigDecimal value) {
            addCriterion("wlc.AFTER_MONEY <>", value, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyGreaterThan(BigDecimal value) {
            addCriterion("wlc.AFTER_MONEY >", value, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("wlc.AFTER_MONEY >=", value, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyLessThan(BigDecimal value) {
            addCriterion("wlc.AFTER_MONEY <", value, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyLessThanOrEqualTo(BigDecimal value) {
            addCriterion("wlc.AFTER_MONEY <=", value, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyIn(List<BigDecimal> values) {
            addCriterion("wlc.AFTER_MONEY in", values, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyNotIn(List<BigDecimal> values) {
            addCriterion("wlc.AFTER_MONEY not in", values, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("wlc.AFTER_MONEY between", value1, value2, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andAfterMoneyNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("wlc.AFTER_MONEY not between", value1, value2, "afterMoney");
            return (Criteria) this;
        }

        public Criteria andChangeTypeIsNull() {
            addCriterion("wlc.CHANGE_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andChangeTypeIsNotNull() {
            addCriterion("wlc.CHANGE_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andChangeTypeEqualTo(Short value) {
            addCriterion("wlc.CHANGE_TYPE =", value, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeNotEqualTo(Short value) {
            addCriterion("wlc.CHANGE_TYPE <>", value, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeGreaterThan(Short value) {
            addCriterion("wlc.CHANGE_TYPE >", value, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeGreaterThanOrEqualTo(Short value) {
            addCriterion("wlc.CHANGE_TYPE >=", value, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeLessThan(Short value) {
            addCriterion("wlc.CHANGE_TYPE <", value, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeLessThanOrEqualTo(Short value) {
            addCriterion("wlc.CHANGE_TYPE <=", value, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeIn(List<Short> values) {
            addCriterion("wlc.CHANGE_TYPE in", values, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeNotIn(List<Short> values) {
            addCriterion("wlc.CHANGE_TYPE not in", values, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeBetween(Short value1, Short value2) {
            addCriterion("wlc.CHANGE_TYPE between", value1, value2, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTypeNotBetween(Short value1, Short value2) {
            addCriterion("wlc.CHANGE_TYPE not between", value1, value2, "changeType");
            return (Criteria) this;
        }

        public Criteria andChangeTimeIsNull() {
            addCriterion("wlc.CHANGE_TIME is null");
            return (Criteria) this;
        }

        public Criteria andChangeTimeIsNotNull() {
            addCriterion("wlc.CHANGE_TIME is not null");
            return (Criteria) this;
        }

        public Criteria andChangeTimeEqualTo(Date value) {
            addCriterion("wlc.CHANGE_TIME =", value, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeNotEqualTo(Date value) {
            addCriterion("wlc.CHANGE_TIME <>", value, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeGreaterThan(Date value) {
            addCriterion("wlc.CHANGE_TIME >", value, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("wlc.CHANGE_TIME >=", value, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeLessThan(Date value) {
            addCriterion("wlc.CHANGE_TIME <", value, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeLessThanOrEqualTo(Date value) {
            addCriterion("wlc.CHANGE_TIME <=", value, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeIn(List<Date> values) {
            addCriterion("wlc.CHANGE_TIME in", values, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeNotIn(List<Date> values) {
            addCriterion("wlc.CHANGE_TIME not in", values, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeBetween(Date value1, Date value2) {
            addCriterion("wlc.CHANGE_TIME between", value1, value2, "changeTime");
            return (Criteria) this;
        }

        public Criteria andChangeTimeNotBetween(Date value1, Date value2) {
            addCriterion("wlc.CHANGE_TIME not between", value1, value2, "changeTime");
            return (Criteria) this;
        }

        public Criteria andRelationIdIsNull() {
            addCriterion("wlc.RELATION_ID is null");
            return (Criteria) this;
        }

        public Criteria andRelationIdIsNotNull() {
            addCriterion("wlc.RELATION_ID is not null");
            return (Criteria) this;
        }

        public Criteria andRelationIdEqualTo(Long value) {
            addCriterion("wlc.RELATION_ID =", value, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdNotEqualTo(Long value) {
            addCriterion("wlc.RELATION_ID <>", value, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdGreaterThan(Long value) {
            addCriterion("wlc.RELATION_ID >", value, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdGreaterThanOrEqualTo(Long value) {
            addCriterion("wlc.RELATION_ID >=", value, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdLessThan(Long value) {
            addCriterion("wlc.RELATION_ID <", value, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdLessThanOrEqualTo(Long value) {
            addCriterion("wlc.RELATION_ID <=", value, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdIn(List<Long> values) {
            addCriterion("wlc.RELATION_ID in", values, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdNotIn(List<Long> values) {
            addCriterion("wlc.RELATION_ID not in", values, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdBetween(Long value1, Long value2) {
            addCriterion("wlc.RELATION_ID between", value1, value2, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationIdNotBetween(Long value1, Long value2) {
            addCriterion("wlc.RELATION_ID not between", value1, value2, "relationId");
            return (Criteria) this;
        }

        public Criteria andRelationTypeIsNull() {
            addCriterion("wlc.RELATION_TYPE is null");
            return (Criteria) this;
        }

        public Criteria andRelationTypeIsNotNull() {
            addCriterion("wlc.RELATION_TYPE is not null");
            return (Criteria) this;
        }

        public Criteria andRelationTypeEqualTo(Short value) {
            addCriterion("wlc.RELATION_TYPE =", value, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeNotEqualTo(Short value) {
            addCriterion("wlc.RELATION_TYPE <>", value, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeGreaterThan(Short value) {
            addCriterion("wlc.RELATION_TYPE >", value, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeGreaterThanOrEqualTo(Short value) {
            addCriterion("wlc.RELATION_TYPE >=", value, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeLessThan(Short value) {
            addCriterion("wlc.RELATION_TYPE <", value, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeLessThanOrEqualTo(Short value) {
            addCriterion("wlc.RELATION_TYPE <=", value, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeIn(List<Short> values) {
            addCriterion("wlc.RELATION_TYPE in", values, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeNotIn(List<Short> values) {
            addCriterion("wlc.RELATION_TYPE not in", values, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeBetween(Short value1, Short value2) {
            addCriterion("wlc.RELATION_TYPE between", value1, value2, "relationType");
            return (Criteria) this;
        }

        public Criteria andRelationTypeNotBetween(Short value1, Short value2) {
            addCriterion("wlc.RELATION_TYPE not between", value1, value2, "relationType");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated do_not_delete_during_merge
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table BJWG_WALLET_CHANGE
     *
     * @mbggenerated
     */
    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}