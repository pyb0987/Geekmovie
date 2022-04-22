<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardDetail</title>
</head>
<body>
	<h1>${data.title}</h1>
	<p>작성자 : ${data.writer} | 게시일 :${data.regdate}</p>
	<hr>
	<p>${data.contents} </p>
	<p>
		<a href="boardUpdate?seq=${data.seq}">수정(미구현)</a>
		<form action="boardDelete" method="post">
			<input type="hidden" name="seq" value="${data.seq}" />
			<input type="submit" value="삭제">
		</form>
		<a href="boardList">목록</a>
	</p>
</body>
</html>