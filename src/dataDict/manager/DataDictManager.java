package dataDict.manager;

import java.util.List;
import dataDict.domain.ClientLevel;
import dataDict.domain.ItemCategory;
import dataDict.domain.ItemUnit;
import jdbcTools.JDBCTools;
/**
 * 字典管理类(单例模式)
 * @author cx998
 *
 */
public class DataDictManager {
	private static DataDictManager instance=null;
	/**
	 * 返回单例对象
	 * @return
	 */
	public static DataDictManager getInstance()
	{
		if(instance==null)
			instance=new DataDictManager();
		return instance;
	}
	/**
	 * 返回分销商级别列表
	 * @return
	 */
	public List<ClientLevel> findClientLevelList(){
		String sql="select * from data_dict where category='A'";
		return JDBCTools.Query(ClientLevel.class, sql);
	}
	
	/**
	 * 返回物料类别列表
	 * @return
	 */
	public List<ItemCategory> findItemCateGoryList(){
		String sql="select * from data_dict where category='C'";
		return JDBCTools.Query(ItemCategory.class, sql);
	}
	
	/**
	 * 返回物料计量单位列表
	 * @return
	 */
	public List<ItemUnit> findItemUnitList(){
		String sql="select * from data_dict where category='D'";
		return JDBCTools.Query(ItemUnit.class, sql);
	}
}
