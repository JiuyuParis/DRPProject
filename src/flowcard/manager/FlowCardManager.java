package flowcard.manager;

import java.util.Date;

import common.ApplicationException;
import common.PageModel;
import flowcard.domain.FlowCard;

/**
 * 流向单维护业务层接口
 * @author Jiuyu
 *
 */
public interface FlowCardManager {
	/**
	 * 添加流向单
	 * @param flowCard
	 * @throws ApplicationException
	 */
	public void addFlowCad(FlowCard flowCard) throws ApplicationException;
	
	/**
	 * 删除流向单
	 * @param flowCardVouNos
	 * @throws ApplicationException
	 */
	public void delFlowCard(String[] flowCardVouNos) throws ApplicationException;
	
	/**
	 * 修改流向单
	 * @param flowCard
	 * @throws ApplicationException
	 */
	public void modifyFlowCard(FlowCard flowCard)  throws ApplicationException;
	
	/**
	 * 分页查询
	 * @param pageNo
	 * @param pageSize
	 * @param clientId
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws ApplicationException
	 */
	public PageModel<FlowCard> finFlowCards(int pageNo,int pageSize,String clientId,Date beginDate,Date endDate) throws ApplicationException;
	
	/**
	 * 送审流向单
	 * @param flowCardVouNos
	 * @throws ApplicationException
	 */
	public void auditFlowCard(String[] flowCardVouNos) throws ApplicationException;
	
	/**
	 * 根据流向单单号查询详细信息
	 * @param flowCardVouNo
	 * @return
	 * @throws ApplicationException
	 */
	public FlowCard findFlowCardDetail(String flowCardVouNo) throws ApplicationException;
}
