package basedata.web;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import common.ApplicationException;
import systemFiles.Constants;
/**
 * 物料上传
 * @author Jiuyu
 *
 */
public class FileUploadServlet extends AbstractItemServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4788409243641052725L;
	//private String uploadPath = "D:\\share\\JavaProjects\\drp\\apache-tomcat-5.5.26\\webapps\\drp4.0\\upload\\"; // 用于存放上传文件的目录
	private File uploadPath;//存放上传文件的路径
//	private File uploadPathWeb;//存放上传文件的路径
	
	//private File tempPath = new File("D:\\addnetFile\\tmp\\"); // 用于存放临时文件的目录
	
	private File tempPath;// 用于存放临时文件的目录
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		//form提交采用multipart/form-data,无法采用req.getParameter()取得数据
		//String itemNo = req.getParameter("itemNo");
		//System.out.println("itemNo======" + itemNo);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		// maximum size that will be stored in memory
		factory.setSizeThreshold(4096);
		
		// the location for saving data that is larger than getSizeThreshold()
		factory.setRepository(tempPath);

		ServletFileUpload upload = new ServletFileUpload(factory);
		// maximum size before a FileUploadException will be thrown
		upload.setSizeMax(1000000 * 20);
		try {
			List<FileItem> fileItems = upload.parseRequest(req);//解析request请求，获取表单数据即得到FileItem对象列表
			String itemNo = "";//上传图片物料的代码
			for (Iterator<FileItem> iter = fileItems.iterator(); iter.hasNext();) {
				FileItem item = (FileItem) iter.next();
				
				//是普通的表单输入域则取出物料代码
				if(item.isFormField()) {
					if ("itemNo".equals(item.getFieldName())) {
						itemNo = item.getString();
					}
				}
				//是否为input="type"输入域
				if (!item.isFormField()) {
					String fileName = item.getName();
					long size = item.getSize();//返回该图片的大小
					//如果没有选择文件则跳过该文件项目
					if ((fileName == null || fileName.equals("")) && size == 0) {
						continue;
					}
					//截取字符串 如：C:\WINDOWS\Debug\PASSWD.LOG
					fileName = fileName.substring(fileName.lastIndexOf("\\") + 1, fileName.length());
					System.out.println(fileName);
					//item.write(new File(uploadPath + itemNo + ".gif"));
					itemManager.uploadItemImage(itemNo, fileName);//将物料图片名加入到数据库中
					File file=new File(uploadPath, fileName);//要上传的文件
					//如果文件存在则覆盖文件
					if(file.exists())
					{
						file.delete();
						item.write(file);
	//					item.write(new File(uploadPathWeb, fileName));
					}
				}
			}
			res.sendRedirect(req.getContextPath() + "/servlet/item/SearchItemServlet?info="+Constants.UPLOAD);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ApplicationException("上传图片失败！");
		}
	}

	public void init() throws ServletException {
		super.init();//显示调用父类构造初始化方法
		uploadPath = new File("E:\\Files\\eclipse-workspace\\DRP Manager System\\DRP Project\\WebContent\\upload");
		//如果目录不存在
		if (!uploadPath.exists()) {
			//创建目录
			uploadPath.mkdir();
		}
		
		/*
		 * uploadPathWeb = new File(getServletContext().getRealPath("upload"));
		 * System.out.println("uploadPath=====" + uploadPath); //如果目录不存在 if
		 * (!uploadPath.exists()) { //创建目录 uploadPath.mkdir(); }
		 */
		
		//临时目录
		tempPath = new File("E:\\Files\\eclipse-workspace\\DRP Manager System\\DRP Project\\WebContent\\temp");
		if (!tempPath.exists()) {
			tempPath.mkdir();
		}
	}
}
