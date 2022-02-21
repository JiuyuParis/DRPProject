package basedata.Dao;

import java.sql.Connection;

import basedata.domain.Item;
import common.PageModel;

/**
 * 物料数据访问接口
 * @author Jiuyu
 *
 */
public interface ItemDao {
	/**
	 * 添加物料
	 * @param conn
	 * @param item
	 */
	void addItem(Connection conn,Item item);
	
	/**
	 * 删除物料
	 * @param conn
	 * @param item
	 */
	void delItem(Connection conn,String[] itemNos);
	
	/**
	 * 修改物料
	 * @param conn
	 * @param item
	 */
	void modifyItem(Connection conn,Item item);
	
	/**
	 * 查找物料信息
	 * @param conn
	 * @param itemNo
	 */
	Item findItemById(Connection conn,String itemNo);
	
	/**
	 * 根据条件分页查询
	 * @param conn
	 * @param pageNo
	 * @param pageSize
	 * @param condition
	 * @return
	 */
	PageModel<Item> findItemList(Connection conn,int pageNo,int pageSize,String condition);
}
