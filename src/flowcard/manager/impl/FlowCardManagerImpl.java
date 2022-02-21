package flowcard.manager.impl;

import java.util.Date;
import java.util.List;

import common.ApplicationException;
import common.BeanFactory;
import common.DaoException;
import common.PageModel;
import flowcard.dao.FlowCardDao;
import flowcard.domain.FlowCard;
import flowcard.manager.FlowCardManager;

/**
 * 流向单维护业务层接口
 * @author Jiuyu
 *
 */
public class FlowCardManagerImpl implements FlowCardManager {
	
	private FlowCardDao flowCardDao;
	
	public FlowCardManagerImpl() {
		this.flowCardDao=(FlowCardDao) BeanFactory.getInstance().getDaoBean(FlowCardDao.class);
	}
	@Override
	public void addFlowCad(FlowCard flowCard) throws ApplicationException {
		try {
			String flowCardVouNo = flowCardDao.generateVuoNo();//生成流向单单号
			flowCardDao.addFlowCardMaster(flowCardVouNo, flowCard);//添加流向单主信息
			flowCardDao.addFlowCardDetail(flowCardVouNo, flowCard.getFlowCardDetails());//添加流向单详细信息
		} catch (DaoException e) {
			throw new ApplicationException("添加流向单失败！");
		}
	}

	@Override
	public void delFlowCard(String[] flowCardVouNos) throws ApplicationException {
		try {
			flowCardDao.delFlowCardDetail(flowCardVouNos);
			flowCardDao.delFlowCardMaster(flowCardVouNos);
		} catch (DaoException e) {
			throw new ApplicationException("删除流向单失败！");
		}

	}

	@Override
	public void modifyFlowCard(FlowCard flowCard) throws ApplicationException {
		// TODO Auto-generated method stub

	}

	@Override
	public PageModel<FlowCard> finFlowCards(int pageNo, int pageSize, String clientId, Date beginDate, Date endDate)
			throws ApplicationException {
		PageModel<FlowCard> pageModel=null;
		try {
			List<FlowCard> flowCards=flowCardDao.finFlowCards(pageNo, pageSize, clientId, beginDate, endDate);//取得流向单列表
			int totalRecorders=flowCardDao.getRecordCount(clientId, beginDate, endDate);//取得总记录数
			pageModel=new PageModel<FlowCard>();
			pageModel.setList(flowCards);
			pageModel.setTotalRecords(totalRecorders);
			pageModel.setPageSize(pageSize);
			pageModel.setPageNo(pageNo);
		} catch (DaoException e) {
			throw new ApplicationException("分页查询流向单失败！");
		}
		return pageModel;
	}

	@Override
	public void auditFlowCard(String[] flowCardVouNos) throws ApplicationException {
		try {
			flowCardDao.auditFlowCard(flowCardVouNos);
		} catch (DaoException e) {
			throw new ApplicationException("送审流向单失败！");
		}

	}

	@Override
	public FlowCard findFlowCardDetail(String flowCardVouNo) throws ApplicationException {
		// TODO Auto-generated method stub
		return null;
	}

}
