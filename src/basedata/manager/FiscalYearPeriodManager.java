package basedata.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import basedata.domain.FiscalYearPeriod;
import common.PageModel;
import jdbcTools.JDBCTools;
import systemFiles.IdGenerator;

/**
 *核算期间管理类，采用单例模式实现
 *
 */
public class FiscalYearPeriodManager {

	private static FiscalYearPeriodManager instance = new FiscalYearPeriodManager();

	private FiscalYearPeriodManager() {
	}

	public static FiscalYearPeriodManager getInstance() {
		return instance;
	}

	/**
	 * 增加会计核算期间
	 * 
	 * @param fiscalYearPeriod  FiscalYearPeriod
	 */
	public void addFiscalYearPeriod(FiscalYearPeriod fiscalYearPeriod) {
		String sql = "insert into fiscal_year_period(fiscal_id, fiscal_year, fiscal_period, begin_date, end_date, period_sts) "
				+ "values(?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = JDBCTools.Connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, IdGenerator.generate("fiscal_year_period"));
			pstmt.setInt(2, fiscalYearPeriod.getFiscalYear());
			pstmt.setInt(3, fiscalYearPeriod.getFiscalPeriod());
			pstmt.setDate(4, new java.sql.Date(fiscalYearPeriod.getBeginDate()
					.getTime()));
			pstmt.setDate(5, new java.sql.Date(fiscalYearPeriod.getEndDate()
					.getTime()));
			pstmt.setString(6, fiscalYearPeriod.getPeriodSts());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, null);
		}
	}

	/**
	 *修改会计核算期间
	 * 
	 * @param fiscalYearPeriod  FiscalYearPeriod
	 */
	public void modifyFiscalYearPeriod(FiscalYearPeriod fiscalYearPeriod) {
		String sql = "update fiscal_year_period set begin_date=?, end_date=?, period_sts=? where fiscal_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = JDBCTools.Connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1, new java.sql.Date(fiscalYearPeriod.getBeginDate().getTime()));
			pstmt.setDate(2, new java.sql.Date(fiscalYearPeriod.getEndDate().getTime()));
			pstmt.setString(3, fiscalYearPeriod.getPeriodSts());
			pstmt.setInt(4, fiscalYearPeriod.getFiscalId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, null);
		}
	}
	
	/**
	 * 根据核算年和核算月查询会计核算期间
	 * @param fiscalYear 核算年
	 * @param fiscalPeriod 核算月
	 * @return FiscalYearPeriod
	 */
	public FiscalYearPeriod findFiscalYearPeriod(int fiscalYear, int fiscalPeriod) {
		String sql = "select fiscal_id, fiscal_year, fiscal_period, begin_date, end_date, period_sts from fiscal_year_period " +
		"where fiscal_year=? and fiscal_period=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FiscalYearPeriod fiscalYearPeriod = null;
		try {
			conn = JDBCTools.Connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fiscalYear);
			pstmt.setInt(2, fiscalPeriod);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				fiscalYearPeriod = new FiscalYearPeriod();
				fiscalYearPeriod.setFiscalId(rs.getInt("fiscal_id"));
				fiscalYearPeriod.setFiscalYear(rs.getInt("fiscal_year"));
				fiscalYearPeriod.setFiscalPeriod(rs.getInt("fiscal_period"));
				fiscalYearPeriod.setBeginDate(rs.getDate("begin_date"));
				fiscalYearPeriod.setEndDate(rs.getDate("end_date"));
				fiscalYearPeriod.setPeriodSts(rs.getString("period_sts"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, rs);
		}
		return fiscalYearPeriod;
	}
	
	/**
	 * 根据id查询会计期间
	 * @param id id
	 * @return FiscalYearPeriod
	 */
	public FiscalYearPeriod findFiscalYearPeriodById(int id) {
		String sql = "select fiscal_id, fiscal_year, fiscal_period, begin_date, end_date, period_sts from fiscal_year_period " +
		"where fiscal_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FiscalYearPeriod fiscalYearPeriod = null;
		try {
			conn = JDBCTools.Connect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				fiscalYearPeriod = new FiscalYearPeriod();
				fiscalYearPeriod.setFiscalId(rs.getInt("fiscal_id"));
				fiscalYearPeriod.setFiscalYear(rs.getInt("fiscal_year"));
				fiscalYearPeriod.setFiscalPeriod(rs.getInt("fiscal_period"));
				fiscalYearPeriod.setBeginDate(rs.getDate("begin_date"));
				fiscalYearPeriod.setEndDate(rs.getDate("end_date"));
				fiscalYearPeriod.setPeriodSts(rs.getString("period_sts"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, rs);
		}
		return fiscalYearPeriod;		
	}
	
	/**
	 * 查询全部会计核算期间
	 * 
	 * @param pageNo 第几页
	 * @param pageSize  每页多条数据
	 * @return PageModel
	 */
	public PageModel<FiscalYearPeriod> findAllFiscalYearPeriod(int pageNo, int pageSize) {
//		String sql = "select fiscal_id, fiscal_year, fiscal_period, begin_date, end_date, period_sts from t_fiscal_year_period " +
//		"order by id limit " + (pageNo -1)  * pageSize + ", " + pageSize ;
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select * from fiscal_year_period order by fiscal_id limit ?,?");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PageModel<FiscalYearPeriod> pageModel = null;
		try {
			conn = JDBCTools.Connect();
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setInt(1, (pageNo-1) * pageSize);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			List<FiscalYearPeriod> fiscalYearPeriodList = new ArrayList<FiscalYearPeriod>();
			while (rs.next()) {
				FiscalYearPeriod fiscalYearPeriod = new FiscalYearPeriod();
				fiscalYearPeriod.setFiscalId(rs.getInt("fiscal_id"));
				fiscalYearPeriod.setFiscalYear(rs.getInt("fiscal_year"));
				fiscalYearPeriod.setFiscalPeriod(rs.getInt("fiscal_period"));
				fiscalYearPeriod.setBeginDate(rs.getDate("begin_date"));
				fiscalYearPeriod.setEndDate(rs.getDate("end_date"));
				fiscalYearPeriod.setPeriodSts(rs.getString("period_sts"));
				fiscalYearPeriodList.add(fiscalYearPeriod);
			}
			//取得所有的记录数
			int totalRecords = getTotalRecords(conn);
			pageModel = new PageModel<FiscalYearPeriod>();
			pageModel.setPageNo(pageNo);
			pageModel.setPageSize(pageSize);
			pageModel.setList(fiscalYearPeriodList);
			pageModel.setTotalRecords(totalRecords);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTools.closeSCR(pstmt, conn, rs);
		}
		return pageModel;
	}
	
	/**
	 * 取得记录总数
	 * @param conn
	 * @return 总数
	 */
	private int getTotalRecords(Connection conn) {
		String sql = "select count(*) from fiscal_year_period";
		int totalRecords = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalRecords = rs.getInt(1);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTools.closeSCR(pstmt, conn, rs);
		}
		return totalRecords;
	}	
}
