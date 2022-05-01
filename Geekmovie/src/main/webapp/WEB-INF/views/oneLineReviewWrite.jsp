<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GeekLineWrite</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/debounce.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>


<link	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">

<script>
$(document).ready(function(){		
	
	var windowResize = function(){					//리사이징 함수

		fontResize()		
	}
	
	windowResize();
	window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
		 windowResize();
	}, 20), true);	
	
	
	
	
});

</script>

<link	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>


<style>
body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}


</style>
</head>
<body>

</body>
</html>