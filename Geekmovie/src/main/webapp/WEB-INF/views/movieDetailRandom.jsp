
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GeekRandomMovie</title>

<link rel="stylesheet" href="${path}/resources/css/movieDetail.css?"/>
<link rel="stylesheet" href="${path}/resources/css/movieSlide.css?ver=2"/>
<link rel="stylesheet" href="${path}/resources/css/movieCast.css?"/>
<link rel="stylesheet" href="${path}/resources/css/movieCrew.css?"/>

<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>
<link rel="stylesheet" href="${path}/resources/css/movieLike.css"/>

<style>
@import
	url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);	/*슬라이드 아이콘*/
body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}

#credit{
	margin: 0 auto;
	max-width : 1400px;
	min-width : 620px;
}

#userSpace{
 display : flex;
}


.board-container{
display : flex;
flex-direction: column;
width : 50%;
padding : 30px;
}

.board{
width : 100%;
height : 100%;
background-color : white;
}

.creditName{
padding-left: 30px;
}



.arrow {
  cursor: pointer;
  position: absolute;
  width: 70px;
  height: 70px;
  border: solid 6px #bbb;
  border-radius: 100%;
  z-index: 3;
  transition: all 0.2s linear;
  box-sizing: border-box;
  right: 30px;top: 40%;

}
.arrow:before, .arrow:after {
  content: "";
  position: absolute;
  display : block;
  width: 35%;
  height: 10%;
  top: 41%;
  left: 55%;
  background: #bbb;
  z-index: 4;
  transform: translate(-50%, -50%) rotate(45deg);
  transition: all 0.2s linear;
  box-sizing: border-box;
}

.arrow-left{
	left : 30px;
	transform: rotate(180deg);
}
.arrow:after {
  z-index: 5;
  top: 59%;
  left: 55%;
  transform: translate(-50%, -50%) rotate(-45deg);
}
.arrow:hover {
  border: solid 8px #777;
}
.arrow:hover:after, .arrow:hover:before {
  background: #777;
}
.arrow:active {
  border: solid 8px #111;
}
.arrow:active:after, .arrow:active:before {
  background: #111;
}

.seeMoreBoard{
	font-size : 1.6rem;
	display : inline-block;
}

.seeMoreBoardLink{
	color : #f8efc5;
	display : inline-block;
	 white-space : nowrap;
	 width : 0;
	 overflow : hidden;
	 transform : translateY(1.6rem);
	 margin-left : 1rem;
    transition : width 1s;
    cursor:pointer;
}
.seeMoreBoard-container{
	transform: translateX(20px);
	display: inline-block;
	}

.seeMoreBoard-container:hover .seeMoreBoardLink{
		 width : 6rem;	 
}

.board-container{
display : flex;
flex-direction: column;
width : 50%;
padding : 30px;
align-items: flex-start;
}

.board{
width : 100%;
height : 100%;
border-top : solid 1px white;
display : grid;
flex-grow : 1;
grid-template-rows : repeat(6, 1fr);
}
.user-container-title{
	margin: 2.5rem 4rem;
	display : flex;
	justify-content: space-between;
	flex-grow : 0;
}
.user-container-contents{
	border-top : solid 1px white;
	border-bottom : solid 1px white;
}
#user-movieLike-container, #user-movieAdd-container{
	grid-column: 1 / span 2;
}
.user-container-content{
	cursor : pointer;
	display: flex;
	align-items: center;
	height: 80px;
	flex-wrap: wrap;
	border: solid 1px #333;
}
.user-container-content:hover{
	background: linear-gradient(0deg, rgba(2,0,36,1) 0%, rgba(13,40,38,1) 50%, rgba(0,0,0,1) 100%);
}

.user-content-title{
width: 80%;
    margin-left: 3%; 
}

.user-content-title h5{font-size: 1.4rem;
width: calc((50vw - 60px) * 0.8);}
.user-content-recommend{width : 17%;}
.user-content-movie{width : 40%;margin-left: 4%; }
.user-content-score{width : 34%;}
.user-content-gendate{width : 22%;}
.user-container-content div{display : inline-block;}
.user-container-content h5{
margin : 0;
}
.user-content-title h5, .user-content-movie h5, .user-content-gendate h5, .user-content-recommend h5{
	overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
	font-weight: 400;
}


.star-rating, .star-rating > * {
    height: 1.7rem; 
    background: url(${path}/resources/img/star.png);
    background-size : 1.6rem auto;		/* 별점 너비는 1.6rem*/
    background-position: 0 -1.7rem;
    background-repeat: repeat-x; 
    width: 8rem;
    display: inline-block;
}
 
.star-rating > * {
    background-position: 0 0;
    max-width:8rem; 
}


</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/throttle.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fontResize.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/movieLike.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/movieSlide.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/movieListAjax.js?ver=2"></script>
	
<script>
	$(document).ready(function() {

		
		
		var colorMap = new Map([[28,["#44c76750","#18ab2950", "#ffffff", "#2f6627"]],	//genreColorMap
			[12, ["#7892c250","#4e609650", "#ffffff", "#283966"]],
			[16, ["#33bdef50","#057fd050", "#ffffff","#5b6178"]],
			[35, ["#dbe6c450","#b2b8ad50", "#ffffff", "#ced9bf"]],
			[80, ["#f2453750","#d0271850", "#ffffff", "#810e05"]],
			[99, ["#ffffff50","#dcdcdc50", "ffffff", "#ffffff"]],
			[18, ["#e4685d50","#ffffff50", "#ffffff", "#b23e35"]],
			[10751, ["#ffec6450","#ffaa2250", "#ffffff", "#ffee66"]],
			[14, ["#599bb350","#29668f50", "#ffffff", "#3d768a"]],
			[36, ["#2dabf950","#0b0e0750", "#ffffff", "#263666"]],
			[27, ["#d0451b50","#94291150", "#ffffff", "#854629"]],
			[10402, ["#ededed50","#d6bcd650", "ffffff", "#e1e2ed"]],
			[9648, ["#2e466e50","#1f2f4750", "#ffffff", "#263666"]],
			[10749, ["#79bbff50","#337bc450", "#ffffff", "#5b8a3c"]],
			[878, ["#5d53ed50","#84bbf350", "#ffffff", "#2a67a3"]],
			[10770, ["#7d5d3b50","#54381e50", "#ffffff", "#4d3534"]],
			[53, ["#fc8d8350","#d8352650", "#ffffff", "#b23e35"]],
			[10752, ["#768d8750","#56696350", "#ffffff", "#2b665e"]],
			[37, ["#77b55a50","#4b8f2950", "#ffffff", "#5b8a3c"]]]);  
		
		
		
		var windowResize = function(){					//리사이징 함수
			document.getElementById("detail-bigPicture").style.backgroundSize = window.innerWidth+'px';
			document.getElementById("detail-bigPicture").style.height = window.innerWidth*0.5+'px'
			
			
			
			fontResize()
			movieContainerResize()	
			
		}
		
		windowResize();
		var ResizeTimer;
		window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
			 windowResize();
		}, 20), true);	
		
		const SimilarMovieContainer = document.querySelector("#similar-movie .movies-container");
		const RecommendMovieContainer = document.querySelector("#recommend-movie .movies-container");
		movieSlideController(SimilarMovieContainer);					//movieSlide.js
		movieSlideController(RecommendMovieContainer);				
		
		movieLike('${sessionScope.id}');	//영화좋아요/add 적용 
		
		var LastestId = 1000000;
		function GetLastestId(){
		$.ajax({							//LastestMovie id만 가져오기	- 랜덤영화번호 지정을 위해서
        	type: 'GET',
        	url: '/movie/getLastestMovie?language=${language}',
        	dataType : 'json',
        	contentType : 'application/json', 
        	async: false, 
        	success: function(data){
        			LastestId = data.id;
        		}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
 		})	
		}
		function randomIdGet(LastestId){
		
		let checkId;
		let rid;
		do {
			rid = Math.floor(Math.random()*LastestId)+1;
			checkId = false;
			$.ajax({							//받아온 영화 정보 디테일로 만들기
	        	type: 'GET',
	        	url: `/movie/getMovieData?movieId=`+rid+`&language=${language}`,
	        	dataType : 'json',
	        	contentType : 'application/json', 
	        	async: false, 
	        	success: function(data){
	        		if(data.success == false ||  data.adult){
	        		checkId = true;
	        		}
	        		if(data.vote_count < 1){
		        		checkId = true;
		        		}
	        		
	        	}
	        	,
	        	error: function(request, status, error){
	        	checkId = true;

	        	}
			
			})
		}while (checkId);
			return rid;
		}
		if(`${nowMovie}`!=''){
			var randomId= `${nowMovie}`
		}else{
		var randomId = randomIdGet(LastestId);
			
		}

		
		
		$.ajax({							//받아온 영화 정보 디테일로 만들기
        	type: 'GET',
        	url: `/movie/getMovieData?movieId=`+randomId+`&language=${language}`,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		let str1;
        		let str2;
        		if(!!data.backdrop_path){
        		str1 = 'https://image.tmdb.org/t/p/original/'+data.backdrop_path ;			//백드랍 이미지
        		}else{        		
        			str1 = '${pageContext.request.contextPath}/resources/img/wall.jpg' ;	
        		}
        		if(!!data.poster_path){
        		str2 = "<img src='https://image.tmdb.org/t/p/w500/"+data.poster_path+"'>"    //포스터
        		}else{
        			str2 = "<img src='${pageContext.request.contextPath}/resources/img/noImage.jpg'>"
        		}
        		let str3 = "<h1 style='text-shadow: -2px 0 #000, 0 2px #000, 2px 0 #000, 0 -2px #000; margin-bottom: 0;'>"+data.title+"</h1>"      //제목
        		let str5 = "<p id='overview' style='font-size:1.05rem;'>"+data.overview+"</p>";				//오버뷰
        		let str7 = "<h6 id='release_date'>"+data.release_date+" 개봉/"+data.runtime+"mins</h6>"
        		
        		
        		if(!!data.homepage && data.homepage != ''){
            		str8 = "<div style='background-color: gold; height: 20px; cursor: pointer; text-align : center;' onclick='window.open(\""+data.homepage+"\");'>홈페이지 이동</div>"     //홈페이지

            		}else{
            			str8 = ""
            		}       		
        		$("#detail-bigPicture").css({"background":"linear-gradient(to bottom,rgba(0,0,0,0) 80%,rgba(0,0,0,0.5) 90%,rgba(0,0,0,1) 100%), url("+ str1 +")", "background-repeat": "no-repeat", "background-size": "cover"});   //배경화면 및 그라데이션 
        		$("#detail-poster").html(str2);
        		$("#detail-title").html(str3)
        		if (data.title!=data.original_title){
        			let	str4 = "<h5 style='text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000; margin-top: 0.9rem; margin-bottom: 0;'>"+data.original_title+"</h5>" 
            		$("#detail-originalTitle").html(str4)}
        		$("#detail-overview").html(str5);
        		let str6 = "";
        		data.genres.forEach(function(item){
        			str6 += "<div class='detail-genre' style='background-color:"+colorMap.get(item.id)[0]+"; border:4px solid "+colorMap.get(item.id)[1]+"; color:"+colorMap.get(item.id)[2]+"; 	text-shadow:0px 1px 0px "+colorMap.get(item.id)[3]+";'>"+item.name+"</div>"
        		})
        		$("#detail-genres").html(str6);
        		$("#detail-release").html(str7);
        		$("#detail-homepage").html(str8);
        		let countryAry = [];
        		data.production_countries.forEach(function(item){
        			countryAry.push(item.name);
        		})
        		let str9 = '<h6>제작국가 : '+countryAry.join(' ,')+'</h6>'
        		$("#detail-country").html(str9);
        		$("#scoreImdb .Score").html(data.vote_average);    //imdb 점수 표시
        		$(".detail-Click.clickBox").data("id", randomId);
        	   	$(".detail-Click.clickBox").activeLikeMovie();
        		return false;
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        	
        })
        
        
        printCast();				//최초 1회 캐스트 받아오기
		document.getElementById("moreCasts").onclick = function(){printCast(); return false;}
        printCrew();				//최초 1회 크루 받아오기
		document.getElementById("moreCrews").onclick = function(){printCrew(); return false;}
        function printCast(){
        $.ajax({							//출연진 정보 출력 함수
        	type: 'GET',
        	url: `/movie/getMovieCredit?movieId=`+randomId+`&language=${language}`,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		let CastReadNum = $("#casts").children().length		//이미 불러들인 cast의 수
        		let index=0;
        		while(index<8 && CastReadNum+index<data.cast.length){
        			let imageUrl;
        			if(data.cast[CastReadNum+index].profile_path!=null){
        				imageUrl = "https://image.tmdb.org/t/p/w185"+data.cast[CastReadNum+index].profile_path;
        			}else{
        				imageUrl = '${pageContext.request.contextPath}/resources/img/noPersonImage.png'       		//사진이 없을때 이미지			
        			}       			
        			let str = "<div class='cast'>"
					str += "<div class='cast-picture' style='background: url(\""+imageUrl+"\"); background-repeat: no-repeat; background-size : contain'></div>"
					str += "<div class='cast-info'><div class='cast-name'><h5>"+data.cast[CastReadNum+index].name+"</h5></div><div class='cast-character'><h6>"+data.cast[CastReadNum+index].character+" 역</h6></div></div>"
					$("#casts").append(str);
					index+=1;
        		}
        		if (CastReadNum+index>=data.cast.length){
        			$("#moreCasts").remove();				//더이상 없으면 버튼을 삭제
        		}
        	},
            error: function(request, status, error){
            	console.log(request, status, error)
            }
        		

        			
        })
        return false;
		}
		
        function printCrew(){
            $.ajax({							//제작진 정보 출력 함수
            	type: 'GET',
            	url: `/movie/getMovieCredit?movieId=`+randomId+`&language=${language}`,
            	dataType : 'json',
            	contentType : 'application/json', 
            	success: function(data){
            		let CrewReadNum = $("#crews").children().length		//이미 불러들인 crew의 수
            		let index=0;
            		while(index<8 && CrewReadNum+index<data.crew.length){
            			let imageUrl;
            			if(data.crew[CrewReadNum+index].profile_path!=null){
            				imageUrl = "https://image.tmdb.org/t/p/w185"+data.crew[CrewReadNum+index].profile_path;
            			}else{
            				imageUrl = '${pageContext.request.contextPath}/resources/img/noPersonImage.png'       				
            			}       			
            			let str = "<div class='crew'>"
    					str += "<div class='crew-picture' style='background: url(\""+imageUrl+"\"); background-repeat: no-repeat; background-size : contain'></div>"
    					str += "<div class='crew-info'><div class='crew-name'><h5>"+data.crew[CrewReadNum+index].name+"</h5></div><div class='crew-character'><h6>"+data.crew[CrewReadNum+index].known_for_department+"<br>"+data.crew[CrewReadNum+index].job+"</h6></div></div>"
    					$("#crews").append(str);
    					index+=1;
            		}	
            		if (CrewReadNum+index>=data.crew.length){
            			$("#moreCrews").remove();
            		}
            	},
                error: function(request, status, error){
                	console.log(request, status, error)
                }		
            			
            })
            return false;
    		}
        
        
        movieListAjax('similar-movie', `/movie/getSimilarMovieList?movieId=`+randomId+`&page=1&language=${language}`, `${language}`);				//getSimilarMovieList 출력
        movieListAjax('recommend-movie', `/movie/getRecommendMovieList?movieId=`+randomId+`&page=1&language=${language}`, `${language}`);				//getSimilarMovieList 출력

                

        $(document).on("click", ".arrow-left", function(e){	
        location.href =`/movie/randomMovieDetail?language=${language}&nowMovie=${beforeMovie}&nextMovie=`+randomId
       	 });

        $(document).on("click", ".arrow-right", function(e){		
            location.href =`/movie/randomMovieDetail?language=${language}&beforeMovie=`+randomId+`&nowMovie=${nextMovie}`
           	 });
		
		
		$(".onelineLink").click(function(){
			location.href ='oneLineReview?SearchMode=movie&query='+randomId+'&language=ko-KR&page=1'
		});

		$(".boardLink").click(function(){
			location.href ='boardList?SearchType=M_id&bKeyword='+randomId+'&page=1'
		});
		
		
		  $.ajax({							//한줄평 정보 받아오기
				url: `oneLineReview/movie/`+randomId,
				dataType : 'json',
				contentType : 'application/json', 
				success: function(data){
					console.log(data)
			    	$(".oneLineReview .user-container-content").each(function(i, e){
					if(!!data[i]){
						$(e).data("olrid",data[i].oneLineReviewId);
	    			$(e).children(".user-content-title").html("<h5>"+data[i].comment+"</h5>");
	    			$(e).children(".user-content-recommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
	    			$(e).children(".user-content-movie").html("<h5>"+data[i].movieId+"</h5>");
	    			$(e).children(".user-content-score").html("<span class='star-rating'></span>");
	    			$(e).find(".star-rating").data("score",data[i].score);
	    			var date = new Date(data[i].gendate);
	    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
	    			}else{
	    				$(e).removeClass("user-container-content");
	    				}
			    	})
	    			$('.oneLineReview .star-rating').generateStars();		//별점생성함수 호출
	    			movieData('oneLineReview');
				},
					error: function(request, status, error){
						console.log(request, status, error)
					}
				})

	    	$.ajax({							//관련리뷰정보 받아오기
				url: `/movie/boardList/movie/`+randomId,
				dataType : 'json',
				contentType : 'application/json', 
				success: function(data){
			    	$(".userReview .user-container-content").each(function(i, e){
					if(!!data[i]){
		    			$(e).data("reviewId",data[i].seq);
		    			$(e).children(".user-content-movie").data("movieId", data[i].movie_id);
		    			$(e).children(".user-content-title").html("<h5>"+data[i].title+"</h5>");
		    			$(e).children(".user-content-recommend").html("<h5>"+"[+"+data[i].likes+"]"+"</h5>");
		    			$(e).children(".user-content-movie").html("<h5>"+data[i].movie_id+"</h5>");
		    			$(e).children(".user-content-score").html("<span class='star-rating'></span>");
		    			$(e).find(".star-rating").data("score",data[i].b_score);
		    			var date = new Date(data[i].regdate);
		    			$(e).children(".user-content-gendate").html("<h5>"+date.toLocaleDateString()+"</h5>");
		    			}else{
		    				$(e).removeClass("user-container-content");
		    			}
				});
	    			$('.userReview .star-rating').generateStars();		//별점생성함수 호출
	    			movieData('userReview');
			    	
				}
			,
			error: function(request, status, error){
				console.log(request, status, error)
			}
		})
				$(document).on("click", ".userReview .user-container-content", function(e){			//리뷰 링크 연결
			let seq = $(e.currentTarget).data("reviewId");
			if(!!seq){
				location.href = '/movie/boardDetail?seq='+seq+'&searchType=Wr&bKeyword=&curPage=1&range=1';
			   
			}
		})
			$(document).on("click", ".oneLineReview .user-container-content", function(e){			//한줄평 링크 연결
			let olrId = $(e.currentTarget).data("olrid");
			if(!!olrId){
				$.ajax({							
			    	type: 'GET',
			    	url: `oneLineReview/page/`+olrId,
			    	dataType : 'text',
			    	success: function(data){
					location.href = '/movie/oneLineReview?page='+data+'&language=${language}&focus='+olrId;
			    	},
			    	error: function(request, status, error){
			        	console.log(request, status, error)
			        }
					});
			}
		})
		
		
		var starSize=1.6;
	    	$.fn.generateStars = function() {			//별점생성함수 - 크기는 1.6rem
	        	return this.each(function(i,e){
	        		let score = $(e).data("score")
	        		$(e).html($('<span/>').width(score*starSize/2+'rem'));
	      			$(e)[0].dataset.score = score;
	        	});
	        	}	
	    	function movieData(containerClass){			//movieId로부터 영화제목 가져오기
	    		$("."+containerClass+" .user-content-movie h5").each(function(i, e){
	    			var movieId = $(e).html()
	    			$.ajax({	
	    	        	type: 'GET',
	    	        	url: `/movie/getMovieData?movieId=`+movieId+`&language=${language}`,
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
		
		
	})
</script>




</head>

<body>
	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="${language}"/>  
</jsp:include>  

	<div id="detail-bigPicture">
	</div>
	<span class="arrow arrow-left"></span>
	<span class="arrow arrow-right"></span>
	<div id="detail-MovieContainer">
		<div id="onleft">
			<div id="detail-poster"></div>
			<div id="detail-homepage"></div>
		</div>
		<div id="detail-nonPoster">
			<div id="detail-title"></div>
			<div id="detail-originalTitle"></div>
			<div id="detail-overview"></div>
			<div id="detail-genres"></div>
			<div id="detail-release"></div>
			<div class="spacing"
				style="width: 95%; height: 120px; display: flex; justify-content: space-between; ">
				<div id="detail-country"></div>
				<div class="detail-Click clickBox">
				<div class="heartClickBig heartClick"><div class="heartClickBigClicker heartClickClicker"></div></div>
				<div class="addClick addClickBig">
            		<svg viewBox="0 0 44 44">
                		<path d="M14,24 L21,31 L39.7428882,11.5937758 C35.2809627,6.53125861 30.0333333,4 24,4 C12.95,4 4,12.95 4,24 C4,35.05 12.95,44 24,44 C35.05,44 44,35.05 44,24 C44,19.3 42.5809627,15.1645919 39.7428882,11.5937758" transform="translate(-2.000000, -2.000000)"></path>
            		</svg>
        		</div>
        		</div>
				<div id="detail-vote">
					<div id="scoreGeek">
						<div class="siteName">GeekScore</div>
						<div class="Score">7.5</div>
					</div>
					<div id="scoreImdb">
						<div class="siteName">IMDB</div>
						<div class="Score"></div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<div id="credit-container">
	<div id="credit">
		<h5 class="creditName">출연진</h5>
		<div id="casts"></div>
		<div class="credit-button-container">
			<div id="moreCasts">더 보기</div>
		</div>
	

		<h5 class="creditName">제작진</h5>
		<div id="crews"></div>
		<div class="credit-button-container">
			<div id="moreCrews">더 보기</div>
		</div>
		</div>
	</div>
	<div id="userSpace">
	<div class="board-container">
	<div class="seeMoreBoard-container"><h3 class="seeMoreBoard">한줄평</h3><h5 class="seeMoreBoardLink" OnClick="location.href ='boardList?SearchType=M_id&bKeyword=${movieId}&page=1'">더 보기 >></h5></div>

	<div class="board oneLineReview">
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>		
	</div>
	</div>
	<div class="board-container">
	<div class="seeMoreBoard-container"><h3 class="seeMoreBoard">관련된 리뷰</h3><h5 class="seeMoreBoardLink" OnClick="location.href ='boardRecommendList'">더 보기 >></h5></div>
	<div class="board userReview">
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>
	<div class="user-container-content"><div class="user-content-title"></div><div class="user-content-recommend"></div><div class="user-content-movie"></div><div class="user-content-score"></div><div class="user-content-gendate"></div></div>		
	</div>
	</div>
	</div>
	
	<div id="similar-movie">
	<div class="seeMoreMovies-container"><h3 class="seeMoreMovies">이 영화와 비슷한 영화</h3><h5 class="seeMoreMoviesLink" OnClick="location.href =`/movie/search?searchMode=similarmovie&movieId=${movieId}&page=2&language=${language}`">더 보기 >></h5></div>
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


<div id="recommend-movie">
	<div class="seeMoreMovies-container"><h3 class="seeMoreMovies">추천 영화</h3><h5 class="seeMoreMoviesLink" OnClick="location.href =`/movie/search?searchMode=recommendmovie&movieId=${movieId}&page=2&language=${language}`">더 보기 >></h5></div>
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


<jsp:include page="./common/footer.jsp">  
<jsp:param name="language" value="ko-KR"/>  
</jsp:include>  
</body>
</html>
