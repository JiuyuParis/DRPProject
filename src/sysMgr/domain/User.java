package sysMgr.domain;
import java.util.Date;
/**
 * 用户实体类
 * @author cx998
 *
 */
public class User {
	private String USER_ID;
	private String USER_NAME;
	private String PASSWORD;
	private String CONTACT_TEL;
	private String EMAIL;
	private Date CREATE_DATE;
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	public String getPASSWORD() {
		return PASSWORD;
	}
	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}
	public String getCONTACT_TEL() {
		return CONTACT_TEL;
	}
	public void setCONTACT_TEL(String cONTACT_TEL) {
		CONTACT_TEL = cONTACT_TEL;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
	public Date getCREATE_DATE() {
		return CREATE_DATE;
	}
	public void setCREATE_DATE(Date cREATE_DATE) {
		CREATE_DATE = cREATE_DATE;
	}
	public User(String uSER_ID, String uSER_NAME, String pASSWORD, String cONTACT_TEL, String eMAIL, Date cREATE_DATE) {
		super();
		USER_ID = uSER_ID;
		USER_NAME = uSER_NAME;
		PASSWORD = pASSWORD;
		CONTACT_TEL = cONTACT_TEL;
		EMAIL = eMAIL;
		CREATE_DATE = cREATE_DATE;
	}
	public User() {
		super();
	}
}
