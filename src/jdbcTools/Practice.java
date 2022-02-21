package jdbcTools;

import java.util.ArrayList;
import java.util.List;

public class Practice {
	public static void main(String[] args) throws RuntimeException{
		try {
			int a = 3, b = 0;
			int c = a / b;
		} catch (Exception e) {
//			e.printStackTrace();
			throw new RuntimeException("！！！");
		}
	}
}
