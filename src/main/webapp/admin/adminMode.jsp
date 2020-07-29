<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="exam.vo.MemberVo"%>
<%@page import="exam.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/include/head.jsp" />
	
<style>
	.alt li{
		font-size: 20px;
		
	}
	a {
		text-decoration: none;
	}
	a:hover {
		text-decoration: underline;
	}
</style>
</head>
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
	
	if (id != null){ 
		MemberDao dao = MemberDao.getInstance();
		MemberVo vo = dao.getMemberById(id);
		int grade = vo.getGrade();
		if( !(grade >= 9) ) {
			response.sendRedirect("/index.jsp");
			return;
		}
	} else {
		response.sendRedirect("/index.jsp");
		return;
	}
%>
<body class="subpage">

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<!-- One -->
	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>aaa</p>
				<h2>관리자 모드</h2>
			</header>
		</div>
	</section>

	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<div class="align-center">
						<ul class="alt">
							<li><a href="/admin/adminUsers.jsp">전체 회원정보 보기</a></li>
							<li><a href="/admin/adminNotice.jsp">공개 게시판 관리</a></li>
							<li><a href="/admin/adminFileNotice.jsp">회원 게시판 관리</a></li>
							<li><a href="/admin/report.jsp">레포트</a></li>
							<li><a href="/admin/email.jsp">이메일 전송</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer -->
	<jsp:include page="/include/footer.jsp" /> 

	<!-- Scripts -->
	<jsp:include page="/include/script.jsp" />

	<!-- Nav -->
	<jsp:include page="/include/adminNav.jsp" />

	<script>
		
	</script>

</body>
</html>