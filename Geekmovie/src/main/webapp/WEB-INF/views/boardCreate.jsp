<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardCreate.jsp</title>

<script type="text/javascript">
	
	function checkValue(){
		console.log("active");
		let nc = document.bCreateForm;
		console.log(nc);
		if(nc.title.value == ""){
			alert("제목을 입력해 주세요");
			nc.title.focus();
			return false;
		}
		if(nc.contents.value == ""){
			alert("내용을 입력해 주세요");
			nc.contents.focus();
			return false;
		}
	}

</script>

</head>
<body>
<h1>게시글 작성</h1>
	<form name="bCreateForm" method="post" onsubmit="return checkValue()">
		<p>제목 : <input type="text" name="title"></p>
		<p>작성자 : <input type="text" value="${sessionScope.id}" name="writer" readonly="readonly"></p>
		<p>내용 : <textarea id="bContent" name="contents" rows="4" cols="50" ></textarea></p>
		<p><input type="submit" value="게시글 작성"></p>
	</form>
</body>
</html>
