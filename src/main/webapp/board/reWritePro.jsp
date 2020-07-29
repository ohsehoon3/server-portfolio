<%@page import="exam.dao.BoardDao"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // post 파라미터 한글처리
    request.setCharacterEncoding("utf-8");
 
    String pageNum = request.getParameter("pageNum");
%>
    <jsp:useBean id="vo" class="exam.vo.BoardVo" />
    <jsp:setProperty property="*" name="vo" />
<%
    // ip & regDate setter메소드 호출로 값 저장
    vo.setIp(request.getRemoteAddr());
    vo.setRegDate(LocalDateTime.now());
    
    // DB객체 가져오기
    BoardDao dao = BoardDao.getInstance();
    vo.setBoardtype(1);
    
    // board 테이블에 새글 insert하기
    dao.replyInsert(vo);
    vo.setReadcount(0);
 
    System.out.println(vo);
    
    // 글목록 notice.jsp로 이동
    response.sendRedirect("notice.jsp?pageNum=" + pageNum);
%>
