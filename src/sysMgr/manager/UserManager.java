package sysMgr.manager;
import java.util.List;

import common.PageModel;
import jdbcTools.JDBCTools;
import sysMgr.domain.User;
public class UserManager {
	private static UserManager instance=null;
	/**
	 * 单例模式（懒汉式）
	 * @return UserManager实例
	 */
	public static synchronized UserManager getInstance()
	{
		if(instance==null)
			instance=new UserManager();
		return instance;
	}
	/**
	 * 添加用户方法
	 * @param user
	 */
	public  void addUser(User user)
	{
		String sql="insert into user(user_id,user_name,password,contact_tel,email,create_date) values(?,?,?,?,?,?)";
		JDBCTools.ZSG(sql,user.getUSER_ID(),user.getUSER_NAME(),user.getPASSWORD(),user.getCONTACT_TEL(),user.getEMAIL(),user.getCREATE_DATE());
	}
	/**
	 * 查询用户方法
	 * @param user
	 * @return 用户列表
	 */
	public List<User> Query(User user)
	{
		String sql="select * from user where user_id=?";
		return JDBCTools.Query(User.class, sql,user.getUSER_ID());
	}
	/**
	 * 给分页模型PageModel赋值方法
	 * @param pageNo
	 * @param pageSize
	 * @return 分页模型
	 */
	public PageModel<User> getUserList(int pageNo,int pageSize)
	{
		String sql="select * from user order by user_id limit ?,?";
		//按页数返回查询
		List<User> userList=JDBCTools.Query(User.class, sql, (pageNo-1)*pageSize,pageSize);
		PageModel<User> pageModel=new PageModel<User>();
		pageModel.setList(userList);
		pageModel.setTotalRecords(JDBCTools.getTupleNum("select count(*) from user"));
		pageModel.setPageSize(pageSize);
		pageModel.setPageNo(pageNo);
		return pageModel;
	}
	/**
	 * 修改用户方法
	 * @param user
	 */
	public void modifyUser(User user)
	{
		String sql="update user set user_name=?, password=?,contact_tel=?,email=? where user_id=?";
		JDBCTools.ZSG(sql, user.getUSER_NAME(),user.getPASSWORD(),user.getCONTACT_TEL(),user.getEMAIL(),user.getUSER_ID());
	}
	/**
	 * 删除用户方法1（循环删除，执行效率低）
	 * @param userId
	 */
	public void deleteUser(String[] userId)
	{
		String sql="delete from user where user_id=?";
		for(int i=0;i<userId.length;i++)
		{
			JDBCTools.ZSG(sql, userId[i]);
		}
	}
	/**
	 * 删除用户方法2（拼串删除，执行效率高）
	 * @param userId
	 */
	public void deleteUser2(String[] userId)
	{
		StringBuilder users=new StringBuilder();
		for(int i=0;i<userId.length;i++)
			users.append("'").append(userId[i]).append("',");
		String sql="delete from user where user_id in ("+users.substring(0,users.length()-1)+")";
		System.out.println(sql);
		JDBCTools.ZSG(sql);
	}
	/**
	 * 删除用户方法2（拼串删除，执行效率高）
	 * @param userId
	 */
	public void deleteUser3(String[] userId)
	{
		StringBuilder users=new StringBuilder();
		for(int i=0;i<userId.length;i++)
		{
			users.append("?");
			if(i<userId.length-1)
				users.append(",");
		}
		String sql="delete from user where user_id in ("+users+")";
		System.out.println(sql);
		
		JDBCTools.ZSG2(sql,userId);
	}
	/**
	 * 用户登录检查
	 * @param userId
	 * @param password
	 * @return 用户信息（列表，取第一个元素即可）
	 */
	public List<User> login(String userId,String password)
	{
		String sql="select * from user where user_id=?";
		List<User> user=JDBCTools.Query(User.class, sql, userId);
		if(user==null)
			throw new UserNotFoundException("<font color='red'>用户【"+userId+"】不存在</font>");
		if(!(password.equals(user.get(0).getPASSWORD())))
			throw new PasswordNotRightException("<font color='red'>密码错误</font>");
		return user;
	}
}
