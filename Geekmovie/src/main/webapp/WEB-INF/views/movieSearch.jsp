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
    width :  100%;
    max-width : 1800px;
    display: flex;
    border : solid 1px yellow;
}
.movies-searchInnerContainer-padding{
	width : 80%;
    padding-bottom : 60%;
    box-sizing: border-box;
    position: relative;
    border : solid 1px green;
}
.movies-searchInnerContainer{
    width: 100%;
    height: 90%;
    box-sizing: border-box;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    grid-auto-rows: 1fr;
    row-gap: 1%;
    column-gap: 1%;
}
.side{width : 10%;}
.movie-searchContainer{
    border : solid 1px red;
    display : grid;   
    grid-template-columns: 2fr 3fr;
    grid-template-rows: 3fr 1fr 1fr 2fr;
	column-gap: 3%;
}
.movie-pictureContainer{
	grid-row: 1 / span 4;
	width: 100%;
    height: 100%;
}
.movie-picture{
	width: 100%;
    height: 100%;
	box-sizing: border-box;
}
.movie-content{	border : solid 1px green;}
.movie-title{
	
	font-family: 'NanumSquareRoundBold';
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
			else if(window.innerWidth>500){
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
		
		
		if('${data.searchMode}'==='movie'){								//분류 작업
			var searchUrl = `/movie/searchMovieList?query=${data.query}&language=${data.language}&page=${data.page}`
			var searchText = "<h1>\'${data.query}\'로 검색한 결과입니다.</h1>"
		}else{
			var searchUrl = `<%=request.getParameter("page") %>`
			var searchText = `<h1>\'${query}\'로 검색안한 결과입니다.</h1>`
		}
		
		
		

  		$.ajax({							//받아온 영화 정보 표에 나열
        	type: 'GET',
        	url: searchUrl,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		$("#searchText").html(searchText)
        		var str = ""
        			
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
					

        			str += '<div class="movie-searchContainer"><div class="movie-pictureContainer"><div class="movie-picture" style="background: url(\'';
        			str +=	imageUrl+'\'); background-size: contain; background-repeat: no-repeat; background-position: center center;"></div>';
					str += '</div><div class="movie-title-container"><div class="movie-title prevent-flow">';
					str += item.title+'</div></div><div class="movie-year prevent-flow">'
					str += year+'</div><div class="movie-genre prevent-flow">'
					str += genreAry.join(' ,')+'</div><div class="movie-vote prevent-flow">'+item.vote_average+'</div>'					//나중에 geekmovie자체점수로 변경필요
						
					str += '</div>'

					})
        		
        		$(".movies-searchInnerContainer").html(str)
				makePagination(data.total_pages);
        		return false;
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        	
        	
        	
        	
        })
        function makePagination(pageNum){
        console.log(pageNum)
        var pageNow = ${data.page}
        var pageFirst = parseInt((pageNow-1)/10)*10
        var str ='';
        if (pageNow<11){
        str += '<a>&laquo;</a>'
        }else{
            str += `<a href=\"/movie/search?searchMode=${data.searchMode}&query=${data.query}&language=${data.language}&page=`+pageFirst+`\">&laquo;</a>`
        }
        var index = 1
        while(pageFirst+index<=pageNum && index<11){
        	if(pageFirst+index==pageNow){
        		str += `<a class="active" href=\"/movie/search?searchMode=${data.searchMode}&query=${data.query}&language=${data.language}&page=`+(pageFirst+index)+`\">`+(pageFirst+index)+'</a>'
        	}else{
        	str += `<a href=\"/movie/search?searchMode=${data.searchMode}&query=${data.query}&language=${data.language}&page=`+(pageFirst+index)+`\">`+(pageFirst+index)+'</a>'
        	}
        		index +=1
        }
        if(pageFirst+10>=pageNum){
        	str += '<a>&raquo;</a>'
        }else{
        	str += `<a href=\"/movie/search?searchMode=${data.searchMode}&query=${data.query}&language=${data.language}&page=`+(pageFirst+11)+`\">&raquo;</a>`
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

			<div class="movies-searchInnerContainer">

				
			</div>

	
	
		<div class="pagination">

</div>	


</body>
</html>
