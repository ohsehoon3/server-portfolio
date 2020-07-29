<%@page import="exam.vo.BoardVo"%>
<%@page import="exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/include/head.jsp" />
	
<style>
</style>
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
	
	// int num & String pageNum 파라미터 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String category = request.getParameter("category"); // 검색유형
	String search = request.getParameter("search"); // 검색어
	
	// null값을 빈문자열로 처리
	category = (category == null) ? "" : category;
	search = (search == null) ? "" : search;
	
	// DB객체 가져오기
	BoardDao dao = BoardDao.getInstance();
	// 조회수 1증가
	dao.updateReadcount(num);
	// 글 한개 가져오기
	BoardVo vo = dao.getBoardByNum(num);
	// 내용에서 엔터키 줄바꿈: \r\n을 <br> 바꾸기
	String content = "";
	if (vo.getContent() != null) {
		content = vo.getContent().replaceAll("\r\n", "<br>");
	}
%>

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<!-- One -->
	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>aaa</p>
				<h2>공개 게시판</h2>
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
						<h2>Content</h2>
					</header>
					<table id="content">
						<tr>
							<th scope="col" width="200">글번호</th>
							<td width="500" style="text-align: left;"><%=vo.getNum()%></td>
						</tr>
						<tr>
							<th scope="col">조회수</th>
							<td style="text-align: left;"><%=vo.getReadcount()%></td>
						</tr>
						<tr>
							<th scope="col">작성자</th>
							<td style="text-align: left;"><%=vo.getName()%></td>
						</tr>
						<tr>
							<th scope="col">작성일</th>
							<td style="text-align: left;"><%=vo.getRegDate()%></td>
						</tr>
						<tr>
							<th scope="col">글제목</th>
							<td style="text-align: left;"><%=vo.getSubject()%></td>
						</tr>
						<tr>
							<th scope="col">글내용</th>
							<td style="text-align: left;"><%=content%></td>
						</tr>
					</table>
					<div class="row unifrom">
						<div class="6u 12u$(small)">
							<button type="button" class="btn button alt small" name="good">좋아요</button>
							<button type="button" class="btn button alt small" name="bad">싫어요</button>
						</div>
						<div class="6u 12u$(small) align-right" >
							<button type="button" class="btn button special small" onclick="location.href='updatePasswdCheck.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>'">글수정</button>
							<button type="button" class="btn button special small" onclick="location.href='deletePasswdCheck.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>'">글삭제</button>
							<button type="button" class="btn button special small" onclick="location.href='reWriteForm.jsp?reRef=<%=vo.getReRef() %>&reLev=<%=vo.getReLev() %>&reSeq=<%=vo.getReSeq() %>&pageNum=<%=pageNum %>'">답글쓰기</button>
							<button type="button" class="btn button special small" onclick="location.href='notice.jsp?pageNum=<%=pageNum %>&category=<%=category %>&search=<%=search %>'">목록보기</button>
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
	<jsp:include page="/include/nav.jsp" />
	
</body>
</html>