package flowcard.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import basedata.domain.Client;
import common.DaoException;
import flowcard.dao.FlowCardDao;
import flowcard.domain.FlowCard;
import flowcard.domain.FlowCardDetail;
import jdbcTools.JDBCToolsThreadLocal;
import sysMgr.domain.User;

/**
 * 流向单维护数据访问结构实现
 * @author Jiuyu
 *
 */
public class FlowCardDaoImpl implements FlowCardDao {

	@Override
	public String generateVuoNo() throws DaoException {
		Connection conn=JDBCToolsThreadLocal.Connect();
		String sqllString="select max(flow_card_no) from flow_card_master where substr(flow_card_no,1,8)=?";
		String currentDate=new SimpleDateFormat("yyyyMMdd").format(new Date());
		PreparedStatement psmt=null;
		ResultSet rs=null;
		String vouNo=currentDate+"0001";
		try {
			psmt=conn.prepareStatement(sqllString);
			psmt.setString(1, currentDate);
			rs=psmt.executeQuery();
			rs.next();
			if(rs.getLong(1)!=0) {
				vouNo=String.valueOf(rs.getLong(1)+1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("FlowCardDaoImpl->>generateVuoNo,exception:"+e);
			throw new DaoException(e);
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, rs);
		}
		return vouNo;
	}

	@Override
	public void addFlowCardMaster(String flowCardVouNo, FlowCard flowCard) throws DaoException {
		Connection conn=JDBCToolsThreadLocal.Connect();
		String sqlString="insert into flow_card_master(flow_card_no,opt_type,fiscal_year_period_id,client_id,recorder_id,opt_date,vou_sts)"
				+ " values(?,?,?,?,?,?,?)";
		PreparedStatement psmt=null;
		try {
			psmt=conn.prepareStatement(sqlString);
			psmt.setString(1, flowCardVouNo);
			psmt.setString(2, flowCard.getOptType());
			psmt.setInt(3, flowCard.getFiscalYearPeriod().getFiscalId());
			psmt.setInt(4, flowCard.getClient().getId());
			psmt.setString(5, flowCard.getRecorder().getUSER_ID());
			psmt.setTimestamp(6, new Timestamp(flowCard.getOptDate().getTime()));
			psmt.setString(7, flowCard.getVouSts());
			psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("FlowCardDaoImpl->>addFlowCardMaster,exception:"+e);
			throw new DaoException(e);
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, null);
		}

	}

	@Override
	public void addFlowCardDetail(String flowCardVouNo, List<FlowCardDetail> flowCards) throws DaoException {
		Connection conn=JDBCToolsThreadLocal.Connect();
		String sqlString="insert into flow_card_detail(flow_card_no,aim_client_id,item_no,opt_qty,adjust_flag)"
				+ " values(?,?,?,?,?)";
		PreparedStatement psmt=null;
		try {
			psmt=conn.prepareStatement(sqlString);
			for(Iterator<FlowCardDetail> flowCardDetailIterator=flowCards.iterator();flowCardDetailIterator.hasNext();) {
				FlowCardDetail flowCardDetail=flowCardDetailIterator.next();
				psmt.setString(1, flowCardVouNo);
				psmt.setInt(2, flowCardDetail.getAimClient().getID());
				psmt.setString(3, flowCardDetail.getItem().getNo());
				psmt.setBigDecimal(4, flowCardDetail.getOptQty());
				psmt.setString(5, flowCardDetail.getAdjustFlag());
				psmt.addBatch();
			}
			psmt.executeBatch();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("FlowCardDaoImpl->>addFlowCardDetail,exception:"+e);
			throw new DaoException(e);
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, null);
		}
	}

	@Override
	public void delFlowCardMaster(String[] flowCardVouNos) throws DaoException {
		StringBuilder sqlBuilder=new StringBuilder();
		for(int i=0;i<flowCardVouNos.length;i++) {
			sqlBuilder.append("?");
			if (i < flowCardVouNos.length-1) {
				sqlBuilder.append(",");
			}
		}
		String sqlString="delete from flow_card_master where flow_card_no in ("+sqlBuilder.toString()+")";
		Connection conn=JDBCToolsThreadLocal.Connect();
		PreparedStatement psmt=null;
		try {
			psmt=conn.prepareStatement(sqlString);
			for(int i=0;i<flowCardVouNos.length;i++) {
				psmt.setString(i+1, flowCardVouNos[i]);
			}
			psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("FlowCardDaoImpl->>delFlowCardMaster,exception:"+e);
			throw new DaoException(e);
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, null);
		}
	}

	@Override
	public void delFlowCardDetail(String[] flowCardVouNos) throws DaoException {
		StringBuilder sqlBuilder=new StringBuilder();
		for(int i=0;i<flowCardVouNos.length;i++) {
			sqlBuilder.append("?");
			if (i < flowCardVouNos.length-1) {
				sqlBuilder.append(",");
			}
		}
		String sqlString="delete from flow_card_detail where flow_card_no in ("+sqlBuilder.toString()+")";
		Connection conn=JDBCToolsThreadLocal.Connect();
		PreparedStatement psmt=null;
		try {
			psmt=conn.prepareStatement(sqlString);
			for(int i=0;i<flowCardVouNos.length;i++) {
				psmt.setString(i+1, flowCardVouNos[i]);
			}
			psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("FlowCardDaoImpl->>delFlowCardDetail,exception:"+e);
			throw new DaoException(e);
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, null);
		}

	}

	@Override
	public void modifyFlowCardMaster(String flowCardVouNo, FlowCard flowCard) throws DaoException {
		// TODO Auto-generated method stub

	}

	@Override
	public void modifyFlowCardDetail(String flowCardVouNo, List<FlowCard> flowCards) throws DaoException {
		// TODO Auto-generated method stub

	}

	@Override
	public List<FlowCard> finFlowCards(int pageNo, int pageSize, String clientId, Date beginDate, Date endDate)
			throws DaoException {
		StringBuilder sql=new StringBuilder();
		sql.append("select a.flow_card_no,b.client_id,b.name as cliet_name,c.user_name,a.opt_date ");
		sql.append("from flow_card_master a join client b on a.client_id=b.id join user c on a.recorder_id=c.user_id where a.vou_sts='N' and ");
		if(clientId!=null&&!"".equals(clientId)) {
			sql.append("b.client_id='"+clientId+"' and ");
		}
		sql.append("a.opt_date between ? and ? order by flow_card_no limit "+(pageNo-1)*pageSize+","+pageSize);
		List<FlowCard> flowCards=new ArrayList<FlowCard>();
		Connection connection=null;
		connection=JDBCToolsThreadLocal.Connect();
		PreparedStatement psmt=null;
		ResultSet rs=null;
		try {
			psmt=connection.prepareStatement(sql.toString());
			psmt.setTimestamp(1, new Timestamp(beginDate.getTime()));
			psmt.setTimestamp(2, new Timestamp(endDate.getTime()));
			rs=psmt.executeQuery();
			while (rs.next()) {
				FlowCard flowCard=new FlowCard();
				flowCard.setFlowCardNo(rs.getString("flow_card_no"));
				
				Client client=new Client();
				client.setClientId(rs.getString("client_id"));
				client.setName(rs.getString("cliet_name"));
				
				flowCard.setClient(client);
				
				User recorder=new User();
				recorder.setUSER_NAME(rs.getString("user_name"));
				
				flowCard.setRecorder(recorder);
				
				flowCard.setOptDate(rs.getTimestamp("opt_date"));
				
				flowCards.add(flowCard);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("FlowCardDaoImpl->>finFlowCards,exception:"+e);
			throw new DaoException(e);
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, rs);
		}
		return flowCards;
	}

	@Override
	public int getRecordCount(String clientId, Date beginDate, Date endDate) throws DaoException {
		System.out.println(beginDate);
		System.out.println(endDate);
		String sql="select count(*) from flow_card_master a join client b on a.client_id=b.id where a.vou_sts='N' and ";
		if(clientId!=null&&!"".equals(clientId)) {
			sql=sql+"b.client_id='"+clientId+"' and ";
		}
		sql=sql+"a.opt_date between ? and ?";
		Connection connection=null;
		connection=JDBCToolsThreadLocal.Connect();
		PreparedStatement psmt=null;
		ResultSet rs=null;
		int count=0;//总记录数
		try {
			psmt=connection.prepareStatement(sql);
			psmt.setTimestamp(1, new Timestamp(beginDate.getTime()));
			psmt.setTimestamp(2, new Timestamp(endDate.getTime()));
			rs=psmt.executeQuery();
			rs.next();
			count=rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("FlowCardDaoImpl->>finFlowCards,exception:"+e);
			throw new DaoException(e);
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, rs);
		}
		return count;
	}

	@Override
	public void auditFlowCard(String[] flowCardVouNos) throws DaoException {
		StringBuilder sqlBuilder=new StringBuilder();
		for(int i=0;i<flowCardVouNos.length;i++) {
			sqlBuilder.append("?");
			if (i < flowCardVouNos.length-1) {
				sqlBuilder.append(",");
			}
		}
		String sqlString="update flow_card_master set vou_sts='S' where flow_card_no in ("+sqlBuilder.toString()+")";
		Connection conn=JDBCToolsThreadLocal.Connect();
		PreparedStatement psmt=null;
		try {
			psmt=conn.prepareStatement(sqlString);
			for(int i=0;i<flowCardVouNos.length;i++) {
				psmt.setString(i+1, flowCardVouNos[i]);
			}
			psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("FlowCardDaoImpl->>auditFlowCard,exception:"+e);
			throw new DaoException(e);
		}finally {
			JDBCToolsThreadLocal.closeSCR(psmt, null, null);
		}
	}

	@Override
	public FlowCard findFlowCardMaster(String vouNo) throws DaoException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<FlowCardDetail> findFlowCardDetails(String vouNo) throws DaoException {
		// TODO Auto-generated method stub
		return null;
	}

}
