<%@page import="exam.vo.BoardVo"%>
<%@page import="exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/include/head.jsp" />
</head>
<body class="subpage">
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
	
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardDao dao = BoardDao.getInstance();
	BoardVo vo = dao.getBoardByNum(num);
%>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<!-- One -->
	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>aaa</p>
				<h2>Delete</h2>
			</header>
		</div>
	</section>

	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<h2></h2>
					</header>
					<div class="clear"></div>
					<div id="sub_img_member"></div>

					<div class="clear"></div>
					<nav id="sub_menu"></nav>

					<article>
						<form id="deletePasswdCheck" action="deleteContentPro.jsp" method="post" name="frm" onsubmit="return check();">
						<input id="pageNum" name="pageNum" type="hidden" value="<%= pageNum %>">
							<fieldset>
								<input id="num" name="num" type="hidden" value="<%= vo.getNum() %>"><br>
								<input name="passwd" type="hidden" id="passwd" value="<%= vo.getPasswd() %>">
								<label for="passwd">비밀번호 확인</label> <input name="passwd2" type="password" id="passwd2"><br> 
							</fieldset>
							<br>
							<div id="buttons">
								<input type="submit" class="btn button special small submit" value="비밀번호 확인"> 
							</div>
						</form>
					</article>

					<div class="clear"></div>
				</div>
			</div>
		</div>
	</section>
	
	<!-- Footer -->
	<jsp:include page="/include/footer.jsp" />

	<!-- Scripts -->
	<jsp:include page="/include/script.jsp" />
	
	<!-- Nav -->
	<jsp:include page="/include/nav.jsp" />

	<script>
		function check() {
			var passwd = document.getElementById('passwd');
			var passwd2 = document.getElementById('passwd2');
			
			if ( passwd2.value == "" ) {
				alert('비밀번호를 입력하세요.');
				frm.passwd2.focus();
				return false;
			} else if ( passwd2.value != passwd.value ) {
				alert('비밀번호를 확인하세요.');
				frm.passwd2.focus();
				return false;
			}
		}
	</script>
</body>
</html>
