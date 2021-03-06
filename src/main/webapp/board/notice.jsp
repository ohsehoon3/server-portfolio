<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="exam.vo.BoardVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.BoardDao"%>
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
	a {
		text-decoration: none;
	}	
</style>
</head>
<%
	// 검색어 관련 파라미터 가져오기
	String category = request.getParameter("category"); // 검색유형
	String search = request.getParameter("search"); // 검색어
	int boardtype = 1;
	
	// null값을 빈문자열로 처리
	category = (category == null) ? "" : category;
	search = (search == null) ? "" : search;
	
	// DB객체 가져오기
	BoardDao dao = BoardDao.getInstance();
	// 전체 글 갯수
	int totalCount = dao.getTotalCount(category, search, boardtype);
	
	// 사용자가 요청한 페이지번호 파라미터 가져오기
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null || strPageNum.equals("") || strPageNum.equals("null")) {
		strPageNum = "1";
	}
	// if 대신 삼항연산자 사용
	//strPageNum = (strPageNum == null) ? "1" : strPageNum;
	
	// 문자열 페이지 번호 숫자로 변환
	int pageNum = Integer.parseInt(strPageNum);
	
	// 한 페이지에 15개씩 가져오기
	int pageSize = 10;
	// 시작행 인덱스번호 구하기(수식)
	int startRow = (pageNum - 1) * pageSize;
	
	// 원하는 페이지의 글을 가져오는 메소드
	List<BoardVo> list = null;
	if (totalCount > 0) {
		list = dao.getBoards(startRow, pageSize, category, search, boardtype);
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
				<h2>Notice</h2>
			</header>
		</div>
	</section>

	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<h2>공개 게시판</h2>
					</header>
					<!-- Table -->
					<div align="right">	글 목록 (전체 글갯수: <%=totalCount%>) </div>
					<table>
						<tr>
							<th>번호</th>
							<th style="width: 40%;">제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회</th>
							<th>IP</th>
						</tr>
						<%
						if (totalCount > 0) {
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
						
							for (BoardVo vo : list) {
								LocalDateTime dateTime = vo.getRegDate();
								String strRegDate = dateTime.format(formatter);
								%>
								<tr>
									<td><%=vo.getNum() %></td>
									<td class='left' onclick="location.href='content.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>&category=<%=category %>&search=<%=search %>'">
										<%
										for (int j=0; j < vo.getReLev(); j++) {
											%><img src="/images/level.gif"/><% 
										}
										if (vo.getReLev() != 0) {
											%><img src="/images/re.gif" /><%
										}
										%>
										<%=vo.getSubject() %>
									</td>
									<td><%=vo.getName() %></td>
									<td><%=strRegDate %></td>
									<td><%=vo.getReadcount() %></td>
									<td><%=vo.getIp() %></td>
								</tr>
								<%
							}
						} else {
							%>
							<tr>
								<td colspan="6">게시판 글 없음</td>
							</tr>
							<%
						}
						%>
					</table>

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
							<a href="notice.jsp?pageNum=<%=startPage - pageBlock %>&category=<%=category %>&search=<%=search %>">[이전]</a>&nbsp;&nbsp;
							<%
						}
						
						// 페이지 1 ~ 끝 페이지 (페이지블록 내에서의 시작페이지부터 끝페이지까지 번호 출력해보기)
						for (int i=startPage; i<=endPage; i++) {
							%>
							<a href="notice.jsp?pageNum=<%=i %>&category=<%=category %>&search=<%=search %>">
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
							<a href="notice.jsp?pageNum=<%=endPage + 1 %>&category=<%=category %>&search=<%=search %>">[다음]</a>
							<%
						}
					}
					%>
					</div>
					<div class="row unifrom">
						<div id="table_search" class="6u 12u$(small)">
							<form action="notice.jsp" method="get">
								<ul class="actions small">
									<li>
										<select name="category" id="category" class="button alt small">
											<option value="content" <% if (category.equals("content")) { %>selected<% } %>>글내용</option>
											<option value="subject" <% if (category.equals("subject")) { %>selected<% } %>>글제목</option>
											<option value="name" <% if (category.equals("name")) { %>selected<% } %>>작성자</option>
										</select>
									</li>
									<li><input type="text" name="search" value="<%=search %>" class="input_box button alt small"></li> 
									<li><input type="submit" value="검색" class="btn button special small" ></li>
									
								</ul>
							</form>
						</div>
						<div class="6u 12u$(small)" >
							<ul class="actions small align-right">
								<li><input type="button" value="글쓰기" class="btn button special small" onclick="location.href='writeForm.jsp?pageNum=<%=pageNum %>&category=<%=category %>&search=<%=search %>'"></li>
							</ul>
						</div>
					</div>	
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
	
</body>
</html>