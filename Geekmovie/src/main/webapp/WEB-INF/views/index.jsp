
<%@page import="com.geekmovie.user.vo.userVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
String language = "ko-KR";
%>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GeekMovie</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css"
	rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movieSlide.css?ver=1"/>
<style>
@import
	url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);	/*슬라이드 아이콘*/
	
body {
	overflow-x: hidden;
	background-color: #000000;
	padding-top : 100px;
}


.movie-BigPicture { /*index 맨위 사진-구상중 */
	position: relative;
	width: 100%;
	height: 50%;
	z-index : -1;
}

h1,h3,h5,h6 {
	font-family: 'NanumSquareRoundBold';				/*글꼴*/
	color: #fff;
	}	
h1{font-size : 2.4rem;}
h3{font-size : 1.6rem;}
h5{font-size : 1rem;}







</style>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/debounce.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/movieSlide.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fontResize.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/movieListAjax.js?ver=2"></script>

<script>

    
    $(document).ready(function(){			 
    	var language = '<%=language %>'
		


		var windowResize = function(){					//리사이징 함수
			fontResize()		//폰트리사이즈
			movieContainerResize()			//movieSlide.js
		}
	

		window.addEventListener('resize', throttle(function() {
			windowResize();
			  }, 100), true);										//윈도우 사이즈 변경때마다 리사이징 실행 - throttle

			  
		windowResize();//최초 1회 리사이징 실행		
			  
				
		const TrendMovieContainer = document.querySelector("#trend-movie .movies-container");	
		const PopularMovieContainer = document.querySelector("#popular-movie .movies-container");
		const NowMovieContainer = document.querySelector("#now-movie .movies-container");
		movieSlideController(TrendMovieContainer);					//movieSlide.js
		movieSlideController(PopularMovieContainer);
		movieSlideController(NowMovieContainer);


		
		
		var trendMovieIds = [];
		$.ajax({							//TrendMovieList id만 가져오기
        	type: 'GET',
        	url: '/movie/getTrendingMovieList?timewindow=week',
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		for (var movie of data.results){
        			trendMovieIds.push(movie.id)
        		}
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        })
		
		
    	
    	
        movieListAjax('trend-movie', '/movie/getTrendingMovieList?timewindow=week', language);				//TrendMovieList 출력
        movieListAjax('popular-movie', '/movie/getPopularMovieList?page=1&language='+language, language);
		movieListAjax('now-movie', '/movie/getNowPlayingMovieList?page=1&language='+language, language);		//getNowPlayingMovieList 출력
        

		 
		 
        		
    })
    </script>




</head>

<body>
	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  
	
	
	
	<section>
	
	
	<div class="movie-BigPicture"></div>
	
	
	
	<div id="trend-movie">
	<div class="seeMoreMovies-container"><h3 class="seeMoreMovies">지금 트렌드는</h3></div>
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
	
	</section>
</body>
</html>
