<%@page import="com.geekmovie.board.vo.PageVo"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
PageVo pagination = (PageVo)request.getAttribute("pagination");
	
	int listCnt = pagination.getListCnt(); // 전체 페이지 숫자
	int curPage = pagination.getPage();  // 현재 페이지
	int listSize = pagination.getListSize(); // 페이지당 목록 갯수
	
	int rangeSize = pagination.getRangeSize();
	int range = pagination.getRange();
	int startPage = pagination.getStartPage();
	int endPage = pagination.getEndPage();
	
	boolean prev = pagination.isPrev();
	boolean next = pagination.isNext();
%>

start : <%=startPage %> / end : <%=endPage %> / 현재구간 : <%=range %> / 현재 페이지 : <%=curPage %> / 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardList</title>
</head>
<body>
<!-- List -->
	<table border="1">
		<tr><th>seq</th><th>title</th><th>writer</th><th>regdate</th><th>cnt</th><th>likes</th></tr>
		<c:forEach var="b" items="${data}">
			<tr>
				<td>${b.seq}</td>
				<td><a href="boardDetail?seq=${b.seq }">${b.title}</a></td>
				<td>${b.writer}</td>
				<td>${b.regdate}</td>
				<td>${b.cnt}</td>
				<td>${b.likes}</td>
			</tr>
		</c:forEach>
	</table>
<!-- Page -->
<%if(prev) { %>
<a href="boardList?curPage=<%=startPage - rangeSize%>&range=<%=range -1 %>">[이전<%=rangeSize%>개]</a>
<%} %>
<%for(int i = startPage; i<=endPage; ++i){ %>
<a href="boardList?curPage=<%=i%>&range=<%=range%>">[<%=i%>]</a>
<%} %>
<%if(next) { %>
<a href="boardList?curPage=<%=startPage + rangeSize%>&range=<%=range +1 %>">[다음<%=rangeSize%>개]</a>
<%} %>

<!-- Search -->
	<form>
		<select name="b_search">
			<option value="제목+내용">제목+내용</option>
			<option value="작성자">작성자</option>
			<option value="영화이름">영화이름</option>
		</select>
		<input type="text" placeholder="검색" name="keyword" value="${keyword}" />
		<input type="submit" value="검색">
	</form>
	<a href="boardCreate">게시글 작성</a>
</body>
</html>