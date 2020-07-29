<%@page import="exam.vo.MemberVo"%>
<%@page import="exam.dao.MemberDao"%>
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

	String category = request.getParameter("category");
	String search = request.getParameter("search");
	id = request.getParameter("id"); 
	
	// DB객체 가져오기
	MemberDao dao = MemberDao.getInstance();
	MemberVo vo = dao.getMemberById(id);
	
	System.out.println(vo);
%>
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
					<header class="align-center">
						<p></p>
						<h2>UpdateUser</h2>
					</header>
					<div class="clear"></div>
					<div id="sub_img_member"></div>

					<div class="clear"></div>
					<nav id="sub_menu"></nav>

					<article>
						<form id="updateUser" action="updateUserPro.jsp" method="post" name="frm" onsubmit="return check();">
						<input type="hidden" name="category" value="<%=category %>">
						<input type="hidden" name="search" value="<%=search %>">
							<fieldset>
								<legend>필수 입력</legend>
								<label for="id">아이디</label>
								<input id="id" name="id" type="text" value="<%=vo.getId() %>" readonly><br> 
								<label for="passwd">비밀번호</label> <input name="passwd" type="password" id="passwd" value="<%=vo.getPasswd() %>"><br> 
								<label for="passwd2">비밀번호 확인</label> <input name="passwd2" type="password" id="passwd2" value="<%=vo.getPasswd() %>"> <span id="passwdMessage"></span> <br>
								<label for="name">이름</label> <input id="name" name="name" type="text" value="<%=vo.getName() %>"><br>
								<label for="age" >나이</label> <input id="age" name="age" type="number" value="<%=vo.getAge() %>"><br>
								<label>성별</label>
								<input name="gender" type="radio" id="man" value="남" <%if (vo.getGender().equals("남")) {%>checked<%} %>><label for="man">남자</label> 
								<input name="gender" type="radio" id="woman" value="여" <%if (vo.getGender().equals("여")) {%>checked<%} %>><label for="woman">여자</label>
								<label for="email">이메일</label> <input id="email" name="email" type="email" value="<%=vo.getEmail() %>"><br> 
							</fieldset>
							<fieldset>
								<legend>추가 입력</legend>
								<label for="address">주소</label> <input id="address" name="address" type="text" class="address" value="<%=vo.getAddress() %>"><br> 
								<label for="tel">전화번호</label> <input id="tel" name="tel" type="text" class="phone" value="<%=vo.getTel() %>"><br> 
								<label for="mtel">휴대전화번호</label> <input id="mtel" name="mtel" type="text" class="mobile" value="<%=vo.getMtel() %>"><br>
							</fieldset>
								<label for="grade" >등급</label> 
								<ul class="actions small">
									<li>
										<select name="grade" id="grade" class="button alt small">
											<option value="1" <% if (vo.getGrade() == 1) { %>selected<% } %>>1</option>
											<option value="2" <% if (vo.getGrade() == 2) { %>selected<% } %>>2</option>
											<option value="5" <% if (vo.getGrade() == 5) { %>selected<% } %>>5</option>
											<option value="10" <% if (vo.getGrade() == 10) { %>selected<% } %>>10</option>
										</select>
									</li>
								</ul>
							<br>
							<div id="buttons">
								<input type="submit" value="회원정보수정" class="submit"> 
								<input type="reset" value="새로작성" class="cancel">
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
	<jsp:include page="/include/adminNav.jsp" />

	<script>
		// 비밀번호 확인
		var passwd = document.getElementById('passwd');
		var passwd2 = document.getElementById('passwd2');
		
		$('input[name="passwd"]').keyup(function (event) {
			if (passwd.value == "") {
				$('span#passwdMessage').html('패스워드를 입력하세요.').css('color', 'red');
			} else if (passwd.value != passwd2.value) {
				$('span#passwdMessage').html('패스워드 불일치..').css('color', 'red');
			} else {
				$('span#passwdMessage').html('패스워드 일치함!!').css('color', 'green');
			}
		});
		
		$('input[name="passwd2"]').keyup(function (event) {
			if (passwd.value != passwd2.value) {
				$('span#passwdMessage').html('패스워드 불일치..').css('color', 'red');
			} else {
				$('span#passwdMessage').html('패스워드 일치함!!').css('color', 'green');
			}
		});
		
		function check() {
			var result;
			var radio = $('input[name="gender"]:checked').val();
			if ( frm.passwd.value == '' ) {
				alert('비밀번호를 입력하세요.');
				frm.passwd.focus();
				return false;
			} else if ( frm.passwd2.value != frm.passwd.value ) {
				alert('비밀번호를 확인해주세요.');
				frm.passwd2.focus();
				return false;
			} else if ( frm.name.value == '' ) {
				alert('이름을 입력하세요.');
				frm.name.focus();
				return false;
			} else if ( frm.age.value == '' ) {
				alert('나이를 입력하세요.');
				frm.age.focus();
				return false;
			} else if ( radio != '남' && radio != '여' ) {
				alert('성별을 입력하세요.');
				frm.gender[0].focus();
				return false;
			} else if ( frm.email.value == '' ) {
				alert('이메일을 입력하세요.');
				frm.email.focus(); 
				return false;
			}
		}
	</script>
</body>
</html>
