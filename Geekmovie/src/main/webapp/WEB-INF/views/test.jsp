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
	<h1>댓글목록</h1>
	<ul>
		<li>
			<div>
				<p>댓글 작성자1</p>
				<p>첫 댓</p>
			</div>
		</li>
		<li>
			<div>
				<p>댓글 작성자2</p>
				<p>두번째</p>
			</div>
		</li>
		<li>
			<div>
				<p>댓글 작성자3</p>
				<p>세번째</p>
			</div>
		</li>
	</ul>	
	<div>
		<p>
			<label>댓글 작성자</label> <input type="text">
		</p>
		<p>
			<textarea rows="5" cols="50"></textarea>
		</p>
		<p>
			<button type="button">작성</button>
		</p>
	</div>
	
</body>
</html>