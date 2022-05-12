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
	flex-wrap: wrap;
	border-bottom: solid 1px #999;
}
.user-container-content:hover{
	background: linear-gradient(0deg, rgba(2,0,36,1) 0%, rgba(13,40,38,1) 50%, rgba(0,0,0,1) 100%);
}

.user-content-title{
width: 80%;
    margin-left: 3%; 
}
.user-content-freetitle{
width: 80%;
    margin-left: 3%; 
}
.user-content-title h5, .user-content-freetitle h5{font-size: 1.4rem;}
.user-content-recommend{width : 17%;}
.user-content-freerecommend{width : 17%;}
.user-content-movie{width : 40%;margin-left: 4%; }
.user-content-freemovie{width : 74%;margin-left: 4%; }
.user-content-score{width : 34%;}
.user-content-gendate{width : 22%;}
.user-container-content div{display : inline-block;}
.user-container-content h5{
margin : 0;
display : inline;
}
.user-content-title h5, .user-content-movie h5, .user-content-gendate h5, .user-content-recommend h5, 
.user-content-freetitle h5, .user-content-freemovie h5, .user-content-freerecommend h5{
	overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
	font-weight: 400;
}


.star-rating, .star-rating > * {
    height: 1.7rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 1.6rem auto;		/* 별점 너비는 1.6rem*/
    background-position: 0 -1.7rem;
    background-repeat: repeat-x; 
    width: 8rem;
    display: inline-block;
}
 
.star-rating > * {
    background-position: 0 0;
    max-width:8rem; 
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
			
			if(window.innerWidth>900){   //폰트 리사이징
				$(".bigMovieTitle").css("fontSize", "7rem").css("line-height", "8rem")
			}else if(window.innerWidth>750){
				$(".bigMovieTitle").css("fontSize", "6rem").css("line-height", "7rem")
			}else if(window.innerWidth>550){
				$(".bigMovieTitle").css("fontSize", "5rem").css("line-height", "6rem")
			}else if(window.innerWidth>350){
				$(".bigMovieTitle").css("fontSize", "3rem").css("line-height", "5rem")
			}
			
		}
		windowResize();

		window.addEventListener('resize', throttle(function() {
			windowResize();

			  }, 200), true);										//윈도우 사이즈 변경때마다 리사이징 실행 - throttle


			  
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
		    	$(".userReview .user-container-content").each(function(i, e){
				if(!!data[i]){
	    			$(e).data("reviewId",data[i].seq);
	    			$(e).children(".user-content-movie").data("movieId", data[i].movie_id);
	    			$(e).children(".user-content-title").html("<h5>"+data[i].title+"</h5>");
	    			$(e).children(".user-content-recommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
	    			$(e).children(".user-content-movie").html("<h5>"+data[i].movie_id+"</h5>");
	    			$(e).children(".user-content-score").html("<span class='star-rating'></span>");
	    			$(e).find(".star-rating").data("score",data[i].b_score);
	    			var date = new Date(data[i].regdate);
	    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
	    			}else{
	    				$(e).removeClass("user-container-content");
	    			}
			});
    			$('.userReview .star-rating').generateStars();		//별점생성함수 호출
    			movieData('userReview');
			}
		,
		error: function(request, status, error){
			console.log(request, status, error)
		}
	})
			$.ajax({							//추천게시글정보 받아오기
			url: `/movie/freeboardListRecommend`,
			dataType : 'json',
			contentType : 'application/json', 
			success: function(data){
		    	$(".userFree .user-container-content").each(function(i, e){
				if(!!data[i]){
	    			$(e).data("reviewId",data[i].seq);
	    			$(e).children(".user-content-freetitle").html("<h5>"+data[i].title+"</h5>");
	    			$(e).children(".user-content-freerecommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
	    			$(e).children(".user-content-freemovie").html("<h5>"+data[i].movie_id+"</h5>");
	    			var date = new Date(data[i].regdate);
	    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
	    			}else{
	    				$(e).removeClass("user-container-content");
	    			}
			});
			}
		,
		error: function(request, status, error){
			console.log(request, status, error)
		}
	})
	
	
	
		$(document).on("click", ".userReview .user-container-content", function(e){			//리뷰 링크 연결
		let seq = $(e.currentTarget).data("reviewId");
		if(!!seq){
			location.href = '/movie/boardDetail?seq='+seq+'&searchType=Wr&bKeyword=&curPage=1&range=1';
		   
		}
	})
		$(document).on("click", ".userFree .user-container-content", function(e){			//게시글 링크 연결
		let seq = $(e.currentTarget).data("reviewId");
		if(!!seq){
			location.href = '/movie/freeboardDetail?seq='+seq+'&searchType=Wr&bKeyword=&curPage=1&range=1';
		   
		}
	})
	
	
	
		var starSize=1.6;
	$.fn.generateStars = function() {			//별점생성함수 - 크기는 1.6rem
    	return this.each(function(i,e){
    		let score = $(e).data("score")
    		$(e).html($('<span/>').width(score*starSize/2+'rem'));
  			$(e)[0].dataset.score = score;
    	});
    	}	
	function movieData(containerClass){			//movieId로부터 영화제목 가져오기
		$("."+containerClass+" .user-content-movie h5").each(function(i, e){
			var movieId = $(e).html()
			$.ajax({	
	        	type: 'GET',
	        	url: `/movie/getMovieData?movieId=`+movieId+`&language=<%=language %>`,
	        	dataType : 'json',
	        	contentType : 'application/json', 
	        	success: function(data){
	        			$(e).html(data.title);	
	        	}
	        
	        	,
	        	error: function(request, status, error){
	        		console.log(request, status, error)
	        	}
	        })
		
		})
		}
    	
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
	<div class="seeMoreBoard-container"><h3 class="seeMoreBoard">추천리뷰</h3><h5 class="seeMoreBoardLink" OnClick="location.href ='boardRecommendList'">더 보기 >></h5></div>
	<div class="board userReview">
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>		
	</div>
	</div>
	<div class="board-container">
	<div class="seeMoreBoard-container"><h3 class="seeMoreBoard">추천글</h3><h5 class="seeMoreBoardLink" OnClick="location.href ='freeboardRecommendList'">더 보기 >></h5></div>
	<div class="board userFree">
	<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
	<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
	<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
	<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
	<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
	<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
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
	
<jsp:include page="./common/footer.jsp">  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  
</body>
</html>
