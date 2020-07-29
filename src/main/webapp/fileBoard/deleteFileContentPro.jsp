<%@page import="java.io.File"%>
<%@page import="exam.vo.AttachfileVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.AttachfileDao"%>
<%@page import="exam.dao.BoardDao"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// num, pageNum 파라미터 가져오기
 	int bno = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// 파일 삭제를 위해 AttachfileDao 가져오기 
	AttachfileDao attachDao = AttachfileDao.getInstance();
	// 특정 번호 게시글에 첨부된 첨부파일 정보 가져오기	
	List<AttachfileVo> attachList = attachDao.getAttachfilesByBno(bno);
	
	// 파일 삭제하기
	for (AttachfileVo attachVo : attachList) {
		String filename = attachVo.getUuid() + "_" + attachVo.getFilename();
		// 삭제할 파일을 File 객체로 준비
		File file = new File(attachVo.getUploadpath(), filename);
		
		if (file.exists()) { // 해당 경로에 파일 존재하면
			file.delete(); // 파일 삭제
		}
	}
	
	// 첨부파일 테이블 레코드 삭제하기
	attachDao.deleteAttachfilesByBno(bno);
	
	// 게시판 테이블 레코드 삭제하기
	BoardDao boardDao = BoardDao.getInstance();
	boardDao.deleteByNum(bno);
%>
<script>
	alert('삭제 완료');
	location.href = '/fileBoard/fileNotice.jsp?pageNum=<%=pageNum %>';
</script>