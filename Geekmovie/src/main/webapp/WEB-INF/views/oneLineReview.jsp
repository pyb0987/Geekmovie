<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <c:set var="path" value="${pageContext.request.contextPath}"/>
   
   <% String language = "ko-KR"; %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/debounce.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>



<link	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<script>

var searchMovieSelect = function(movieId, movieTitle){			//누르면 movieId 달아줌
	console.log(movieId)
	document.oneLineReviewSearch.query.value = movieTitle;
	document.oneLineReviewSearch.movieId.value = movieId;
	document.getElementById('oneLineReviewInputbox').className = "movieSelected";
	};
	
	
	
$(document).ready(function(){		

	var language = '<%=language %>';
	
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

		fontResize()		
	}
	
	windowResize();
	var ResizeTimer;
	window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
		 windowResize();
	}, 20), true);	
	
	
	
	$("#oneLineReviewInputbox").on("propertychange change keyup paste input",  debounce(function(){  //자동완성을 위한 키업 이벤트리스너
	oneLineReviewInputBoxSearch();
	}, 500, false));															//키를 받을때마다 실행 - debounce
	
	

	function movieSelected(){
		document.getElementById('oneLineReviewInputbox').className = "movieSelected";
		
	}

	
	function oneLineReviewInputBoxSearch(){	
		const query = $("#oneLineReviewInputbox").val();
		if (!query || document.oneLineReviewSearch.searchMode.value != "movie"){
			$("#oneLineReviewInputboxSearchResultsContainer").empty();	
			return false;
		}else{
		  let inputUrl = '/movie/searchMovieList?query='+query+'&language='+language+'&page=1';
		  $.ajax({							//searchMovieList 출력
	        	type: 'GET',
	        	url: inputUrl,
	        	dataType : 'json',
	        	contentType : 'application/json', 
	        	success: function(data){
	        		$("#oneLineReviewInputboxSearchResultsContainer").empty();	
	        		if (data.total_results>0){
	        			let index=0;
	        			var str = '';
	            		while(index<5 && data.total_results>index){
	            			str +='<div class="search-result-container">';
							str += '<div class="search-result" tabindex:"'+(index+1)+'" onclick="searchMovieSelect(\''+data.results[index].id+'\',\''+data.results[index].title+'\')">';
							if(!!data.results[index].poster_path){
		        				imageUrl = "https://image.tmdb.org/t/p/w92"+data.results[index].poster_path;
		        			}else{
		        				imageUrl = `${pageContext.request.contextPath}/resources/img/noImage.jpg`       		//사진이 없을때 이미지			
		        			}   
							str += '<div class="result-picture" style=\'background: url("'+imageUrl +'"); background-repeat: no-repeat; background-size : contain\'></div>';
							str += '<div class="result-nonPicture">';
							str += '<div class="result-title result-title-font">'+data.results[index].title+'</div>';
							if (!!data.results[index].release_date){
							str += '<div class="result-year result-font">'+data.results[index].release_date.substr(0,4)+'</div>'								
							}else{
							str += '<div class="result-year result-font">unknown</div>'
							}
							var genreAry = []
							data.results[index].genre_ids.forEach(function(item){
			        			genreAry.push(genreMap.get(item))
							})
							str += '<div class="result-genre result-font">'+genreAry.join(' ,')+'</div></div></div></div>'
	            			index +=1
	            		}
						$("#oneLineReviewInputboxSearchResultsContainer").append(str);
	        		}

	    			return false;
	        	}
	        
	        	,
	        	error: function(request, status, error){
	        		console.log(request, status, error)
	        	}
	        })
		}
	}
	
	
	document.querySelector("#searchbutton").onclick=function(){
		let form = document.keywordSearch;
		form.submit();
	};

	
	
	
	
	
	
	
	
	
makePagination( Number(`${page.nowStartPage}`), Number(`${page.nowEndPage}`), Number(`${page.nowPage}`), Number(`${page.endPage}`))

function makePagination(pageFirst,pageLast, pageNow, pageNum){					//아래쪽 페이징 기능 구현
    var str ='';
    if (pageNow==1){
        str += '<a>처음</a>'
        }else{
            str += `<a href="/movie/oneLineReview?page=1">처음</a>`			//처음(페이지 1로)
        }
    if (pageNow<11){
    str += '<a>&laquo;</a>'
    }else{
        str += `<a href="/movie/oneLineReview?page=`+(pageFirst-10)+`">&laquo;</a>`		//앞쪽 10페이지의 처음(페이지25에 있다면 페이지 11로)
    }
    var index = 0
    while(pageFirst+index<=pageNum && pageFirst+index<=pageLast){
    	if(pageFirst+index==pageNow){
    		str += `<a class="active">`+(pageFirst+index)+'</a>'		//현재 페이지
    	}else{
    	str += `<a href="/movie/oneLineReview?page=`+(pageFirst+index)+`">`+(pageFirst+index)+'</a>' 	//페이지 10개 생성
    	}
    		index +=1
    }
    if(pageLast>=pageNum){
    	str += '<a>&raquo;</a>'
    }else{
    	str += `<a href="/movie/oneLineReview?page=`+(pageLast+1)+`">&raquo;</a>`	//뒤쪽 10페이지의 처음(페이지25에 있다면 페이지 31로)
    }
    if(pageNow==pageNum){
    	str += '<a>끝</a>'
    }else{
    	str += `<a href="/movie/oneLineReview?page=`+(pageNum)+`">&nbsp;끝&nbsp;</a>` //맨뒤로
    }
    $('.pagination').html(str);
		}
   
	


});

</script>



<link rel="stylesheet" href="${path}/resources/css/pagination.css"/>
<style>
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);

body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}
h1, h2{
	font-family: 'NanumSquareRoundBold';				/*글꼴*/
	color: #fff;
	font-size : 1.8rem;
	}


#oneLineReviewInputbox{		
	flex-shrink : 1;		
    border: none;
    height: 35px;
    font-size: 1.2rem;
}

option{
	font-size: 1rem;
} 

#oneLineReviewSearchbutton-container{
    width: 70px;
    height: 40px;
    flex-grow : 0;
}


#oneLineReviewSearchbox-container{
    max-width: 650px;
    padding-left : 25px;
    padding-right : 25px;
    margin : auto;
        
}

#oneLineReviewSearchbox{
	display: flex;
    min-width : 330px;
    height: 40px;
    border-radius: 35px;
    background-color: white;
    border: 3px solid red;

}

#oneLineReviewSearch{
display : flex;
flex-grow : 1;
align-items : baseline;
margin : auto;
}

#oneLineReviewSearchMode{
font-family: 'NanumSquareRound';
margin-left : 20px;
    border: none;
    flex-grow : 0;

}
#oneLineReviewInputbox-container{
	display : flex;
	flex-direction : column;
    flex-grow : 1;
}


#oneLineReviewSearchbutton{
    width: 100%;
    height: 100%;
    display: flex;
    align-items : center;
}

#oneLineReviewSearchimage{
	width: 30px;
	height: 30px;
	transfrom : rotate(0.02deg);	
}

.search-result-container:hover{				
border-image: none;
border : solid 3px black;       
padding : 4px;
padding-top : 5px;
box-sizing : border-box;
}

.movieSelected{
background-color : yellow;
}

#checkImg{
max-width : 30px;
max-height : 30px;
}


</style>
</head>
<body>

	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  


	<h1>한줄평</h1>
	<h2>
	<table border="1">
	<tr><th>Id</th><th>userId</th><th>movieId</th><th>Score</th><th>comment</th><th>likes</th><th>Gendate</th></tr>
		<c:forEach var="r" items="${data}">
			<tr>
				<td>${r.oneLineReviewId}</td>
				<td>${r.userId }</td>
				<td>${r.movieId}</td>
				<td>${r.score}</td>
				<td>${r.comment}</td>
				<td>${r.likes}</td>
				<td>${r.gendate}</td>
			</tr>
		</c:forEach>
		</table>
	</h2>
			<div id="oneLineReviewSearchbox-container">
				<div id="oneLineReviewSearchbox">
	<form method="get" name="oneLineReviewSearch" id="oneLineReviewSearch" accept-charset="utf-8">
		<select name="searchMode" id="oneLineReviewSearchMode">
							<option value="movie">영화제목</option>
							<option value="keyword">내용</option>
							<option value="author">작성자</option>
						</select> 
						<div id="oneLineReviewInputbox-container">  
						<input type="text" id="oneLineReviewInputbox" name="query" autocomplete='off' maxlength=50 placeholder="검색할 키워드를 입력하세요">
						<input type="hidden" name="movieId" value="">
						<input type="hidden" name="language" value="<%=request.getParameter("language") %>">
						<div id="oneLineReviewInputboxSearchResultsContainer"><img id="checkImg" src="${path}/resources/img/check.png"></div>
					</div>
					</form>
					<div id="oneLineReviewSearchbutton-container">
					<div id="oneLineReviewSearchbutton" onmouseover="this.style.cursor='pointer'">
							<img id="oneLineReviewSearchimage"
								src="${pageContext.request.contextPath}/resources/img/searchIcon.png"
								alt="search">
							</div>
						</div>
					</div>
			</div>

	
	<div class="pagination"></div>
	
	
</body>
</html>