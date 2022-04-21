<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html lang="en">

<%
String searchMode =request.getParameter("searchMode");
String query =request.getParameter("query");
String language =request.getParameter("language");


%>


<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GeekMovieFinder</title>
<link	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">

<style>
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);

body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}

#credit{
	margin: 0 auto;
	max-width : 1400px;
	min-width : 620px;
}



</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/throttle.js"></script>
<script>
	$(document).ready(function() {
			
		var colorMap = new Map([[28,["#44c76750","#18ab2950", "#ffffff", "#2f6627"]],	//genreColorMap
			[12, ["#7892c250","#4e609650", "#ffffff", "#283966"]],
			[16, ["#33bdef50","#057fd050", "#ffffff","#5b6178"]],
			[35, ["#dbe6c450","#b2b8ad50", "#ffffff", "#ced9bf"]],
			[80, ["#f2453750","#d0271850", "#ffffff", "#810e05"]],
			[99, ["#ffffff50","#dcdcdc50", "ffffff", "#ffffff"]],
			[18, ["#e4685d50","#ffffff50", "#ffffff", "#b23e35"]],
			[10751, ["#ffec6450","#ffaa2250", "#ffffff", "#ffee66"]],
			[14, ["#599bb350","#29668f50", "#ffffff", "#3d768a"]],
			[36, ["#2dabf950","#0b0e0750", "#ffffff", "#263666"]],
			[27, ["#d0451b50","#94291150", "#ffffff", "#854629"]],
			[10402, ["#ededed50","#d6bcd650", "ffffff", "#e1e2ed"]],
			[9648, ["#2e466e50","#1f2f4750", "#ffffff", "#263666"]],
			[10749, ["#79bbff50","#337bc450", "#ffffff", "#5b8a3c"]],
			[878, ["#5d53ed50","#84bbf350", "#ffffff", "#2a67a3"]],
			[10770, ["#7d5d3b50","#54381e50", "#ffffff", "#4d3534"]],
			[53, ["#fc8d8350","#d8352650", "#ffffff", "#b23e35"]],
			[10752, ["#768d8750","#56696350", "#ffffff", "#2b665e"]],
			[37, ["#77b55a50","#4b8f2950", "#ffffff", "#5b8a3c"]]]);  
		
		console.log('<%=searchMode %>')
		console.log('<%=language %>')
		console.log('<%=query %>')
		
		var windowResize = function(){					//리사이징 함수
			//리사이징 할거
		}
		
		windowResize();
		var ResizeTimer;
		window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
			 windowResize();
		}, 20), true);	
		
	
  	
		
		

        
		
	})
</script>




</head>

<body>
	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  



		<div class="movies-container">
			<div class="movies-innerContainer">
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
				<div class="movie-container"><div class="movie"></div></div>
			</div>
		</div>



</body>
</html>
