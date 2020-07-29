<%@page import="exam.vo.BoardVo"%>
<%@page import="exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//세션 가져오기
	String id = (String) session.getAttribute("id");
	if (id == null) { // 아이디 없음
		response.sendRedirect("/member/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/include/head.jsp" />
</head>
<body class="subpage">
<%
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
				<h2>회원 게시판</h2>
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
		            <form action="reFileWritePro.jsp" method="post" name="frm" enctype="multipart/form-data" onsubmit="return check()">
    		        <input type="hidden" name="reRef" value="<%=reRef %>">
		            <input type="hidden" name="reLev" value="<%=reLev %>">
		            <input type="hidden" name="reSeq" value="<%=reSeq %>">
		            <input type="hidden" name="pageNum" value="<%=pageNum %>">
		                <table id="fileWriteForm">
		                    <tr>
		                        <th scope="col" width="200">아이디</th>
		                        <td style="text-align: left; width: 500px;">
		                            <input type="text" name="name" value="<%=id %>" readonly>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scope="col">글제목</th>
		                        <td style="text-align: left;">
		                            <input type="text" name="subject">
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scope="col">파일</th>
		                        <td style="text-align: left;">
		                        	<button type="button" id="btnAddFile" class="btn button alt small">첨부파일 추가</button>
									<div id="fileBox">
										<div>
											<input type="file" name="filename"><span class="fileDelete">X</span>
										</div>
									</div>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scope="col">글내용</th>
		                        <td style="text-align: left;">
		                            <textarea name="content" rows="13" cols="40"></textarea>
		                        </td>
		                    </tr>
		                </table>
		 
		                <div class="align-right">
		                    <button type="submit" class="btn button special small">글쓰기</button>
		                    <button type="reset" class="btn button special small">다시쓰기</button>
		                    <button type="button" class="btn button special small" onclick="location.href='fileNotice.jsp?pageNum<%=pageNum %>'">목록보기</button>
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
		var fileCount = 1;
		
		// 정적 이벤트 바인딩
		$('button#btnAddFile').click(function (event) {
			if (fileCount >= 5) {
				alert('첨부파일은 최대 5개까지만 가능합니다.');
				return;
			}
			
			var str = '<div><input type="file" name="filename"><span class="fileDelete">X</span></div>';
			
			$('div#fileBox').append(str);
			fileCount++;
		});
	
		// 동적 이벤트 바인딩
		$('div#fileBox').on('click', 'span.fileDelete', function () {
			$(this).parent().remove();
			fileCount--;
		});
	
		function check() {
			if ( frm.subject.value == '' ) {
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