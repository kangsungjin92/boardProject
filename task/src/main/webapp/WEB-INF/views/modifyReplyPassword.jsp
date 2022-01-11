<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function (){
	var board_no = ${board_no};
	var pageNum = ${pageNum};
	var reply_no = ${reply_no}
	
	$('#cancel').click(function(){
		location.href="/jin/getContent.do?board_no="+board_no+'&pageNum='+pageNum+'&reply_no'+reply_no;
	});
	
	$('#confirm').click(function(){
		var password = $('#password').val();
		$.ajax({
			type : 'POST',
			url : '/jin/chkPasswordReplyProc.do',
			data : {
				'board_no' : board_no,
				'pageNum' : pageNum,
				'reply_no' : reply_no,
				'reply_password' : password
			},
			dataType : 'JSON',
			success : function(data){
				if(password == data.reply_password){
					location.href="/jin/modifyReplyPage.do?board_no="+board_no+'&reply_no='+reply_no+'&pageNum='+pageNum;
				}else{
					alert('비밀번호가 틀립니다');
					return;
				}
			},
			error : function(request, error){
				alert("ajax 실패");
			}
		});
	});
});

</script>
</head>
<body>
<center>
	<h1>비밀번호 확인</h1>
	<input type="password" id="password" name="reply_password" />
	<input type="button" id="cancel" value="취소" />
	<input type="button" id="confirm" value="확인" />
</center>
</body>
</html>