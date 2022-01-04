<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function() {
		$('#btnWithoutLogin').click(function() {
			alert('비회원으로 로그인 하셨습니다');
			location.href = "/jin/loginWithoutId.do";
		});//비회원 로그인

		$('#signUpBtn').click(function() {
			alert('회원가입 페이지로 이동')
			location.href = '/jin/signUp.do'
		});
		

	})
</script>
</head>
<body>
	<center>
		<h1>환영합니다</h1>
		<form action="/jin/loginProc.do" method="get">
			<label for="user_id">아이디 : </label> &nbsp;&nbsp;&nbsp;
			<input type="text" id="user_id" name="user_id" autofocus value="" required placeholder="아이디를 입력해주세요" /><br /> <label for="user_password">비밀번호: </label> 
			<input type="password" id="user_password" name="user_password" required="required" placeholder="비밀번호를 입력해주세요" /><br /> 
			<input type="submit" value="로그인"> <input id="btnWithoutLogin" type="button" value="비회원으로 로그인" />
			<input type="button" id="signUpBtn" value="회원가입" />
		</form>
	</center>
</body>
</html>