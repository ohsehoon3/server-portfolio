package exam.dao;

import org.apache.ibatis.session.SqlSession;

import exam.mapper.LikeBoardMapper;
import exam.vo.LikeBoardVo;

public class LikeBoardDao {

	private static LikeBoardDao instance = new LikeBoardDao();
	
	public static LikeBoardDao getInstance() {
		return instance;
	}

	private LikeBoardDao() {}
	
	public int getLikeno() {
		int likeno = 0;
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			LikeBoardMapper mapper = sqlSession.getMapper(LikeBoardMapper.class);
			likeno = mapper.getLikeno();
		}
		return likeno;
	} // getLikeno()
	
	public void insertLikeno(LikeBoardVo vo) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			LikeBoardMapper mapper = sqlSession.getMapper(LikeBoardMapper.class);
			int likeno = mapper.getLikeno();
			
			vo.setLikeno(likeno);
			
			mapper.insertLikeno(vo);
		}
	} // insertLikeno()
	
	public static void main(String[] args) {
		LikeBoardDao dao = LikeBoardDao.getInstance();
//		System.out.println(dao.getLikeno());
		
//		LikeBoardVo vo = new LikeBoardVo();
//		vo.setBno(1);
//		vo.setId("ohse");
//		dao.insertLikeno(vo);
//		System.out.println(vo);
	}
}
