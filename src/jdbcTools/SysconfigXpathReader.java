package jdbcTools;
import java.io.InputStream;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
/**
 * dom4j使用Xpath读取Sysconfig文件
 * @author cx998
 *
 */
public class SysconfigXpathReader {
	private static SysconfigXpathReader instance=null;
	private JDBCconfig jdbcconfig=new JDBCconfig();
//	private Map<String,String> daoFactoryMap=new HashMap<String,String>();//key-名称，value-具体类完整路径
	
	/**
	 * 懒汉式加载实例化SysconfigXpathReader成员
	 * @return JDBCconfig配置对象
	 */
	public static synchronized SysconfigXpathReader getInstance()
	{
		if(instance==null)
			instance=new SysconfigXpathReader();
		return instance;
	}
	
	/**
	 * 构造函数，完成jdbcconfig的赋值操作
	 */
	private SysconfigXpathReader()
	{
		//构造SAXReader对象
		SAXReader reader=new SAXReader();
		//利用反射加载文件
		InputStream in=SysconfigXpathReader.class.getResourceAsStream("./Sysconfig.xml");
		try {
			Document doc=reader.read(in);
			//利用XPath获得元素
			Element driverName=(Element) doc.selectObject("/config/MySQLConnection/driverName");
			Element url=(Element) doc.selectObject("/config/MySQLConnection/url");
			Element user=(Element) doc.selectObject("/config/MySQLConnection/user");
			Element password=(Element) doc.selectObject("/config/MySQLConnection/password");
			//给jdbcconfig属性赋值
			jdbcconfig.setDriverName(driverName.getStringValue());
			jdbcconfig.setUrl(url.getStringValue());
			jdbcconfig.setUser(user.getStringValue());
			jdbcconfig.setPassword(password.getStringValue());
//			System.out.println("读取jdbcConfig->"+jdbcconfig);//打印读取jdbcconfig日志
			//获取daoFactory信息
			/*
			 * List<Node> daoFactoryList=doc.selectNodes("/config/dao-factory/*");//取到了dao-
			 * factory下的子节点列表 //循环dao-factory下面的标签列表 for(int
			 * i=0;i<daoFactoryList.size();i++) { Element daoFactoryElement=(Element)
			 * daoFactoryList.get(i); String tagNameString=daoFactoryElement.getName();
			 * String tagTextString=daoFactoryElement.getText(); //
			 * System.out.println("读取dao-factory->"+tagNameString+":"+tagTextString);//
			 * 打印读取物料工厂日志 daoFactoryMap.put(tagNameString,
			 * tagTextString);//放入到daoFactoryMap中 }
			 */
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 获取JDBCconfig实例
	 * @return
	 */
	public JDBCconfig getJDBCconfig()
	{
		return jdbcconfig;
	}
	/**
	 * 根据标签名获取DaoFactory的完整路径
	 * @param factoryName
	 * @return
	 */
	/*
	 * public String getDaoFactory(String factoryName) { return
	 * daoFactoryMap.get(factoryName); }
	 */
}
