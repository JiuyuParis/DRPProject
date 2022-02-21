package basedata.manager;

import java.sql.Connection;

import basedata.Dao.ItemDao;
import basedata.domain.Item;
import common.ApplicationException;
import common.BeanFactory;
import common.PageModel;
import jdbcTools.JDBCTools;

public class ItemManagerImpl implements ItemManager {
	private ItemDao itemDao=null;
	public ItemManagerImpl() {
		itemDao=(ItemDao) BeanFactory.getInstance().getDaoBean(ItemDao.class);
		/*
		 * String
		 * className=SysconfigXpathReader.getInstance().getDaoFactory("item-dao-factory"
		 * );//读取Sysconfig配置文件获得工厂路径 ItemDaoFactory factory=null;//物料工厂 try {
		 * factory=(ItemDaoFactory)
		 * Class.forName(className).getDeclaredConstructor().newInstance();//
		 * 通过反射机制创建工厂实例
		 * 
		 * } catch (InstantiationException | IllegalAccessException |
		 * IllegalArgumentException | InvocationTargetException | NoSuchMethodException
		 * | SecurityException | ClassNotFoundException e) { e.printStackTrace(); }
		 * itemDao=factory.createItemDao();//创建物料Dao数据访问对象
		 */		 	}
	
	
	public ItemDao getItemDao() {
		return itemDao;
	}


	public void setItemDao(ItemDao itemDao) {
		this.itemDao = itemDao;
	}


	@Override
	public void addItem(Item item) {
		Connection connection=null;
		try {
			connection=JDBCTools.Connect();
			if(itemDao.findItemById(connection, item.getNo())!=null)
				throw new ApplicationException("物料代码已存在！"+"代码【"+item.getNo()+"】");
			itemDao.addItem(connection, item);
		} catch (ApplicationException e) {
			throw e;
		}finally {
			JDBCTools.closeSCR(null, connection, null);
		}
	}

	@Override
	public void delItem(String[] itemNos) {
		Connection connection=null;
		try {
			connection=JDBCTools.Connect();
			itemDao.delItem(connection, itemNos);;
		} catch (ApplicationException e) {
			throw e;
		}finally {
			JDBCTools.closeSCR(null, connection, null);
		}
	}

	@Override
	public void modifyItem(Item item) {
		Connection connection=null;
		try {
			connection=JDBCTools.Connect();
			itemDao.modifyItem(connection, item);
		} catch (ApplicationException e) {
			throw e;
		}finally {
			JDBCTools.closeSCR(null, connection, null);
		}
	}

	@Override
	public Item findItemById(String itemNo) {
		Connection connection=null;
		try {
			connection=JDBCTools.Connect();
			return itemDao.findItemById(connection, itemNo);
		}finally {
			JDBCTools.closeSCR(null, connection, null);
		}
	}

	@Override
	public PageModel<Item> findItemList(int pageNo, int pageSize, String condition) {
		Connection connection = null;
		try {
			connection = JDBCTools.Connect();
			return itemDao.findItemList(connection, pageNo, pageSize, condition);
		} finally {
			JDBCTools.closeSCR(null, connection, null);
		}
	}
	
	@Override
	public void uploadItemImage(String itemNo,String fileName) {
		Connection connection=null;
		try {
			connection=JDBCTools.Connect();
			Item item=itemDao.findItemById(connection, itemNo);
			item.setFileName(fileName);//将图片文件名设置到item中
			itemDao.modifyItem(connection, item);
		} catch (Exception e) {
			throw new ApplicationException("上传物料图片失败！");
		}finally {
			JDBCTools.closeSCR(null, connection, null);
		}
	}
	
}
