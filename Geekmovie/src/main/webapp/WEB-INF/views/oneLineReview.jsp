<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$.ajax({							//한줄평 목록반환
	type: 'GET',
	url: `/movie/api/oneLineReview`,
	dataType : 'json',
	contentType : 'application/json', 
	success: function(data){
		console.log(data)
		str ="";
		for(var onelinereview of data){
			str += onelinereview.oneLineReviewId+" "
			str += onelinereview.userId+' '
			str += onelinereview.movieId+' '
			str += onelinereview.comment+' '
			str += onelinereview.likes+' '
			str += onelinereview.score+' '
			str += onelinereview.gendate+'<br>'
			
		}
		$("h2").html(str)
	},
    error: function(request, status, error){
    	console.log(request, status, error)
    }
})

</script>
</head>
<body>
	<h1>한줄평</h1>
	<h2></h2>
	
	
</body>
</html>