<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // id passwd 파라미터 가져오기
    String id = request.getParameter("id");
    String passwd = request.getParameter("passwd");
    
    boolean keepLogin = false;
	// 체크박스는 체크를 안하면 null을 리턴함
	String strKeepLogin = request.getParameter("keepLogin"); // "true"
	if (strKeepLogin != null) { // "true"
		keepLogin = Boolean.parseBoolean(strKeepLogin);
	}
    
    // DB객체 준비
    MemberDao dao = MemberDao.getInstance();
    
    // -1: 아이디 없음, 0: 비밀번호 틀림, 1: 아이디 비밀번호 일치
    int check = dao.userCheck(id, passwd);
    
    if (check == 1) {
        session.setAttribute("id", id);
        
		// 로그인 상태유지 원하면 쿠키 생성 후 응답주기
		if (keepLogin){ // keepLogin == true
			Cookie idCookie = new Cookie("id", id);
			idCookie.setMaxAge(60*10); // 쿠키 유지 기간 (초단위 설정) 10분
			idCookie.setPath("/"); // 상위 폴더도 경로 추가
			response.addCookie(idCookie);
		}
		response.sendRedirect("/index.jsp");
		
    } else if (check == 0) {
        %>
        <script>
            alert('비밀번호 틀림');
            history.back();
        </script>
        <%
    } else { // check == -1
        %>
        <script>
            alert('아이디 없음');
            history.back();
        </script>
        <%
    }
%>
