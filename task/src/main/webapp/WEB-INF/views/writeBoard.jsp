<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script type="text/javascript">

	$(function() {

		var pageNum = ${pageNum};
		$('#cancel').click(function(){
			location.href = '/jin/board.do?pageNum='+pageNum;
		});
		
		
		

		
		$('#title').bind('propertychange change click keyup input paste', function(){
			var inputLength = $(this).val().length;
			var title_content = $(this).val();
			
			if(inputLength>100){
				var content = title_content.substring(0,100);
				alert('제목은 최대 100글자입니다.')
				$('#title').val(content);
				$('#title').focus();
			}
		});
		

	
		$('#content').bind("propertychange change click keyup input paste", function(){
			var inputLength = $(this).val().length;
			var content = $('#content').val();
			
			$('#spanInputLength').text(inputLength);
			
			if(inputLength>300){
				var value = content.substring(0,300);
				alert('내용은 최대 300글자입니다.');
				$('#content').val(value);
				$('#spanInputLength').text('300');
			}
		});
		
		$('#password').bind("propertychange change click keyup input paste", function(){
			var inputLength = $(this).val().length;
			var content = $('#password').val();
			
			$('#passwordValiChk').css({
				'display' : 'none'
			});
			var password = $('#password').val();
			var reg = new RegExp('^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,100}$');
			if(reg.test(password)){
				$('#passwordValiChk').text('사용가능한 비밀번호입니다');
				$('#passwordValiChk').css({
					'color' : 'green',
					'display' : 'inline'
				});
			}else{
				$('#passwordValiChk').text('비밀번호는 공백 제외 8글자 이상, 숫자, 영어, 특수문자를 포함해야합니다');
				$('#passwordValiChk').css({
					'color' : 'red',
					'display' : 'inline'
				});
			}
			
			if(inputLength>100){
				var value = content.substring(0,100);
				alert('글자수는 100글자를 넘을 수 없습니다');
				$('#password').val(value);
			}
		});
	
		

	
		
	});
	
	
	
	//validation
	function check(){
		
		//공백 체크
		var title = $('#title').val().trim();
		var content = $('#content').val().trim();
		if(title == ''){
			alert('제목은 빈칸일 수 없습니다.');
			$('#title').focus();
			return false;
		}else if(content==''){
			alert('내용은 빈칸일 수 없습니다.');
			$('content').focus();
			return false;
		}
		
		//비밀번호 유효성 검사
		var password = $('#password').val();
		var reg = new RegExp('^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,100}$');
		if(!reg.test(password)){
			alert('비밀번호는 영문, 숫자, 특수 문자가 포함된 8글자 ~ 100글자로 구성되어야합니다.');
			$('#password').val('');
			$('#password').focus();
			return false;
		}
		
		
		//비밀번호 길이
		var inputLength = $('#password').val().length;
		if(inputLength<8){
			alert('비밀번호는 8글자 이상입니다');
			$('#password').val('');
			$('#password').focus();
			return false;
		}else if(inputLength >100){
			alert('비밀번호는 100글자 이하입니다');
			$('#password').val('');
			$('#password').focus();
			return false;
			}
		
		
		if(confirm('비밀번호는 변경하실 수 없습니다. 계속하시겠습니까?')){
			return true;
		}else{
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
			<form action="/jin/boardWriteProc.do" method="post" onsubmit="return check();">
				<input type="text" style="width: 400px; margin: 2px 0px 2px 0px;" id="title" name="board_title" placeholder="제목을 입력해주세요" /><input type="text" style="width: 100px; margin: 2px 0px 2px 0px;" id="board_writer" name="board_writer" placeholder="이름을 입력해주세요" /><br>
				<textarea class="textarea" id="content" name="board_content" style="width: 500px; height: 100px; resize : none;"placeholder="내용을 입력해주세요"></textarea><br> 
				<input type="password" style="width: 500px;" id="password"name="board_password" placeholder="비밀번호는 영문, 숫자, 특수 문자가 포함된 8글자 ~ 100글자로 구성되어야합니다." /><br>
				<span id="passwordValiChk" class="passWordSpan"></span><br>
				<input type="hidden" name="reply" value="n" />
				<input id="cancel" type="button" value="목록으로" /> 
				<input type="submit" value="등록" />
			</form>
			<p>내용 글자수 : <span id="spanInputLength">0</span>/300</p>
			

		</div>
	</center>
</body>
</html>