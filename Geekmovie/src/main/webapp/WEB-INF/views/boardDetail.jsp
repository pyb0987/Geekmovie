<%@page import="com.geekmovie.board.service.BoardService"%>
<%@page import="com.geekmovie.board.vo.BoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<% BoardVo data = (BoardVo)request.getAttribute("data"); %>
<% String wr = data.getWriter(); %>
<% String id = (String)session.getAttribute("id"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardDetail</title>
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


window.onload = function(){	

document.querySelector("#b_modify").onclick = function(){
	if('${sessionScope.id}'!='${data.writer}'){
		var result = confirm("작성자만 이용하실 수 있습니다.");
		if(result){
		    location.href = 'boardDetail?seq=${data.seq}';
		}
	}else{
		location.href = 'boardUpdate?seq=${data.seq}';
	}
};



}
</script>
</head>
<body>
	<h1>${data.title}</h1>
	<p>작성자 : ${data.writer} | 게시일 :${data.regdate}</p>
	<hr>
	<p>${data.contents} </p>
	<%if(id != null && id.equals(wr)) {%>
		<button id="b_modify">게시글 수정</button>
		
		<form name='deleteform' id="b_delete" action="boardDelete" method="post">
			<input type="hidden" name="seq" value="${data.seq}" />
			<input type="button" value="삭제" onclick="deleteCheck();" >
		</form>
	<%} %>
		
<a href="boardList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">목록</a>
</body>
</html>