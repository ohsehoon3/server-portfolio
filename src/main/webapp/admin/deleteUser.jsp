<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String category = request.getParameter("category");
	String search = request.getParameter("search");
	String[] value = request.getParameterValues("user");
	if (value == null) {
		%>
		<script>
			alert('체크된 회원이 없습니다.')
			history.back();
		</script>
		<%
		return;
	}
	MemberDao dao = MemberDao.getInstance();
	
	for (String id : value) {
		dao.deleteById(id);
	}
%>
<script>
	alert('<%=value.length %>명의 회원이 탈퇴되었습니다.')
	location.href = '/admin/adminUsers.jsp?category=<%=category %>&search=<%=search %>';
</script>