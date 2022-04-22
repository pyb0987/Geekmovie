<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>BoardList</title>
</head>
<body>
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
	<a href="boardCreate">게시글 작성</a>
</body>
</html>