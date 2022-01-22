<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		var board_no = ${content.board_no};
		
		
		$('#toList').click(function(){
			location.href="/jin/board.do?pageNum=1";
		});
		
		$('.passWordSpan').css({
			'display' : 'none'
		});

		
		
		$('#title').bind("propertychange change click keyup input paste", function(){
			var inputLength = $(this).val().length;
			var title = $('#title').val();
			if(inputLength>100){
				var value = title.substring(0,100);
				alert('제목은 100글자를 넘길 수 없습니다');
				$('#title').val(value);
			}
		});
		
		$('#board_writer').bind('propertychange change click keyup input paste', function(){
			var inputLength = $(this).val().length;
			var board_writer = $(this).val();
			if(inputLength > 20){
				var value = board_writer.substring(0,20);
				alert('이름은 최대 20글자입니다.');
				$('#board_writer').val(value);
			}
		});
		
		$('#cancel').click(function(){
			location.href = '/jin/getContent.do?pageNum='+pageNum+'&board_no='+board_no;
		});

		
		$('#content').bind("propertychange change click keyup input paste", function(){
			var inputLength = $(this).val().length;
			var content = $('#content').val();
			$('#spanInputLength').text(inputLength);
			if(inputLength>300){
				var value = content.substring(0,300);
				alert('글자수는 300글자를 넘을 수 없습니다');
				$('#content').val(value);
				$('#spanInputLength').text('300');
			}
		});

		
		$('#password').bind("propertychange change click keyup input paste", function(){
			var inputLength = $(this).val().length;
			var password = $('#password').val();
			if(inputLength >100){
				var value = password.substring(0,100);
				alert('비밀번호는 100글자를 넘을 수 없습니다');
				$('#password').val(value);
			}
		});
		

		
		
		$('#password').bind("propertychange change click keyup input paste", function(){
			$('#passwordValiChk').css({
				'display' : 'none'
			});
			var password = $('#password').val().trim();
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
		});
		
		
		
		
		
		
		
		autosize($('.textarea'));
		
	});
	
	
	
	//validation
	function check(){
		
		if(!confirm('비밀번호는 변경하실 수 없습니다. 계속하시겠습니까?')){
			return false;
		}
		//공백 체크
		var title = $('#title').val().trim();
		var content = $('#content').val().trim();
		if(title == ''){
			alert('제목이 존재하지 않습니다');
			$('#title').val('');
			$('#title').focus();
			return false;
		}else if(content == ''){
			alert('내용은 빈칸일 수 없습니다');
			$('#content').val('');
			$('#content').focus();
			return false;
		}
		
		
		var name = $('#board_writer').val().trim();
		if(name==''){
			alert('이름은 빈칸일 수 없습니다');
			$('#board_writer').focus();
			return false;
		}
		
		name = $('#board_writer').val();
		if(name.length>20){
			alert('이름은 최대 20글자입니다.');
			$('#board_writer').val('');
			$('#board_writer').focus();
			return false;
		}
		
		//비밀번호 유효성 검사
		var password = $('#password').val();
		var reg = new RegExp('^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,100}$');
		if(!reg.test(password)){
			alert('유효한 비밀번호가 아닙니다(영문, 숫자, 특수 기호 조합으로 8글자 이상 100글자 이하)');
			$('#password').val('');
			return false;
		}
		
		
		//비밀번호 길이
		var inputLength = $('#password').val().length;
		if(inputLength<8){
			alert('비밀번호는 8글자 이상입니다');
			return false;
		}else if(inputLength >100){
			alert('비밀번호는 100글자 이하입니다');
			return false;
			}
		
		
		//비밀번호 일치여부
		var password = $('#password').val().trim();
		var passwordChk = $('#passwordChk').val().trim();
		if(password != passwordChk){
			alert('비밀번호가 일치하지 않습니다');
			$('#passwordChk').val('');
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
			<form action="/jin/boardReplyProc.do" method="post" onsubmit="return check();">
				<input type="hidden" name="board_no" value="${content.board_no }"/>
				<input type="hidden" name="pageNum" value="${pageNum }" />
				<input type="text" style="width: 400px; margin: 10px 0px;" id="title" name="board_title" placeholder="제목을 입력해주세요" />
				<input type="text" style="width:100px;" id="board_writer" name="board_writer" placeholder="이름을 입력해주세요" /><br>
				<textarea class="textarea" id="content" name="board_content" style="width: 500px; min-height: 200px; resize : none;"placeholder="내용을 입력해주세요"></textarea><br> 
				<input type="password" style="width: 300px;" id="password"name="board_password" placeholder="비밀번호는 영문, 숫자, 특수 문자가 포함된 8글자 ~ 100글자로 구성되어야합니다." /><br>
				<span id="passwordValiChk" class="passWordSpan"></span><br>
				<input type="hidden" name="reply" value="n" />
				<input id="cancel" type="button" value="취소" /> 
				<input type="submit" value="등록" />
				<input id="toList" type="button" value="목록으로" />
			</form>
			<p><span id="spanInputLength">0</span>/300</p>
		</div>
	</center>
</body>
</html>