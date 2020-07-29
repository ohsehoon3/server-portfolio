package exam.mapper;

import java.util.List;  

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import exam.vo.MemberVo;
 
public interface MemberMapper {
	int insert(MemberVo vo);

	@Select("SELECT passwd FROM member where id = #{id} ")
	String getPasswdById(String id);
	
	@Select("SELECT COUNT(*) FROM member WHERE id = #{id} ")
	int countMemberById(String id);
	
	List<MemberVo> getMembers(@Param("startRow") int startRow,
							  @Param("pageSize") int pageSize,
							  @Param("category") String category,
							  @Param("search") String search);
	
	@Select("SELECT * FROM member WHERE id = #{id} ")
	MemberVo getMemberById(String id);
	
	// @ 생략
	int update(MemberVo vo);
	
	@Delete("DELETE FROM member WHERE id = #{id}")
	int deleteById(String id);
	
	int getTotalCount(@Param("category") String category, 
			  		  @Param("search") String search);
	
	@Select("SELECT age FROM member")
	int[] getMembersAge();
	
	@Delete("DELETE FROM member")
	void deleteAll();
	
	@Select("SELECT COUNT(*) FROM member ")
	int getCountAll();
}
