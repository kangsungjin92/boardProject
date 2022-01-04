<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(function(){
		$('#signUpBtn').click(function(){
			var id = $('#user_id').val();
			var pw = $('#user_password').val();
			location.href='/jin/signUpProc.do?user_id='+id+'&user_password='+pw;
		}
			
		);
	});
</script>
</head>
<body>
	<center>
		<h3>회원가입</h3>
		<form action="/jin/signUpProc.do" method="post">
			<input type="text" name="user_id" id="user_id" required
				placeholder="아이디를 입력해주세요" /><br> <input type="password"
				name="user_password" required id="user_password"
				placeholder="비밀번호를 입력해주세요" /><br> <input type="button"
				id="signUpBtn" value="가입하기" /> <input type="button" value="취소" />
		</form>
	</center>
</body>
</html>