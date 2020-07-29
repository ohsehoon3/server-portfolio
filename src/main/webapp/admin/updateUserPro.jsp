<%@page import="exam.vo.MemberVo"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	// post 파라미터 한글처리
	request.setCharacterEncoding("utf-8");

	String category = request.getParameter("category");
	String search = request.getParameter("search");
%>
<jsp:useBean id="vo" class="exam.vo.MemberVo" />
<jsp:setProperty property="*" name="vo" />
<%	
	MemberDao dao = MemberDao.getInstance(); 
	
	dao.update(vo);
%>
<script>
 	alert('<%=vo.getId() %>님의 회원정보 수정 완료');
 	location.href='/admin/adminUsers.jsp?category=<%=category %>&search=<%=search %>';
</script>