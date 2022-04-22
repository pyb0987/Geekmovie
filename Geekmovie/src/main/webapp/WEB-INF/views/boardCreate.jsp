<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardCreate.jsp</title>
</head>
<body>
<h1>게시글 작성</h1>
<form method="post">
	<p>제목 : <input type="text" name="title"></p>
	<p>작성자 : <input type="text" name="writer"></p>
	<p>내용 : <input type="text" name="contents"></p>
	<p><input type="submit" value="create"></p>
</form>
</body>
</html>