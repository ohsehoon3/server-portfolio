package exam.mapper;

import org.apache.ibatis.annotations.Select;

import exam.vo.LikeBoardVo;

public interface LikeBoardMapper {

	@Select("select ifnull(max(likeno), 0) + 1 as max_likeno from likeboard ")
	int getLikeno();
	
	int insertLikeno(LikeBoardVo vo);
}
