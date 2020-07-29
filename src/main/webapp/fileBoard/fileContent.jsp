<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="exam.vo.AttachfileVo"%>
<%@page import="java.util.List"%>
<%@page import="exam.vo.BoardVo"%>
<%@page import="exam.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 세션값 가져오기
	String id = (String) session.getAttribute("id");
	// 세션값 없으면 login.jsp로 이동
	if (id == null) {
		%>
		<script>
			alert('해당 게시물은 로그인 후 이용할 수 있습니다.');
			location.href = '/member/login.jsp';
		</script>
		<%
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/include/head.jsp" />
	
<style>
</style>
</head>
<body class="subpage">
<%
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
	BoardVo vo = dao.getBoardAndAttachfilesByNum(num);
	// 첨부파일 리스트 가져오기
	List<AttachfileVo> attachList = vo.getAttachList();	
	
	// 내용에서 엔터키 줄바꿈: \r\n을 <br> 바꾸기
	String content = "";
	if (vo.getContent() != null) {
		content = vo.getContent().replace("\r\n", "<br>");
	}
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	LocalDateTime dateTime = vo.getRegDate();
	String strRegDate = dateTime.format(formatter);
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
						<h2>FileContent</h2>
					</header>
					<table id="content">
						<tr>
							<th scope="col" width="200">글번호</th>
							<td width="500" style="text-align: left;"><%=vo.getNum() %></td>
						</tr>
						<tr>
							<th scope="col">조회수</th>
							<td style="text-align: left;"><%=vo.getReadcount() %></td>
						</tr>
						<tr>
							<th scope="col">작성자</th>
							<td style="text-align: left;"><%=vo.getName() %></td>
						</tr>
						<tr>
							<th scope="col">작성일</th>
							<td style="text-align: left;"><%=strRegDate %></td>
						</tr>
						<tr>
							<th scope="col">글제목</th>
							<td style="text-align: left;"><%=vo.getSubject() %></td>
						</tr>
						<tr>
							<th scope="col">첨부파일</th>
							<td style="text-align: left;">
								<%
								if (attachList != null) {
									for ( AttachfileVo attachVo : attachList) {
										%>
										<a href="download.jsp?uuid=<%=attachVo.getUuid() %>"> 
										<%=attachVo.getFilename() %>
										</a><br>
										<%
									}
								}
								%>
							</td>
						</tr>
						<tr>
							<th scope="col">글내용</th>
							<td style="text-align: left;"><%=content %></td>
						</tr>
					</table>
					<div class="row unifrom">
						<div class="6u 12u$(small)">
							<button type="button" class="btn button alt small" id="like" name="like" data-start="true">좋아요</button>
							<button type="button" class="btn button alt small" id="hate" name="hate">싫어요</button>
						</div>
						<div class="6u 12u$(small) align-right">
							<%
							if (id != null && id.equals(vo.getName())) {
								%>
								<button type="button" class="btn button special small" onclick="location.href='updateFileWriteForm.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>'">글수정</button>
								<button type="button" class="btn button special small" onclick="remove()">글삭제</button>
								<%
							}
							%>
							<button type="button" class="btn button special small" onclick="location.href='reFileWriteForm.jsp?reRef=<%=vo.getReRef() %>&reLev=<%=vo.getReLev() %>&reSeq=<%=vo.getReSeq() %>&pageNum=<%=pageNum %>'">답글쓰기</button>
							<button type="button" class="btn button special small" onclick="location.href='fileNotice.jsp?pageNum=<%=pageNum %>&category=<%=category %>&search=<%=search %>'">목록보기</button>
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
	
	<script>
		function remove() {
			var result = confirm('<%=vo.getNum() %>번 글을 정말 삭제하시겠습니까?');
			if (result) {
				location.href = 'deleteFileContentPro.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>';
			}
		}
		
		$('#like').click(function () {
			var id = <%=id %>;
			var bno = <%=vo.getNum() %>;
			var $btn = $(this);
			var like = $(this).data('start')
			$.ajax({
				url: '/ajax/ajax_like_IdCheck.jsp',
				data: { id: id, bno: bno },
				success: function (data) {
					likeDup(data, $btn)
				}
			})
		});
		function likeDup(data, $selfBtn) {
			if (data) {
				$selfBtn.val('좋아요 취소'); 
			} else {
				$selfBtn.val('좋아요');
			}
			$selfBtn.data('start', like);
		}
		
	</script>
	
</body>
</html>