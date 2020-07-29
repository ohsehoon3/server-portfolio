<%@page import="exam.dao.MemberDao"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!-- post 파라미터 한글처리 -->
<% request.setCharacterEncoding("utf-8"); %>
 
<!-- 액션태그 vo 객체 생성 -->
<jsp:useBean id="vo" class="exam.vo.MemberVo" />
<% String passwd2 = request.getParameter("passwd2"); %>
<!-- 액션태그 setProperty 폼 -> vo에 저장 -->
<jsp:setProperty property="*" name="vo" />

<!-- regDate 가입날짜 생성해서 넣기 -->
<% vo.setRegDate(LocalDateTime.now()); %>
 
<!-- DB 객체 가져오기 -->
<% MemberDao dao = MemberDao.getInstance(); %>
 
<%
	if (vo.getId().equals(null)) {
		%>
		<script>
			alert('아이디를 입력하세요');
			history.back();
		</script>
		<%
	} 

	int grade = 1;
	vo.setGrade(grade);
%>

<!-- 회원가입 메소드 호출 -->
<% dao.insert(vo); %>
 
<!-- login.jsp로 이동 -->
<script>
	alert('회원가입 성공!');
	location.href = 'login.jsp';
</script>