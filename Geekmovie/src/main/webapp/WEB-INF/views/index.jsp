
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
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css"
	rel="stylesheet">


<style>

@import
	url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);
body {
	overflow-x: hidden;
	background-color: #000000;
	padding-top : 100px;
}


.movie-BigPicture { /*index 맨위 사진-구상중 */
	width: 500px;
	height: 500px;
	border: solid red 1px;
}









</style>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movieHover.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movieSlide.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/debounce.js"></script>

<script>

    
    $(document).ready(function(){			 
		
    	

		
	
		
		let movieContainerWidth;	
		let movieInnerContainerWidth;

    	var movieContainerResize = function() {						//movieContainer 리사이징 함수
		if(window.innerWidth>1050){
			movieWidth=210;
		}else if(window.innerWidth>=800){
		movieWidth = window.innerWidth/5
		}else if(window.innerWidth >=600){
		movieWidth = window.innerWidth/4
		}else{
		movieWidth = window.innerWidth/3
		}
		movieContainerWidth = movieWidth*40-window.innerWidth;	
		movieInnerContainerWidth = movieWidth*20;
		$(".movies-container").width(movieContainerWidth+'px');
		$(".movies-container").offset({left:-movieWidth*20+window.innerWidth});
		$(".movies-innerContainer").width(movieInnerContainerWidth);
		$(".movies-innerContainer").each(function(index, item){
			console.log(Number(item.style.left.replace('px','')), movieWidth*20-window.innerWidth)
			if(Number(item.style.left.replace('px',''))>movieWidth*20-window.innerWidth){
				item.style.left=movieWidth*20-window.innerWidth+'px'; 
			}
		})
		$(".movie-container").width(movieWidth+'px');	
		  }
    		
		movieContainerResize();
		$(".movies-innerContainer").each(function(index, item){item.style.left=movieWidth*20-window.innerWidth;})//최초 1회 리사이징 실행 및 위치 초기화


		window.addEventListener('resize', debounce(function() {
			  movieContainerResize();
			  }, 100), true);										//윈도우 사이즈 변경때마다 리사이징 실행 - throttle

				
			
		const TrendMovieContainer = document.querySelector("#trend-movie .movies-container");	
		const PopularMovieContainer = document.querySelector("#popular-movie .movies-container");
		const TrendMovieInnerContainer = document.querySelector("#trend-movie .movies-container .movies-innerContainer");	
		const PopularMovieInnerContainer = document.querySelector("#popular-movie .movies-container .movies-innerContainer");	
				
				
						
				
				
		let TrendIsDragging = null;		//moviebox drag 변수 설정
		let TrendOriginLeft = null;
		let TrendOriginX = null;
		let PopularIsDragging = null;	
		let PopularOriginLeft = null;
		let PopularOriginX = null;
		
		TrendMovieInnerContainer.addEventListener("mousedown",(e) => {				//마우스 클릭시 드래그 실행
			TrendIsDragging = true;
			TrendOriginX = e.clientX;
			TrendOriginLeft = TrendMovieInnerContainer.offsetLeft;
		});
		PopularMovieInnerContainer.addEventListener("mousedown",(e) => {				//마우스 클릭시 드래그 실행
			PopularIsDragging = true;
			PopularOriginX = e.clientX;
			PopularOriginLeft = PopularMovieInnerContainer.offsetLeft;
		});
		

		document.addEventListener("mousemove", (e) => {					//마우스 클릭 후 드래그 중 실행
			if(TrendIsDragging){
				const diffX = e.clientX - TrendOriginX;
				const endOfXPoint = movieContainerWidth - movieInnerContainerWidth;
				let dragging = Math.min(Math.max(0, TrendOriginLeft+diffX),endOfXPoint)
				TrendMovieInnerContainer.style.left = dragging+"px";
			}
			if(PopularIsDragging){
				const diffX = e.clientX - PopularOriginX;
				const endOfXPoint = movieContainerWidth - movieInnerContainerWidth;
				let dragging = Math.min(Math.max(0, PopularOriginLeft+diffX),endOfXPoint)
				PopularMovieInnerContainer.style.left = dragging+"px";
			}
		});

		document.addEventListener("mouseup", (e) => {			//드래그 후 마우스 놓을때 실행
			TrendIsDragging = false;
			PopularIsDragging = false;
		})

		
		
		
		
		
		$.ajax({							//TrendMovieList 출력
        	type: 'GET',
        	url: '/movie/getTrendingMovieList?timewindow=week',
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		$("#trend-movie .movies-container .movie").each(function(index, element){
        			if(data.results[index].poster_path){
        			str = "<div class='movie-image'><img src='https://image.tmdb.org/t/p/w342/"+data.results[index].poster_path+"'></div>" ;
        			}else{
        			str = "<div class='movie-image' style='color : white; text-align: center; '>"+data.results[index].title+"</div>"			//이미지 없으면 제목 출력
        			}
        			let title = data.results[index].title;
        			let overview = data.results[index].overview;
        			if(title.length>20){
        				title = title.substr(0, 20)+"..."					// 제목 20자 넘으면 자르기
            		}
        			if(overview.length>120){
        			overview = overview.substr(0, 120)+"..."					//overview 120자 넘으면 자르기
        			}
        			str += "<figcaption><h3>"+title +"</h3><p>"+overview +"</p><p>"+ data.results[index].release_date +"</p><i class='ion-ios-arrow-right'><a href='/movie/movieDetail?movieId="+data.results[index].id+"&language=<%=language%>'></a></i></figcaption>"         			
        					$(this).html(str);
        		})
        		
        	
        	}
        
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        })
    	
    	
        
        
        $.ajax({							//popularMovieList 출력
        	type: 'GET',
        	url: '/movie/getPopularMovieList?page=1&language=<%=language%>',
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		$("#popular-movie .movies-container .movie").each(function(index, element){
        			if(data.results[index].poster_path){
        			str = "<div class='movie-image'><img src='https://image.tmdb.org/t/p/w342/"+data.results[index].poster_path+"'></div>" ;
        			}else{
        			str = "<div class='movie-image' style='color : white; text-align: center; '>"+data.results[index].title+"</p></div>"			//이미지 없으면 제목 출력
        			}
        			let title = data.results[index].title;
        			let overview = data.results[index].overview;
        			if(title.length>20){
        				title = title.substr(0, 20)+"..."					// 제목 20자 넘으면 자르기
            		}
        			if(overview.length>120){
        			overview = overview.substr(0, 120)+"..."					//overview 120자 넘으면 자르기
        			}
        			str += "<figcaption><h3>"+title +"</h3><p>"+overview +"</p><p>"+ data.results[index].release_date +"</p><i class='ion-ios-arrow-right'><a href='/movie/movieDetail?movieId="+data.results[index].id+"&language=<%=language%>'></a></i></figcaption>" 
        			$(this).html(str);
        		})
        		
        	
        	}
        
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        })
        
        
		 
		 
        		
    })
    </script>




</head>

<body>
	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  
	
	
	
	<section>
	
	<a href="boardList" style="color : white">게시판</a>

	<h1>ABCDEFG</h1>
	
	<!-- 회원 로그인 및 가입 공간 -->
	
	<form action="join" id="join" method="get">
	<p>아이디 : <input type = "text" name="id"></p>
	<p>패스워드 : <input type = "text" name="password"></p>
	<p><input type = "submit" value="로그인"></p>
	
	<!-- 가입  -->
	</form>

	<form action="createUser" id="createUser" method="get">
	<p><input type = "submit" value="회원가입"></p>
	</form>
	
	
	<div id="trend-movie">
		<div class="movie-BigPicture"></div>
		<h3>지금 트렌드는</h3>
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
		<h3>사람들이 많이 보는 영화</h3>
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
