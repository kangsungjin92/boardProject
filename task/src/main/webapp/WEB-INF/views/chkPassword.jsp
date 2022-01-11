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
	var reply = '${reply}';
	
	$('#toList').click(function(){
		location.href="/jin/board.do?pageNum="+pageNum;	
	});
	
	
	$('#password').bind("propertychange change click keyup input paste", function(){
		var inputLength = $(this).val().length;
		var content = $('#password').val();
		
		if(inputLength>100){
			var value = content.substring(0,100);
			alert('내용은 최대 100글자입니다.');
			$('#password').val(value);
		}
	});
	
	$('#cancel').click(function(){
		location.href="/jin/getContent.do?board_no="+board_no+'&pageNum='+pageNum;
	});
	
	$('#confirm').click(function(){
		var password = $('#password').val().trim();
		$.ajax({
			type : 'POST',
			url : '/jin/chkPasswordProc.do',
			data : {
				'board_no' : board_no,
				'pageNum' : pageNum,
				'board_password' : password,
				'reply' : reply
			},
			dataType : 'JSON',
			success : function(data){
				if(password == data.board_password){
					location.href="/jin/deleteBoard.do?board_no="+board_no+'&reply='+reply+'&pageNum='+pageNum;
				}else if(password != data.board_password){
					alert('잘못된 비밀번호입니다.');
					$('#password').val('');
					$('#password').focus();
					return;
				}else if(password == ''){
					alert('비밀번호는 빈칸일 수 없습니다.');
					$('#password').val('');
					$('#password').focus();
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
	<input type="password" id="password" name="board_password" />
	<input type="button" id="cancel" value="취소" />
	<input type="button" id="confirm" value="확인" />
	<input type="button" id="toList" value="목록으로" />
</center>
</body>
</html>