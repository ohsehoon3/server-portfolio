<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="exam.vo.BoardVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 검색어 관련 파라미터 가져오기
	String category = request.getParameter("category"); // 검색유형
	String search = request.getParameter("search"); // 검색어
	int boardtype = 2;
	
	// null값을 빈문자열로 처리
	category = (category == null) ? "" : category;
	search = (search == null) ? "" : search;
	
	// DB객체 가져오기
	BoardDao dao = BoardDao.getInstance();
	// 전체 글 갯수
	int totalCount = dao.getTotalCount(category, search, boardtype);
	
	int pageSize = 5;
	
	List<BoardVo> list = dao.getBoardOrderByReadcount(pageSize, boardtype);
	
%>
<table>
	<tr>
		<th>번호</th>
		<th style="width: 30%;">제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회</th>
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
				<td class='left' onclick="location.href='/fileBoard/fileContent.jsp?num=<%=vo.getNum() %>'">
					<%
					for (int j=0; j < vo.getReLev(); j++) {
						%><img src="/images/level.gif"/><% 
					}
					if (vo.getReLev() != 0) {
						%> <%=vo.getNum() %> <img src="/images/re.gif" /> <%
					}
					%>
					<%=vo.getSubject() %>
				</td>
				<td><%=vo.getName() %></td>
				<td><%=strRegDate %></td>
				<td><%=vo.getReadcount() %></td>
			</tr>
			<%
		}
	} else {
		%>
		<tr>
			<td colspan="5">게시판 글 없음</td>
		</tr>
		<%
	}
	%>
</table>