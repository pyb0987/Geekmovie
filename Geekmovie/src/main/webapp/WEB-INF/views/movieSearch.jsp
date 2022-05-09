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
<link rel="stylesheet" href="${path}/resources/css/pagination.css"/>
<link rel="stylesheet" href="${path}/resources/css/movieSearch.css?ver=1"/>

<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>
<link rel="stylesheet" href="${path}/resources/css/movieLike.css"/>
<style>
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);

body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}


.movie-searchContainer figcaption{
	background-color: rgba(0, 0, 0, 0.72);
	opacity: 0;
	padding : 0;
	position: relative;
	width : 100%;
	height : 100%;
}


.movie-searchContainer:hover figcaption{
	opacity: 1;
}

.search-click.clickBox{
	display : flex;
	align-items: center;
	position: absolute;
	width : 100%;
	bottom : -0.8rem;
	right : 5px;
  	opacity: 0;
  -webkit-transition: all 0.35s ease;
  transition: all 0.35s ease;
}
.search-Click .heartClick{
	left : -1.5rem;
	margin-left : 20%;
	margin-right: -1.5rem;
}

.movie-searchContainer:hover .search-click.clickBox{
	opacity: 1;
}

.heartClickClicker, .addClick{
	z-index : 2;
}

#searchText h1 {
    padding-left: 20px;
    margin: 50px;
}
#searchText{
    width: 80%;
    margin: 0 auto;
}


.movies-searchInnerContainer{
    padding-top: 50px;
    border-top: 3px solid red;
}
</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/throttle.js"></script>
	 
	 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fontResize.js"></script>
	 <script type="text/javascript" src="${path}/resources/js/movieLike.js?ver=1"></script>
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
			fontResize();
		}
		
		windowResize();
		var ResizeTimer;
		window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
			 windowResize();
		}, 400), true);	
		
		
		movieLike('${sessionScope.id}');	//영화좋아요/add 적용 
		
		
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
					

        			str += '<div class="movie-searchContainer" data-id="'+item.id+'" style="cursor:pointer;"><div class="movie-pictureContainer"><div class="movie-picture" style="background: url(\'';
        			str +=	imageUrl+'\'); background-size: contain; background-repeat: no-repeat; background-position: center center;">';
					str += "<figcaption><div class='search-click clickBox' data-id='"+item.id+"'><div class='heartClickExtraSmall heartClick'><div class='heartClickExtraSmallClicker heartClickClicker clickCheck'></div></div><div class='addClick addClickExtraSmall clickCheck'><svg class='clickCheck' viewBox='0 0 44 44'><path class='clickCheck' d='M14,24 L21,31 L39.7428882,11.5937758 C35.2809627,6.53125861 30.0333333,4 24,4 C12.95,4 4,12.95 4,24 C4,35.05 12.95,44 24,44 C35.05,44 44,35.05 44,24 C44,19.3 42.5809627,15.1645919 39.7428882,11.5937758' transform='translate(-2.000000, -2.000000)'></path></svg></div></div></figcaption>";
        			str += '</div></div><div class="movie-title-container"><div class="movie-title prevent-flow">';
					str += item.title+'</div></div><div class="movie-year prevent-flow">'
					str += year+'</div><div class="movie-genre prevent-flow">'
					str += genreAry.join(' ,')+'</div><div class="movie-vote prevent-flow">'+item.vote_average+'</div>'					//나중에 geekmovie자체점수로 변경필요
						
					str += '</div>'
					count +=1
					})
					str += '<div class="fake-searchContainer"></div>'.repeat(Math.max(20-count, 0))
					str += '<div class="pagination-container" style="grid-column: 1 / span 4;"><div class="pagination"></div></div>'
        			$(".movies-searchInnerContainer").html(str)
        			 $(".search-click.clickBox").activeLikeMovie();
					$(".movie-searchContainer").each(function(i, e){
						$(this).click(function(e){
							if(!(e.target.classList.contains('clickCheck'))){
							location.href ='/movie/movieDetail?movieId='+$(e.currentTarget).data('id')+`&language=${data.language}`
							}
								
							});
						})
					
					
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
