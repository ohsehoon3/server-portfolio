<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String id = (String) session.getAttribute("id");
	if (id == null) {
		response.sendRedirect("/login.jsp");
		return;
	}

	// post 파라미터 한글처리
	request.setCharacterEncoding("utf-8"); 
%>
 
<!-- 액션태그 vo 객체 생성 -->
<jsp:useBean id="vo" class="exam.vo.MemberVo" />

<!-- 액션태그 setProperty 폼 -> vo에 저장 -->
<jsp:setProperty property="*" name="vo" />

<!-- DB 객체 가져오기 -->
<% MemberDao dao = MemberDao.getInstance(); %>

<!-- 회원정보 수정 메소드 호출 -->
<% 
	int rowCount = dao.update(vo);
	
	if (rowCount > 0) {
		%>
		<script>
			alert('수정 성공');
			location.href = '/index.jsp';
		</script>
		<%
	} else {
		%>
		<script>
			alert('수정 실패\n다시 시도하세요...');
			history.back();
		</script>
		<%
	}
%>