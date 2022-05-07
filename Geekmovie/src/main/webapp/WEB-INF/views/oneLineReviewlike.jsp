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
<script type="text/javascript" src="${path}/resources/js/InputSearch.js?ver=2"></script>


<script>



	
	
$(document).ready(function(){		

	
	var language = '${language}';
	var starSize = 1.8 //rem
	var starBigSize = 2
	
	var windowResize = function(){					//리사이징 함수

		fontResize()		
		
	}
	
	windowResize();
	window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
		 windowResize();
	}, 20), true);	
	
	
	
	
	
	
	InputSearch("oneLineReviewInputbox", "oneLineReviewInputboxMovieId", "checkImg", "oneLineReviewSearchMode", "oneLineReviewSearchbutton", "oneLineReviewInputboxSearchResultsContainer", language, '${path}', '/movie/oneLineReview');



	
	
	
	 $(document).on("click", ".delete-button", function(e){			//삭제 기능 구현
		var result = confirm("삭제하면 복구할 수 없습니다. \n그래도 삭제 하시겠습니까?");
		if(result){
			var olrid = $(e)[0].currentTarget.dataset.olrid
			$.ajax({
	        url: '/movie/oneLineReview/'+olrid,
	        method: "DELETE",
	          }).done(function(response){
	        	 if(response==1){
	        	 alert("성공적으로 삭제가 완료되었습니다.");
	             location.href = "/movie/oneLineReview?SearchMode=${SearchMode}&query=${query}&page=${page.nowPage}";			//현재페이지 새로고침
	        	 }else{
		        	 alert("삭제가 실패했습니다. \n다시 시도해 주세요.");	        		 
	        	 }
	          });
	        };
	 });
	 
	 $(document).on("click", ".update-button", function(e){			//수정 기능 구현
		
		 var olrContainer = e.currentTarget.parentNode.parentNode.parentNode;
		 var formerHtml = olrContainer.innerHTML;
		var olrid = $(e)[0].currentTarget.dataset.olrid;
	 	let movieName = olrContainer.querySelector(".oneLineReview-Title h3").innerText;
	 	let score = olrContainer.querySelector(".star-rating").dataset.score;
	 	let content = olrContainer.querySelector(".oneLineReview-quoteInside").innerText;	
	 	
		let formStr = '<div class="oneLineReview"><div id="olrCreate-container"><div class="oneLineReview-Title"><h3>'+movieName+'</h3></div></div>';
        formStr += '<div class="oneLineReview-Score"><h3><div class="star-box" data-score="'+score+'"><span class="star-boxFill" style="width : '+(score)+'rem"></span><span class="star" data-score="1"></span><span class="star" data-score="2"></span><span class="star" data-score="3"></span><span class="star" data-score="4"></span><span class="star" data-score="5"></span><span class="star" data-score="6"></span><span class="star"  data-score="7"></span><span class="star"  data-score="8"></span><span class="star"  data-score="9"></span><span class="star"  data-score="10"></span></div></h3>';
        formStr += '</div><div class="oneLineReview-quote"><h5 class="oneLineReview-quoteInside"><textarea id="quote-input" name="opinion" type="text" name=content maxlength=300 placeholder="한줄평을 입력하세요.">'+content+'</textarea></h5><div class="oneLineReview-userId"><h5>- <span class="userId">${sessionScope.id}</span> -</h5></div></div>';
        formStr += '<div class="oneLineReview-gendate"></div><div class="like-dislike"><div class="like-dislike"><div class="update-complete-button like-dislike-button"><span class="functional-button-span">작성</span></div><div class="quit-update-button like-dislike-button"><span class="functional-button-span">취소</span></div></div></div></div>';
        olrContainer.innerHTML = formStr;
        
		$.fn.EditGiveStars = function(number) {	//-------별점부여함수 구현		- 크기는 2rem
		    return this.each(function(i,e){$(e).children(".star-boxFill").width(number*starBigSize/2+'rem')});
		    }
		olrContainer.querySelector(".star-box").addEventListener("click", (function(e){	
	            $(this).EditGiveStars(e.target.dataset.score);
	            $(this)[0].dataset.score = e.target.dataset.score;		//star-box에 정보 저장하여 나중에 제출
	        }));
	 	
		olrContainer.querySelector(".quit-update-button").addEventListener("click", (function(e){	//수정 취소 버튼
			var result = confirm("취소하면 작업한 내용은 사라집니다. \n그래도 취소 하시겠습니까?");
			if(result){
			olrContainer.innerHTML = formerHtml;
			}
        }));
		
		olrContainer.querySelector(".update-complete-button").addEventListener("click", (function(e){	//수정 완료 버튼
			var result = confirm("한줄평을 업데이트 하시겠습니까?");
			if(result){
	    		var olrData = {};
	    		olrData['olrId'] = olrid;
	    		olrData['score'] = olrContainer.querySelector('.star-box').dataset.score;
	    		olrData['content'] = olrContainer.querySelector('#quote-input').value;
				$.ajax({
					   url: '/movie/oneLineReview/'+olrid,
					   method: "PUT",
					   data: JSON.stringify(olrData),
			           dataType: "json",
			           contentType:"application/json;charset=UTF-8",
			           success: function(data){
				           if(data==1){
				   	        	alert("성공적으로 수정이 완료되었습니다.");
					           location.href = "/movie/oneLineReview/like?userId=<%=UserId %>&language=${language}&page=${page.nowPage}";			//현재페이지 새로고침
				           }else{
						       alert("수정에 실패했습니다. \n다시 시도해 주세요.");	        		 
					       }
				       },
				       error: function(){  alert("수정에 실패했습니다. \n다시 시도해 주세요.");  }
				       });
					}
			}));
        });
	 	

	 
	 
	 
	 
	 //---------------좋아요 기능 구현
	 
	$.fn.activeLikeButtons = function() {			// - 이미 눌린 좋아요 버튼 active효과주기
		this.each(function(i,e){
		let olrId = $(e).children()[0].dataset.olrid;
		let mode = Number($(e).hasClass("like-button"));
     	 $.ajax({
			 url: '/movie/oneLineReview/Like/'+olrId+'?userId=${sessionScope.id}&mode='+mode,
			method: "GET",
	        success: function(data){
	        	if(data==1){		   
	        	$(e).addClass("active");
	        	}else{
		        	$(e).removeClass("active"); 
	        	}
	       	},
	       	error: function(request, status, error){
	        	console.log(request, status, error)
	       	}
	       	});
	});
	}
	 
	if('${sessionScope.id}'!=''){
		$(".like-button, .dislike-button").activeLikeButtons();
	}
	
	
	 $(document).on("click", ".like-button, .dislike-button", function(e){		//좋아요 버튼 누를때 이벤트
		 if('${sessionScope.id}'==''){
				var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
				if(result){
				    location.href = 'user_join';
				}
			}else{
				var button = e.currentTarget;
	    		var likeData = {};
	    		var olrId = button.childNodes[0].dataset.olrid;
	    		var likeButton = button.parentElement.querySelector(".like-button");
	    		var dislikeButton = button.parentElement.querySelector(".dislike-button");
	    		likeData['mode'] = Number(button.classList.contains("like-button"));
	    		likeData['userId'] = '${sessionScope.id}';
				$.ajax({
					   url: '/movie/oneLineReview/Like/'+olrId,
					   method: "POST",
					   data: JSON.stringify(likeData),
			           dataType: "json",
			           contentType:"application/json;charset=UTF-8",
			           success: function(data){
				           if(data==1 || data==2){				//성공시 정보 업데이트
				        	   $.ajax({
								   url: '/movie/oneLineReview/'+olrId+'?query=likes',
								   method: "GET",
						           success: function(data){
						        	   likeButton.querySelector(".like-dislike-button-span").innerText = data;
						       		},
						       		error: function(){
						       		location.href = "/movie/oneLineReview/like?userId=<%=UserId %>&language=${language}&page=${page.nowPage}";			//현재페이지 새로고침
						       		}
						       		});
				        	   $.ajax({
								   url: '/movie/oneLineReview/'+olrId+'?query=dislikes',
								   method: "GET",
						           success: function(data){
						        	   dislikeButton.querySelector(".like-dislike-button-span").innerText = data;
						       		},
						       		error: function(){
						       		location.href = "/movie/oneLineReview/like?userId=<%=UserId %>&language=${language}&page=${page.nowPage}";			//현재페이지 새로고침	
						       		}
						       		});
				        	   $(likeButton).activeLikeButtons();
				        	   $(dislikeButton).activeLikeButtons();
				           }else{
				        	   console.log(data)
						       alert("존재하지 않는 대상입니다.");	        		 
					       }
				       },
				       error: function(){  alert("의견이 반영되지 않았습니다.");  }
				       });
				
			}
		 
	 })
	

	
	
	
	
	//---------------------한줄평 한줄평 페이징 기능 구현
	
	
	
oneLineReviewMakePagination( Number(`${page.nowStartPage}`), Number(`${page.nowEndPage}`), Number(`${page.nowPage}`), Number(`${page.endPage}`), '${SearchMode}', '${query}')

function oneLineReviewMakePagination(pageFirst,pageLast, pageNow, pageNum, searchMode, query){					//한줄평 페이징 기능 구현
    var str ='';
    if (pageNow==1){
        str += '<a>처음</a>'
        }else{
            str += `<a href="/movie/oneLineReview/like?userId=<%=UserId %>&language=${language}&page=1">처음</a>`			//처음(페이지 1로)
        }
    if (pageNow<11){
    str += '<a>&laquo;</a>'
    }else{
        str += `<a href="/movie/oneLineReview/like?userId=<%=UserId %>&language=${language}&page=`+(pageFirst-1)+`">&laquo;</a>`		//앞쪽 10페이지의 처음(페이지25에 있다면 페이지 20으로)
    }
    var index = 0
    while(pageFirst+index<=pageNum && pageFirst+index<=pageLast){
    	if(pageFirst+index==pageNow){
    		str += `<a class="active">`+(pageFirst+index)+'</a>'		//현재 페이지
    	}else{
    	str += `<a href="/movie/oneLineReview/like?userId=<%=UserId %>&language=${language}&page=`+(pageFirst+index)+`">`+(pageFirst+index)+'</a>' 	//페이지 10개 생성
    	}
    		index +=1
    }
    if(pageLast>=pageNum){
    	str += '<a>&raquo;</a>'
    }else{
    	str += `<a href="/movie/oneLineReview/like?userId=<%=UserId %>&language=${language}&page=`+(pageLast+1)+`">&raquo;</a>`	//뒤쪽 10페이지의 처음(페이지25에 있다면 페이지 31로)
    }
    if(pageNow==pageNum){
    	str += '<a>끝</a>'
    }else{
    	str += `<a href="/movie/oneLineReview/like?userId=<%=UserId %>&language=${language}&page=`+(pageNum)+`">&nbsp;끝&nbsp;</a>` //맨뒤로
    }
    $('.oneLineReviewSearchPagination').html(str);
		}
   
   
	
	
//---------------------별점생성함수 구현
	
	
	$.fn.generateStars = function() {			//별점생성함수 - 크기는 1.8rem
    	return this.each(function(i,e){
    		let score = $(e).text()
    		$(e).html($('<span/>').width(score*starSize/2+'rem'));
  			$(e)[0].dataset.score = score;
    	});
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
<link rel="stylesheet" href="${path}/resources/css/oneLineReviewList.css?ver=1"/>
<link rel="stylesheet" href="${path}/resources/css/oneLineReviewSearch.css?ver=2"/>
<link rel="stylesheet" href="${path}/resources/css/globalModal.css?ver=1"/>

<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>


<style>
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);

body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}




/* 별점 나타내기*/

span.star-rating, span.star-rating > * {
    height: 2rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 1.8rem auto;		/* 별점 너비는 1.8rem*/
    background-position: 0 -2rem;
    background-repeat: repeat-x; 
    width: 9rem;
    display: inline-block;
}
 
span.star-rating > * {
    background-position: 0 0;
    max-width:9rem; 
}

/*-------한줄평 입력------*/

/*별점 주기*/
.star-box{
    display: flex;
}

.star-box, .star-box .star-boxFill {
    height: 2.2rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 2rem auto;		/* 별점 너비는 1.6rem*/
    background-position: 0 -2.2rem;
    background-repeat: repeat-x; 
    width: 10rem;
}
 
.star-box .star-boxFill {
    background-position: 0 0;
    width: 0;
    max-width:10rem; 
    position: absolute;
}

.star{
    display: block;
    padding: 0;
    margin: 0;
    height: 100%;
    width: 10%;
    z-index: 2;
}

/*한줄평 입력 텍스트*/

#quote-input{
	font-family: 'Nanum Gothic', sans-serif;
	width : 100%;
	font-size : 1rem;
	
}
#olrCreate-Title{
	font-family: 'Nanum Gothic', sans-serif;
    border: none;
    width : 100%;
    height: 2.4rem;
    font-size: 1.4rem;
}

#olrCreate-container .oneLineReview-Title{
	position : relative;
    margin : 0 2rem;
}

#olrCreate-container{
	position : relative;
}

#olrCreate-checkImg{
	right : 4rem;
}
#olrCreate-Searchbutton{
	width: 2rem;
	height: 2rem;
	transform : rotate(0.02deg);
	position : absolute;
	right : 2rem;
	top : 0.2rem;
}

#olrCreate-Searchimage{
width : 100%;
height : 100%;
}

#olrCreate-checkImg{
position : absolute;
right : 4.5rem;
top : 0.3rem;
max-width : 2rem;
max-height : 30rem;
display : none;
}
#olrCreate-checkImg.visualized{display : block;
}


#olrCreate-SearchResultsContainer{
position : absolute;
width : 100%;
z-index : 2;

}


</style>
</head>
<body>

	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="${language}"/>  
</jsp:include>  


	<h1>내가 좋아한 한줄평</h1>

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
			<div class="oneLineReview-Title"><h3 onclick='location.href=`/movie/movieDetail?movieId=<%=oneLineReview.getMovieId() %>&language=${language}`;'><%=oneLineReview.getMovieId() %></h3></div>
			<div class="oneLineReview-Score"><h3><span class="star-rating"><%=oneLineReview.getScore() %></span></h3></div>
			<div class="oneLineReview-quote"><h5 class="oneLineReview-quoteInside"><%=oneLineReview.getComment() %></h5>
			<div class="oneLineReview-userId"><h5>- <span class="userId"><%=oneLineReview.getOneLineReviewLikeVo().getUserId() %></span> -</h5></div>
			</div>

			<div class="oneLineReview-gendate"><h6>작성 : <%=oneLineReview.getGendate() %></h6><% if (oneLineReview.getModdate()!=null){ %><h6>수정 : <%=oneLineReview.getModdate() %><% }%> &nbsp;</h6></div>
			<div class="like-dislike">
				<div class="like-button like-dislike-button"><span class="like-button-span like-dislike-button-span" data-olrId='<%=oneLineReview.getOneLineReviewId() %>'><%=oneLineReview.getLikes() %></span><img class="like-icon" src="${path}/resources/img/like.png"></div>
				<div class="dislike-button like-dislike-button"><span class="dislike-button-span like-dislike-button-span" data-olrId='<%=oneLineReview.getOneLineReviewId() %>'><%=oneLineReview.getDislikes() %></span><img class="dislike-icon" src="${path}/resources/img/dislike.png"></div>
				<% if(UserId != null && oneLineReview.getOneLineReviewLikeVo().getUserId().equals(UserId)){ %>
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
						<input type="hidden" id="oneLineReviewInputboxMovieId" name="movieId" value="">
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