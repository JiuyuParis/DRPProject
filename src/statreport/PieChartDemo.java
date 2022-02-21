package statreport;

import java.io.FileOutputStream;
import java.io.IOException;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

/**
 * 生成饼状图实例类
 * @author Jiuyu
 *
 */
public class PieChartDemo {
	public static void main(String[] args) throws IOException{
		DefaultPieDataset data = getDataSet();
		JFreeChart chart = ChartFactory.createPieChart3D("水果产量图",data, true, false,false);
		//写图表对象到文件，参照柱状图生成源码
		FileOutputStream fos_jpg = null;
		try {
			fos_jpg = new FileOutputStream("D:\\fruit.jpg");
			ChartUtilities.writeChartAsJPEG(fos_jpg,1.0f,chart,400,300,null);
		} finally {
			try {
				fos_jpg.close();
			} catch (Exception e) {}
		}
	}
	/**
	 * 获取一个演示用的简单数据集对象
	 * @return
	 */
	private static DefaultPieDataset getDataSet() {
		DefaultPieDataset dataset = new DefaultPieDataset();
		dataset.setValue("苹果",100);
		dataset.setValue("梨子",200);
		dataset.setValue("葡萄",300);
		dataset.setValue("香蕉",400);
		dataset.setValue("荔枝",500);
		return dataset;
	}
}
