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
	$('#toList').click(function(){
		location.href="/jin/board.do?pageNum="+ pageNum;
	});
	
	
	$('#delete').click(function(){
		location.href="/jin/chkPassword.do?pageNum="+pageNum+"&board_no="+board_no+"&reply="+reply;
	});
	
	$('#reply').click(function(){
		location.href="/jin/replyBoard.do?board_no="+board_no+"&pageNum="+pageNum;
	});
	
	$('#replyBtn').click(function(){
		var pageNum = ${pageNum};
		var board_no = ${content.board_no};
		var reply_content = $('#reply_content').val().trim();
		var reply_password = $('#reply_password').val().trim();
		var content = $('#reply_content').val().trim();
		if(content == ''){
			alert('댓글 내용이 없습니다');
			$('#reply_content').focus();
			return;
		}
		
		var inputLength = $(this).val().length;
		var content = $('#reply_content').val();
		if(inputLength > 200){
			alert('내용은 최대 200글자입니다');
			$('#reply_password').val('');
			$('#reply_password').focus();
			return;
		}
		
		var password = $('#reply_password').val().trim();
		var reg = new RegExp('^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,50}$');
		if(reg.test(password)){
			location.href="/jin/writeReply.do?pageNum="+pageNum+'&board_no='+board_no+'&reply_content='+reply_content+'&reply_password='+reply_password;
		}else{
			alert('비밀번호는 영문 숫자 특수문자를 포함해야하며 8글자부터 50글자까지입니다.');
			$('#reply_password').val('');
			$('#reply_password').focus();
			return;
		}
	});
	
	$('#reply_content').keyup(function(){
		var inputLength = $(this).val().length;
		var content = $('#reply_content').val();
		$('#spanInputLength').text(inputLength);
		if(inputLength > 200){
			var reply = content.substring(0,200);
			alert('댓글은 최대 200글자입니다');
			$('#reply_content').val(reply);
			$('#spanInputLength').text(200);
			return;
		}
	});

	$('#reply_password').keyup(function(){
		var password = $('#reply_password').val().trim();
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
				<textarea readonly class="textarea" id="title" style="width : 500px; margin : 10px 0px;" name="board_title" ><c:out value="${content.board_title }" escapeXml="true" /></textarea>
				<%-- <input type="text" readonly style="width: 500px; margin: 10px 0px;" id="title" name="board_title" value="<c:out value="${content.board_title }" escapeXml="true" />" /> <br> --%>
				
				
				<textarea class="textarea" id="content" name="board_content" style=" width: 500px; height: 300px;" readonly><c:out value="${content.board_content }" escapeXml="true" /></textarea><br> 

				
				<input id="delete" type="button" id="delete" value="삭제하기" />
				<input id="toList" type="button" value="목록으로" />
				<!-- <input id="reply" type="button" value="답글달기" />  -->
				<input type="submit" value="수정하기" />
			</form>
			
			
			
			<%-- <div style="width : 600px;">
			<input style="width : 250px;" type="text" name="reply_content" id="reply_content" placeholder="댓글은 마음의 창입니다" />
			<input style="width : 100px;" type="password" id="reply_password" name="reply_password" placeholder="비밀번호" />
			<br>
			<span id="spanInputLength">0</span>/200<br>
			<span id="spanPasswordChk" style="display:none;"></span>
			
			<input type="button" id="replyBtn" value="등록하기 " />
			<h1>댓글</h1>
			<table width="600px" style="text-align:center">
				<thead>
					<tr>
						<td class="line" >내용</td>
						<td class="line" >작성일자</td>
						<td class="line"></td>
						<td class="line"></td>
					</tr>
				</thead>
			
				<tbody id="replyTableBody">
					<c:forEach var="reply" items="${replyList }" >
						<tr>
							<td style="text-align:left;" class="line" width="400" style="text-align : left"><c:out value="${reply.reply_content }" escapeXml="true" /></td>
							<td class="line" width="100"><fmt:formatDate value="${reply.regdate }" type="both" pattern="yyyy-MM-dd"/> </td>
							<td class="line" width="50"><a style="text-decoration : none;color:black;" href="/jin/modifyReply.do?board_no=${content.board_no }&reply_no=${reply.reply_no }&pageNum=${pageNum }">수정</a></td>
							<td class="line" width="50"><a style="text-decoration : none;color:black;" href="/jin/deleteReply.do?board_no=${content.board_no }&reply_no=${reply.reply_no }&pageNum=${pageNum }">삭제</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>

		</div> --%>
	</center>
</body>
</html>