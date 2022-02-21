package common;

import java.util.List;

/**
 * 分页模型类，封装分页信息
 * @author cx998
 *
 */
public class PageModel<T> {
	//数据库查询列表
	private List<T> list;
	//查询记录总条数
	private int totalRecords;
	//每页要分多少条数据
	private int pageSize;
	//第几页
	private int pageNo;
	/**
	 * 计算总页数
	 * @return 总页数
	 */
	public int getTotalPages()
	{
		return (int) Math.ceil((double)totalRecords/pageSize);
	}
	/**
	 * 获得首页
	 * @return 首页
	 */
	public int getTopPage()
	{
		return 1;
	}
	/**
	 * 获得尾页
	 * @return 尾页
	 */
	public int getBottomPage() 
	{
		return getTotalPages();
	}
	/**
	 * 向前翻页
	 * @return
	 */
	public int getPreviousPage()
	{
		if(pageNo<=1)
			return 1;
		return pageNo-1;
	}
	/**
	 * 向后翻页
	 * @return
	 */
	public int getNextPage()
	{
		if(pageNo>=getTotalPages())
			return getTotalPages();
		return pageNo+1;
	}
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}
	public int getTotalRecords() {
		return totalRecords;
	}
	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
}
