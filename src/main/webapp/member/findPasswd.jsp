<%@page import="exam.vo.MemberVo"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

    String id = request.getParameter("id");
    String email = request.getParameter("email");
    
    if (id == null || id == "" ) {
    	%>
        <script>
            alert('아이디를 입력하세요');
            history.back();
        </script>
        <%
        return;
    } else if (email == null || email == "") {
    	%>
        <script>
            alert('이메일을 입력하세요');
            history.back();
        </script>
        <%
        return;
    }
    
    // DB객체 준비
    MemberDao dao = MemberDao.getInstance();
	
    if (!dao.isIdDuplicated(id)) {
    	%>
        <script>
            alert('회원정보 없음');
            history.back();
        </script>
        <%
        return;
    }
    
    // -1: 아이디 없음, 0: 비밀번호 틀림, 1: 아이디 비밀번호 일치
    MemberVo vo = dao.getMemberById(id);
    
    if (id.equals(vo.getId())) {
    	if (email.equals(vo.getEmail())) {
    		%>
            <script>
                alert('회원님의 비밀번호는 <%=vo.getPasswd() %>입니다.');
                history.back();
            </script>
            <%
    	} else {
    		%>
            <script>
                alert('회원정보 없음');
                history.back();
            </script>
            <%
    	}
    } else { 
        %>
        <script>
            alert('회원정보 없음');
            history.back();
        </script>
        <%
    }
%>
