package flowcard.domain;

import java.math.BigDecimal;

import basedata.domain.AimClient;
import basedata.domain.Item;

/**
 * 流向单明细信息
 * @author Jiuyu
 *
 */
public class FlowCardDetail {
	private FlowCard flowCard;//流向单主信息
	private BigDecimal optQty;//操作数量
	private BigDecimal adjustQty;//调整数量
	private String adjustReason;//调整原因
	private String adjustFlag;//调整标记Y-调整 N-未调整
	private AimClient aimClient;//需方客户
	private Item item;//物料
	public FlowCard getFlowCard() {
		return flowCard;
	}
	public void setFlowCard(FlowCard flowCard) {
		this.flowCard = flowCard;
	}
	public BigDecimal getOptQty() {
		return optQty;
	}
	public void setOptQty(BigDecimal optQty) {
		this.optQty = optQty;
	}
	public BigDecimal getAdjustQty() {
		return adjustQty;
	}
	public void setAdjustQty(BigDecimal adjustQty) {
		this.adjustQty = adjustQty;
	}
	public String getAdjustReason() {
		return adjustReason;
	}
	public void setAdjustReason(String adjustReason) {
		this.adjustReason = adjustReason;
	}
	public String getAdjustFlag() {
		return adjustFlag;
	}
	public void setAdjustFlag(String adjustFlag) {
		this.adjustFlag = adjustFlag;
	}
	public AimClient getAimClient() {
		return aimClient;
	}
	public void setAimClient(AimClient aimClient) {
		this.aimClient = aimClient;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	
}
