package exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import exam.mapper.MemberMapper;
import exam.vo.MemberVo;

// Data Access Object(데이터베이스 접근 객체)
// member 테이블을 제어할 수 있는(sql문 실행하는) 클래스
public class MemberDao { 
	
	// 새로고침 (서버 다운시키는)공격 방지법(?) // 내부적으로만 new 생성해서 사용
	private static MemberDao instance = new MemberDao();
	
	public static MemberDao getInstance() {
		return instance;
	}

	private MemberDao() {}
	
	public void insert(MemberVo vo) { 
		// openSession()은 내부적으로 Connection을 가져온다.
		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false); // autocommit 안함
		// MemberMapper 인터페이스가 구현된 객체는
		// mybatis-config.xml 로딩시 이미 메모리에 등록되어있음.
		// 해당 타입으로 찾아서 리턴함
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		
		int rowCount = mapper.insert(vo);
		System.out.println("vo = " + vo);
		if (rowCount > 0) {
			sqlSession.commit();
		} else {
			sqlSession.rollback();
		}
		//JDBC 자원 직접 닫기
		sqlSession.close();
	} // insert()
	// MyBatis(MemberMapper)사용으로 메소드가 간단해짐
	// Dao가 Mapper에 의존하게됨. JSP와 Mapper사이의 대리자(Proxy) 역할
	
	public int userCheck(String id, String passwd) {
		int check = -1; // -1: 아이디 없음, 0: 비밀번호 틀림, 1: 아이디 비밀번호 일치
		
		SqlSession sqlSession = null;
		try {
			sqlSession = DBManager.getSqlSessionFactory().openSession(false);
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			
			String dbPasswd = mapper.getPasswdById(id);
			System.out.println("dbPasswd = " + dbPasswd);
			
			if (dbPasswd != null) {
				if (dbPasswd.equals(passwd)) {
					check = 1;
				} else {
					check = 0;
				}
			} else { // dbPasswd == null
				check = -1;
			}
		} finally {
			// JDBC 자원닫기
			sqlSession.close();
		}
		return check;
	} // userCheck()
	
	public boolean isIdDuplicated(String id) {
		boolean isIdDup;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) { 
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			int count = mapper.countMemberById(id);
			
			if (count == 1) {
				isIdDup = true; // 아이디 중복
			} else { // count == 0
				isIdDup = false; // 아이디 중복아님
			}
		}
		// sqlSession은 자동으로 finally로 닫힘
		return isIdDup;
	}
	
	public List<MemberVo> getMembers(int startRow, int pageSize, String category, String search) {
		List<MemberVo> list = null;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			list = mapper.getMembers(startRow, pageSize, category, search);
		}
		
		return list;
	} // getMembers()
	
	// id로 member 레코드(행) 한 개 가져오기
	public MemberVo getMemberById(String id) {
		MemberVo vo = null;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			vo = mapper.getMemberById(id);
		}
		
		return vo;
	} // getMemberById()
	
	public int update(MemberVo vo) throws Exception {
		int rowCount;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			rowCount = mapper.update(vo);
		}
		if (vo == null) {
			throw new SQLException("id에 해당하는 MemberVo가 없습니다.");
		}
		
		return rowCount;
	} // update()
	
	public int deleteById(String id) {
		int rowCount = 0;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			rowCount = mapper.deleteById(id);
		}
		
		return rowCount;
	} // deleteById()
	
	public int getTotalCount(String category, String search) {
		int count = 0;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			count = mapper.getTotalCount(category, search);
		}
		
		return count;
	} // getTotalCount()
	
	public List<List<Object>> getCountByGender() {
		List<List<Object>> list = new ArrayList<List<Object>>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql =  "SELECT gender, COUNT(*) count ";
			sql += "FROM member ";
			sql += "GROUP BY gender ";
			
			pstmt = con.prepareCall(sql);
			// 실행
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				List<Object> rowList = new ArrayList<Object>();
				
				rowList.add(rs.getString("gender"));
				rowList.add(rs.getInt("count"));
				
				list.add(rowList);
			}
			
			// 열제목 행을 첫번째 요소로 삽입
			if (list.size() > 0) {
				list.add(0, Arrays.asList("성별", "인원"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	}
	
	public List<List<Object>> getCountByAge() {
		List<List<Object>> list = new ArrayList<List<Object>>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql =  "SELECT CASE ";
			sql += "WHEN age BETWEEN 0 and 9 THEN '10세 미만' ";
			sql += "WHEN age BETWEEN 10 and 19 THEN '10대' ";
			sql += "WHEN age BETWEEN 20 and 29 THEN '20대' ";
			sql += "WHEN age BETWEEN 30 and 39 THEN '30대' ";
			sql += "WHEN age BETWEEN 40 and 49 THEN '40대' ";
			sql += "WHEN age BETWEEN 50 and 59 THEN '50대' ";
			sql += "ELSE '60대 이상' ";
			sql += "END as age_range, count(*) count ";
			sql += "FROM member ";
			sql += "group by age_range ";
			
			pstmt = con.prepareCall(sql);
			// 실행
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				List<Object> rowList = new ArrayList<Object>();
				
				rowList.add(rs.getString("age_range"));
				rowList.add(rs.getInt("count"));
				
				System.out.println(rowList);
				
				list.add(rowList);
			}
			// 열제목 행을 첫번째 요소로 삽입
			if (list.size() > 0) {
				list.add(0, Arrays.asList("나이대", "인원"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	}
	
	public void deleteAll() {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			mapper.deleteAll();
		}
	}
	
	public int getCountAll() {
		int count = 0;
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			count = mapper.getCountAll();
		}
		return count;
	}
	
	// Dummy 회원
	public void insertDummyUsers(int count) {
		for (int i=1; i<=count; i++) {
			MemberVo vo = new MemberVo();
			
			vo.setId("a" + i);
			vo.setPasswd("1234");
			vo.setName("a" + i);
			vo.setAge(10 + i);
			vo.setGender("남");
			vo.setEmail("a" + i + "@naver.com");
			vo.setRegDate(LocalDateTime.now());
			vo.setGrade(1);
			
			insert(vo); // dao객체의 insert() 활용해서 행 추가
		} // for
	} // insertDummyUsers()
	
	public static void main(String[] args) {
		MemberDao dao = MemberDao.getInstance();
		
//		dao.insertDummyUsers(1);
		
//		List<List<Object>> list = dao.getCountByGender();
//      for (List<Object> rowList : list) {
//          System.out.println(rowList); ///
//      }
		
//		List<List<Object>> list = dao.getCountByAge();
//	    for (List<Object> rowList : list) {
//	        System.out.println(rowList); ///
//	    }
	    
//		List<List<Object>> list = dao.getMembersAge();
//	    for (List<Object> rowList : list) {
//	        System.out.println(rowList); ///
//	    }
		
//		// getMembers() 테스트 // ctrl + F11 -> App...으로 실행
//		List<MemberVo> memberList = dao.getMembers();
//		
//		for (MemberVo vo : memberList) {
//			System.out.println(vo.toString()); // 없으면 빈칸 출력
//		}
//		
//		System.out.println();
//		
//		// getMemberById() 테스트
//		MemberVo memberVo = dao.getMemberById("aa"); // 없으면 null 출력
//		System.out.println(memberVo);
		
	}
}