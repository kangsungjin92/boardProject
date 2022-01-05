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
		$('#title').keyup(function(){
			var inputLength = $(this).val().length;
			var title = $('#title').val();
			if(inputLength>100){
				var value = title.substring(0,99);
				alert('제목은 100글자를 넘길 수 없습니다');
				$('#title').val(value);
			}
		})
		
		var pageNum = ${pageNum};
		$('#cancel').click(function(){
			location.href = '/jin/board.do?pageNum='+pageNum;
		});
		
		$('#content').keyup(function(){
			var inputLength = $(this).val().length;
			var content = $('#content').val();
			$('#spanInputLength').text(inputLength);
			if(inputLength>300){
				var value = content.substring(0,299);
				alert('글자수는 300글자를 넘을 수 없습니다');
				$('#content').val(value);
				$('#spanInputLength').text('300');
			}
		});
		
	});
	function check(){
		inputLength = $('#password').val().length;
		alert(inputLength);
		if(inputLength<8){
			alert('비밀번호는 8글자 이상입니다');
			return false;
		}else{
			return true;
		}
	}
</script>
<style>
#wrap {
	position: top
}
</style>
</head>
<body>
	<center>
		<div id="wrap">
			<form action="/jin/boardWriteProc.do" method="post" onsubmit="return check();">
				<input type="text" style="width: 300px; margin: 10px 0px;" id="title" name="board_title" placeholder="제목을 입력해주세요" /><br>
				<textarea id="content" style="width: 300px; height: 300px"placeholder="내용을 입력해주세요"></textarea><br> 
				<input type="password" style="width: 300px;" id="password"name="board_password" placeholder="비밀번호를 입력해주세요" /><br>
				<input id="cancel" type="button" value="취소" /> 
				<input type="submit" value="등록" />
			</form>
			<p><span id="spanInputLength">0</span>/300</p>
			

		</div>
	</center>
</body>
</html>