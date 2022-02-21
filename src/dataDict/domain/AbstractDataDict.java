package dataDict.domain;
/**
 * 数据字典的抽象类
 * @author cx998
 *
 */
public abstract class AbstractDataDict {
	private String DICT_ID;
	private String NAME;
	private String CATEGORY;
	public String getDICT_ID() {
		return DICT_ID;
	}
	public void setDICT_ID(String dICT_ID) {
		DICT_ID = dICT_ID;
	}
	public String getCATEGORY() {
		return CATEGORY;
	}
	public void setCATEGORY(String cATEGORY) {
		CATEGORY = cATEGORY;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	
	
}
