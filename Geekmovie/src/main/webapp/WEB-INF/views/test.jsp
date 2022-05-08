<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reply Test</title>

<script type="text/javascript">
	
	var seq = 85;
	getReplise();
	
	function getReplise() {
		
		$.getJSON("${path}/replies/all/"+seq, function(data)) {
			console.log(data);
			var str = "";
			
			$(data).each(function() {
				str += ""
			});
		}
		
	}
	
</script>


</head>
<body>
	<h1>댓글작성</h1>
	<form method="post">
		<input id="newReplyText" type="text" placeholder="댓글입력">
		<input id="newReplyWriter" type="text" placeholder="작성자">
		<input type="button" value="저장">
	</form>
	
</body>
</html>