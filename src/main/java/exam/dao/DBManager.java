package exam.dao;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBManager {
	
	private static SqlSessionFactory sqlSessionFactory;
	
	// static 초기화 블록
	static {
		// 자바 7부터 try with resources 문법 제공.
		// try ()에 finally에서 자원닫아야할 참조변수 명시하면
		// 자동으로 자원 닫아줌
		try (InputStream is = Resources.getResourceAsStream("mybatis-config.xml")) { // 소스 폴더라서(?) 파일 이름만 입력해도 가능
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(is);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
}
