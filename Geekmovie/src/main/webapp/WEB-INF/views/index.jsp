
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
<style>
body {
	overflow-x: hidden;
}

.movie-container {
	width: 100%;
	height: 320px;
	margin: 0 auto;
	position: relative;
}

.movie-innerContainer {
	display: flex;
	height: 100%;
	width: 4000px;
	align-items: center;
	position: absolute;
}

.movie {
	position: relative;
	padding: 0px;
	height: 270px;
	margin-right: 15px;
	flex-shrink: 0;
	flex-basis: 185px;
	overflow: hidden;
}

.movie-BigPicture { /*index 맨위 사진-구상중 */
	width: 500px;
	height: 500px;
	border: solid red 1px;
}

img { /*이미지 전부 채우게 함*/
	width: 100%;
	height: 100%;
	object-fit: cover;
	-webkit-user-drag: none; /*드래그 못하게 함*/
}
</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

    
    $(document).ready(function(){			 
		
    	
		let movieContainerWidth = 8000-window.innerWidth;		
		let movieInnerContainerWidth = 4000;
		
    	

    	function movieContainerResize() {						//movieContainer 리사이징 함수
			$(".movie-container").width(8000-window.innerWidth+'px');
			$(".movie-container").offset({left : -4000+window.innerWidth});
			$(".movie-innerContainer").offset({left : 0});
			movieContainerWidth = 8000-window.innerWidth;		
        }

		movieContainerResize() 										//최초 1회 리사이징 실행

		window.addEventListener('resize', movieContainerResize);				//윈도우 사이즈 변경때마다 리사이징 실행

		

		let TrendIsDragging = null;		//moviebox drag 변수 설정
		let TrendOriginLeft = null;
		let TrendOriginX = null;
		let PopularIsDragging = null;		
		let PopularOriginLeft = null;
		let PopularOriginX = null;
		
		const TrendMovieContainer = document.querySelector("#trend-movie .movie-container");		
		const TrendMovieInnerContainer = document.querySelector("#trend-movie .movie-container .movie-innerContainer");
		const PopularMovieContainer = document.querySelector("#popular-movie .movie-container");		
		const PopularMovieInnerContainer = document.querySelector("#popular-movie .movie-container .movie-innerContainer");
		
		

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
				const TrendDiffX = e.clientX - TrendOriginX;
				const endOfXPoint = movieContainerWidth - movieInnerContainerWidth;
				let dragging = Math.min(Math.max(0, TrendOriginLeft+TrendDiffX),endOfXPoint)
				TrendMovieInnerContainer.style.left = dragging+"px";
			}
			if(PopularIsDragging){
				const PopularDiffX = e.clientX - PopularOriginX;
				const endOfXPoint = movieContainerWidth - movieInnerContainerWidth;
				let dragging = Math.min(Math.max(0, PopularOriginLeft+PopularDiffX),endOfXPoint)
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
        		console.log(data.results)
        		$("#trend-movie .movie-container .movie-image").each(function(index, element){
        			if(data.results[index].poster_path){
        			str = "<img src='https://image.tmdb.org/t/p/w185/"+data.results[index].poster_path+"'>" ;
        			}else{
        			str = "<p>"+data.results[index].title+"</p>"			//이미지 없으면 제목 출력
        			}
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
        		console.log(data.results)
        		$("#popular-movie .movie-container .movie-image").each(function(index, element){
        			if(data.results[index].poster_path){
        			str = "<img src='https://image.tmdb.org/t/p/w185/"+data.results[index].poster_path+"'>" ;
        			}else{
        			str = "<p>"+data.results[index].title+"</p>"			//이미지 없으면 제목 출력
        			}
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

	<a href="boardList"></a>

	<h1>ABCDEFG</h1>
	
	<!-- 회원 로그인 및 가입 공간 -->
	
	<form action="join" id="join" method="post">
	<p>아이디 : <input type = "text" name="id"></p>
	<p>패스워드 : <input type = "text" name="password"></p>
	<p><input type = "submit" value="로그인"></p>
	
	<!-- 가입 -->
	</form>
	<form action="create" id="create" method="get">
	<p><input type = "submit" value="회원가입"></p>
	</form>
	
	
	<div id="trend-movie">
		<div class="movie-BigPicture"></div>
		<h3>지금 트렌드는</h3>
		<div class="movie-container">
			<div class="movie-innerContainer">
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
			</div>
		</div>
	</div>


	<div id="popular-movie">
		<h3>사람들이 많이 보는 영화</h3>
		<div class="movie-container">
			<div class="movie-innerContainer">
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
				<div class="movie">
					<div class="movie-image"></div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
