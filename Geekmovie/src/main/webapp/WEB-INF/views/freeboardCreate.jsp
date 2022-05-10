<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%
String id = (String)session.getAttribute("id");
if(id==null){%>
	<script>
		alert('비정상 접근입니다. 로그인 후 이용 바랍니다.');
		document.location.href="/movie";
	</script>
<%}%>
<%
String language = "ko-KR";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GeekFreeBoardCreate</title>
<link
	href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap"
	rel="stylesheet">
<!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css" />
<link rel="stylesheet" href="${path}/resources/css/pagination.css?" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript">
	
	function checkValue(){
		console.log("active");
		let nc = document.fCreateForm;
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

	
	window.onload = function(){	
		
		var windowResize = function(){					//리사이징 함수

			fontResize()
			
		}

		windowResize();
		var ResizeTimer;
		window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
			 windowResize();
		}, 20), true);		
		
		$("#bContent").on("propertychange change keyup paste input", throttle(function(e){			//입력시 한줄평 입력칸의 크기를 100ms마다 바꿈
			$(this).css("height", '500px');
			$(this).height(this.scrollHeight);
		}, 100));
		
		
	}
</script>

<style type="text/css">
body {
	overflow-x: hidden;
	background-color: #000000;
	margin: 0;
	padding-top: 100px;
}

#wrap {
	margin-top: 100px;
}

.BoardHeader h1 {
	padding-left: 50px;
	margin: 30px;
	color: black;
}

.BoardContainer {
	width: 80%;
	margin: 0 auto;
	top: 3rem;
}

.BoardWrap {
	border-radius: 10px;
	padding: 50px;
	background-color: white;
}

.BoardHeader {
	border-top: 3px solid red;
}

.Boardbody {
	display: grid;
	grid-template-columns: repeat(4, auto);
}

.toList a {
	text-decoration: none;
	color: #f2f5dc;
}

.toList {
	text-align: center;
	grid-column: 4/5;
	grid-row: 5/6;
}

.toList:hover a {
	color: #f2f5dccc;
}

.Detail-body-header {
	display: flex;
	grid-column: 1/5;
	width: 100%;
	align-items: center;
	position: relative;
}

.movieLikes, .movieWatchCount {
	text-align: end;
}

.movieContent {
	grid-column: 1/5;
	margin: 3% 0;
	padding: 0 2%;
	border: solid 2px #444;
	border-radius: 10px;
	min-height: 500px;
}

.movieContent h5 {
	font-weight: 400;
	color: black;
}

.BoardColored {
	background-color: #555;
	box-sizing: border-box;
	padding: 0 10px;
	border: 1px solid black;
	margin: 1px;
}

.BoardColored h5, .BoardColored h4 {
	font-weight: 400;
	color: #f2f5dc;
}

.writer input {
	cursor: pointer;
}

.writer {
	display: flex;
	justify-content: space-evenly;
	align-items: center;
}

.writer button, .writer input, #writerId {
	border: none;
	background: none;
	color: #f2f5dc;
}

.writer button:hover h5, input:hover {
	color: #f2f5dccc;
}

#bContent {
	width: 100%;
	height: 500px;
	border: none;
}
#SearchId-container, #titleId-container{
position : relative;
width : 70%;
height: 2rem;
}
#SearchId, #titleId{
    font-size: 1.4rem;
    width: 100%;
    height: 120%;
    color : black;
    box-sizing: border-box;
}
.BoardSpace{
	grid-column: 2/5;
}
</style>
</head>
<body>

	<jsp:include page="./common/header.jsp">
		<jsp:param name="session"
			value='<%=(String)session.getAttribute("UserVo")%>' />
		<jsp:param name="language" value="<%=language %>" />
	</jsp:include>


	<div id="wrap">
		<div class="BoardContainer">
			<form name="fCreateForm" method="post" onsubmit="return checkValue()">
				<div class="BoardWrap">
					<div class="BoardHeader">
						<h1>게시글 작성</h1>
					</div>

					<div class="Boardbody">
						<div class="Detail-body-header BoardColored">
							<h4>글 제목 : &nbsp;</h4>
							<div id="titleId-container">
								<input id="titleId" type="text" name="title"
									placeholder="제목을 입력해주세요">
							</div>
						</div>
						<div class="Detail-body-header BoardColored">
						<h4 class="movieName">태그 : &nbsp;</h4>
						<div id="SearchId-container">
								<input id="SearchId" type="text" name="movie_id" value="자유게시판">
</div>
</div>
							<div class="BoardColored">
								<h5>
									작성자 : <input id="writerId" type="text"
										value="${sessionScope.id}" name="writer" readonly="readonly">
								</h5>
							</div>
							<div class="BoardColored BoardSpace"></div>


							<div class="movieContent">
								<h5>
									<textarea id="bContent" name="contents" rows="4" cols="50"
										placeholder="내용을 작성해주세요"></textarea>
								</h5>
							</div>

							<div class="BoardColored toList">
								<h4>
									<a
										href="freeboardList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">목록</a>
								</h4>
							</div>
							<div class="BoardColored writer">
								<h5>
									<input type="submit" value="게시글 작성">
								</h5>

							</div>
						</div>

				
				</div>
			</form>
		</div>
	</div>

	<div class="spacing" style="height: 200px"></div>
	<jsp:include page="./common/footer.jsp">  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  
</body>
</html>