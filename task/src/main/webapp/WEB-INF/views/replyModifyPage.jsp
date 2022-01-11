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
		var reply_no = ${reply_no};
		var board_no = ${board_no};
		var pageNum = ${pageNum};
		$('#cancel').click(function(){
			location.href = '/jin/getContent.do?pageNum='+pageNum+'&board_no='+board_no+'&reply_no='+reply_no;
		});
		
		$('#reply_content').keyup(function(){
			var inputLength = $(this).val().length;
			var content = $('#reply_content').val();
			$('#spanInputLength').text(inputLength);
			if(inputLength>200){
				var value = content.substring(0,200);
				alert('글자수는 200글자를 넘을 수 없습니다');
				$('#reply_content').val(value);
				$('#spanInputLength').text('200');
			}
		});
		
	
	
		
	});
	
	
	
	//validation
	function check(){
		
		//공백 체크
		var content = $('#reply_content').val().trim();
		if(content ==''){
			alert('내용이 존재하지 않습니다');
			return false;
		}
		
		var length = content.length;
		
		if(length>200){
			alert('최대 200글자입니다');
			return false;
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
			<form action="/jin/replyUpdate.do" method="post" onsubmit="return check();">
				<input type="hidden" name="board_no" value="${board_no }" />
				<input type="hidden" name="pageNum" value="${pageNum }" />
				<input type="hidden" name="reply_no" value="${reply_no }" />
				
				<input type="text" style="width: 500px; margin: 10px 0px;" id="reply_content" name="reply_content" placeholder="내용을 입력해주세요" /><br>
				<input id="cancel" type="button" value="취소" /> 
				<input type="submit" value="등록" />
			</form>
			<p><span id="spanInputLength">0</span>/200</p>
			

		</div>
	</center>
</body>
</html>