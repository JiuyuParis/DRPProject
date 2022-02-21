package basedata.domain;
/**
 * 需方客户（视图）
 * @author cx998
 *
 */
public class AimClient {
	private int ID;
	private String NAME;
	private String CLIENT_TEMI_ID;
	private String CLIENT_TEMI_LEVEL;
	private String CLIENT_TEMI_LEVEL_NAME;
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getCLIENT_TEMI_ID() {
		return CLIENT_TEMI_ID;
	}
	public void setCLIENT_TEMI_ID(String cLIENT_TEMI_ID) {
		CLIENT_TEMI_ID = cLIENT_TEMI_ID;
	}
	public String getCLIENT_TEMI_LEVEL() {
		return CLIENT_TEMI_LEVEL;
	}
	public void setCLIENT_TEMI_LEVEL(String cLIENT_TEMI_LEVEL) {
		CLIENT_TEMI_LEVEL = cLIENT_TEMI_LEVEL;
	}
	public String getCLIENT_TEMI_LEVEL_NAME() {
		return CLIENT_TEMI_LEVEL_NAME;
	}
	public void setCLIENT_TEMI_LEVEL_NAME(String cLIENT_TEMI_LEVEL_NAME) {
		CLIENT_TEMI_LEVEL_NAME = cLIENT_TEMI_LEVEL_NAME;
	}
	
}
