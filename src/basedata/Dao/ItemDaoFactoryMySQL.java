package basedata.Dao;
/**
 * 物料工厂MySQL类
 * @author Jiuyu
 *
 */
public class ItemDaoFactoryMySQL implements ItemDaoFactory {

	@Override
	public ItemDao createItemDao() {
		return new ItemDaoMySQL();
	}

}
