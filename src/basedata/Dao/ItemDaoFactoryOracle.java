package basedata.Dao;
/**
 * 物料工厂Oracle类
 * @author Jiuyu
 *
 */
public class ItemDaoFactoryOracle implements ItemDaoFactory {

	@Override
	public ItemDao createItemDao() {
		return new ItemDaoOracle();
	}

}
