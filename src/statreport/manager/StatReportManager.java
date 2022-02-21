package statreport.manager;

import java.util.Map;

/**
 * 统计报表管理接口
 * @author Jiuyu
 *
 */
public interface StatReportManager {
	/**
	 * 取得分销商级别个数
	 * @return Map(key="一级分销商", value=100;key="二级分销商"， value=200,
	 * key="三级分销商", value=0,)
	 */
	public Map<String, Integer> getClientLevelCount();
}
