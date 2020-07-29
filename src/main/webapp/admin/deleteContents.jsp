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
 		dao.deleteByNum(num[i]);
	}
%>
<script>
	alert('<%=value.length %>개의 글이 삭제되었습니다.')
	location.href = '/admin/adminNotice.jsp?category=<%=category %>&search=<%=search %>';
</script>