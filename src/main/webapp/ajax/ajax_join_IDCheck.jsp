<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");

	if (id == null || id.length() == 0) {
		return;
	}

	MemberDao dao = MemberDao.getInstance();
	
	boolean isIdDup = dao.isIdDuplicated(id);
	out.println(isIdDup);
%>
<%//=isIdDup %>
