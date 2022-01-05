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
<script type="text/javascript">
	$(function() {
		var pageNum = ${cri.page};

		$('#writeBtn').click(function(){
			location.href="/jin/boardWrite.do?pageNum="+pageNum;
		});
	});//end whole function
</script>

<style>
h3 {
	position: relative;
}

table {
	border-bottom: 1px solid #d1d1d1;
	width: 50%;
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
	border-color: grey;
}



tbody {
	text-align: center;
	vertical-align: middle;
	overflow: hidden;
	text-overflow: ellipsis;
}
a{
	text-decoration : none;
	color : black;
}
</style>
</head>
<body>
	<div id="wrap" width="90%">
		<center>
			<table border="1px solid black" id="boardTable">
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${boardList ne null }">
							<c:set var="num" value="${boardCnt - (cri.page-1)*cri.perPageNum}" />
							<c:forEach var="board" items="${boardList}">
								<tr>
									<td>${num}</td>
									<td style="text-align : left;"><a href="#">${board.board_title }</a></td>
									<td><fmt:formatDate value="${board.board_regdate }" type="both" pattern="yyyy-MM-dd"/></td>
									<td>${board.viewCnt }</td>
								</tr>
								<c:set var="num" value="${num-1 }" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td>등록된 내용이 없습니다</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div id="pagingDiv" style="display: block; text-align: center;">
				<c:if test="${pm.startPage != 1 }">
					<a
						href="/jin/board.do?pageNum=${pm.startPage - 1 }">&lt;</a>
				</c:if>
				<c:forEach begin="${pm.startPage }"
					end="${pm.endPage }" var="p">
					<c:choose>
						<c:when test="${p == cri.page }">
							<b>${p }</b>
						</c:when>
						<c:when test="${p != cri.page }">
							<a href="/jin/board.do?pageNum=${p }">${p }</a>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:if test="${pm.endPage != pm.tempEndPage}">
					<a
						href="/jin/board.do?pageNum=${pm.endPage+1 }">&gt;</a>
				</c:if>
			</div>
			<input type="button" id="writeBtn" value="새글작성" />
		</center>
	</div>

</body>
</html>