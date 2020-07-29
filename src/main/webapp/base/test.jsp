<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>JDBC 연동 테스트</h1>
    <hr>
    <%
    // DB접속 정보
    String url = "jdbc:mysql://localhost:3306/ohse?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
    String user = "jspuser";
    String passwd = "jsppass";
    
    // 1단계 드라이버 클래스 로딩
    Class.forName("com.mysql.jdbc.Driver");
    // 2단계 DB연결(DB주소, DB아이디, DB비번)
    Connection con = DriverManager.getConnection(url, user, passwd);
    
    out.println("연결성공!<br>");
    %>
</body>
</html>
