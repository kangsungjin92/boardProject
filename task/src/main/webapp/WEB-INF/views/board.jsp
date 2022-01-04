<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">


$(function(){
	$('#disconnectSessionBtn').click(function(){
		location.href='/jin/logout.do';
	});//end func
	
	});//end whole function


</script>

<style>
h3 {
	position: relative;
}
</style>
</head>
<body>
	<div id="wrap" width="90%">
		<center>
			<c:choose>
				<c:when test="${id ne null }">
					<h3>${id }님
						환영합니다
						</h3>
				</c:when>
				<c:otherwise>
					<h3>${ip }님
						환영합니다
						</h3>
				</c:otherwise>
			</c:choose>

			<table border="1px solid black" id="boardTable">
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
				</thead>
			</table>
			<input type="button" id="writeBtn" value="새글작성" /> <input
				type="button" id="disconnectSessionBtn" value="세션끊기" />
		</center>
	</div>

</body>
</html>