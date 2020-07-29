<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/include/head.jsp" />
</head>
<body class="subpage">

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<!-- One -->
	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>welcome</p>
				<h2>Join</h2>
			</header>
		</div>
	</section>

	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<h2></h2>
					</header>
					<div class="clear"></div>
					<div id="sub_img_member"></div>

					<div class="clear"></div>
					<nav id="sub_menu"></nav>

					<article>
						<form id="join" action="joinPro.jsp" method="post" name="frm" onsubmit="return check();">
							<fieldset>
								<legend>필수 입력</legend>
								<label for="id">아이디</label> <span id="idDupMessage"></span>
								<input id="id" name="id" type="text" autofocus><br> 
								<label for="passwd">비밀번호</label> <input name="passwd" type="password" id="passwd"><br> 
								<label for="passwd2">비밀번호 확인</label> <input name="passwd2" type="password" id="passwd2"> <span id="passwdMessage"></span> <br>
								<label for="name">이름</label> <input id="name" name="name" type="text"><br>
								<label for="age" >나이</label> <input id="age" name="age" type="number"><br>
								<label>성별</label>
								<input name="gender" type="radio" id="man" value="남"><label for="man">남자</label> 
								<input name="gender" type="radio" id="woman" value="여"><label for="woman">여자</label>
								<label for="email">이메일</label> <input id="email" name="email" type="email"><br> 
							</fieldset>
							<fieldset>
								<legend>추가 입력</legend>
								<label for="address">주소</label> <input id="address" name="address" type="text" class="address"><br> 
								<label for="tel">전화번호</label> <input id="tel" name="tel" type="text" class="phone"><br> 
								<label for="mtel">휴대전화번호</label> <input id="mtel" name="mtel" type="text" class="mobile"><br>
							</fieldset>
							<br>
							<div id="buttons">
								<input type="submit" value="회원가입" class="submit"> 
								<input type="reset" value="새로작성" class="cancel">
							</div>
						</form>

					</article>

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

	<script>
		// ID 중복 확인
		$('input[name="id"]').keyup(function (event) {
			var id = $(this).val();
			if (id == "") {
				$('span#idDupMessage').html('아이디를 입력하세요.').css('color', 'red');
			}
				
			$.ajax({
				url: '/ajax/ajax_join_IDCheck.jsp',
				data: { id: id },
				success: function (data) {
					showIdDupMessage(data);
				}
			})
		});
		function showIdDupMessage(data) {
			if (data) {
				$('span#idDupMessage').html('이미 사용중인 아이디 입니다.').css('color', 'red');
			} else {
				$('span#idDupMessage').html('사용 가능한 아이디 입니다.').css('color', 'green');
			}
		}
		
		// 비밀번호 확인
		var passwd = document.getElementById('passwd');
		var passwd2 = document.getElementById('passwd2');
		
		$('input[name="passwd"]').keyup(function (event) {
			if (passwd.value == "") {
				$('span#passwdMessage').html('패스워드를 입력하세요.').css('color', 'red');
			} else if (passwd.value != passwd2.value) {
				$('span#passwdMessage').html('패스워드 불일치..').css('color', 'red');
			} else {
				$('span#passwdMessage').html('패스워드 일치함!!').css('color', 'green');
			}
		});
		
		$('input[name="passwd2"]').keyup(function (event) {
			if (passwd.value != passwd2.value) {
				$('span#passwdMessage').html('패스워드 불일치..').css('color', 'red');
			} else {
				$('span#passwdMessage').html('패스워드 일치함!!').css('color', 'green');
			}
		});
		
		function check() {
			var result;
			var id = $('input[name="id"]').val();
			var radio = $('input[name="gender"]:checked').val();
			$.ajax({
				async: false,
				url: '/ajax/ajax_join_IDCheck.jsp',
				data: { id: id },
				success: function (data) {
// 					console.log(typeof data);
// 					console.log('data = ' + data);
					result = data;
				}
			});
			if ( frm.id.value == '') {
				alert('아이디를 입력하세요.');
				frm.id.focus();
				return false;
			} else if (result) {
				alert('아이디를 확인하세요.');
				frm.id.focus();
				return false;
			} else if ( frm.passwd.value == '' ) {
				alert('비밀번호를 입력하세요.');
				frm.passwd.focus();
				return false;
			} else if ( frm.passwd2.value != frm.passwd.value ) {
				alert('비밀번호를 확인해주세요.');
				frm.passwd2.focus();
				return false;
			} else if ( frm.name.value == '' ) {
				alert('이름을 입력하세요.');
				frm.name.focus();
				return false;
			} else if ( frm.age.value == '' ) {
				alert('나이를 입력하세요.');
				frm.age.focus();
				return false;
			} else if ( radio != '남' && radio != '여' ) {
				alert('성별을 입력하세요.');
				frm.gender[0].focus();
				return false;
			} else if ( frm.email.value == '' ) {
				alert('이메일을 입력하세요.');
				frm.email.focus(); 
				return false;
			} 
		}
	</script>
</body>
</html>
