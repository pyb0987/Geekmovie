
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








#header{
	display: flex;
	height : 100px;
	top : 0;
	left : 0;
    width: 100%;
    background-color: #242608;
    align-items: center;
    position : fixed;
    z-index : 3;
}

    /*-- menu button --*/
#menu-container{
    width: 140px;
    min-width: 70px;
    height: 30px;
    display: flex;
    justify-content: center;
}
#menu{

    width: 40px;
    height: 30px;
    position:relative;
}
.menubar{
    position: absolute;
    width: 100%;
    height: 13%;
    background-color: #f8efc5;
    border-radius: 4px;
    transition : all 0.2s;
}
.menubar2{transform: translateY(13px);}
.menubar3{transform: translateY(26px);}
.menubar1.active-menu  { transform : translateY(13px) rotate(30deg); }
.menubar2.active-menu  { opacity: 0; }
.menubar3.active-menu  { transform : translateY(13px) rotate(-30deg); }




    /*-- logo --*/
#logo-img{
    
}
#logo{
	width: 150px;
    min-width : 100px;
    height: 40px;
    font-family: 'Square Peg', cursive;
    font-size: 1.9rem;
    color : #f8efc5;
    letter-spacing: -4px;
    line-height : 40px;
    text-decoration: none;
}





    /*-- searchbox --*/    
#searchbox{
	display: flex;
    min-width : 430px;
    height: 40px;
    border-radius: 35px;
    align-items: center;
    background-color: white;
    border: 3px solid red;

}

#inputbox{
    border: none;
    height: 35px;
    font-size: 1.2rem;
    flex-grow : 1;
}
#searchbutton-container{
    width: 70px;
    height: 40px;
    flex-grow : 0;
}
#searchbox-container{
    width: 650px;
    padding-left : 25px;
    padding-right : 25px;
    margin : auto;
        
}
#searchbutton{
    width: 100%;
    height: 100%;
    display: flex;
    align-items : center;
}

#search-image{
	width: 30px;
	height: 30px;
	transfrom : rotate(0.02deg);	
}
#searchMode{
font-family: 'NanumSquareRound';
margin-left : 20px;
    border: none;
    flex-grow : 0;

}
#keywordSearch{
display : flex;
flex-grow : 1;
align-items : center;
margin : auto;
}



#user-menu1, #user-menu2{
 color : #f8efc5e0;
   margin-right : 10px;
   white-space : nowrap;

} 

#user-menu1:hover, #user-menu2:hover{
 color : #f8efc570;
} 

#foldMenuContainer{
 width : 240px;
 height : 100%;
 top : 100px;
left : 0;
 position : fixed;
 z-index : 2;
 background-color : #252525;
 border-right : solid 10px #1D1D1D;
 
 transform : translateX(-100%);
 transition : all 0.3s;
}

#foldMenuContainer.active-menu{

	transform : translateX(0);
}

#foldMenu{
 width : 100%;
 height : 100%;
 
display : flex;
flex-direction: column;
}

.menuButton{
box-sizing: border-box;
 width : 100%;
 height : 80px;
 line-height : 80px;
 color : white;
 font-family: 'NanumSquareRound';
 text-align : center;
 font-size: 1.1rem;
 cursor : pointer;          
 border-right: 1px solid #323235;
 border-left: 1px solid rgba(255, 255, 255, 0.2);
 background-image: -moz-linear-gradient(top, #535357, #3c3c3f);
 background-image: -ms-linear-gradient(top, #535357, #3c3c3f);
 background-image: -webkit-linear-gradient(top, #535357, #3c3c3f);
 background-image: linear-gradient(top, #535357, #3c3c3f);
           
 -webkit-box-shadow: inset 0 1px 0px rgba(255, 255, 255, 0.2), 0 1px 0px #292929;
 -moz-box-shadow: inset 0 1px 0px rgba(255, 255, 255, 0.2), 0 1px 0px #292929;
 box-shadow: inset 0 1px 0px rgba(255, 255, 255, 0.2), 0 1px 0px #292929;
}
.menuButton:hover{
background-image: -moz-linear-gradient(top, #484852, #383839);
 background-image: -ms-linear-gradient(top, #484852, #383839);
 background-image: -webkit-linear-gradient(top, #484852, #383839);
 background-image: linear-gradient(top, #484852, #383839);        
box-shadow: -2px 2px 16px rgba(0, 0, 0, 0.6);
box-shadow: -1px 1px 16px rgba(0, 0, 0, 0.6);
}


</style>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movieHover.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movieSlide.css"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/movieSlideOne.js" ></script>
<script>

    
    $(document).ready(function(){			 
		
    	
		session_check();
		
	
		
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

		var timer;
		window.addEventListener('resize', function() {
			  if (timer) { clearTimeout(timer); }
				  timer = setTimeout(movieContainerResize, 100);
				}, true);										//윈도우 사이즈 변경때마다 리사이징 실행 - debounce

				
			
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
        
        
        
        $("#menu").click(function() {
            $("#menu").children().toggleClass("active-menu");			//메뉴 버튼 모양 토글            
            $("#foldMenuContainer").toggleClass("active-menu");
            
            
        });
        
		 function session_check(){ 							//메뉴 세션 체크
	         var UserVo = '<%=(String)session.getAttribute("UserVo")%>';

	          if(UserVo=="null"){ 
	             let str1 = "<a id='user-menu1' href='login'>로그인</a>"
	             let str2 = "<a id='user-menu2' href='createUser'>회원가입</a>"
	        	$("#user-menu1").html(str1);
	        	$("#user-menu2").html(str2);
	          }
	          else{
	             location.replace("/user/mypageForm.jsp");
	          }
	    }   
		 
		
		 
		 $("#inputbox").on("propertychange change keyup paste input", function(){				//자동완성을 위한 키업 이벤트리스너
			 const query = document.getElementById("inputbox").value;
			  let inputUrl = "/movie/searchMovieList?language="+'<%=language%>'+"&query="+query+"&page=1";
			  console.log(inputUrl)
			  $.ajax({							//TrendMovieList 출력
		        	type: 'GET',
		        	url: inputUrl,
		        	dataType : 'json',
		        	contentType : 'application/json', 
		        	success: function(data){
		        		console.log(data);
		        	
		        	}
		        
		        	,
		        	error: function(request, status, error){
		        		console.log(request, status, error)
		        	}
		        })
			
			});
		 
		 
        		
    })
    </script>




</head>

<body>
	<header>
	<div id="header">
		<div id="menu-container">
			<div id="menu" onmouseover="this.style.cursor='pointer'">
				<div class="menubar menubar1"></div>
				<div class="menubar menubar2"></div>
				<div class="menubar menubar3"></div>
			</div>
		</div>
		<div id="logo-img">
			<a id="logo" href="#">Geekmovie</a>
		</div>
		<div id="searchbox-container">
				<div id="searchbox">
					<form id="keywordSearch" name="keywordSearch" method="post">
						<select name="searchMode" id="searchMode">
							<option value="movie">영화이름</option>
							<option value="keyword">게시글</option>
						</select> 
						<input type="text" id="inputbox">
					</form>
					<div id="searchbutton-container">
						<div id="searchbutton" onclick=""
							onmouseover="this.style.cursor='pointer'">
							<img id="search-image"
								src="${pageContext.request.contextPath}/resources/img/searchIcon.png"
								alt="search">
						</div>
					</div>
				</div>
			</div>
		<div id="user-menu1"></div>
		<div id="user-menu2"></div>
	</div>
	
	<div id="foldMenuContainer">
		<div id="foldMenu">
		<div class="menuButton">최신영화</div>
		<div class="menuButton">인기영화</div>

		<div class="menuButton" onclick="location.href='boardList';">최신게시글</div>

		<div class="menuButton">마이페이지</div>
		</div>
	</div>
	
	</header>
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
