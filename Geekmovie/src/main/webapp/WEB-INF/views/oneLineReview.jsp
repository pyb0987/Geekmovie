<%@page import="com.geekmovie.onelinereview.vo.OneLineReviewVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <c:set var="path" value="${pageContext.request.contextPath}"/>
 
 
<% 
List<OneLineReviewVo> oneLineReviewList = (List<OneLineReviewVo>)request.getAttribute("data");
String UserId = (String)session.getAttribute("id");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GeekLineReview</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/debounce.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript" src="${path}/resources/js/oneLineReviewSearch.js"></script>


<script>



	
	
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
	
	


	
	document.querySelector("#oneLineReviewCreate").addEventListener('click', function(){			//한줄평 쓰기 기능 구현
		if('${sessionScope.id}'==''){
			var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
			if(result){
			    location.href = 'join';
			}
		}else{
			var formStr = '<div class="oneLineReviewOuterContainer oneLineReviewCreate"><div class="oneLineReview-pictureContainer"><div class="oneLineReview-pictureInnerContainer"></div></div><div class="oneLineReviewContainer"><div class="oneLineReview">';
			formStr += '<div class="oneLineReview-Title"><h2><input type="text" id="title-input" name="query" autocomplete="off" maxlength=50 placeholder="영화제목"></h2></div>';
			formStr += '<div class="oneLineReview-Score"><h3><span class="star-rating">0</span></h3></div>';
			formStr += '<div class="oneLineReview-quote"><h5 class="oneLineReview-quoteInside"><textarea id="quote-input" name="opinion" type="text" name=content maxlength=300 placeholder="한줄평을 입력하세요."></textarea></h5>';
			formStr += '<div class="oneLineReview-userId"><h5>- <span class="userId">${sessionScope.id}</span> -</h5></div></div>';
			formStr += '<div class="oneLineReview-gendate"></div><div class="like-dislike">'
			formStr += '<div class="like-dislike">'
			formStr +='<div class="create-button like-dislike-button"><span class="functional-button-span">작성 완료</span></div><div class="quit-button like-dislike-button"><span class="functional-button-span">취소</span></div></div></div></div></div>'

			$("#oneLineReviewsContainer").prepend(formStr);
			document.querySelector(".oneLineReviewCreate .oneLineReview-Title #title-input").focus();
			
			$("#quote-input").on("propertychange change keyup paste input", throttle(function(e){			//입력시 한줄평 입력칸의 크기를 100ms마다 바꿈
				$(this).css("height", 'auto');
				$(this).height(this.scrollHeight);
			}, 100));
		}
	}, { once : true});
	
	
	
	 $(".delete-button").on("click", function(e){			//삭제 기능 구현
		var result = confirm("삭제하면 복구할 수 없습니다. \n 그래도 삭제 하시겠습니까?");
		if(result){
			var olrid = $(e)[0].currentTarget.dataset.olrid
			$.ajax({
	        url: '/movie/oneLineReview/'+olrid,
	        method: "DELETE",
	          }).done(function(response){
	        	 if(response==1){
	        	 alert("성공적으로 삭제가 완료되었습니다.");
	             location.href = "/movie/oneLineReview?SearchMode=${SearchMode}&query=${query}&page=${page.nowPage}";
	        	 }else{
		        	 alert("삭제가 실패했습니다. \n다시 시도해 주세요.");	        		 
	        	 }
	          });
	        };
	 });

	
	

	
	
	
	
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
    	return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*0.9+'rem'));});
    	}
	$('.star-rating').generateStars();		//별점생성함수 호출

	
//-------------------movieId로부터 제목과 포스터 받아오기
	
	$(".oneLineReviewOuterContainer").each(function(i, e){
		var movieId = $(e).find(".oneLineReview-Title h3").html()
		var userId = $(e).find(".userId").html()
		$.ajax({	
        	type: 'GET',
        	url: `/movie/getMovieData?movieId=`+movieId+`&language=${language}`,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		if(!!data.poster_path){
            		var imgpath = 'https://image.tmdb.org/t/p/w500/'+data.poster_path   //포스터
            		}else{
            		var imgpath = '${pageContext.request.contextPath}/resources/img/noImage.jpg'
            		}
        			var str1 = `<div class="oneLineReview-picture" style='background: url("`+imgpath+`"); background-repeat: no-repeat; background-position: center; background-size : cover'></div>`
        			$(e).find(".oneLineReview-pictureInnerContainer").html(str1);
        			$(e).find(".oneLineReview-Title h3").html(data.title)	
        			}
        
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        })
	
	})

});

</script>


<link rel="stylesheet" href="${path}/resources/css/movieSearch.css"/>
<link rel="stylesheet" href="${path}/resources/css/pagination.css?ver=1"/>
<link rel="stylesheet" href="${path}/resources/css/oneLineReviewList.css"/>
<link rel="stylesheet" href="${path}/resources/css/oneLineReviewSearch.css"/>
<link rel="stylesheet" href="${path}/resources/css/globalModal.css"/>

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




/* 별점 */

span.star-rating, span.star-rating > * {
    height: 2rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 1.8rem auto;		/* 별점 너비는 1.6rem*/
    background-position: 0 -2rem;
    background-repeat: repeat-x; 
    width: 9rem;
    display: inline-block;
}
 
span.star-rating > * {
    background-position: 0 0;
    max-width:9rem; 
}


#quote-input{
	font-family: 'NanumSquareRoundBold';
	width : 100%;
	font-size : 1rem;
	
}
#title-input{
	font-family: 'NanumSquareRoundBold';
    border: none;
    height: 2rem;
    width : 80%;
    font-size: 1.4rem;
}




</style>
</head>
<body>

	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="${language}"/>  
</jsp:include>  


	<h1>한줄평</h1><h3 id="oneLineReviewCreate">쓰기</h3>

	<div id="oneLineReviewsContainer">
	<%
	for(OneLineReviewVo oneLineReview : oneLineReviewList){
	%>
					<div class="oneLineReviewOuterContainer">
				<div class="oneLineReview-pictureContainer">
			<div class="oneLineReview-pictureInnerContainer"></div>
		</div>
		<div class="oneLineReviewContainer">
		<div class="oneLineReview">
			<div class="oneLineReview-Title"><h3><%=oneLineReview.getMovieId() %></h3></div>
			<div class="oneLineReview-Score"><h3><span class="star-rating"><%=oneLineReview.getScore() %></span></h3></div>
			<div class="oneLineReview-quote"><h5 class="oneLineReview-quoteInside"><%=oneLineReview.getComment() %></h5>
			<div class="oneLineReview-userId"><h5>- <span class="userId"><%=oneLineReview.getUserId() %></span> -</h5></div>
			</div>

			<div class="oneLineReview-gendate"><h6>작성 : <%=oneLineReview.getGendate() %></h6><h6>수정 : <%=oneLineReview.getModdate() %></h6></div>
			<div class="like-dislike">
				<div class="like-button like-dislike-button"><span class="like-button-span like-dislike-button-span"><%=oneLineReview.getLikes() %></span><img class="like-icon" src="${path}/resources/img/like.png"></div>
				<div class="dislike-button like-dislike-button"><span class="dislike-button-span like-dislike-button-span"><%=oneLineReview.getDislikes() %></span><img class="dislike-icon" src="${path}/resources/img/dislike.png"></div>
				<% if(UserId != null && oneLineReview.getUserId().equals(UserId)){ %>
				<div class="update-button like-dislike-button" style="width : 4.5rem;" data-olrId='<%=oneLineReview.getOneLineReviewId() %>'><span class="functional-button-span">수정</span></div>
        		<div class="delete-button like-dislike-button" style="width : 4.5rem;" data-olrId='<%=oneLineReview.getOneLineReviewId() %>'><span class="functional-button-span">삭제</span></div>
        		<%} %>
			</div>
		</div>
		</div>
			</div>
		
	
	
		
	<%
	}
	%>

	</div>
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
						<input type="hidden" name="page" value="1">
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

	<div class="pagination-container" style="margin-top : 30px;">
	<div class="pagination oneLineReviewSearchPagination"></div>
	</div>
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