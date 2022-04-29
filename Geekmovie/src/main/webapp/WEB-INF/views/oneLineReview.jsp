<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <c:set var="path" value="${pageContext.request.contextPath}"/>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/debounce.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<link rel="stylesheet" href="${path}/resources/css/movieSearch.css"/>


<link	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<script>

function searchMovieSelect(movieId, movieTitle){			//영화검색결과를 누르면 movieId 달아줌
	document.oneLineReviewSearch.query.value = movieTitle;
	document.oneLineReviewSearch.movieId.value = movieId;
	document.getElementById('oneLineReviewInputbox').className = "movieSelected";
	document.getElementById('oneLineReviewInputbox').readOnly = true;
	document.getElementById('checkImg').className = "visualized";
	
	$(".modal").fadeOut();
	};

	

	
	
$(document).ready(function(){		

	var language = '${language}';
	
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
	window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
		 windowResize();
	}, 20), true);	
	
	
	
	$("#oneLineReviewInputbox").on("propertychange change keyup paste input",  debounce(function(){  //자동완성을 위한 키업 이벤트리스너
	oneLineReviewInputBoxSearch();
	}, 500, false));															//키를 받을때마다 실행 - debounce
	

	
	
	
	
	
	//----------------------한줄평 검색창 영화기능구현
	
	function movieSelected(){					//영화선택되면 색깔변경
		document.getElementById('oneLineReviewInputbox').className = "movieSelected";
	}
	
	var checkImg = document.getElementById('checkImg');//체크박스 누르면 색깔변경 사라짐
	checkImg.addEventListener('click', function(e){
		document.getElementById('oneLineReviewInputbox').classList.remove("movieSelected");
		document.getElementById('oneLineReviewInputbox').readOnly = false;
		document.getElementById('checkImg').classList.remove("visualized");
    }); 
	var oneLineReviewSearchMode = document.getElementById('oneLineReviewSearchMode') //서치모드 변경시 색깔변경 사라짐
	oneLineReviewSearchMode.addEventListener('click', function(e){
		document.getElementById('oneLineReviewInputbox').classList.remove("movieSelected");
		document.getElementById('oneLineReviewInputbox').readOnly = false;
		document.getElementById('checkImg').classList.remove("visualized");
    }); 
	
	var modalExit = document.querySelector('.modalExit');//X박스 누르면 모달창 제거
	modalExit.addEventListener('click', function(e){
	    $(".modal").fadeOut();
    }); 
	
	function SearchResultMoreEventListenerAllocator(searchresultmore){				//영화 정보 완료되면 이벤트 설정
	searchresultmore.addEventListener('click', function(e){
			const query = $("#oneLineReviewInputbox").val();
			modalSearch(1, query, language);		//더보기 하면 모달창으로
	});
	};
	
	function ModalEventListenerAllocator(){
	  Array.prototype.forEach.call(document.querySelectorAll('.modalPagination a'), function(btn) {
		    btn.addEventListener('click', function(e) {
		      var tr = e.target;
		      if(!!tr.dataset.page){
		    	  modalSearch(tr.dataset.page, tr.dataset.query, tr.dataset.language);
		      	}
		      })
		    });
	  };

	var oneLineReviewSearchbutton = document.getElementById('oneLineReviewSearchbutton');		//서치버튼 클릭
	oneLineReviewSearchbutton.addEventListener('click', function(e){
		var query = $("#oneLineReviewInputbox").val();
		if(query!=""){
		let isReady = document.getElementById('oneLineReviewInputbox').classList.contains("movieSelected");
		let oneLineReviewSearchMode = document.querySelector('#oneLineReviewSearchMode').value;
		if (oneLineReviewSearchMode != 'movie' || isReady){		
			if(oneLineReviewSearchMode == 'movie'){
				query = document.oneLineReviewSearch.movieId.value;
			}
			url = '/movie/oneLineReview?SearchMode='+oneLineReviewSearchMode+'&query='+query+'&language='+language+'&page=1';		//서치 실행 url
			location.href = url;
		}else{				//만약 체크가 안되어있다면 모달창으로
			modalSearch(1, query, language);
		}
		}
	});
	

	
	
	function modalSearch(modalPage, inputQuery, inputLanguage){		//모달창 정보표시
		$(".modal").fadeIn();
		$(".modal").css('position', 'fixed');
		var searchUrl = "/movie/searchMovieList?query="+inputQuery+"&language="+inputLanguage+"&page="+modalPage;
		  		$.ajax({							//받아온 영화 정보 표에 나열
        	type: 'GET',
        	url: searchUrl,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		var str = ""
        		var count = 0;
        		$(".movies-searchInnerContainer").empty();	
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
        			str += '<div class="movie-searchContainer" OnClick="searchMovieSelect(\''+item.id+'\',\''+item.title+'\')" style="cursor:pointer;"><div class="movie-pictureContainer"><div class="movie-picture" style="background: url(\'';
        			str +=	imageUrl+'\'); background-size: contain; background-repeat: no-repeat; background-position: center center;"></div>';
					str += '</div><div class="movie-title-container"><div class="movie-title prevent-flow">';
					str += item.title+'</div></div><div class="movie-year prevent-flow">'
					str += year+'</div><div class="movie-genre prevent-flow">'
					str += genreAry.join(' ,')+'</div><div class="movie-vote prevent-flow">'+item.vote_average+'</div>'					//나중에 geekmovie자체점수로 변경필요
						
					str += '</div>'
					count +=1
					})
					str += '<div class="fake-searchContainer"></div>'.repeat(Math.max(20-count, 0))
					str += '<div class="pagination-container" style="grid-column: 1 / span 4;"><div class="pagination modalPagination"></div></div>'
        			$(".movies-searchInnerContainer").html(str)
				ModalmakePagination(data.total_pages,inputQuery,inputLanguage,  modalPage);
        		return false;
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        		$(".movies-searchInnerContainer").html('<div id="searchText"></div>');
        		
        		$("#searchText").html('<h1>검색결과가 존재하지 않습니다.</h1>')	
        	}
        })
	}	
	
	function ModalmakePagination(pageNum, inputQuery, inputLanguage, modalPage){				//모달창 내부 페이징 기능 구현
  		if(pageNum>500){
  			pageNum = 500;			//외부데이터베이스 서치시 500쪽 제한
  		}
        var pageNow = modalPage;
        var pageFirst = parseInt((pageNow-1)/10)*10;
        var str='';
        if (pageNow==1){
            str += '<a>처음</a>'
            }else{
                str += "<a class='modalSearch' data-page='"+1+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>처음</a>";
            }
        if (pageNow<11){
        str += '<a>&laquo;</a>'
        }else{
            str += "<a class='modalSearch' data-page='"+(pageFirst)+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>&laquo;</a>";
        }
        var index = 1
        while(pageFirst+index<=pageNum && index<11){
        	if(pageFirst+index==pageNow){
        		str += `<a class="active">`+(pageFirst+index)+'</a>'
        	}else{
        	str += "<a class='modalSearch' data-page='"+(pageFirst+index)+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>"+(pageFirst+index)+"</a>";
        	}
        		index +=1
        }
        if(pageFirst+10>=pageNum){
        	str += '<a>&raquo;</a>'
        }else{
        	str += "<a class='modalSearch' data-page='"+(pageFirst+11)+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>&raquo;</a>";
        }
        if(pageNow==pageNum){
        	str += '<a>끝</a>'
        }else{
        	str += "<a class='modalSearch' data-page='"+(pageNum)+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>&nbsp;끝&nbsp;</a>";
        }
        
        $('.modalPagination').html(str);
        
		if(!!document.querySelector('.modalPagination a')){
    		ModalEventListenerAllocator();
		}
        
  		};

	
	
	function oneLineReviewInputBoxSearch(){				//한줄평 5개 영화목록 서치
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
							str += '<div class="search-result" tabindex:"'+(index+1)+'" OnClick="searchMovieSelect(\''+data.results[index].id+'\',\''+data.results[index].title+'\')">';
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
	            		str += '<div class="search-result-container" style="height : 30px;"><div id="search-result-more")">더 보기</div></div>';
						$("#oneLineReviewInputboxSearchResultsContainer").append(str);
	        		}
	        		if(!!document.getElementById('search-result-more')){
	        		var searchresultmore = document.getElementById('search-result-more');
	        		SearchResultMoreEventListenerAllocator(searchresultmore);
	        			
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
	
	
	
	
	
	
	
	//---------------------한줄평 한줄평 페이징 기능 구현
	
	
	
oneLineReviewMakePagination( Number(`${page.nowStartPage}`), Number(`${page.nowEndPage}`), Number(`${page.nowPage}`), Number(`${page.endPage}`), '${SearchMode}', '${query}')

function oneLineReviewMakePagination(pageFirst,pageLast, pageNow, pageNum, searchMode, query){					//한줄평 페이징 기능 구현
    var str ='';
    if (pageNow==1){
        str += '<a>처음</a>'
        }else{
            str += `<a href="/movie/oneLineReview?SearchMode=`+searchMode+`&query=`+query+`&page=1">처음</a>`			//처음(페이지 1로)
        }
    if (pageNow<11){
    str += '<a>&laquo;</a>'
    }else{
        str += `<a href="/movie/oneLineReview?SearchMode=`+searchMode+`&query=`+query+`&page=`+(pageFirst-1)+`">&laquo;</a>`		//앞쪽 10페이지의 처음(페이지25에 있다면 페이지 20으로)
    }
    var index = 0
    while(pageFirst+index<=pageNum && pageFirst+index<=pageLast){
    	if(pageFirst+index==pageNow){
    		str += `<a class="active">`+(pageFirst+index)+'</a>'		//현재 페이지
    	}else{
    	str += `<a href="/movie/oneLineReview?SearchMode=`+searchMode+`&query=`+query+`&page=`+(pageFirst+index)+`">`+(pageFirst+index)+'</a>' 	//페이지 10개 생성
    	}
    		index +=1
    }
    if(pageLast>=pageNum){
    	str += '<a>&raquo;</a>'
    }else{
    	str += `<a href="/movie/oneLineReview?SearchMode=`+searchMode+`&query=`+query+`&page=`+(pageLast+1)+`">&raquo;</a>`	//뒤쪽 10페이지의 처음(페이지25에 있다면 페이지 31로)
    }
    if(pageNow==pageNum){
    	str += '<a>끝</a>'
    }else{
    	str += `<a href="/movie/oneLineReview?SearchMode=`+searchMode+`&query=`+query+`&page=`+(pageNum)+`">&nbsp;끝&nbsp;</a>` //맨뒤로
    }
    $('.oneLineReviewSearchPagination').html(str);
		}
   
   
	
	
//---------------------별점생성함수 구현
	
	
	$.fn.generateStars = function() {			//별점생성함수 - 크기는 1.6rem
    	return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*0.8+'rem'));});
    	}
	$('.star-rating').generateStars();		//별점생성함수 호출


});

</script>



<link rel="stylesheet" href="${path}/resources/css/pagination.css"/>

<link	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>


<style>
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);

body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}





#oneLineReviewInputbox{		/*한줄평 검색창*/
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
    position : relative;
}
#oneLineReviewSearchbutton{
    width: 100%;
    height: 100%;
    display: flex;
    align-items : center;
}

#oneLineReviewSearchimage, #modalExitImage{
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
background-color : #ffff88;
}
#checkImg{
position : absolute;
right : 15px;
top : 5px;
max-width : 30px;
max-height : 30px;
display : none;
}
#checkImg.visualized{display : block;
}
#search-result-more{
text-align: center;
font-size : 1rem;
}




.modal{				/*모달창 규격 - 내부는 movieSearch이용(영화 테두리만 바꿈)*/
	position : absolute;
	width : 100vw; height: 100vh;
	background : rgba(0,0,0,0.6);
	top:0; left:0;
	display: none;
}
.modalExit{
	width:60px; height:60px;
	margin: 150px auto 20px auto;
	cursor : pointer;
}
.modal-content{
  background:#333; border-radius:10px;
  width:800px; height:650px;
  position:relative;
  margin: 0px auto;
  text-align:center;
  box-sizing:border-box; padding:74px 0;
  font-size : 12px;
}
.movie-searchContainer{
    border : double 4px #87CEFA77;
}
.movie-searchContainer:hover{
    border : double 4px #87CEFA;
}





/* 별점 */

span.star-rating, span.star-rating > * {
    height: 1.85rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 1.6rem auto;		/* 별점 너비는 1.6rem*/
    background-position: 0 -1.6rem;
    background-repeat: repeat-x; 
    width: 8rem;
    display: inline-block;
}
 
span.star-rating > * {
    background-position: 0 0;
    max-width:8rem; 
}




</style>
</head>
<body>

	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="${language}"/>  
</jsp:include>  


	<h1>한줄평</h1>
	<h2>
	<table border="1">
	<tr><th>Id</th><th>userId</th><th>movieId</th><th>Score</th><th>comment</th><th>likes</th><th>Gendate</th><th>Moddate</th></tr>
		<c:forEach var="r" items="${data}">
			<tr>
				<td>${r.oneLineReviewId}</td>
				<td>${r.userId }</td>
				<td>${r.movieId}</td>
				<td>${r.score} <span class="star-rating">${r.score}</span></td>
				<td>${r.comment}</td>
				<td>${r.likes}</td>
				<td>${r.gendate}</td>
				<td>${r.moddate}</td>
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
						<input type="hidden" name="language" value="${language}">
						<img id="checkImg" src="${path}/resources/img/check.png" onmouseover="this.style.cursor='pointer'">
						<div id="oneLineReviewInputboxSearchResultsContainer"></div>
					</div>
					</form>
					<div id="oneLineReviewSearchbutton-container">
					<div id="oneLineReviewSearchbutton" onmouseover="this.style.cursor='pointer'">
							<img id="oneLineReviewSearchimage"
								src="${path}/resources/img/searchIcon.png"
								alt="search">
							</div>
						</div>
					</div>
			</div>

	
	<div class="pagination oneLineReviewSearchPagination"></div>


	<div class="modal">
		<div class="modalExit"><img id="modalExitImage" src="${path}/resources/img/x.png" alt="exit"></div>
		<div class="modal-content" title="영화를 선택하세요.">
			<div class="movies-searchContainer">
				<div class="movies-searchInnerContainer-padding">
					<div class="movies-searchInnerContainer"></div>
				</div>
			</div>
		</div>
	</div>



</body>
</html>