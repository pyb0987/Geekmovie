<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
<title>boardUpdate</title>
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
	    $('.movieScore .star-box').CreateGiveStars(${data.b_score});
	  
	        
	  $.ajax({							//받아온 영화 정보 디테일로 만들기
	type: 'GET',
	url: `/movie/getMovieData?movieId=${data.movie_id}&language=<%=language %>`,
	dataType : 'json',
	contentType : 'application/json', 
	success: function(data){
		let str1;
		let str2;
		if(!!data.backdrop_path){
		str1 = 'https://image.tmdb.org/t/p/original/'+data.backdrop_path ;			//백드랍 이미지
		}else{        		
			str1 = '${path}/resources/img/wall.jpg' ;	
		}

		   		
		$("#detail-bigPicture").css({"background":'linear-gradient(to bottom,rgba(0,0,0,0) 80%,rgba(0,0,0,0) 90%,rgba(0,0,0,1) 100%), url('+ str1 +')', "background-repeat": "no-repeat", "background-size": "cover"});   //배경화면 및 그라데이션 

		
	   	$(".movieName").html("영화 제목 : "+data.title);
	   	
		return false;
	}
	,
	error: function(request, status, error){
		console.log(request, status, error)
	}
	
})     
	        
	        
	        
	        
	        
	        
	}
	
	
	
</script>
<style>
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
	}
.BoardWrap {
		top : 3rem;
		width : 70%;
		margin : 0 auto;
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
    border-left: double 7px brown;
    border-right: double 7px brown;
min-height : 500px;
}

.movieContent h5{
	    font-weight: 400;
}

.BoardColored{
background-color: #696565;
border : 1px solid black;
box-sizing : border-box;
padding: 0 10px;
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
background-color: #eee;
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
	#detail-bigPictureContainer{
	position : relative;
	width : 100%;
	padding-bottom : 25%;
	}
	
	#detail-bigPicture { /*detail 맨위 배경화면 */
	position: absolute;
	width: 100%;
	height : 100%;
	
}
#titleId-container{
position : relative;
width : 70%;
height: 2rem;
}

#titleId{
    font-size: 1.4rem;
    width: 100%;
    height: 120%;
    color : black;
    box-sizing: border-box;
}
.writer a h5{
    text-decoration: none;
    color : #f2f5dc;
}

.writer a:hover h5{
	color : #f2f5dccc;
}
</style>
</head>
<body>
<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language %>"/>  
</jsp:include>  
	<div id="detail-bigPictureContainer">
	<div id="detail-bigPicture"></div></div>
<div id="wrap">
	<form name="bCreateForm" method="post" onsubmit="return checkValue()">
	<div class="BoardWrap">
	<div class="BoardHeader">
			<h1>게시글 수정</h1>
	</div>
	
	<div class="Boardbody">
	<div class="Detail-body-header BoardColored">
	<h4>글 제목 : &nbsp;</h4><div id="titleId-container"><input id="titleId" type="text" name="title" placeholder="제목을 입력해주세요" value="${data.title}"><input type="hidden" id="MovieId" name="movie_id" value="${data.movie_id}"><input type="hidden" id="movieScoreInput" name="b_score" value="${data.b_score}"></div>
	</div>
	<div class="Detail-body-header BoardColored">
	<h4 class="movieName"></h4><div id="SearchId-container"></div>

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
	<h5><textarea id="bContent" name="contents" rows="4" cols="50" placeholder="내용을 작성해주세요">${data.contents}</textarea></h5>
	</div>

	<div class="BoardColored toList">
	<h4><a href="boardList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">목록</a></h4>
	</div>	
		<div class="BoardColored writer">
		<h5><input type="submit" value="게시글 수정"></h5>
		<a href="/movie/boardDetail?seq=${data.seq}&searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}"><h5>취소</h5></a>
		</div>
	</div>
	</div>
	</form>
	</div>

<div class="spacing" style="height:200px"></div>

	

</body>
</html>