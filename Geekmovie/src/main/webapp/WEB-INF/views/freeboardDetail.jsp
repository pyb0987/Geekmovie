<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.geekmovie.board.vo.FreeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<% FreeVo data = (FreeVo)request.getAttribute("data"); %>
<% String wr = data.getWriter(); %>
<% String id = (String)session.getAttribute("id");
Timestamp gendate = data.getRegdate();
String formattedgenDate = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss").format(gendate);

String language = "ko-KR";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GeekBoardDetail</title>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>


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

document.querySelector("#f_modify").onclick = function(){
	if('${sessionScope.id}'!='${data.writer}'){
		var result = confirm("작성자만 이용하실 수 있습니다.");
		if(result){
		    location.href = 'freeboardDetail?seq=${data.seq}';
		}
	}else{
		location.href = 'freeboardUpdate?seq=${data.seq}';
	}
};

var windowResize = function(){					//리사이징 함수

	fontResize()
	
}

windowResize();
var ResizeTimer;
window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
	 windowResize();
}, 20), true);	

}

document.querySelector(".toListButton").addEventListener('click', function(){
	if('${recommend}'=='true'){
		location.href="freeboardRecommendList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}"
	}else{		
		location.href="freeboardList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}"
	}
 })


</script>
<style>

body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}
	.BoardHeader h1 {
		padding-left : 50px;
		margin : 30px;
		color : black;
	}
	
.BoardContainer{
width : 80%;
margin : 0 auto;
top : 3rem;
}	
	.BoardWrap {
    border-radius: 10px;
    padding: 50px;
    background-color: white;
	}
	.BoardHeader {
		border-top: 3px solid red;
	}
	.Boardbody{
		display : grid;
		grid-template-columns: repeat(5, auto);
	}
		#spacing{
	position : relative;
	width : 100%;
	height: 100px;
	}
	.Detail-body-header{
display : flex;
justify-content: space-between;
grid-column: 1 / 6;
}
.movieLikes, .movieWatchCount{
    text-align: end;
}
.movieName{
	cursor : pointer;
}
.movieName:hover{
	color : #f2f5dccc;
}

.movieScore{
    display: flex;
    align-items: center;
    justify-content: space-around;
}

.movieContent{
grid-column: 1 / 6;
    margin: 3% 0;
    padding: 0 2%;
     border: solid 2px #444;
    border-radius: 10px;
min-height : 500px;
}

.movieContent h5{
	    font-weight: 400;
	    color : black;
}
.BoardDate{
grid-column: 1 / 3;
}
.BoardColored{
background-color: #555;
box-sizing : border-box;
padding: 0 10px;
    border: 1px solid black;
    margin: 1px;
}
.BoardColored h5, .BoardColored h4{
font-weight : 400;
color: #f2f5dc;
}

.toList{
    text-align: center;
	grid-column: 5 / 6;
	grid-row: 5 / 6;
}
.toList a{
    text-decoration: none;
}
.toList:hover h4{
	color : #f2f5dccc;
}
.writer{
display : flex;
    justify-content: space-evenly;
    align-items: center;
}

.like-dislike{
	grid-column: 3 / span 2;
	display : flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 20px; 
	
}

.like-dislike-button{
	width: 8rem;
    height: 4rem;
    margin: 0.7rem;
    padding: 0.1rem;
	border-radius: 0.6rem;
	display: flex;
	align-items: center;
	justify-content: space-around;
	border : solid 3px skyblue;
	position: relative;
	background-color:white;
	transition: all 0.3s;
	cursor : pointer;
}

.like-dislike-button:hover{
  background: skyblue;
  border : solid 3px white;
}

.like-dislike-button.active{
  background: skyblue;
  border : solid 3px white;
}

.like-dislike-button:active{
  background: rgb(219, 228, 231);
}
.like-icon{
	width: 50%;
	height: 50%;
	object-fit: contain;
}
.dislike-icon{
	width: 50%;
	height: 50%;
	object-fit: contain;
}

.likedislike{
justify-content: center;
}

.writer button, input{
	border: none;
    background: none;
    color : #f2f5dc;
}
#f_delete h5 input{
 font-size : 1rem;
}

.writer button:hover h5, input:hover{
	color : #f2f5dccc;
}
.listHeader {
		width : 80%;
		margin : auto;
		margin-bottom : 50px;
		border-bottom : 3px solid red;
}

</style>
</head>
<body>
	<jsp:include page="./common/header.jsp">
		<jsp:param name="session"
			value='<%=(String) session.getAttribute("UserVo")%>' />
		<jsp:param name="language" value="${language}" />
	</jsp:include>

	<div id="spacing"></div>
		<div class="listHeader">
			<h1>게시글 보기</h1>
		</div>
	
	<div class="BoardContainer">
		<div class="BoardWrap">
			<div class="BoardHeader">
				<h1>${data.title}</h1>
			</div>

			<div class="Boardbody">
				<div class="Detail-body-header BoardColored">
					<h4>작성자 : ${data.writer}</h4>
					<h4 class="movieName"></h4>
				</div>
				<div class="BoardColored BoardDate">
					<h5><%=formattedgenDate%></h5>
				</div>
				<div class="movieScore BoardColored">
					<h5>영화태그 : ${data.movie_id}</h5>
				</div>
				<div class="BoardColored">
					<h5 class="movieWatchCount">조회수 : ${data.cnt}</h5>
				</div>
				<div class="BoardColored">
					<h5 class="movieLikes">좋아요 : ${data.likes}</h5>
				</div>

				<div class="movieContent">
					<h5>${data.contents}</h5>
				</div>

				<div class="Detail-body-header likedislike">
					<div class="like-dislike">
						<div class="like-button like-dislike-button">
							<span class="like-button-span like-dislike-button-span">${data.likes}</span><img
								class="like-icon" src="${path}/resources/img/like.png">
						</div>
						<div class="dislike-button like-dislike-button">
							<span class="dislike-button-span like-dislike-button-span">${data.likes}</span><img
								class="dislike-icon" src="${path}/resources/img/dislike.png">
						</div>
					</div>
				</div>
				<div class="BoardColored toList">
					<a class="toListButton"><h4>목록</h4></a>
				</div>



				<%
				if (id != null && id.equals(wr)) {
				%>
				<div class="BoardColored writer">
					<button id="f_modify">
						<h5>게시글 수정</h5>
					</button>
				</div>
				<div class="BoardColored writer">
					<form name='deleteform' id="f_delete" action="boardDelete"
						method="post">
						<input type="hidden" name="seq" value="${data.seq}" />
						<h5>
							<input type="button" value="삭제" onclick="deleteCheck();">
						</h5>
					</form>
					<%} %>
				</div>
			</div>
		</div>
	</div>
	<div id="comments-container"></div>

	<div class="spacing" style="height: 200px"></div>
</body>
</html>