<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>freeboardUpdate.jsp</title>

<script type="text/javascript">

	function deleteCheck(){
		console.log("delete");
		if('${sessionScope.id}'=='${data.writer}'){
			var result = confirm("삭제하면 복구할 수 없습니다. \n 그래도 삭제 하시겠습니까?");
			if(result){
			    var deleteform = document.deleteform;
			    deleteform.submit();
			}
		}
	};
</script>

</head>
<body>
<h1>게시글 수정</h1>
	<form method="post">
		<p>제목 : <input type="text" name="title" value="${data.title}"></p>
		<p>영화태그 : <input type="text" name="movie_id" value="${data.movie_id}"/></p>
		<p>작성자 : ${data.writer}</p>
		<p>내용 : <textarea id="fContent" name="contents" rows="4" cols="50" >${data.contents}</textarea></p>
		<p><input type="submit" value="수정하기"></p>
	</form>
	<form name='deleteform' action="freeboardDelete" method="post">
			<input type="hidden" name="seq" value="${data.seq}" />
			<input type="button" value="삭제" onclick="deleteCheck();" >
	</form>
	<a href="/movie/freeboardList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">목록</a>
	<a href="/movie/freeboardDetail?seq=${data.seq}&searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">취소</a>
</body>
</html>