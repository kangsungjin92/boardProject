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
		/* $('.tTitle').css({
			'display' : 'inline-block',
			'overflow' : 'hidden',
		  	'text-overflow' : 'ellipsis',
		  	'white-space' : 'nowrap',
		  	'width': '400px',
		  	'height': '20px'
		}); */
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
	text-align: center;
	border-collapse: collapse;
	border-spacing: 0;
	border-color: grey;
	table-layout: fixed;
}



a{
	text-decoration : none;
	color : black;
	cursor : pointer;
}



</style>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

$(function(){
	$('#searchBtn').click(function(){
		var search = $('#search').val().trim();
		if(search==''){
			alert('내용이 없습니다');
			return;
		}
		location.href="/jin/search.do?search="+search;
	});
});
	

</script>
</head>
<body>

		<center>
		<h1><a href="/jin/board.do?pageNum=1">게시판으로..</a></h1>
			<table id="boardTable"  border="1px solid black" id="boardTable">
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
				</thead>
				<tbody id="tablebody">
					<c:choose>
						<c:when test="${boardList ne null }">
							<c:set var="num" value="${boardCnt - (cri.page-1)*cri.perPageNum}" />
							<tbody id="tableBody">
							<c:forEach var="board" items="${boardList}">
								<tr>
									<td>${num}</td>
									
									<c:choose>
									
									
										<c:when test="${board.board_content == ' '}">
											<td class="tTitle" style="text-align : left;color : red">
											<c:if test="${board.depth >0 }">
												<c:forEach begin="1" end="${board.depth }">
													&nbsp;&nbsp;
												</c:forEach>
											</c:if>
										<c:out value="삭제된 게시물입니다.." escapeXml="true" />
											</td>
											<td>
										<c:out value="${board.board_writer }" escapeXml="true" />	
											</td>
											
											<td><fmt:formatDate value="${board.board_regdate }" type="both" pattern="yyyy-MM-dd"/></td>
									<td>${board.viewCnt }</td>
										</c:when>
										
										
										
										<c:otherwise>
										<td class="tTitle" style="width:300px; max-width:300px; overflow: hidden; text-overflow : ellipsis; white-space : pre; text-align : left;"><c:if test="${board.depth >0 }"><c:forEach begin="1" end="${board.depth }">&nbsp;&nbsp;</c:forEach>→</c:if><a href="/jin/getContent.do?board_no=${board.board_no }&pageNum=${cri.page}" ><c:out value="${board.board_title }" escapeXml="true" /> [<span style="color : #ff7f00;">${board.reply_count }</span>]</a></td>
									<td id="tdWriter" style="max-width:80px; overflow: hidden; text-overflow : ellipsis; white-space : nowrap;"><c:out value="${board.board_writer }" escapeXml="true" /></td>
									<td><fmt:formatDate value="${board.board_regdate }" type="both" pattern="yyyy-MM-dd"/></td>
									<td>${board.viewCnt }</td>
										</c:otherwise>
									</c:choose>
								</tr>
								
								<c:set var="num" value="${num-1 }" />
							</c:forEach>
							</tbody>
						</c:when>
						<c:otherwise>
							<tr>
								<td>등록된 내용이 없습니다</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<input type="text" id="search" /><input type="button" value="검색" id="searchBtn" /><br>
			<div id="pagingDiv" style="display: block; text-align: center;">
				<c:if test="${pm.startPage != 1 }">
					<a
						href="/jin/board.do?pageNum=1">&lt;&lt;</a>
				</c:if>
				<c:if test="${pm.startPage != 1 }">
					<a
						href="/jin/board.do?pageNum=${pm.startPage - 1 }">&lt;</a>
				</c:if>
				
				
				
				<c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="p">
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
				<c:if test="${pm.endPage != pm.tempEndPage}">
					<a
						href="/jin/board.do?pageNum=${pm.tempEndPage }">&gt;&gt;</a>
				</c:if>
			</div>
			<input type="button" id="writeBtn" value="새글작성" />
		</center>


</body>
</html>