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
		
		
		$('#reply_writer').bind("propertychange change click keyup input paste", function(){
			var inputLength = $('#reply_writer').val().length;
			var writer = $('#reply_writer').val();
			if(inputLength>20){
				var value = writer.substring(0,20);
				alert('이름은 최대 20글자입니다.');
				$('#reply_writer').val(value);
			}
		});
	
	
		$('#reply_content').bind("propertychange change click keyup input paste", function(){
			var inputLength = $(this).val().length;
			var content = $('#reply_content').val();
			
			$('#spanInputLength').text(inputLength);
			
			if(inputLength>50){
				var value = content.substring(0,50);
				alert('댓글은 최대 50글자입니다.');
				$('#reply_content').val(value);
				$('#spanInputLength').text('50');
			}
		});
		
		
		
	});
	
	
	
	//validation
	function check(){
		
		if($('#reply_writer').val().trim()==''){
			alert('작성자는 빈칸일 수 없습니다.');
			$('#reply_writer').focus();
			return;
		}
		
		if($('#reply_writer').val().length>20){
			alert('이름은 최대 20글자입니다.');
			$('#reply_writer').val('');
			$('#reply_writer').focus();
			return;
		}
		
		
		
		
		//공백 체크
		var content = $('#reply_content').val();
		if(content.trim() ==''){
			alert('내용은 빈칸일 수 없습니다.');
			return false;
		}
		
		var length = content.length;
		
		if(length>50){
			alert('최대 50글자입니다');
			$('#reply_content').val('');
			$('#reply_content').focus();
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
				<input id="reply_writer" name="reply_writer" type="text" style="width : 100px;" placeholder="이름을  입력해주세요" value="${vo.reply_writer }"/>
				<input type="text" style="width: 400px; margin: 10px 0px;" id="reply_content" name="reply_content" placeholder="내용을 입력해주세요" value="${vo.reply_content }" /><br>
				<input id="cancel" type="button" value="취소" /> 
				<input type="submit" value="등록" />
			</form>
			<p><span id="spanInputLength">0</span>/50</p>
			

		</div>
	</center>
</body>
</html>