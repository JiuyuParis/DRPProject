package basedata.manager;

import basedata.domain.Item;
import common.PageModel;

/**
 * 物料业务逻辑层接口
 * @author Jiuyu
 *
 */
public interface ItemManager {
	/**
	 * 添加物料
	 * @param conn
	 * @param item
	 */
	void addItem(Item item);
	
	/**
	 * 删除物料
	 * @param conn
	 * @param item
	 */
	void delItem(String[] itemNos);
	
	/**
	 * 修改物料
	 * @param conn
	 * @param item
	 */
	void modifyItem(Item item);
	
	/**
	 * 查找物料信息
	 * @param conn
	 * @param itemNo
	 */
	Item findItemById(String itemNo);
	
	/**
	 * 根据条件分页查询
	 * @param conn
	 * @param pageNo
	 * @param pageSize
	 * @param condition
	 * @return
	 */
	PageModel<Item> findItemList(int pageNo,int pageSize,String condition);
	
	/**
	 * 物料图片上传
	 * @param itemNo
	 * @param fileName
	 */
	public void uploadItemImage(String itemNo,String fileName);
}
