package basedata.domain;

import java.util.Date;
  
/**
 * 核算期间
 * @author wangy
 *
 */
public class FiscalYearPeriod {
	
	//id 
	private int fiscalId;
	
	//核算年
	private int fiscalYear;
	
	//核算月
	private int fiscalPeriod;
	
	//开始日期
	private Date beginDate;
	
	//结束日期
	private Date endDate;
	
	//状态״̬
	private String periodSts;

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public int getFiscalPeriod() {
		return fiscalPeriod;
	}

	public void setFiscalPeriod(int fiscalPeriod) {
		this.fiscalPeriod = fiscalPeriod;
	}

	public int getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(int fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	public String getPeriodSts() {
		return periodSts;
	}

	public void setPeriodSts(String periodSts) {
		this.periodSts = periodSts;
	}

	public int getFiscalId() {
		return fiscalId;
	}

	public void setFiscalId(int fiscalId) {
		this.fiscalId = fiscalId;
	}
	
	
}
