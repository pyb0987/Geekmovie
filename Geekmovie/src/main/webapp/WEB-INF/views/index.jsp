<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.geekmovie.user.vo.userVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%
String language = "ko-KR";
%>

<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>

<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GeekMovie</title>

<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>

<style>
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);	/*슬라이드 아이콘*/
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@800&display=swap');	/*함렛 글꼴*/
	
body {
	overflow-x: hidden;
	background-color: #000000;
	margin: 0;
	padding-top : 100px;

}


#userSpace{
 display : flex;
}


.board-container{
display : flex;
flex-direction: column;
width : 50%;
padding : 30px;
align-items: flex-start;
}

.board{
width : 100%;
height : 100%;
border-top : solid 1px white;
display : grid;
flex-grow : 1;
grid-template-rows : repeat(6, 1fr);
}

.seeMoreBoard{
	font-size : 1.6rem;
	display : inline-block;
}

.seeMoreBoardLink{
	color : #f8efc5;
	display : inline-block;
	 white-space : nowrap;
	 width : 0;
	 overflow : hidden;
	 transform : translateY(1.6rem);
	 margin-left : 1rem;
    transition : width 1s;
    cursor:pointer;
}
.seeMoreBoard-container{
	transform: translateX(20px);
	display: inline-block;
	}

.seeMoreBoard-container:hover .seeMoreBoardLink{
		 width : 6rem;	 
}


.user-container-title{
	
	margin: 2.5rem 4rem;
	display : flex;
	justify-content: space-between;
	flex-grow : 0;
}



.user-container-contents{
	border-top : solid 1px white;
	border-bottom : solid 1px white;
}
#user-movieLike-container, #user-movieAdd-container{
	grid-column: 1 / span 2;
}
.user-container-content{
	cursor : pointer;
	display: flex;
	align-items: center;
	height: 80px;
}
.user-container-content:hover{
	background: linear-gradient(0deg, rgba(2,0,36,1) 0%, rgba(13,40,38,1) 50%, rgba(0,0,0,1) 100%);
}


.user-container-content div{
	display : inline-block;
}


</style>
<link rel="stylesheet" href="${path}/resources/css/movieSlide.css?ver=2"/>
<link rel="stylesheet" href="${path}/resources/css/movieBigSlide.css?ver=2"/>
<link rel="stylesheet" href="${path}/resources/css/movieLike.css"/>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/debounce.js"></script>

<script type="text/javascript" src="${path}/resources/js/movieLike.js?ver=3"></script>
<script type="text/javascript" src="${path}/resources/js/movieSlide.js?ver=3"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript" src="${path}/resources/js/movieListAjax.js?ver=1"></script>
<script type="text/javascript" src="${path}/resources/js/movieBigSlide.js?ver=2"></script>

<script>

    
    $(document).ready(function(){			 
    	var language = '<%=language %>'
		


    	const bigMovieSlide = document.querySelector("#movies-BigPictureSlide");
		var bmc = bigMovieController(bigMovieSlide, language);
		bmc.initialSet();
    	
    	
    	
		var windowResize = function(){					//리사이징 함수
			fontResize()		//폰트리사이즈
			
			bmc.adjust();
			movieContainerResize()			//movieSlide.js

			
		}
		windowResize();

		window.addEventListener('resize', throttle(function() {
			windowResize();
			  }, 100), true);										//윈도우 사이즈 변경때마다 리사이징 실행 - throttle

			  
		movieLike('${sessionScope.id}');	//영화좋아요/add 적용 
			  
		
		const TrendMovieContainer = document.querySelector("#trend-movie .movies-container");	
		const PopularMovieContainer = document.querySelector("#popular-movie .movies-container");
		const NowMovieContainer = document.querySelector("#now-movie .movies-container");
		const TopMovieContainer = document.querySelector("#top-movie .movies-container");
		movieSlideController(TrendMovieContainer);					//movieSlide.js
		movieSlideController(PopularMovieContainer);
		movieSlideController(NowMovieContainer);
		movieSlideController(TopMovieContainer);


		

		windowResize();//최초 1회 리사이징 실행		
		
		
		 

		
		$.ajax({							//추천리뷰정보 받아오기
			url: `/movie/boardListRecommend`,
			dataType : 'json',
			contentType : 'application/json', 
			success: function(data){
				console.log(data)
			}
		,
		error: function(request, status, error){
			console.log(request, status, error)
		}
		
	})
		
    	
    	
        movieListAjax('trend-movie', '/movie/getTrendingMovieList?timewindow=day', language);				//TrendMovieList 출력
        movieListAjax('popular-movie', '/movie/getPopularMovieList?page=1&language='+language, language);
		movieListAjax('now-movie', '/movie/getNowPlayingMovieList?page=1&language='+language, language);		//getNowPlayingMovieList 출력
		movieListAjax('top-movie', '/movie/getTopRatedMovieList?page=1&language='+language, language);		
        

		 
		 
        		
    })
    </script>

</head>

<body>
	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  
	
	
	

	<section>
	
	<div id="movies-bigPictureSlide">
	<div class="movies-BigPictureContainer"> 

	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>	
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	<div class="movie-bigPictureContainer"><div class="movie-bigPicture"></div><div class="movie-bigDetail"></div></div>
	</div>
	<div class="movieSlidePrev">&lang;</div>
	<div class="movieSlideNext">&rang;</div>
	</div>
	
	<div class="spacing" style="height : 100px; z-index=-1;"></div>
	<div id="trend-movie">
	<div class="seeMoreMovies-container"><h3 class="seeMoreMovies">일일 추천영화</h3></div>
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
	</div>



	<div id="popular-movie">
		<div class="seeMoreMovies-container"><h3 class="seeMoreMovies">사람들이 많이 보는 영화</h3><h5 class="seeMoreMoviesLink" OnClick="location.href ='/movie/search?searchMode=popularmovie&page=2&language=<%=language %>'">더 보기 >></h5></div>
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
	</div>
	
	
		<div id="userSpace">
	<div class="board-container">
	<div class="seeMoreBoard-container"><h3 class="seeMoreBoard">추천리뷰</h3><h5 class="seeMoreBoardLink" OnClick="location.href ='boardList'">더 보기 >></h5></div>
	<div class="board userReview">
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
			
	</div>
	</div>
	<div class="board-container">
	<div class="seeMoreBoard-container"><h3 class="seeMoreBoard">게시판</h3><h5 class="seeMoreBoardLink" OnClick="location.href ='freeboardList'">더 보기 >></h5></div>
	<div class="board userFree"><div>게시판이 들어갈 곳</div></div>
	</div>

	</div>
	
	
	
	
	
		<div id="now-movie">
		<div class="seeMoreMovies-container"><h3 class="seeMoreMovies">현재 상영중인</h3><h5 class="seeMoreMoviesLink" OnClick="location.href ='/movie/search?searchMode=nowmovie&page=2&language=<%=language %>'">더 보기 >></h5></div>
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
	</div>
	
	
			<div id="top-movie">
		<div class="seeMoreMovies-container"><h3 class="seeMoreMovies">최고의 찬사를 받는</h3><h5 class="seeMoreMoviesLink" OnClick="location.href ='/movie/search?searchMode=topmovie&page=2&language=<%=language %>'">더 보기 >></h5></div>
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
	</div>
	
	</section>
</body>
</html>
