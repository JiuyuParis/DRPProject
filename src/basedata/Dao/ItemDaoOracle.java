package basedata.Dao;

import java.sql.Connection;

import basedata.domain.Item;
import common.PageModel;
/**
 * 物料数据Oracle访问类
 * @author Jiuyu
 *
 */
public class ItemDaoOracle implements ItemDao {

	@Override
	public void addItem(Connection conn, Item item) {
		System.out.println("ItemDaoOracle.addItem");

	}

	@Override
	public void delItem(Connection conn, String[] itemNos) {
		// TODO Auto-generated method stub

	}

	@Override
	public void modifyItem(Connection conn, Item item) {
		// TODO Auto-generated method stub

	}

	@Override
	public Item findItemById(Connection conn, String itemNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageModel<Item> findItemList(Connection conn, int pageNo, int pageSize, String condition) {
		// TODO Auto-generated method stub
		return null;
	}

}
