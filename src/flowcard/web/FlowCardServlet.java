package flowcard.web;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import basedata.domain.AimClient;
import basedata.domain.Client;
import basedata.domain.FiscalYearPeriod;
import basedata.domain.Item;
import common.BaseServlet;
import common.PageModel;
import flowcard.domain.FlowCard;
import flowcard.domain.FlowCardDetail;
import flowcard.manager.FlowCardManager;
import systemFiles.Constants;

/**
 * 流向单维护
 * @author Jiuyu
 *
 */
public class FlowCardServlet extends BaseServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3970239555056090086L;
	private FlowCardManager flowCardManager;
	@Override
	public void init() throws ServletException {
		flowCardManager=(FlowCardManager)getBeanFactory().getServiceBean(FlowCardManager.class);//通过工厂获得FlowCardManager对象
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(Constants.ADD.equals(getCommand())) {
			add(req, resp);
		}else if (Constants.MODIFY.equals(getCommand())) {
			modify(req, resp);
		}else if(Constants.DEL.equals(getCommand())) {
			del(req, resp);
		}else if(Constants.SHOW_ADD.equals(getCommand())){
			showAdd(req, resp);
		}else if (Constants.AUDIT.equals(getCommand())) {
			audit(req, resp);
		}else {
			search(req, resp);
		}
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

	/**
	 * 添加
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cliendId=req.getParameter("clientInnerId");//供方分销商代码
		String[] aimdIds=req.getParameterValues("aimInnerId");//需方分销商代码
		String[] itemNos=req.getParameterValues("itemNo");//物料代码
		String[] qty=req.getParameterValues("qty");//操作数量
		FlowCard flowCard=new FlowCard();//流向单对象
		flowCard.setOptType("A");//操作类型A-流向单
		//会计核算期，正常应该在session中取得
		FiscalYearPeriod fiscalYearPeriod=new FiscalYearPeriod();
		fiscalYearPeriod.setFiscalId(6);
		flowCard.setFiscalYearPeriod(fiscalYearPeriod);
		//供方分销商
		Client client=new Client();
		client.setId(Integer.parseInt(cliendId));
		flowCard.setClient(client);
		flowCard.setRecorder(getCurrentUser());//录入人
		flowCard.setOptDate(new Date());//操作日期
		flowCard.setVouSts("N");//单据状态N:录入
		
		List<FlowCardDetail> flowCardDetails=new ArrayList<FlowCardDetail>();//流向单明细信息列表
		for(int i=0;i<aimdIds.length;i++) {
			if (!aimdIds[i].equals("")) {
				FlowCardDetail flowCardDetail = new FlowCardDetail();
				//需方分销商
				AimClient aimClient = new AimClient();
				aimClient.setID(Integer.parseInt(aimdIds[i]));
				flowCardDetail.setAimClient(aimClient);
				//物料
				Item item = new Item();
				item.setNo(itemNos[i]);
				flowCardDetail.setItem(item);
				flowCardDetail.setAdjustFlag("N");//调整标志N未调整
				flowCardDetail.setOptQty(new BigDecimal(qty[i]));//操作数量
				flowCardDetails.add(flowCardDetail);
			}
		}
		flowCard.setFlowCardDetails(flowCardDetails);//流向单明细信息列表
		flowCardManager.addFlowCad(flowCard);
		resp.sendRedirect(req.getContextPath()+"/servlet/flowcard/FlowCardServlet");//重定向
	}
	
	/**
	 * 删除
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void del(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String[] flowCardNos=req.getParameterValues("selectFlag");
		flowCardManager.delFlowCard(flowCardNos);
		resp.sendRedirect(req.getContextPath()+"/servlet/flowcard/FlowCardServlet");//重定向
	}
	
	/**
	 * 修改
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void modify(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	/**
	 * 显示添加页面
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void showAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/flowcard/flow_card_add.jsp").forward(req, resp);
	}
	
	/**
	 * 分页查询
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void search(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cliendId=req.getParameter("clientId");
		String beginDate=req.getParameter("beginDate");
		String endDate=req.getParameter("endDate");
		int pageNo=1;
		if(req.getParameter("pageNo")!=null&&!"".equals(req.getParameter("pageNo"))) {
			pageNo=Integer.parseInt(req.getParameter("pageNo"));
		}
		int pageSize=Integer.parseInt(this.getServletContext().getInitParameter("pageSize"));//从Context中拿到pageSize参数
		Date formatBeginDate=null;
		Date formatEndDate=null;
		try {
			if(beginDate!=null&&!"".equals(beginDate)) {
				formatBeginDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(beginDate+" 00:00:00");
			}else {
				formatBeginDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date())+" 00:00:00");
			}
			
			if(endDate!=null&&!"".equals(endDate)) {
				formatEndDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(endDate+" 23:59:59");
			}else {
				formatEndDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date())+" 23:59:59");
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		PageModel<FlowCard> pageModel=flowCardManager.finFlowCards(pageNo, pageSize, cliendId, formatBeginDate, formatEndDate);
		
		//将相关信息设置到req中
		req.setAttribute("formatBeginDate", formatBeginDate);
		req.setAttribute("formatEndDate", formatEndDate);
		req.setAttribute("pageModel", pageModel);
		
		req.getRequestDispatcher("/flowcard/flow_card_maint.jsp").forward(req, resp);
	}
	
	/**
	 * 送审
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void audit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String[] flowCardNos=req.getParameterValues("selectFlag");
		flowCardManager.auditFlowCard(flowCardNos);
		resp.sendRedirect(req.getContextPath()+"/servlet/flowcard/FlowCardServlet");//重定向
	}
	
}
