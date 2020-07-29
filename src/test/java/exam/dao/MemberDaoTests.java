package exam.dao;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertSame;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.LocalDateTime;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;

import exam.vo.MemberVo;

@TestMethodOrder(OrderAnnotation.class)
public class MemberDaoTests {
	// 픽스처 준비
	private MemberDao dao;
	private MemberVo m1;
	
	@BeforeEach
	void init() {
		System.out.println("@BeforeEach - init() 호출됨");
		
		dao = MemberDao.getInstance();
		
		m1 = new MemberVo("ohse", "1234", "오세훈", 31, "남", "ohsehoon3@naver.com", LocalDateTime.now().withNano(0), "부산시", "2836", "2836", 1);
	}
	
	@Order(1)
	@Test
	void deleteAll() {
		System.out.println("1번 Test - deleteAll() 호출됨");
		
		dao.deleteAll();
		assertEquals(0, dao.getCountAll());
	}
	
	@Order(2)
	@Test
	void insertDummyUsers() {
		System.out.println("2번 Test - insertDummyUsers() 호출됨");
		
		dao.insertDummyUsers(50);
		assertSame(50, dao.getCountAll());
	}
	
	@Order(3)
	@Test
	void insertAndGetMemberById() {
		System.out.println("3번 Test - insertAndGetMemberById() 호출됨");
		
		dao.insert(m1);
		assertEquals(51, dao.getCountAll());
		MemberVo mGet1 = dao.getMemberById(m1.getId());
		assertNotNull(mGet1);
		assertEquals(m1.toString(), mGet1.toString());
	}
	
	@Order(4)
	@Test
	void update() throws Exception {
		System.out.println("4번 Test - update() 호출됨");
		
		m1.setGrade(10);
		dao.update(m1);
		MemberVo mGet2 = dao.getMemberById(m1.getId());
		assertEquals(m1.toString(), mGet2.toString());
	}
}
