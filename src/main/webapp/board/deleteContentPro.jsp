<%@page import="exam.dao.BoardDao"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // post 파라미터 한글처리
    request.setCharacterEncoding("utf-8");

	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
%>
    <jsp:useBean id="vo" class="exam.vo.BoardVo" />
    <jsp:setProperty property="*" name="vo" />
<%
    // DB객체 가져오기
    BoardDao dao = BoardDao.getInstance();
    
    // board 테이블에 새글 insert하기
    dao.deleteByNum(num);
%>
<script>
	alert('삭제 완료');
	location.href = '/board/notice.jsp?pageNum=<%=pageNum %>';
</script>