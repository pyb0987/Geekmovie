<%@page import="java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html lang="en">

<%

%>


<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GeekMovieFinder</title>
<link	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">

<style>
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);

body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}
h1{
	font-family: 'NanumSquareRoundBold';				/*글꼴*/
	color: #fff;
	font-size : 1.8rem;
	}



.movies-searchContainer{
    display: flex;
    justify-content: center;
   
}
.movies-searchInnerContainer-padding{
	width : 80%;
    padding-bottom : 70%;
    box-sizing: border-box;
    position: relative;
}
.movies-searchInnerContainer{
	position : absolute;
    width: 100%;
    height: 90%;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    grid-rows: repeat(6, minmax(16%, 20%));
    column-gap: 1%;
    row-gap : 2%;
}
.side{width : 10%;}
.movie-searchContainer{
    border : double 4px darkred;
    box-sizing: border-box;
    display : grid;   
    grid-template-columns: 2fr 3fr;
    grid-template-rows: 2.5fr 1fr 1fr 1fr 1fr;
	column-gap: 3%;
}
.movie-searchContainer:hover{
    border : double 4px aqua;

}

.movie-pictureContainer{
	grid-row: 1 / span 5;
	width: 100%;
    height: 100%;
}
.movie-picture{
	width: 100%;
    height: 100%;
	box-sizing: border-box;
}

.movie-title{
	
	font-family: 'NanumSquareRoundBold';
	font-weight: 700;
	color : white;
	font-size: 1.2rem;
	word-wrap: break-word;
  display : -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  max-height : 3.2rem;
}
.prevent-flow {
  overflow: hidden;
  max-width: 100%;
  width: 100%;
  box-sizing: border-box;
  /*white-space: nowrap; */
  text-overflow: ellipsis;
}
.movie-year, .movie-genre, .movie-vote{
	font-family: 'NanumSquareRound';
	color : white;
	font-size: 1rem;
	white-space: nowrap;
}




.pagination {						/*페이지 처리*/
  display: inline-block;
}
.pagination-container {						/*페이지 처리*/
  display: flex;
  justify-content: center;
  min-width : 500px;
}

.pagination a {
  color: whitesmoke;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
  transition: background-color .3s;
  border: 1px solid #ddd;
}

.pagination a.active {
  background-color: #ddd;
  color: black;
  border: 1px solid #ddd;
}

.pagination a:hover:not(.active) {background-color: #555;}


</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/throttle.js"></script>
<script>
	$(document).ready(function() {
			
		var genreMap = new Map([[28,'액션'],	//genreMap
			[12, '모험'],
			[16, '애니메이션'],
			[35, '코미디'],
			[80, '범죄'],
			[99, '다큐멘터리'],
			[18, '드라마'],
			[10751, '가족'],
			[14, '판타지'],
			[36, '역사'],
			[27, '공포'],
			[10402, '음악'],
			[9648, '미스터리'],
			[10749, '로맨스'],
			[878, 'SF'],
			[10770, 'TV영화'],
			[53, '스릴러'],
			[10752, '전쟁'],
			[37, '서부']]); 

		
		var windowResize = function(){					//리사이징 함수
			console.log(window.innerWidth)
			if(window.innerWidth>1800){   //폰트 리사이징
				$("html").css("fontSize", "16px")
			}else if(window.innerWidth>1500){
				$("html").css("fontSize", "14.5px")
			}else if(window.innerWidth>1000){
				$("html").css("fontSize", "13px")
			}else if(window.innerWidth>700){
				$("html").css("fontSize", "11.5px")
			}
			else if(window.innerWidth>600){
				$("html").css("fontSize", "10px")
			}else{
				$("html").css("fontSize", "8px")

		}
		}
		
		windowResize();
		var ResizeTimer;
		window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
			 windowResize();
		}, 400), true);	
		
		var movieNameOn = false;
		if('${data.searchMode}'==='movie'){								//분류 작업
			var searchUrl = `/movie/searchMovieList?query=${data.query}&language=${data.language}&page=${data.page}`
			var searchText = `\'${data.query}\'로 검색한 결과입니다.`
		}else if('${data.searchMode}'==='popularmovie'){
			var searchUrl = `/movie/getPopularMovieList?page=${data.page}&language=${data.language}`
			var searchText = `사람들이 많이 보는 영화`
		}else if('${data.searchMode}'==='nowmovie'){
			var searchUrl = `/movie/getNowPlayingMovieList?page=${data.page}&language=${data.language}`
				var searchText = `현재 상영중인 영화`
		}else if('${data.searchMode}'==='topmovie'){
			var searchUrl = `/movie/getTopRatedMovieList?page=${data.page}&language=${data.language}`
				var searchText = `높은 점수를 받은 영화`
		}else if('${data.searchMode}'==='similarmovie'){
			var searchUrl = `/movie/getSimilarMovieList?movieId=${data.movieId}&page=${data.page}&language=${data.language}`
				var searchText = `하고 비슷한 영화`
				var movieNameOn = true;
		}else if('${data.searchMode}'==='recommendmovie'){
			var searchUrl = `/movie/getRecommendMovieList?movieId=${data.movieId}&page=${data.page}&language=${data.language}`
				var searchText = `에 관련있는 추천 영화`
				var movieNameOn = true;
		}
		var movieTitle='';
		if(movieNameOn){
			$.getJSON(`/movie/getMovieData?movieId=${data.movieId}&language=${data.language}`, function(data) {
				movieTitle = "'"+data.title+"'";
			});
		}
		
		

  		$.ajax({							//받아온 영화 정보 표에 나열
        	type: 'GET',
        	url: searchUrl,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		$("#searchText").html('<h1>'+movieTitle+searchText+'</h1>')	
        		var str = ""
        		var count = 0;
        		data.results.forEach(function(item,index){
					var genreAry = [];
					item.genre_ids.forEach(function(item){
	        			genreAry.push(genreMap.get(item))
					})
					var imageUrl = '';
					if(!!item.poster_path){
        				imageUrl = "https://image.tmdb.org/t/p/w185"+item.poster_path;
        			}else{
        				imageUrl = `${pageContext.request.contextPath}/resources/img/noImage.jpg`       		//사진이 없을때 이미지			
        			}
					var year = '';
					if(!!item.release_date){
						year = item.release_date.substr(0,4);
					}else{
						year = "Year Unknown"
					}
					

        			str += '<div class="movie-searchContainer" OnClick="location.href =\'/movie/movieDetail?movieId='+item.id+`&language=${data.language}\'" style="cursor:pointer;"><div class="movie-pictureContainer"><div class="movie-picture" style="background: url(\'`;
        			str +=	imageUrl+'\'); background-size: contain; background-repeat: no-repeat; background-position: center center;"></div>';
					str += '</div><div class="movie-title-container"><div class="movie-title prevent-flow">';
					str += item.title+'</div></div><div class="movie-year prevent-flow">'
					str += year+'</div><div class="movie-genre prevent-flow">'
					str += genreAry.join(' ,')+'</div><div class="movie-vote prevent-flow">'+item.vote_average+'</div>'					//나중에 geekmovie자체점수로 변경필요
						
					str += '</div>'
					count +=1
					})
					str += '<div class="fake-searchContainer"></div>'.repeat(Math.max(20-count, 0))
					str += '<div class="pagination-container" style="grid-column: 1 / span 4;"><div class="pagination"></div></div>'
        			$(".movies-searchInnerContainer").html(str)
				makePagination(data.total_pages);
        		return false;
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        		
        		
        		$("#searchText").html('<h1>검색결과가 존재하지 않습니다.</h1>')	
        	}
        	
        	
        	
        	
        })
        function makePagination(pageNum){					//아래쪽 페이징 기능 구현

  		console.log(pageNum)
  		if(pageNum>500){
  			pageNum = 500;
  		}
        var pageNow = ${data.page}
        var pageFirst = parseInt((pageNow-1)/10)*10
        var str ='';
        if(movieNameOn){
        	var strUnit = '&movieId=${data.movieId}'
        }else{
        	var strUnit = '';
        }
        if (pageNow==1){
            str += '<a>처음</a>'
            }else{
                str += `<a href=\"/movie/search?searchMode=${data.searchMode}`+strUnit+`&query=${data.query}&language=${data.language}&page=1\">처음</a>`
            }
        if (pageNow<11){
        str += '<a>&laquo;</a>'
        }else{
            str += `<a href=\"/movie/search?searchMode=${data.searchMode}`+strUnit+`&query=${data.query}&language=${data.language}&page=`+pageFirst+`\">&laquo;</a>`
        }
        var index = 1
        while(pageFirst+index<=pageNum && index<11){
        	if(pageFirst+index==pageNow){
        		str += `<a class="active">`+(pageFirst+index)+'</a>'
        	}else{
        	str += `<a href=\"/movie/search?searchMode=${data.searchMode}`+strUnit+`&query=${data.query}&language=${data.language}&page=`+(pageFirst+index)+`\">`+(pageFirst+index)+'</a>'
        	}
        		index +=1
        }
        if(pageFirst+10>=pageNum){
        	str += '<a>&raquo;</a>'
        }else{
        	str += `<a href=\"/movie/search?searchMode=${data.searchMode}`+strUnit+`&query=${data.query}&language=${data.language}&page=`+(pageFirst+11)+`\">&raquo;</a>`
        }
        if(pageNow==pageNum){
        	str += '<a>끝</a>'
        }else{
        	str += `<a href=\"/movie/search?searchMode=${data.searchMode}`+strUnit+`&query=${data.query}&language=${data.language}&page=`+pageNum+`\">&nbsp;끝&nbsp;</a>`
        }
        
        $('.pagination').html(str);
  		}
       
		
		

        
		
	})
</script>




</head>

<body>
	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="${data.language}"/>  
</jsp:include>


	<div id="searchText"></div>
	<div class="movies-searchContainer">
<div class="movies-searchInnerContainer-padding">
			<div class="movies-searchInnerContainer">

				
			</div>
		</div>
		</div>
		

	



</body>
</html>
