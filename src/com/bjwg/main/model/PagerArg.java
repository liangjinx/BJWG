package com.bjwg.main.model;
/**
 * 分页栏参数配置model
 * @author Carter
 * @version 创建时间：2015-10-14 上午10:01:03
 * @Modified By:Carter
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */
public class PagerArg {
	//分页栏数值迭代开始数
	int beginPage;
	//分页栏数值迭代结束数
	int endPage;
	//上一页
	int lastPage;
	//当前页
	int currentPage;
	//下一页
	int nextPage;
	//总记录数
	int rowCount;
	//总页数
	int pageCount;
	
	public PagerArg(int beginPage,int endPage, int lastPage, int currentPage,int nextPage, int rowCount, int pageCount){
		this.beginPage = beginPage;
		this.endPage = endPage;
		this.lastPage = lastPage;
		this.currentPage = currentPage;
		this.nextPage = nextPage;
		this.rowCount = rowCount;
		this.pageCount = pageCount;
	}
	
	public int getBeginPage() {
		return beginPage;
	}
	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	
	
}

