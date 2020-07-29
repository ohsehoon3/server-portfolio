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
%>    
    
<nav id="menu">
	<ul class="links">
		<li>
			<span style="color:white;, margin-bottom:5px;"><%=id %>님 관리자 모드</span>
			<a href="/member/logout.jsp">로그아웃</a>
		</li>
		<li>
			<a href="/admin/adminUsers.jsp">전체 회원정보 보기</a>
			<a href="/admin/adminNotice.jsp">공개 게시판 관리</a>
			<a href="/admin/adminFileNotice.jsp">회원 게시판 관리</a>
			<a href="/admin/report.jsp">레포트</a>
			<a href="/admin/email.jsp">이메일 전송</a>
		</li>
	</ul>
	<ul class="links">
		<li><span style="color:white;, margin-bottom:5px;">일반 모드</span></li>
		<li><a href="/index.jsp">Home</a></li>
		<li><a href="/map/map.jsp">Map</a></li>
		<li>
			<a href="#" id="notice">게시판</a>
			<a href="/board/notice.jsp" style="display: none;" id="not1" > - 자유게시판</a>
			<a href="/fileBoard/fileNotice.jsp" style="display: none;"> - 회원게시판</a>
		</li>
		<li><a href="/base/generic.jsp">Generic</a></li>
		<li><a href="/base/elements.jsp">Elements</a></li>
	</ul>
</nav>

<script>
	$('#notice').click(function () {
        $(this).next().toggle('slow', function () {});
        $('#not1').next().toggle('slow', function () {});
    });
</script>