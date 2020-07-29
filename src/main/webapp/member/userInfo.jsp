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
	#page_control {
		margin-bottom: 15px;
		text-align: center;
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
	
	MemberDao dao = MemberDao.getInstance();
	MemberVo vo = dao.getMemberById(id);
	
%>
<body class="subpage">

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<!-- One -->
	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>aaa</p>
				<h2>Users</h2>
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
						<h2>회원 정보</h2>
					</header>
					<form>
						<table class="alt">
							<thead>
								<tr>
									<th>아이디</th>
									<th>이름</th>
									<th>나이</th>
									<th>성별</th>
									<th>이메일</th>
									<th>가입일</th>
									<th>주소</th>
									<th>번호1</th>
									<th>번호2</th>
									<th>등급</th>
								</tr>
							</thead>
							<tbody>
								<%
								DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
								LocalDateTime dateTime = vo.getRegDate();
								String strRegDate = dateTime.format(formatter);
								%>
								<tr>
									<td><%=vo.getId() %></td>
									<td><%=vo.getName() %></td>
									<td><%=vo.getAge() %></td>
									<td><%=vo.getGender() %></td>
									<td><%=vo.getEmail() %></td>
									<td><%=strRegDate %></td>
									<td><%=vo.getAddress() %></td>
									<td><%=vo.getTel() %></td>
									<td><%=vo.getMtel() %></td>
									<td><%=vo.getGrade() %></td>
								</tr>
							</tbody>
						</table>
						<div class="row unifrom">
							<div class="6u 12u$(small)" >
								<ul class="actions small">
									<li><input type="button" value="정보 수정" class="btn button alt small" onclick="location.href='updateUserCheck.jsp'"></li>
									<li><input type="button" value="탈퇴" class="btn button alt small" onclick="remove()"></li>
								</ul>
							</div>
						</div>
					</form>
					
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
		function remove() {
			var result = confirm('<%=vo.getId() %>님. 정말 탈퇴하시겠습니까?');
			if (result) {
				location.href = 'deleteUser.jsp?id=<%=vo.getId() %>';
			}
		}
	</script>

</body>
</html>