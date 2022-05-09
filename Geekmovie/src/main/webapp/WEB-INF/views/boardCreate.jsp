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
<title>boardCreate</title>

<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>
<link rel="stylesheet" href="${path}/resources/css/globalModal.css?"/>
<link rel="stylesheet" href="${path}/resources/css/movieSearch.css"/>
<link rel="stylesheet" href="${path}/resources/css/pagination.css?"/>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript" src="${path}/resources/js/InputSearch.js?ver=2"></script>

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
		if(!$("#SearchId").hasClass("movieSelected")){
			alert("영화제목은 필수 값입니다.");
			nc.SearchId.focus();
			return false;
		}
		if(nc.b_score.value<1){
			alert("점수는 필수값입니다.");
			nc.b_score.focus();
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
		
		var starBigSize = 2;
		$.fn.CreateGiveStars = function(number) {			// - 크기는 2rem
		    return this.each(function(i,e){$(e).children(".star-boxFill").width(number*starBigSize/2+'rem')});
		    }

	        $(".movieScore .star").click(function(e){
	            $('.movieScore .star-box').CreateGiveStars(e.target.dataset.score);
	            $('#movieScoreInput').val(e.target.dataset.score);		//여기에 정보 저장하여 나중에 제출
	        })
	    InputSearch("SearchId", "MovieId", "checkImg", "SearchMode", "Searchbutton", "SearchResultsContainer", '<%=language %>', '${path}', null);	  
		
	}
	
</script>
<style type="text/css">
body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}
#wrap{
margin-top: 100px;
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
	grid-template-columns: repeat(4, auto);
}

.toList a{
    text-decoration: none;
    color : #f2f5dc;
}
.toList{
    text-align: center;
	grid-column: 4 / 5;
	grid-row: 5 / 6;
}

.toList:hover a{
	color : #f2f5dccc;
}
.Detail-body-header{
display : flex;
grid-column: 1 / 5;
width : 100%;
align-items: center;
position: relative;
}

.movieLikes, .movieWatchCount{
    text-align: end;
}

.movieScore{
	grid-column: 3 / 5;
    display: flex;
    align-items: center;
    justify-content: space-around;
}

.movieContent{
grid-column: 1 / 5;
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
.writer input{
 cursor : pointer;
}

.writer{
display : flex;
    justify-content: space-evenly;
    align-items: center;
}
.writer button, .writer input, #writerId{
	border: none;
    background: none;
    color : #f2f5dc;
}


.writer button:hover h5, input:hover{
	color : #f2f5dccc;
}

#writerId{
	font-size : 1.4rem;
}

#SearchId, #titleId{
    font-size: 1.4rem;
    width: 100%;
    height: 120%;
    color : black;
    box-sizing: border-box;
}
#bContent{
width : 100%;
height : 500px;
border: none;
}	


.star-box{
    display: flex;
}

.star-box, .star-box .star-boxFill {
    height: 2.2rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 2rem auto;		/* 별점 너비는 1.6rem*/
    background-position: 0 -2.2rem;
    background-repeat: repeat-x; 
    width: 10rem;
}
 
.star-box .star-boxFill {
    background-position: 0 0;
    width: 0;
    max-width:10rem; 
    position: absolute;
}

.star{
    display: block;
    padding: 0;
    margin: 0;
    height: 100%;
    width: 10%;
    z-index: 2;
}

#Searchbutton{
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
}

#Searchimage, #modalExitImage{
	width: 30px;
	height: 30px;
	transform : rotate(0.02deg);	
}
#Searchbutton-container{
    width: 70px;
    height: 40px;
    flex-grow : 0;
}

.movieSelected{
background-color : #ffff88;
}
#checkImg{
right: 0;
top: 0;
position: absolute;
max-width : 30px;
max-height : 30px;
display : none;
}
#checkImg.visualized{display : block;
}
#search-result-more{
text-align: center;
font-size : 1rem;
}
#SearchId-container, #titleId-container{
position : relative;
width : 70%;
height: 2rem;
}
#SearchResultsContainer{
position : absolute;
width : 100%;
    z-index: 2;
border: solid 1px;
    box-sizing: border-box;
}
</style>
</head>
<body>
<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language %>"/>  
</jsp:include>  

	
	
	
	<div id="wrap">
		<div class="BoardContainer">

	<form name="bCreateForm" method="post" onsubmit="return checkValue()">
	<div class="BoardWrap">
	<div class="BoardHeader">
			<h1>게시글 작성</h1>
	</div>
	
	<div class="Boardbody">
	<div class="Detail-body-header BoardColored">
	<h4>글 제목 : &nbsp;</h4><div id="titleId-container"><input id="titleId" type="text" name="title" placeholder="제목을 입력해주세요"></div>
	</div>
	<div class="Detail-body-header BoardColored">
	<h4 class="movieName">영화 제목 : &nbsp;</h4><div id="SearchId-container"><input id="SearchId" type="text" name="search_id" placeholder="영화제목을 입력하세요"><div id="SearchResultsContainer"></div><img id="checkImg" src="${path}/resources/img/check.png" onmouseover="this.style.cursor='pointer'"></div>
		<input type="hidden" id="MovieId" name="movie_id" value="">
		<input type="hidden" id="SearchMode" value="movie">
		<input type="hidden" id="Language" name="language" value="<%=language %>">
		<input type="hidden" id="movieScoreInput" name="b_score" value="0">
	
		
	<div id="Searchbutton-container">
					<div id="Searchbutton" onmouseover="this.style.cursor='pointer'">
							<img id="Searchimage"
								src="${path}/resources/img/searchIcon.png"
								alt="search">
							</div>
						</div>
	</div>
	<div class="BoardColored">
	<h5>작성자 : <input id="writerId" type="text" value="${sessionScope.id}" name="writer" readonly="readonly"></h5>
	</div>
	<div class="BoardColored"></div>
	<div class="movieScore BoardColored">
	<h5>평가 : </h5>
	<div class="star-box">
	<span class="star-boxFill"></span>
	<span class="star" data-score="1"></span>
	<span class="star" data-score="2"></span>
	<span class="star" data-score="3"></span>
	<span class="star" data-score="4"></span>
	<span class="star" data-score="5"></span>
	<span class="star" data-score="6"></span>
	<span class="star" data-score="7"></span>
	<span class="star" data-score="8"></span>
	<span class="star" data-score="9"></span>
	<span class="star" data-score="10"></span>
	</div>
	</div>



	<div class="movieContent">
	<h5><textarea id="bContent" name="contents" rows="4" cols="50" placeholder="내용을 작성해주세요"></textarea></h5>
	</div>

	<div class="BoardColored toList">
	<h4><a href="boardList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">목록</a></h4>
	</div>	
		<div class="BoardColored writer">
		<h5><input type="submit" value="게시글 작성"></h5>
		
	</div>
	</div>
	</div>
	</form>

	</div>


	<div class="modal">
		<div class="modalExit"><img id="modalExitImage" src="${path}/resources/img/x.png" alt="exit"></div>
		<div class="modal-content" title="영화를 선택하세요.">
			<div class="movies-searchContainer">
				<div class="movies-searchInnerContainer-padding">
					<div class="movies-searchInnerContainer"></div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<div class="spacing" style="height:200px"></div>
</body>
</html>
