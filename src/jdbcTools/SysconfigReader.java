package jdbcTools;
import java.io.File;
import java.util.Iterator;
import java.util.List;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
/**
 * dom4j读取Sysconfig文件
 * @author cx998
 *
 */
public class SysconfigReader {

	public static void main(String[] args) {
		readSysconfig();
	}
	public static void readSysconfig() {
		//创建SAXReader对象
		SAXReader reader=new SAXReader();
		//加载xml文件
		try {
			Document dc=reader.read(new File("E:\\Files\\eclipse-workspace\\DRP Manager System\\DRP Project\\src\\jdbcTools\\Sysconfig.xml"));
			//获取根节点
			Element e=dc.getRootElement();//config
			//获取迭代器
			Iterator<Element> it=e.elementIterator();//config下一级即MySQLConnection迭代器
			//遍历迭代器，获得根节点信息
			while(it.hasNext())
			{
				Element Sysconfig=(Element)it.next();//MySQLConnection
				//返回属性键值列表
				List<Attribute> atts=Sysconfig.attributes();
				//获得MySQLConnection属性名和属性值
				for(Attribute att:atts)
				{
					System.out.println("属性名："+att.getName()+"属性值："+att.getValue());
				}
				Iterator<Element> itt=Sysconfig.elementIterator();//MySQLConnection下一级即属性层迭代器
				while(itt.hasNext())
				{
					Element ele=(Element)itt.next();//节点层次
					System.out.println("节点名："+ele.getName()+"节点值："+ele.getText());
				}
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		
	}

}
