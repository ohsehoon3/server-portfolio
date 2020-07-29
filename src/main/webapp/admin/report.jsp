<%@page import="com.google.gson.Gson"%>
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
	
    MemberDao dao = MemberDao.getInstance();

   	List<List<Object>> countGender = dao.getCountByGender();
   	List<List<Object>> countAge = dao.getCountByAge();
   	
    // 자바 리스트를 Gson을 이용하여 JSON 배열리스트로 변환
    Gson gson = new Gson();
    String strCG = gson.toJson(countGender);
    String strAge = gson.toJson(countAge);
%>
<body class="subpage">

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
				<div class="content" >
					<header class="align-center">
						<p></p>
						<h2>레포트</h2>
					</header>
					<div id="pie_chart_div1" style="width: 900px; height: 500px; border: 1px solid;"></div>
					<div id="pie_chart_div2" style="width: 900px; height: 500px; border: 1px solid;"></div>
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
	<script src="https://www.gstatic.com/charts/loader.js"></script>
	<script>
	    google.charts.load('current', {
	        packages : [ 'corechart' ]
	    });
	
	    google.charts.setOnLoadCallback(function() {
	        pieChart1();
	        pieChart2();
	    });
	
	    // 원형 차트 1 
	    function pieChart1() {
	        var arr = <%=strCG %>;
	        console.log(typeof arr);
	        console.log(arr);
	
	        var dataTable = google.visualization.arrayToDataTable(arr);
	
	        var options = {
	            title : '회원 성별 비'
	        };
	
	        var objDiv = document.getElementById('pie_chart_div1');
	        var chart = new google.visualization.PieChart(objDiv);
	        chart.draw(dataTable, options);
	    }
	    
	    function pieChart2() {
	        var arr = <%=strAge %>;
	        console.log(typeof arr);
	        console.log(arr);
	
	        var dataTable = google.visualization.arrayToDataTable(arr);
	
	        var options = {
	            title : '회원 나이 비'
	        };
	
	        var objDiv = document.getElementById('pie_chart_div2');
	        var chart = new google.visualization.PieChart(objDiv);
	        chart.draw(dataTable, options);
	    }
	</script>

</body>
</html>