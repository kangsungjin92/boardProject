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

$(function(){
	
	var value = $('#content').val().length;
	$('#spanLength').text(value);

	
	
	
	
	var pageNum = ${pageNum};
	var board_no = ${content.board_no};
	
	
	$('#board_writer').bind('propertychange change click keyup input paste', function(){
		var inputLength = $(this).val().length;
		var board_writer = $(this).val();
		if(inputLength > 20){
			var value = board_writer.substring(0,20);
			alert('이름은 최대 20글자입니다.');
			$('#board_writer').val(value);
		}
	});
	
	$('#toContent').click(function(){
		location.href="/jin/getContent.do?pageNum="+ pageNum+"&board_no="+board_no;
	});
	
	$('#toList').click(function(){
		location.href="/jin/board.do?pageNum="+pageNum;
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
		
		$('#spanLength').text(inputLength);
		
		if(inputLength>300){
			var value = content.substring(0,300);
			alert('내용은 최대 300글자입니다.');
			$('#content').val(value);
			$('#spanLength').text('300');
		}
	});
	
});

function check(){
	var title = $('#title').val().trim();
	var content = $('#content').val().trim();
	
	if(title==''){
		alert('제목은 빈칸일수 없습니다');
		$('#title').focus();
		return false;
	}
	
	if(content == ''){
		alert('내용은 빈칸일수 없습니다');
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
			<form action="/jin/modifyProc.do" method="post" onsubmit="return check();">
				<input type="hidden" name="board_no" value="${content.board_no }" />
				<input type="hidden" name="pageNum" value="${pageNum }" />
				<input type="text" style="width: 400px; margin: 10px 0px;" id="title" name="board_title" value="<c:out value="${content.board_title }" escapeXml="true" />" />
				<input type="text" style="width: 100px; margin: 2px 0px 2px 0px;" id="board_writer" name="board_writer" value="<c:out value="${content.board_writer }" escapeXml = "true" />" /><br>
				<textarea class="textarea" id="content" name="board_content" style="width: 500px; min-height: 200px; resize : none;"><c:out value="${content.board_content }" escapeXml="true" /></textarea><br> 
				<p>내용 글자수 : <span id="spanLength">0</span>/300</p><br>
				<input id="toContent" type="button" value="취소" />
				<input type="submit" value="수정완료" />
				<input id="toList" type="button" value="목록으로" />
			</form>
			

		</div>
	</center>
</body>
</html>