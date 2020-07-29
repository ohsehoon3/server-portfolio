package exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import exam.mapper.AttachfileMapper;
import exam.vo.AttachfileVo;

public class AttachfileDao {
	
	private static AttachfileDao instance = new AttachfileDao();
	
	public static AttachfileDao getInstance() {
		return instance;
	}

	private AttachfileDao() {
	}
	
	public AttachfileVo getAttachfileByUuid(String uuid) {
		AttachfileVo vo = null;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			vo = mapper.getAttachfileByUuid(uuid);
		}
		
		return vo;
	} // getAttachfileByUuid()

	public List<AttachfileVo> getAttachfilesByBno(int bno) {
		List<AttachfileVo> list = null;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			list = mapper.getAttachfilesByBno(bno);
		}
		
		return list;
	} // getAttachfilesByBno()
	
	// 1) 첨부파일 정보 한 개 추가
	public void insert(AttachfileVo vo) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			mapper.insert(vo);
		}
	} // insert()
	
	// 2) 첨부파일 정보 여러 개 추가
	public void insert(List<AttachfileVo> list) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql  = "INSERT INTO attachfile (uuid, filename, uploadpath, image, bno) ";
			sql += "VALUES (?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql); // 문장을 하나만 사용하기 때문에 재활용 가능
			
			for (AttachfileVo vo : list) {
				pstmt.setString(1, vo.getUuid());
				pstmt.setString(2, vo.getFilename());
				pstmt.setString(3, vo.getUploadpath());
				pstmt.setString(4, vo.getImage());
				pstmt.setInt(5, vo.getBno());
				// 버퍼에 배치작업으로 추가해놓음. 전송x
				pstmt.addBatch();
			} // for
			
			// 실행
			pstmt.executeBatch();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // insert()
	
	public void deleteAttachfilesByBno(int bno) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			mapper.deleteAttachfilesByBno(bno);
		}
	}
	
	public void deleteAttachfileByUuid(String uuid) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			mapper.deleteAttachfileByUuid(uuid);
		}
	}
	
	public void deleteAttachfileByUuids(List<String> uuids) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			mapper.deleteAttachfileByUuids(uuids);
		}
	}
}
