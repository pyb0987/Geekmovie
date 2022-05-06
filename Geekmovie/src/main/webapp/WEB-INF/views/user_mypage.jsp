<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
    
<% 
	String id = (String)session.getAttribute("id");
	if(id == null) id= "product";
	String password = (String)session.getAttribute("password");
	String name =(String)session.getAttribute("name");
	String birthday = (String)session.getAttribute("birthday");
	String gender =(String)session.getAttribute("gender");
	System.out.println(id);
	System.out.println(birthday);
%>

<%if(id=="product"){%>
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
<link	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>
<link rel="stylesheet" href="${path}/resources/css/mypage_style.css?ver=4">
<style>
.star-rating, .star-rating > * {
    height: 1.4rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 1.3rem auto;		/* 별점 너비는 1.3rem*/
    background-position: 0 -1.4rem;
    background-repeat: repeat-x; 
    width: 6.5rem;
    display: inline-block;
}
 
.star-rating > * {
    background-position: 0 0;
    max-width:6.5rem; 
}
</style>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	
	var windowResize = function(){					//리사이징 함수

	fontResize()
	if(window.innerWidth<1200){
	    $("#content-grid").css("grid-template-columns", "1fr");
	}else{
		$("#content-grid").css("grid-template-columns", "1fr 1fr");
	}
	if(window.innerWidth<750){
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
		console.log(movieId)
		$.ajax({	
        	type: 'GET',
        	url: `/movie/getMovieData?movieId=`+movieId+`&language=<%=Language %>`,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        			if(!!data.poster_path){
            		var imgpath = 'https://image.tmdb.org/t/p/w500/'+data.poster_path   //포스터
            		}else{
            		var imgpath = '${pageContext.request.contextPath}/resources/img/noImage.jpg'
            		}
        			//$(e).data('img', imgpath);
        			//$(e).data('id', movieId);
        			//$(e).data('overview', data.overview);
        			//$(e).data('date', data.release_date);
        			$(e).html(data.title);	
        	}
        
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        })
	
	})
	}

	

	
	
	$.ajax({							//내가 작성한 한줄평
    	type: 'GET',
    	url: `/movie/oneLineReview/user/<%=id%>`,
    	dataType : 'json',
    	contentType : 'application/json', 
    	success: function(data){
    		$("#user-olr-container .user-container-content").each(function(i, e){
    			$(e).data("olrid",data[i].oneLineReviewId);
    			$(e).children(".user-content-movie").data("movieId", data[i].movieId);
    			$(e).children(".user-content-title").html("<h5>"+data[i].comment+" [+"+data[i].likes+"]"+"</h5>");
    			$(e).find(".star-rating").html(data[i].score);
    			$(e).children(".user-content-movie").html("<h5>"+data[i].movieId+"</h5>");
    			var date = new Date(data[i].gendate);
    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
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
    		console.log(data)
    	},
        error: function(request, status, error){
        	console.log(request, status, error)
        }
    	
	})
	
	
	$(document).on("click", ".user-content-movie h5", function(e){			//영화 링크 연결
		e.stopPropagation();
	 let movieId = $(e.currentTarget).parents(".user-content-movie").data("movieId");
	location.href = '/movie/movieDetail?movieId='+movieId+'&language=<%=Language %>'
	});
	
	$(document).on("click", "#user-olr-container .user-container-content", function(e){			//영화 링크 연결
		let olrId = $(e.currentTarget).data("olrid");
		console.log(olrId)
		$.ajax({							//내가 작성한 한줄평
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
	})

});
</script>
</head>
<body>

	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=Language %>"/>  
</jsp:include>

	<div id="content-container">
		<div id="content-grid">
			<div id="user-board-container" class="user-container"></div>
			<div id="user-boardLike-container" class="user-container"></div>
			<div id="user-boardComment-container" class="user-container"></div>
			<div id="user-freeboard-container" class="user-container"></div>
			<div id="user-freeboardLike-container" class="user-container"></div>
			<div id="user-freeboardComment-container" class="user-container"></div>
			<div id="user-olr-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 작성한 한줄평</h3>
					<h4 class="seeMoreLink" onclick="location.href = 'oneLineReview?SearchMode=author&query=<%=id%>&language=<%=Language %>&page=1'">&#43;더 보기</h4>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				</div>
			</div>
			<div id="user-olrLike-container" class="user-container">
				<div class="user-container-title">
					<h3>내가 좋아한 한줄평</h3>
					<h4 class="seeMoreLink" onclick="location.href = 'oneLineReview?SearchMode=author&query=<%=id%>&language=<%=Language %>&page=1'">&#43;더 보기</h4>
				</div>
				<div class="user-container-contents">
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				<div class=user-container-content><div class="user-content-title"></div><div class="user-content-score"><span class="star-rating"></span></div><div class="user-content-movie"></div><div class="user-content-gendate"></div></div>
				</div>
			</div>
			<div id="user-movieLike-container" class="user-container"></div>
			<div id="user-movieAdd-container" class="user-container"></div>
		</div>

	</div>
	<div id="info-container">
	
	<h3 id="info-title"><%=name%>님의 마이페이지입니다.</h3>
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
		 		<td class="info-name"><h5><label id="must_password"> * </label><label id="text_id" class="text_front">비밀번호 </label></h5></td>
		 		<td class="info-content"><h5><input type="hidden" name="password" value="password"><label id="text_id"><%=password%></label></h5></td>
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
	
	
	
	
</body>
</html>