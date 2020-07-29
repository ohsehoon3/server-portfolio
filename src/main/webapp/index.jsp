<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="" type="image/x-icon">
	<jsp:include page="/include/head.jsp" />
</head>
<body>

	<!-- Header -->
	<header id="header" class="alt">
		<div class="logo">
			<a href="index.jsp">O <span>Science</span></a>
		</div>
		<a href="#menu">Menu</a>
	</header>

	<!-- Banner -->
	<section class="banner full">
		<article>
			<img src="images/slide01.jpg" alt="" />
			<div class="inner">
				<header>
					<p>welcome</p>
					<h2>O Science</h2>
				</header>
			</div>
		</article>
		<article>
			<img src="images/slide02.jpg" alt="" />
			<div class="inner">
				<header>
					<p>2nd</p>
					<h2>page</h2>
				</header>
			</div>
		</article>
		<article>
			<img src="images/slide03.jpg" alt="" />
			<div class="inner">
				<header>
					<p>3rd</p>
					<h2>page</h2>
				</header>
			</div>
		</article>
		<article>
			<img src="images/slide04.jpg" alt="" />
			<div class="inner">
				<header>
					<p>4th</p>
					<h2>page</h2>
				</header>
			</div>
		</article>
		<article>
			<img src="images/slide05.jpg" alt="" />
			<div class="inner">
				<header>
					<p>5th</p>
					<h2>page</h2>
				</header>
			</div>
		</article>
	</section>

	<!-- One -->
	<section id="one" class="wrapper style2">
		<div class="inner">
			<div class="grid-style">

				<div>
					<div class="box">
						<div class="content">
							<header class="align-center">
								<p>추천 게시글</p>
								<h2>공개 게시판</h2>
							</header>
								<jsp:include page="/include/bestNotice.jsp" />
							<footer class="align-right">
								<a href="/board/notice.jsp" class="button alt">더보기</a>
							</footer>
						</div>
					</div>
				</div>

				<div>
					<div class="box">
						<div class="content">
							<header class="align-center">
								<p>추천 게시글</p>
								<h2>회원 게시판</h2>
							</header>
								<jsp:include page="/include/bestFileNotice.jsp" />
							<footer class="align-right">
								<a href="/fileBoard/fileNotice.jsp" class="button alt">더보기</a>
							</footer>
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