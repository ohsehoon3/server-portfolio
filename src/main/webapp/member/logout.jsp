<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% session.invalidate(); %>

<%
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
	alert('로그아웃 됨.');
	location.href = '/index.jsp';
</script>