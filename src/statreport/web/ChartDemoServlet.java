package statreport.web;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.data.general.DefaultPieDataset;

import common.BaseServlet;
import common.BeanFactory;
import statreport.manager.StatReportManager;

/**
 * 将图片展示到浏览器上
 * @author Jiuyu
 *
 */
public class ChartDemoServlet extends BaseServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 684696764093198519L;
	private StatReportManager statReportManager;
	@Override
	public void init() throws ServletException {
		BeanFactory beanFactory=getBeanFactory();
		statReportManager=(StatReportManager) beanFactory.getServiceBean(StatReportManager.class);
	}
	public void service(ServletRequest req, ServletResponse res)
			throws ServletException, IOException 
		{
			res.setContentType("image/jpeg");
			DefaultPieDataset data = getDataSet();
			JFreeChart chart = ChartFactory.createPieChart3D("分销商级别分布图",data,true,false,false);
			PiePlot3D plot=(PiePlot3D)chart.getPlot();
			// 图片中显示百分比:默认方式
			//plot.setLabelGenerator(new StandardPieSectionLabelGenerator(StandardPieToolTipGenerator.DEFAULT_TOOLTIP_FORMAT));
			// 图片中显示百分比:自定义方式，{0} 表示选项， {1} 表示数值， {2} 表示所占比例 ,小数点后两位
			plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}={1}({2})", NumberFormat.getNumberInstance(), new DecimalFormat("0.00%")));
			// 图例显示百分比:自定义方式， {0} 表示选项， {1} 表示数值， {2} 表示所占比例
			plot.setLegendLabelGenerator(new StandardPieSectionLabelGenerator("{0}={1}({2})"));
			ChartUtilities.writeChartAsJPEG(res.getOutputStream(),
				1.0f,chart,400,300,null);
		}
		/**
		 *分销商级别数据集对象
		 * @return
		 */
		private DefaultPieDataset getDataSet() {
			DefaultPieDataset dataset = new DefaultPieDataset();
			Map<String, Integer> map=statReportManager.getClientLevelCount();
			for(Iterator<Map.Entry<String, Integer>> iterator=map.entrySet().iterator();iterator.hasNext();) {
				Map.Entry<String, Integer> entry=iterator.next();
				dataset.setValue(entry.getKey(),entry.getValue());
			}
			return dataset;
		}
}
