<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		%>
		<script>
			alert('체크된 회원이 없습니다.')
			history.back();
		</script>
		<%
		return;
	}
	MemberDao dao = MemberDao.getInstance();
	
	dao.deleteById(id);
	
	session.invalidate();
	
	// 로그인 상태유지용 쿠키가 존재하면 삭제
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			 if (cookie.getName().equals("id")) {
				 cookie.setMaxAge(0); // 유효기간 0 설정
				 cookie.setPath("/"); // 경로 설정
				 response.addCookie(cookie); // 클라이언트로 응답 보냄
			 }
		}
	}
%>
<script>
	alert('<%=id %>님의 탈퇴가 완료되었습니다..')
	location.href = '/index.jsp';
</script>