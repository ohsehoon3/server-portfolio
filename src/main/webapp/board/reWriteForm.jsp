<%@page import="exam.vo.BoardVo"%>
<%@page import="exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/include/head.jsp" />
	
<style>
	#bot_btn button {
		float: right;
		margin-left: 5px
	}
</style>
</head>
<body class="subpage">
<%
	// 파라미터 가져오기
	String reRef = request.getParameter("reRef");
	String reLev = request.getParameter("reLev");
	String reSeq = request.getParameter("reSeq");
	String pageNum = request.getParameter("pageNum");
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
						<h2>답글쓰기</h2>
					</header>
		            <form action="reWritePro.jsp" method="post" name="frm">
		            <input type="hidden" name="reRef" value="<%=reRef %>">
		            <input type="hidden" name="reLev" value="<%=reLev %>">
		            <input type="hidden" name="reSeq" value="<%=reSeq %>">
		            <input type="hidden" name="pageNum" value="<%=pageNum %>">
		                <table id="reWriteForm">
		                    <tr>
		                        <th scope="col" width="200">이름</th>
		                        <td style="text-align: left; width: 500px;">
		                            <input type="text" name="name">
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scope="col">비밀번호</th>
		                        <td style="text-align: left;">
		                            <input type="password" name="passwd">
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scope="col">글제목</th>
		                        <td style="text-align: left;">
		                            <input type="text" name="subject">
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scope="col">글내용</th>
		                        <td style="text-align: left;">
		                            <textarea name="content" rows="13" cols="40"></textarea>
		                        </td>
		                    </tr>
		                </table>
		 
		                <div id="table_search">
		                    <button type="submit" class="btn button special small">답글쓰기</button>
		                    <button type="reset" class="btn button special small">다시쓰기</button>
		                    <button type="button" class="btn button special small" onclick="location.href='notice.jsp?pageNum<%=pageNum %>'">목록보기</button>
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
		function check() {
			var name = $('input[name="name"]').val();
			
			if ( frm.name.value == '') {
				alert('이름을 입력하세요.');
				frm.name.focus();
				return false;
			} else if ( frm.passwd.value == '' ) {
				alert('비밀번호를 입력하세요.');
				frm.passwd.focus();
				return false;
			} else if ( frm.subject.value == '' ) {
				alert('글제목을 입력하세요.');
				frm.subject.focus(); 
				return false;
			} else if ( frm.content.value == '' ) {
				alert('글내용을 입력하세요.');
				frm.content.focus(); 
				return false;
			} 
		}
	</script>
	
</body>
</html>