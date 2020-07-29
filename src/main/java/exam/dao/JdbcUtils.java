package exam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JdbcUtils {
	
	// DB연결 메소드
	public static Connection getConnection() throws Exception {
		Connection con = null;

		// DB접속 정보
		String url = "jdbc:mysql://localhost:3306/ohse?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
		String user = "jspuser";
		String passwd = "jsppass";
		
		// 1단계 드라이버 클래스 로딩
		Class.forName("com.mysql.jdbc.Driver");
		// 2단계 DB연결(DB주소, DB아이디, DB비번)
		con = DriverManager.getConnection(url, user, passwd);
		// 위의 과정은 커넥션을 매번 생성하는 방법
		
		return con;
	} // getConnection()
	
	public static void close(Connection con, Statement stmt) {
		close(con, stmt, null);
	} // close()
	
	public static void close(Connection con, Statement stmt, ResultSet rs) {
		// JDBC객체는 사용의 역순으로 자원 닫기
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (rs != null) {
				stmt.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (rs != null) {
				con.close(); // 반납하기
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	} // close()
}
