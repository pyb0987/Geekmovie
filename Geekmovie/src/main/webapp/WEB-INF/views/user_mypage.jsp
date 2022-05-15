<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
    
<% 
	String id = (String)session.getAttribute("id");
	String password = (String)session.getAttribute("password");
	String name =(String)session.getAttribute("name");
	String birthday = (String)session.getAttribute("birthday");
	String gender =(String)session.getAttribute("gender");
	System.out.println(id);
	System.out.println(birthday);
%>

<%if(id==null){%>
	<script>
		alert('비정상 접근입니다. 로그인 후 이용 바랍니다.');
		document.location.href="/movie";
	</script>
<%}%>

<% String Language = "ko-KR"; %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My page Test</title>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>
<link rel="stylesheet" href="${path}/resources/css/mypage_style.css?ver=1">
<style>
.star-rating, .star-rating > * {
    height: 1.4rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 1.3rem auto;		/* 별점 너비는 1.3rem*/
    background-position: 0 -1.5rem;
    background-repeat: repeat-x; 
    width: 6.5rem;
    display: inline-block;
}
 
.star-rating > * {
    background-position: 0 0;
    max-width:6.5rem; 
}

.user-movie-score .oneStar{
	height: 1.4rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 1.4rem auto;		
    background-position: 0 0;
    background-repeat: no-repeat; 
    width: 1.4rem;
    display: inline-block;

}
</style>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript">
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

	fontResize()
	if(window.innerWidth<1200){
	    $("#content-grid").css("grid-template-columns", "1fr");
		$(".user-movies-container").css("grid-template-columns" , "1fr 1fr 1fr 1fr");
	    $("#user-movieLike-container, #user-movieAdd-container").css("grid-column", "1 / span 1");

	}else{
		
		$("#content-grid").css("grid-template-columns", "1fr 1fr");
		$(".user-movies-container").css("grid-template-columns" , "1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr");
	    $("#user-movieLike-container, #user-movieAdd-container").css("grid-column", "1 / span 2");
	}
	if(window.innerWidth<650){
	    $("body").css("flex-direction", "column-reverse");
	}else{
		 $("body").css("flex-direction", "row");
	}
	}

	windowResize();
	var ResizeTimer;
	window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
	 	windowResize();
	}, 20), true);
	
	var starSize=1.3;
	$.fn.generateStars = function() {			//별점생성함수 - 크기는 1.3rem
    	return this.each(function(i,e){
    		let score = $(e).text()
    		$(e).html($('<span/>').width(score*starSize/2+'rem'));
  			$(e)[0].dataset.score = score;
    	});
    	}
	
	function movieData(containerId){			//movieId로부터 영화제목 가져오기
	$("#"+containerId+" .user-content-movie h5").each(function(i, e){
		var movieId = $(e).html()
		$.ajax({	
        	type: 'GET',
        	url: `/movie/getMovieData?movieId=`+movieId+`&language=<%=Language %>`,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        			$(e).html(data.title);	
        	}
        
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        })
	
	})
	}


	$.ajax({							//내가 작성한 리뷰게시글
    	type: 'GET',
    	url: `/movie/boardList/<%=id%>`,
    	dataType : 'json',
    	contentType : 'application/json', 
    	success: function(data){
    		$("#user-board-container .user-container-content").each(function(i, e){
    			if(!!data[i]){
    			$(e).data("reviewId",data[i].seq);
    			$(e).children(".user-content-movie").data("movieId", data[i].movie_id);
    			$(e).children(".user-content-title").html("<h5>"+data[i].title+"</h5>");
    			$(e).children(".user-content-recommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
    			$(e).children(".user-content-score").html("<span class='star-rating'></span>");
    			$(e).find(".star-rating").html(data[i].b_score);
    			$(e).children(".user-content-movie").html("<h5>"+data[i].movie_id+"</h5>");
    			var date = new Date(data[i].regdate);
    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
    			}else{
    				$(e).removeClass("user-container-content");
    			}
    		});
    		$('#user-board-container .star-rating').generateStars();		//별점생성함수 호출
    		movieData('user-board-container');
    		},
        error: function(request, status, error){
        	console.log(request, status, error)
        }
    	
	})
	
	$.ajax({							//내가 작성한 자유게시글
    	type: 'GET',
    	url: `/movie/freeboardList/<%=id%>`,
    	dataType : 'json',
    	contentType : 'application/json', 
    	success: function(data){
    		$("#user-freeboard-container .user-container-content").each(function(i, e){
    			if(!!data[i]){
    			$(e).data("reviewId",data[i].seq);
    			$(e).children(".user-content-movie").data("movieId", data[i].movie_id);
    			$(e).children(".user-content-freetitle").html("<h5>"+data[i].title+"</h5>");
    			$(e).children(".user-content-freerecommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
    			$(e).children(".user-content-freereply").html("<h5>(+"+data[i].reply+")</h5>");
    			$(e).children(".user-content-freeid").html("<h5>"+data[i].writer+"</h5>");
    			$(e).children(".user-content-freemovie").html("<h5>"+data[i].movie_id+"</h5>");
    			var date = new Date(data[i].regdate);
    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
    			}else{
    				$(e).removeClass("user-container-content");
    			}
    		});
    	},
        error: function(request, status, error){
        	console.log(request, status, error)
        }
    	
	})
	
	
	
		$.ajax({							//내가 좋아한 자유게시글
    	type: 'GET',
    	url: `/movie/freeboard/user/<%=id%>?nowPageStart=0&Size=10`,
    	dataType : 'json',
    	contentType : 'application/json', 
    	success: function(data){
    		$("#user-freeboardLike-container .user-container-content").each(function(i, e){
    			if(!!data[i]){
    				$(e).data("reviewId",data[i].seq);
        			$(e).children(".user-content-movie").data("movieId", data[i].movie_id);
        			$(e).children(".user-content-freetitle").html("<h5>"+data[i].title+"</h5>");
        			$(e).children(".user-content-freerecommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
        			$(e).children(".user-content-freereply").html("<h5>(+"+data[i].reply+")</h5>");
        			$(e).children(".user-content-freeid").html("<h5>"+data[i].writer+"</h5>");
        			$(e).children(".user-content-freemovie").html("<h5>"+data[i].movie_id+"</h5>");
        			var date = new Date(data[i].regdate);
        			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
        			}else{
        				$(e).removeClass("user-container-content");
        			}
    		});
    		},
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
    	
	})
	
			$.ajax({							//내가 작성한 댓글
    	type: 'GET',
    	url: `/movie/freeboard/reply/user/<%=id%>?start=0&size=10`,
    	dataType : 'json',
    	contentType : 'application/json', 
    	success: function(data){
    			console.log(data)
    		$("#user-freeboardComment-container .user-container-content").each(function(i, e){
    			if(!!data[i]){
    				$(e).data("replyId",data[i].replyId);
    				$(e).data("boardId",data[i].boardId);
        			$(e).children(".user-content-replycontent").html("<h5>"+data[i].content+"</h5>");
        			$(e).children(".user-content-replyrecommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
        			var date = new Date(data[i].create_date);
        			$(e).children(".user-content-freereplydate").html("<h5>"+date.toLocaleDateString()+"</h5>");
    				
        			}else{
        				$(e).removeClass("user-container-content");
        			}
    		});
    		},
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
    	
	})

	$.ajax({							//내가 작성한 한줄평
    	type: 'GET',
    	url: `/movie/oneLineReview/user/<%=id%>`,
    	dataType : 'json',
    	contentType : 'application/json', 
    	success: function(data){
    		$("#user-olr-container .user-container-content").each(function(i, e){
    			if(!!data[i]){
    			$(e).data("olrid",data[i].oneLineReviewId);
    			$(e).children(".user-content-movie").data("movieId", data[i].movieId);
    			$(e).children(".user-content-title").html("<h5>"+data[i].comment+"</h5>");
    			$(e).children(".user-content-recommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
    			$(e).children(".user-content-score").html("<span class='star-rating'></span>");
    			$(e).find(".star-rating").html(data[i].score);
    			$(e).children(".user-content-movie").html("<h5>"+data[i].movieId+"</h5>");
    			var date = new Date(data[i].gendate);
    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
    			}else{
    				$(e).removeClass("user-container-content");
    			}
    		});
    		$('#user-olr-container .star-rating').generateStars();		//별점생성함수 호출
    		movieData('user-olr-container');
    		},
        error: function(request, status, error){
        	console.log(request, status, error)
        }
    	
	})
	
	$.ajax({							//내가 좋아한 한줄평
    	type: 'GET',
    	url: `/movie/oneLineReview/user/<%=id%>/like?nowPageStart=0&Size=10`,
    	dataType : 'json',
    	contentType : 'application/json', 
    	success: function(data){
    		$("#user-olrLike-container .user-container-content").each(function(i, e){
    			if(!!data[i]){
    			$(e).data("olrid",data[i].oneLineReviewId);
    			$(e).children(".user-content-movie").data("movieId", data[i].movieId);
    			$(e).children(".user-content-title").html("<h5>"+data[i].comment+"</h5>");
    			$(e).children(".user-content-recommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
    			$(e).children(".user-content-score").html("<span class='star-rating'></span>");
    			$(e).find(".star-rating").html(data[i].score);
    			$(e).children(".user-content-movie").html("<h5>"+data[i].movieId+"</h5>");
    			var date = new Date(data[i].gendate);
    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
    			}else{
    				$(e).removeClass("user-container-content");
    			}
    		});
    		$('#user-olrLike-container .star-rating').generateStars();		//별점생성함수 호출
    		movieData('user-olrLike-container');
    		},
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
    	
	})
	
	
	function movieGenerate(movieContainerId, moviestart, moviesize, mode){		//영화 생성함수
		var movieContainer = document.querySelector("#"+movieContainerId);
		$.ajax({					
    	type: 'GET',
    	url: `/movie/Like/User/<%=id%>?mode=`+mode+`&start=`+moviestart+`&size=`+moviesize,
    	dataType : 'json',
    	contentType : 'application/json', 
    	success: function(data){
    		if(data.length<moviesize){
    			$(movieContainer).children(".more-button-container").empty();
    		}
    		data.forEach(function(item, index){
    			
    			$.ajax({	
    	        	type: 'GET',
    	        	url: `/movie/getMovieData?movieId=`+item.movieId+`&language=<%=Language %>`,
    	        	dataType : 'json',
    	        	contentType : 'application/json', 
    	        	success: function(movie){
    	        		$(movieContainer).children(".user-movies-container").append('<div class="user-movie-container"><div class="user-movie-image"><div class="user-movie-hover"></div><div class="user-movie-title"></div><div class="user-movie-score"></div></div></div>');
    	    			 var iterMovie = movieContainer.querySelector(".user-movie-container:last-child");
    	    				$(iterMovie).data("movieId",item.movieId);
    	        			if(!!movie.poster_path){
    	        				imageUrl = "https://image.tmdb.org/t/p/w342"+movie.poster_path;
    	        			}else{
    	        				imageUrl = `${path}/resources/img/noImage.jpg`       		//사진이 없을때 이미지			
    	        			}
    	        		
    					var genreAry = [];
    					movie.genres.forEach(function(genre){
    	        			genreAry.push(genreMap.get(genre.id))
    					})
    					
    	        			
    	        			$(iterMovie).find(".user-movie-image").css('background', 'url("'+imageUrl+'")').css('background-size', 'cover').css('background-repeat', 'no-repeat').css('background-position','center center');
    	        			$(iterMovie).find(".user-movie-title").html('<h5>'+movie.title+'</h5><h6>'+genreAry.join(' ,')+'</h6>');
    	        			$(iterMovie).find(".user-movie-score").html("<span class='oneStar'></span><h6>"+movie.vote_average+"</h6>")

    	        	}
    	        	,
    	        	error: function(request, status, error){
    	        		console.log(request, status, error)
    	        	}
    	        })
    			
    			
    		})


    		},
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
    	
		})
	}
	
	movieGenerate('user-movieLike-container', 0,8,1)		//내가 좋아한 영화
	movieGenerate('user-movieAdd-container', 0,8,0)		//내가 찜한 영화
	
	
	$(document).on("click", ".user-content-movie, .user-movie-container", function(e){			//전제 영화 링크 연결
		e.stopPropagation();
	 let movieId = $(e.currentTarget).data("movieId");
	location.href = '/movie/movieDetail?movieId='+movieId+'&language=<%=Language %>'
	});
	
	
	$(document).on("click", "#user-board-container .user-container-content", function(e){			//리뷰 링크 연결
		let seq = $(e.currentTarget).data("reviewId");
		if(!!seq){
			location.href = '/movie/boardDetail?seq='+seq+'&searchType=Wr&bKeyword=<%=id%>&curPage=1&range=1';
		   
		}
	})
	
	$(document).on("click", "#user-freeboard-container .user-container-content, #user-freeboardLike-container .user-container-content", function(e){			//자유게시글 링크 연결
		let seq = $(e.currentTarget).data("reviewId");
		if(!!seq){
			location.href = '/movie/freeboardDetail?seq='+seq+'&searchType=Wr&bKeyword=<%=id%>&curPage=1&range=1';
		   
		}
	})
	
	$(document).on("click", "#user-freeboardComment-container .user-container-content", function(e){			//자유게시글 댓글 링크 연결

		let replyId = $(e.currentTarget).data("replyId");
		let boardId = $(e.currentTarget).data("boardId");
		if(!!boardId){
			location.href = '/movie/freeboardDetail?seq='+boardId+'&searchType=Wr&bKeyword=<%=id%>&curPage=1&range=1&focus='+replyId;
		   
		}
	})
	
	
	
	$(document).on("click", "#user-olr-container .user-container-content, #user-olrLike-container .user-container-content", function(e){			//한줄평 링크 연결
		let olrId = $(e.currentTarget).data("olrid");
		if(!!olrId){
			$.ajax({							
		    	type: 'GET',
		    	url: `oneLineReview/page/`+olrId,
		    	dataType : 'text',
		    	success: function(data){
				location.href = '/movie/oneLineReview?page='+data+'&language=<%=Language %>&focus='+olrId;
		    	},
		    	error: function(request, status, error){
		        	console.log(request, status, error)
		        }
				});
		}
	})
	var Likemoviestart = 8;
	var Likemoviesize = 8;
	$("#user-movieLike-container .moreMovie").click(function(){
		movieGenerate('user-movieLike-container', Likemoviestart,Likemoviesize,1)		//내가 좋아한 영화 버튼클릭
		Likemoviestart += Likemoviesize;
		Likemoviesize += 8;
	});
	var Addmoviestart = 8;
	var Addmoviesize = 8;
	$("#user-movieAdd-container .moreMovie").click(function(){
		movieGenerate('user-movieAdd-container', Addmoviestart,Addmoviesize,0)		//내가 찜한 영화 버튼클릭
		Addmoviestart += Addmoviesize;
		Addmoviesize += 8;
	});
	
	
	

});
</script>
</head>
<body>

	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=Language %>"/>  
</jsp:include>
<section>
	<div id="content-container">
		<div id="content-grid">
			<div id="user-board-container" class="user-container">
			<div class="user-container-title">
					<h3>내가 작성한 리뷰</h3>
					<h4 class="seeMoreLink" onclick="location.href = 'boardList?searchType=Wr&bKeyword=<%=id%>&page=1'">&#43;더 보기</h4>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				</div>
			</div>
			<div id="user-freeboard-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 작성한 자유게시글</h3>
					<h4 class="seeMoreLink" onclick="location.href = 'freeboardList?searchType=Wr&bKeyword=<%=id%>&curPage=1'">&#43;더 보기</h4>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>

				</div>
			</div>
			<div id="user-freeboardLike-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 좋아한 자유게시글</h3>
					<h4 class="seeMoreLink" onclick="location.href = 'freeboardList/like/<%=id%>?curPage=1'">&#43;더 보기</h4>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				</div>
			</div>
			<div id="user-freeboardComment-container" class="user-container">
				<div class="user-container-title">
					<h3>최근에 작성한 댓글</h3>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				<div class=user-container-content><div class="user-content-replycontent"></div><div class="user-content-replyrecommend"></div><div class="user-content-freereplydate"></div></div>
				</div>
			</div>
			<div id="user-boardLike-container" class="user-container"></div>
			<div id="user-freeboardLike-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 좋아한 자유게시글</h3>
					<h4 class="seeMoreLink" onclick="location.href = 'freeboardList/like/<%=id%>?curPage=1'">&#43;더 보기</h4>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-freetitle"></div><div class="user-content-freerecommend"></div><div class="user-content-freereply"></div><div class="user-content-freeid"></div><div class="user-content-freemovie"></div><div class="user-content-gendate"></div></div>

				</div>
			</div>
			<div id="user-boardComment-container" class="user-container"></div>
			<div id="user-olr-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 작성한 한줄평</h3>
					<h4 class="seeMoreLink" onclick="location.href = 'oneLineReview?SearchMode=author&query=<%=id%>&language=<%=Language %>&page=1'">&#43;더 보기</h4>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				</div>
			</div>
			<div id="user-olrLike-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 좋아한 한줄평</h3>
					<h4 class="seeMoreLink" onclick="location.href = 'oneLineReview/like?userId=<%=id%>&language=<%=Language %>&page=1'">&#43;더 보기</h4>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-score"></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				</div>
			</div>
			<div id="user-movieLike-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 좋아한 영화</h3>
				</div>
				<div class="user-movies-container"></div>
				<div class="more-button-container">
					<div class="moreMovie">더 보기</div>
				</div>
			</div>
			<div id="user-movieAdd-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 찜한 영화</h3>
				</div>
				<div class="user-movies-container"></div>
				<div class="more-button-container">
					<div class="moreMovie">더 보기</div>
				</div>
			</div>
		</div>

	</div>
	<div id="info-container">
	
	<h4 id="info-title"><%=name%>님의 마이페이지입니다.</h4>
	<div id="regist_wrap" class="wrap">
      <div>
         <!-- form method : post 방식 -->
         <form method="post" name="regiform" id="regist_form" class="form">
		 <table>
		 	<tr>
		 		<td class="info-name"><h5><label id="must_id"> * </label> <label id="text_id" class="text_front">아이디 </label></h5></td>
		 		<td class="info-content"><h5><input type="hidden" name="id" value="id"><label id="text_id"><%=id%></label></h5></td>
		 	</tr>
		 	<tr>
		 		<td class="info-name"><h5><label id="must_name"> * </label><label id="text_id" class="text_front"> 이름 </label></h5></td>
		 		<td class="info-content"><h5><input type="hidden" name="name" value="name"><label id="text_id"><%=name%></label></h5></td>
		 	</tr>
		 	<tr>
		 		<td class="info-name"><h5><label id="must_birthday"> * </label><label id="text_id" class="text_front"> 생년월일 </label></h5></td>
		 		<td class="info-content"><h5><input type="hidden" name="birthday" value="birthday"><label id="text_id"><%=birthday%></label></h5></td>
		 	</tr>
		 	<tr>
		 		<td class="info-name"><h5><label id="must_gender"> * </label><label id="text_id" class="text_front"> 성별 </label></h5></td>
		 		<td class="info-content"><h5><input type="hidden" name="gender" value="gender"><label id="text_id"><%=gender%></label></h5></td>
		 	</tr>
		 </table>
		</form>
			<div class="hr">
				<hr>
			</div>
		 	<p class="signup_btn-container">
			<input type="button" value = "회원정보 수정" class="signup_btn1" onclick="location.href='user_update_mypage'">
			</p>
			<p class="signup_btn-container">
			<input type="submit" value="회원 탈퇴" class="signup_btn2" onclick="location.href='user_delete_mypage'">
			</p>
		</div>
	</div>
	
	
	</div>
	
</section>
<jsp:include page="./common/footer.jsp">  
<jsp:param name="language" value="ko-KR"/>  
</jsp:include>  
	
</body>
</html>