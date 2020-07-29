<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/include/head.jsp" />
<style>
	div .grid {
	    display: grid;
	    grid-template-columns: repeat(2, 1fr);
	    grid-template-rows: 1fr;
	    gap: 50px;
	}
</style>
</head>
<body class="subpage">

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<!-- One -->
	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>welcome</p>
				<h2>Login</h2>
			</header>
		</div>
	</section>

	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content" >
					<header class="align-center">
						<p></p>
						<h2>Login</h2>
					</header>
					<form action="loginPro.jsp" method="post">
						<fieldset>
							<label>아이디</label> <input type="text" name="id" autofocus><br>
							<label>비밀번호</label> <input type="password" name="passwd"><br>
							<input type="checkbox" name="keepLogin" value="true" id='keepLogin'>
							<label for="keepLogin">로그인 상태 유지</label>
						</fieldset>

						<div class="clear"></div>
						<div id="buttons">
							<input type="submit" value=로그인 class="submit special"> 
							<input type="button" value=회원가입 class="submit special" onclick="location.href='/member/join.jsp'">
						</div>
					</form>
					<div class="grid">
						<form action="findId.jsp" method="post" onsubmit="false">
							<header class="align-center">
								<p></p>
								<h3>아이디 찾기</h3>
							</header>
							<label>이름</label> <input type="text" name="name"><br>
							<label>이메일</label> <input type="email" name="email"><br>
							<div id="buttons">
								<input type="submit" value=찾기 class="submit special"> 
							</div>
						</form>
						<form action="findPasswd.jsp" method="post">
							<header class="align-center">
								<p></p>
								<h3>비밀번호 찾기</h3>
							</header>
							<label>아이디</label> <input type="text" name="id"><br>
							<label>이메일</label> <input type="email" name="email"><br>
							<div id="buttons">
								<input type="submit" value=찾기 class="submit special"> 
							</div>
						</form>
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
	<jsp:include page="/include/nav.jsp" />

	<% 
	String id = (String) session.getAttribute("id");
	if (id != null) {
		response.sendRedirect("/index.jsp");
		return;
	}
	%>
</body>
</html>