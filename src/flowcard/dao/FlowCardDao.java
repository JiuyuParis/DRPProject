package flowcard.dao;

import java.util.Date;
import java.util.List;

import common.DaoException;
import flowcard.domain.FlowCard;
import flowcard.domain.FlowCardDetail;

/**
 * 流向单维护数据访问结构
 * @author Jiuyu
 *
 */
public interface FlowCardDao {
	/**
	 * 生成流向单号
	 * @return
	 * @throws DaoException
	 */
	public String generateVuoNo() throws DaoException;
	
	/**
	 * 添加流向单主信息
	 * @param flowCardVouNo
	 * @param flowCard
	 * @throws DaoException
	 */
	public void addFlowCardMaster(String flowCardVouNo,FlowCard flowCard) throws DaoException;
	
	/**
	 * 添加流向单详细信息
	 * @param flowCardVouNo
	 * @param flowCards
	 * @throws DaoException
	 */
	public void addFlowCardDetail(String flowCardVouNo,List<FlowCardDetail> flowCards) throws DaoException;
	
	/**
	 * 删除流向单主信息
	 * @param flowCardVouNos
	 * @throws DaoException
	 */
	public void delFlowCardMaster(String[] flowCardVouNos) throws DaoException;
	
	/**
	 * 删除流向单详细信息
	 * @param flowCardVouNos
	 * @throws DaoException
	 */
	public void delFlowCardDetail(String[] flowCardVouNos) throws DaoException;
	
	/**
	 * 修改流向单主信息
	 * @param flowCardVouNo
	 * @param flowCard
	 * @throws DaoException
	 */
	public void modifyFlowCardMaster(String flowCardVouNo,FlowCard flowCard) throws DaoException;
	

	/**
	 * 修改流向单详细信息
	 * @param flowCardVouNo
	 * @param flowCards
	 * @throws DaoException
	 */
	public void modifyFlowCardDetail(String flowCardVouNo,List<FlowCard> flowCards) throws DaoException;
	
	/**
	 * 分页查询
	 * @param pageNo
	 * @param pageSize
	 * @param clientId
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws DaoException
	 */
	public List<FlowCard> finFlowCards(int pageNo,int pageSize,String clientId,Date beginDate,Date endDate) throws DaoException;
	
	/**
	 * 根据条件获取记录数
	 * @param clientId
	 * @param beginDate
	 * @param endDate
	 * @return
	 * @throws DaoException
	 */
	public int getRecordCount(String clientId,Date beginDate,Date endDate) throws DaoException;
	
	/**
	 * 送审流向单
	 * @param flowCardVouNos
	 * @throws DaoException
	 */
	public void auditFlowCard(String[] flowCardVouNos) throws DaoException;
	
	/**
	 * 返回流向单主信息
	 * @param vouNo
	 * @return
	 * @throws DaoException
	 */
	public FlowCard findFlowCardMaster(String vouNo) throws DaoException;
	
	/**
	 * 返回流向单主信息详细信息列表
	 * @param vouNo
	 * @return
	 * @throws DaoException
	 */
	public List<FlowCardDetail> findFlowCardDetails(String vouNo)  throws DaoException;
}
