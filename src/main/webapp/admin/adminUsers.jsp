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
	ul {
		margin: 11px;
	}
	table, form {
		margin-bottom: 1px;
		margin-top: 10px;
	}
	#page_control {
		margin-bottom: 15px;
		text-align: center;
	}
	a {
		text-decoration: none;
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

	// 검색어 관련 파라미터 가져오기
	String category = request.getParameter("category"); // 검색유형
	String search = request.getParameter("search"); // 검색어
	
	// null값을 빈문자열로 처리
	category = (category == null) ? "" : category;
	search = (search == null) ? "" : search;

	MemberDao dao = MemberDao.getInstance();
	// 전체 글 갯수
	int totalCount = dao.getTotalCount(category, search);

	// 사용자가 요청한 페이지번호 파라미터 가져오기
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null || strPageNum.equals("") || strPageNum.equals("null")) {
		strPageNum = "1";
	}
	int pageNum = Integer.parseInt(strPageNum);
	
	int pageSize = 10;
	int startRow = (pageNum - 1) * pageSize;
	
	List<MemberVo> list = null;
	if (totalCount > 0) {
		list = dao.getMembers(startRow, pageSize, category, search);
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
				<h2>adminUsers</h2>
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
						<h2>회원 관리</h2>
					</header>
					<div align="right">	회원 목록 (전체 회원 수: <%=totalCount%>) </div>
					<form action="deleteUser.jsp?category=<%=category %>&search=<%=search %>" method="post">
						<table>
							<thead>
								<tr>
									<th> </th>
									<th>아이디</th>
									<th>비밀번호</th>
									<th>이름</th>
									<th>나이</th>
									<th>성별</th>
									<th>이메일</th>
									<th>가입일</th>
									<th>주소</th>
									<th>전번</th>
									<th>폰번</th>
									<th>등급</th>
									<th>정보수정</th>
								</tr>
							</thead>
							<tbody>
								<%
								if (totalCount > 0) {
									DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
									for (MemberVo vo : list) {
										LocalDateTime dateTime = vo.getRegDate();
										String strRegDate = dateTime.format(formatter);
										%>
											<tr>
												<td>
													<input id="<%=vo.getId() %>" type="checkbox" name="user" value="<%=vo.getId() %>">
													<label for="<%=vo.getId() %>"> </label>
												</td>
												<td><%=vo.getId() %></td>
												<td><%=vo.getPasswd() %></td>
												<td><%=vo.getName() %></td>
												<td><%=vo.getAge() %></td>
												<td><%=vo.getGender() %></td>
												<td><%=vo.getEmail() %></td>
												<td><%=strRegDate %></td>
												<td><%=vo.getAddress() %></td>
												<td><%=vo.getTel() %></td>
												<td><%=vo.getMtel() %></td>
												<td><%=vo.getGrade() %></td>
												<td><input type="button" value="수정" class="btn button alt small" onclick="location.href='updateUser.jsp?category=<%=category %>&search=<%=search %>&id=<%=vo.getId() %>'"></td>
											</tr>
										<%
									}
								} else {
									%>
									<tr>
										<td colspan="13">회원 정보 없음</td>
									</tr>
									<%
								}
									%>
							</tbody>
						</table>
						<div class="align-right">
							<ul class="actions small">
								<li><input type="submit" value="삭제" class="btn button alt small"></li>
							</ul>
						</div>
					</form>
					<div id="page_control">
					<%
					if (totalCount > 0) {
						// 총 페이지 수 구하기
						int pageCount = (totalCount / pageSize) /* + (totalCount % pageSize == 0 ? 0 : 1) */; // 삼항연산자 활용가능
						if (totalCount % pageSize > 0) {
							pageCount += 1;
						}
						
						// 화면에 보여줄 페이지 번호의 갯수 설정
						int pageBlock = 10;
						
						// 페이지블록의 시작페이지 구하기!
						int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0 )) * pageBlock + 1;
						
						// 페이지블록의 끝페이지
						int endPage = startPage + pageBlock - 1;
						if (endPage > pageCount) { // 글 없는 페이지 번호 안주기 
							endPage = pageCount;
						}
						
						// [이전 10 페이지]
						if (startPage > pageBlock) { // 여러가지 방법 가능
							%>
							<a href="adminUsers.jsp?pageNum=<%=startPage - pageBlock %>&category=<%=category %>&search=<%=search %>">[이전]</a>&nbsp;&nbsp;
							<%
						}
						
						// 페이지 1 ~ 끝 페이지 (페이지블록 내에서의 시작페이지부터 끝페이지까지 번호 출력해보기)
						for (int i=startPage; i<=endPage; i++) {
							%>
							<a href="adminUsers.jsp?pageNum=<%=i %>&category=<%=category %>&search=<%=search %>">
							<%
							if (i == pageNum) {
								%>
								<span style="font-weight: bold; color: red;">[<%=i %>]</span>
								<%
							} else {
								%>
								[<%=i %>]
								<%
							}
							%>
							</a>&nbsp;&nbsp;
							<%
						}
								
						// [다음 10 페이지]	
						if (endPage < pageCount) {
							%>
							<a href="adminUsers.jsp?pageNum=<%=endPage + 1 %>&category=<%=category %>&search=<%=search %>">[다음]</a>
							<%
						}
					}
					%>
					</div>
					<div class="row unifrom">
						<div id="table_search" class="6u 12u$(small)">
							<form action="adminUsers.jsp" method="get">
								<ul class="actions small">
									<li>
										<select name="category" id="category" class="button alt small">
											<option value="id" <% if (category.equals("id")) { %>selected<% } %>>아이디</option>
											<option value="gender" <% if (category.equals("gender")) { %>selected<% } %>>성별</option>
											<option value="grade" <% if (category.equals("grade")) { %>selected<% } %>>등급</option>
										</select>
									</li>
									<li><input type="text" name="search" value="<%=search %>" class="input_box button alt small"></li> 
									<li><input type="submit" value="검색" class="btn button special small" ></li>
								</ul>
							</form>
						</div>
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

</body>
</html>