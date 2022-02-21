package basedata.domain;

import dataDict.domain.ClientLevel;

/**
 * 分销商类
 * @author cx998
 *
 */
public class Client {
	private int id;
	private int pid;
	private String name;
	private String clientId;
	private String bankNo;
	private String tel;
	private String address;
	private String ems;
	private String isLeaf;
	private String isClient;
	private ClientLevel clientLevel=new ClientLevel();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEms() {
		return ems==null?"":ems;
	}
	public void setEms(String ems) {
		this.ems = ems;
	}
	public ClientLevel getClientLevel() {
		return clientLevel;
	}
	public void setClientLevel(ClientLevel clientLevel) {
		this.clientLevel = clientLevel;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String cientId) {
		this.clientId = cientId;
	}
	public String getBankNo() {
		return bankNo==null?"":bankNo;
	}
	public void setBankNo(String bankNo) {
		this.bankNo = bankNo;
	}
	public String getTel() {
		return tel==null?"":tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address==null?"":address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getIsLeaf() {
		return isLeaf;
	}
	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}
	public String getIsClient() {
		return isClient;
	}
	public void setIsClient(String isClient) {
		this.isClient = isClient;
	}
	
}
