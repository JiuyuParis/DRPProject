package flowcard.domain;
import java.util.Date;
import java.util.List;

import basedata.domain.Client;
import basedata.domain.FiscalYearPeriod;
import sysMgr.domain.User;

/**
 * 流向单主信息
 * @author Jiuyu
 *
 */
public class FlowCard {
	
	private String flowCardNo;//流向单号yyyymmdd0001
	private String optType;//操作类型A-流向单 B-盘点数据
	private Date optDate;//操作日期
	private String vouSts;//单据状态 S:送审 N:录入
	private Date adjustDate;//调整日期
	private Date spotDate;//抽查日期
	private String spotDesc;//抽查描述
	private Date confDate;//复审日期
	private User recorder;//录入人
	private User adjuster;//调整人
	private User confirmer;//复审人
	private User spotter;//抽查人
	private Client client;//供方分销商
	private FiscalYearPeriod fiscalYearPeriod;//会计核算期
	List<FlowCardDetail> flowCardDetails;//流向单明细信息列表
	public String getFlowCardNo() {
		return flowCardNo;
	}
	public void setFlowCardNo(String flowCardNo) {
		this.flowCardNo = flowCardNo;
	}
	public String getOptType() {
		return optType;
	}
	public void setOptType(String optType) {
		this.optType = optType;
	}
	public Date getOptDate() {
		return optDate;
	}
	public void setOptDate(Date optDate) {
		this.optDate = optDate;
	}
	public Date getAdjustDate() {
		return adjustDate;
	}
	public void setAdjustDate(Date adjustDate) {
		this.adjustDate = adjustDate;
	}
	public Date getSpotDate() {
		return spotDate;
	}
	public void setSpotDate(Date spotDate) {
		this.spotDate = spotDate;
	}
	public String getSpotDesc() {
		return spotDesc;
	}
	public void setSpotDesc(String spotDesc) {
		this.spotDesc = spotDesc;
	}
	public Date getConfDate() {
		return confDate;
	}
	public void setConfDate(Date confDate) {
		this.confDate = confDate;
	}
	public User getRecorder() {
		return recorder;
	}
	public void setRecorder(User recorder) {
		this.recorder = recorder;
	}
	public User getAdjuster() {
		return adjuster;
	}
	public void setAdjuster(User adjuster) {
		this.adjuster = adjuster;
	}
	public User getConfirmer() {
		return confirmer;
	}
	public void setConfirmer(User confirmer) {
		this.confirmer = confirmer;
	}
	public User getSpotter() {
		return spotter;
	}
	public void setSpotter(User spotter) {
		this.spotter = spotter;
	}
	public Client getClient() {
		return client;
	}
	public void setClient(Client client) {
		this.client = client;
	}
	public FiscalYearPeriod getFiscalYearPeriod() {
		return fiscalYearPeriod;
	}
	public void setFiscalYearPeriod(FiscalYearPeriod fiscalYearPeriod) {
		this.fiscalYearPeriod = fiscalYearPeriod;
	}
	public List<FlowCardDetail> getFlowCardDetails() {
		return flowCardDetails;
	}
	public void setFlowCardDetails(List<FlowCardDetail> flowCardDetails) {
		this.flowCardDetails = flowCardDetails;
	}
	public String getVouSts() {
		return vouSts;
	}
	public void setVouSts(String vouSts) {
		this.vouSts = vouSts;
	}
	
}
