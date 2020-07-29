<%@page import="java.io.File"%>
<%@page import="exam.vo.AttachfileVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.AttachfileDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String category = request.getParameter("category");
	String search = request.getParameter("search");
	String[] value = request.getParameterValues("user");
	if (value == null) {
		%>
		<script>
			alert('체크된 글이 없습니다.')
			history.back();
		</script>
		<%
		return;
	}
	int[] num = new int[value.length];
	for (int i=0; i<value.length; i++) {
		num[i] = Integer.parseInt(value[i]);
	}

	BoardDao dao = BoardDao.getInstance();
	for (int i=0; i<num.length; i++) {
		// 파일 삭제를 위해 AttachfileDao 가져오기 
		AttachfileDao attachDao = AttachfileDao.getInstance();
		// 특정 번호 게시글에 첨부된 첨부파일 정보 가져오기	
		List<AttachfileVo> attachList = attachDao.getAttachfilesByBno(num[i]);
		
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
		attachDao.deleteAttachfilesByBno(num[i]);
		
		// 게시판 테이블 레코드 삭제하기
		BoardDao boardDao = BoardDao.getInstance();
		boardDao.deleteByNum(num[i]);
	}
%>
<script>
	alert('<%=value.length %>개의 글이 삭제되었습니다.')
	location.href = '/admin/adminFileNotice.jsp?category=<%=category %>&search=<%=search %>';
</script>