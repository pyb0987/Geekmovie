<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardUpdate.jsp</title>
</head>
<body>
<h1>게시글 수정</h1>
	<form method="post">
		<p>제목 : <input type="text" name="title" value="${data.title}"></p>
		<p>작성자 : ${data.writer}</p>
		<p>내용 : <input type="text" name="contents" value="${data.contents}"></p>
		<p><input type="submit" value="수정"></p>
	</form>
	<form action="boardDelete" method="post">
			<input type="hidden" name="seq" value="${data.seq}" />
			<input type="submit" value="삭제">
	</form>
</body>
</html>