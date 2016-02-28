package com.bjwg.main.model;

import com.bjwg.main.base.Pages;

import java.util.ArrayList;
import java.util.List;

public class Area_V2Example {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    protected Pages page;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public Area_V2Example() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
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
     * This method corresponds to the database table HZD_AREA_V2
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
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
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
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public void setPage(Pages page) {
        this.page=page;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table HZD_AREA_V2
     *
     * @mbggenerated
     */
    public Pages getPage() {
        return page;
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table HZD_AREA_V2
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

        public Criteria andAreaIdIsNull() {
            addCriterion("ar2.AREA_ID is null");
            return (Criteria) this;
        }

        public Criteria andAreaIdIsNotNull() {
            addCriterion("ar2.AREA_ID is not null");
            return (Criteria) this;
        }

        public Criteria andAreaIdEqualTo(Long value) {
            addCriterion("ar2.AREA_ID =", value, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdNotEqualTo(Long value) {
            addCriterion("ar2.AREA_ID <>", value, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdGreaterThan(Long value) {
            addCriterion("ar2.AREA_ID >", value, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdGreaterThanOrEqualTo(Long value) {
            addCriterion("ar2.AREA_ID >=", value, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdLessThan(Long value) {
            addCriterion("ar2.AREA_ID <", value, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdLessThanOrEqualTo(Long value) {
            addCriterion("ar2.AREA_ID <=", value, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdIn(List<Long> values) {
            addCriterion("ar2.AREA_ID in", values, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdNotIn(List<Long> values) {
            addCriterion("ar2.AREA_ID not in", values, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdBetween(Long value1, Long value2) {
            addCriterion("ar2.AREA_ID between", value1, value2, "areaId");
            return (Criteria) this;
        }

        public Criteria andAreaIdNotBetween(Long value1, Long value2) {
            addCriterion("ar2.AREA_ID not between", value1, value2, "areaId");
            return (Criteria) this;
        }

        public Criteria andNameIsNull() {
            addCriterion("ar2.NAME is null");
            return (Criteria) this;
        }

        public Criteria andNameIsNotNull() {
            addCriterion("ar2.NAME is not null");
            return (Criteria) this;
        }

        public Criteria andNameEqualTo(String value) {
            addCriterion("ar2.NAME =", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotEqualTo(String value) {
            addCriterion("ar2.NAME <>", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThan(String value) {
            addCriterion("ar2.NAME >", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThanOrEqualTo(String value) {
            addCriterion("ar2.NAME >=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThan(String value) {
            addCriterion("ar2.NAME <", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThanOrEqualTo(String value) {
            addCriterion("ar2.NAME <=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLike(String value) {
            addCriterion("ar2.NAME like", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotLike(String value) {
            addCriterion("ar2.NAME not like", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameIn(List<String> values) {
            addCriterion("ar2.NAME in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotIn(List<String> values) {
            addCriterion("ar2.NAME not in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameBetween(String value1, String value2) {
            addCriterion("ar2.NAME between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotBetween(String value1, String value2) {
            addCriterion("ar2.NAME not between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andParentIsNull() {
            addCriterion("ar2.PARENT is null");
            return (Criteria) this;
        }

        public Criteria andParentIsNotNull() {
            addCriterion("ar2.PARENT is not null");
            return (Criteria) this;
        }

        public Criteria andParentEqualTo(Long value) {
            addCriterion("ar2.PARENT =", value, "parent");
            return (Criteria) this;
        }

        public Criteria andParentNotEqualTo(Long value) {
            addCriterion("ar2.PARENT <>", value, "parent");
            return (Criteria) this;
        }

        public Criteria andParentGreaterThan(Long value) {
            addCriterion("ar2.PARENT >", value, "parent");
            return (Criteria) this;
        }

        public Criteria andParentGreaterThanOrEqualTo(Long value) {
            addCriterion("ar2.PARENT >=", value, "parent");
            return (Criteria) this;
        }

        public Criteria andParentLessThan(Long value) {
            addCriterion("ar2.PARENT <", value, "parent");
            return (Criteria) this;
        }

        public Criteria andParentLessThanOrEqualTo(Long value) {
            addCriterion("ar2.PARENT <=", value, "parent");
            return (Criteria) this;
        }

        public Criteria andParentIn(List<Long> values) {
            addCriterion("ar2.PARENT in", values, "parent");
            return (Criteria) this;
        }

        public Criteria andParentNotIn(List<Long> values) {
            addCriterion("ar2.PARENT not in", values, "parent");
            return (Criteria) this;
        }

        public Criteria andParentBetween(Long value1, Long value2) {
            addCriterion("ar2.PARENT between", value1, value2, "parent");
            return (Criteria) this;
        }

        public Criteria andParentNotBetween(Long value1, Long value2) {
            addCriterion("ar2.PARENT not between", value1, value2, "parent");
            return (Criteria) this;
        }

        public Criteria andZipcodeIsNull() {
            addCriterion("ar2.ZIPCODE is null");
            return (Criteria) this;
        }

        public Criteria andZipcodeIsNotNull() {
            addCriterion("ar2.ZIPCODE is not null");
            return (Criteria) this;
        }

        public Criteria andZipcodeEqualTo(Integer value) {
            addCriterion("ar2.ZIPCODE =", value, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeNotEqualTo(Integer value) {
            addCriterion("ar2.ZIPCODE <>", value, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeGreaterThan(Integer value) {
            addCriterion("ar2.ZIPCODE >", value, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeGreaterThanOrEqualTo(Integer value) {
            addCriterion("ar2.ZIPCODE >=", value, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeLessThan(Integer value) {
            addCriterion("ar2.ZIPCODE <", value, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeLessThanOrEqualTo(Integer value) {
            addCriterion("ar2.ZIPCODE <=", value, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeIn(List<Integer> values) {
            addCriterion("ar2.ZIPCODE in", values, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeNotIn(List<Integer> values) {
            addCriterion("ar2.ZIPCODE not in", values, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeBetween(Integer value1, Integer value2) {
            addCriterion("ar2.ZIPCODE between", value1, value2, "zipcode");
            return (Criteria) this;
        }

        public Criteria andZipcodeNotBetween(Integer value1, Integer value2) {
            addCriterion("ar2.ZIPCODE not between", value1, value2, "zipcode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeIsNull() {
            addCriterion("ar2.BAIDU_CODE is null");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeIsNotNull() {
            addCriterion("ar2.BAIDU_CODE is not null");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeEqualTo(Long value) {
            addCriterion("ar2.BAIDU_CODE =", value, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeNotEqualTo(Long value) {
            addCriterion("ar2.BAIDU_CODE <>", value, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeGreaterThan(Long value) {
            addCriterion("ar2.BAIDU_CODE >", value, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeGreaterThanOrEqualTo(Long value) {
            addCriterion("ar2.BAIDU_CODE >=", value, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeLessThan(Long value) {
            addCriterion("ar2.BAIDU_CODE <", value, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeLessThanOrEqualTo(Long value) {
            addCriterion("ar2.BAIDU_CODE <=", value, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeIn(List<Long> values) {
            addCriterion("ar2.BAIDU_CODE in", values, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeNotIn(List<Long> values) {
            addCriterion("ar2.BAIDU_CODE not in", values, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeBetween(Long value1, Long value2) {
            addCriterion("ar2.BAIDU_CODE between", value1, value2, "baiduCode");
            return (Criteria) this;
        }

        public Criteria andBaiduCodeNotBetween(Long value1, Long value2) {
            addCriterion("ar2.BAIDU_CODE not between", value1, value2, "baiduCode");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table HZD_AREA_V2
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
     * This class corresponds to the database table HZD_AREA_V2
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