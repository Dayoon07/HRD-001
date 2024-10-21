package common;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtils {
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 드라이버, URL, 사용자 이름, 비밀번호
			con = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe",
					"system",
					"12345"
			);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
