package jdbcTools;
/**
 * JDBC配置类
 * @author cx998
 *
 */
public class JDBCconfig {
	private String driverName;
	private String user;
	private String password;
	private String url;
	public String getDriverName() {
		return driverName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String toString() {
		return this.getClass().getName()+"---driverName:"+driverName+"---url:"+url+"---user:"+user+"---password"+password;
	}
}
