<%@page import="exam.vo.MemberVo"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 로그인 상태유지 쿠키정보 가져오기
	Cookie[] cookies = request.getCookies();
	// name이 "id"인 쿠키 객체 찾기
	if (cookies != null) { // null 확인
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("id")) {
				String id = cookie.getValue();
				
				if (id != null) {
					// 로그인 인증(세션에 id값 추가)
					session.setAttribute("id", id);
				}
			}
		}
	}
	
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	MemberDao dao = MemberDao.getInstance();
	
	int grade = 1;
	if (id != null){ 
		MemberVo vo = dao.getMemberById(id);
		grade = vo.getGrade();
	} 
%>    
    
<nav id="menu">
	<ul class="links">
		<li>
			<%
				if (id != null) {
			%> 
					<span style="color:white;, margin-bottom:5px;"><%=id %>님 반갑습니다.</span>
					<a href="/member/userInfo.jsp">회원 정보</a>
			<%
				} else {
			%>
					<a href="/member/join.jsp">회원가입</a>
			<%
				}
			%>
		</li>
		<li>
			<%
			if ( grade >= 9 ){
				%>
				<li><a href="/admin/adminMode.jsp">관리자 모드</a></li>
				<%
			}
			%>
		</li>
		<li>
			<%
				if (id != null) {
			%>
					<a href="/member/logout.jsp">로그아웃</a>
			<%
				} else {
			%>
					<a href="/member/login.jsp">로그인</a> 
			<%
				}
			%>
		</li>
	</ul>
	<ul class="links">
		<li><a href="/index.jsp">Home</a></li>
		<li><a href="/map/map.jsp">Map</a></li>
		<li>
			<a href="#" id="notice">게시판</a>
			<a href="/board/notice.jsp" style="display: none;" id="not1" > - 자유게시판</a>
			<a href="/fileBoard/fileNotice.jsp" style="display: none;"> - 회원게시판</a>
		</li>
		<%
		if ( grade >= 5 ) {
			%>
			<li><a href="/base/generic.jsp">Generic</a></li>
			<li><a href="/base/elements.jsp">Elements</a></li>
			<%
		} 
		%>
	</ul>
</nav>

<script>
	$('#notice').click(function () {
        $(this).next().toggle('slow', function () {});
        $('#not1').next().toggle('slow', function () {});
    });
</script>