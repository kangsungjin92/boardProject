<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
	autosize($('.textarea'));
	
	var pageNum = ${pageNum};
	var board_no = ${content.board_no};
	var reply = '${content.reply}';
	var mother_board_no = $('#mother_board_no');
	$('#toList').click(function(){
		location.href="/jin/board.do?pageNum="+ pageNum;
	});
	
	
	$('#delete').click(function(){
		location.href="/jin/chkPassword.do?pageNum="+pageNum+"&board_no="+board_no+"&reply="+reply;
	});
	
	$('#reply').click(function(){
		location.href="/jin/replyBoard.do?board_no="+board_no+"&pageNum="+pageNum;
	});
	

	
	
	$('#reply_writer').on("propertychange change click keyup input paste", function(){
		var inputLength = $(this).val().length;
		var content = $('#reply_writer').val();
		
		if(inputLength>20){
			var value = content.substring(0,20);
			alert('이름은 최대 20글자입니다.');
			$('#reply_writer').val(value);
		}
	});
	
	
	$('#reply_content').on("propertychange change click keyup input paste", function(){
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
	
	$('#reply_password').bind("propertychange change click keyup input paste", function(){
		var password = $('#reply_password').val();
		var reg = new RegExp('^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,50}$');
		if(reg.test(password)){
			$('#spanPasswordChk').text('사용 가능한 비밀번호입니다.');
			$('#spanPasswordChk').css({
				'color' : 'green',
				'display' : 'block'
			});
		}else{
			$('#spanPasswordChk').text('비밀번호는 공백 제외 8글자 이상 50글자 이하 영문, 숫자, 특수문자를 포함해야합니다');
			$('#spanPasswordChk').css({
				'color' :'red',
				'display' : 'block'
			});
		}
	});

	$('#reply_password').bind("propertychange change click keyup input paste", function(){
		var password = $('#reply_password').val();
		var inputLength = $(this).val().length;
		
		if(inputLength>50){
			var value = password.substring(0,50);
			alert('비밀번호는 최대 50글자입니다.');
			$(this).val(value);
		}
	});


	$('#replyBtn').click(function(){
		var reply_content = $('#reply_content').val();
		var reply_writer = $('#reply_writer').val();
		var reply_password = $('#reply_password').val();
		
		
		if(reply_writer.trim()==''){
			alert('작성자는 빈칸일 수 없습니다');
			$('#reply_writer').focus();
			return;
		}
		
		if(reply_writer.length >20){
			alert('작성자는 최대 20글자입니다.');
			$('#reply_writer').val('');
			$('#reply_writer').focus();
			return;
		}
		
		if(reply_content.trim()==''){
			alert('댓글은 빈칸일 수 없습니다');
			$('#reply_content').focus();
			return;
		}
		
		if(reply_content.length>50){
			alert('댓글은 최대 50글자입니다.');
			$('#reply_content').val('');
			$('#reply_content').focus();
			return;
		}
		
		if(reply_password.trim()==''){
			alert('비밀번호는 빈칸일 수 없습니다');
			$('#reply_password').focus();
			return;
		}
		if(confirm('비밀번호는 변경하실 수 없습니다. 계속하시겠습니까?')){
			location.href="/jin/writeReply.do?pageNum="+pageNum+'&board_no='+board_no+'&reply_content='+reply_content+'&reply_password='+reply_password+"&reply_writer="+reply_writer;
		}else{
			return;
		}
	
	});
	
	
});

</script>
<style>
#wrap {
	position: top
}
.line{
	border-bottom : 1px solid black;
}

.textarea{
	resize:none;
}

#replyTableBody {
	text-align: center;
	vertical-align: middle;
	overflow: hidden;
	text-overflow: ellipsis;
}

</style>
</head>
<body>
	<center>
		<div id="wrap">
			<form action="/jin/modifyContent.do" method="post" >
				<input type="hidden" name="board_no" value="${content.board_no }" />
				<input type="hidden" name="pageNum" value="${pageNum }" />
				
				작성자 : <c:out value="${content.board_writer }" escapeXml = "true" /><br>
				<textarea readonly class="textarea" id="title" style="width : 500px; margin : 0px 0px 2px 0px;" name="board_title" ><c:out value="${content.board_title }" escapeXml="true" /></textarea><br>
				
				<textarea class="textarea" id="content" name="board_content" style=" width: 500px; min-height: 200px;" readonly><c:out value="${content.board_content }" escapeXml="true" /></textarea><br> 
				
				<input id="delete" type="button" id="delete" value="삭제하기" />
				<input id="toList" type="button" value="목록으로" />
				<input id="reply" type="button" value="답글달기" />
				<input type="submit" value="수정하기" />
			</form>
			
			
			<center>
		
			
			<h1>댓글</h1>
			
			 <form>
		 	<input type="text" style="width : 100px" id="reply_writer" name="reply_writer" placeholder="작성자 이름" autocomplete='off'/>
			<input style="width : 250px;" type="text" name="reply_content" id="reply_content" placeholder="댓글은 마음의 창입니다" autocomplete='off'/><br>
			<input style="width : 100px;" type="password" id="reply_password" name="reply_password" placeholder="비밀번호" />
			<br><input type="button" id="replyBtn" value="등록하기 " /><br>
			댓글 글자수 <span id="spanInputLength">0</span>/50<br>
			<span id="spanPasswordChk" style="display:none;"></span>
			</form>
			<table width="1100px" style="text-align:center">
				<thead>
					<tr>
						<td class="line" >내용</td>
						<td class="line" >작성자</td>
						<td class="line" >작성일자</td>
						<td class="line"></td>
						<td class="line"></td>
					</tr>
				</thead>
			
				<tbody id="replyTableBody">
					<c:forEach var="reply" items="${replyList }" >
						<tr>
							<td class="line" width="500" style="text-align : left; white-space : pre;"><c:out value="${reply.reply_content }" escapeXml="true" /></td>
							<td style="white-space : pre; width : 200px;" class="line" id="reply_writer"><c:out value="${reply.reply_writer }" escapeXml="true" /></td>
							<td class="line" width="200"><fmt:formatDate value="${reply.regdate }" type="both" pattern="yyyy-MM-dd"/> </td>
							<td class="line" width="100"><a style="text-decoration : none;color:black;" href="/jin/modifyReply.do?board_no=${content.board_no }&reply_no=${reply.reply_no }&pageNum=${pageNum }">수정</a></td>
							<td class="line" width="100"><a style="text-decoration : none;color:black;" href="/jin/deleteReply.do?board_no=${content.board_no }&reply_no=${reply.reply_no }&pageNum=${pageNum }">삭제</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
	</center>
		</div>
	</center>
</body>
</html>