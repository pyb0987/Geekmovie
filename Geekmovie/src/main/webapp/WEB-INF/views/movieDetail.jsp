
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<%
String language = "ko-KR";

%>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GeekMovie</title>
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css"
	rel="stylesheet">
<link rel="stylesheet" href="${path}/resources/css/movieHover.css">
<style>
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);

body {
	overflow-x: hidden;
	background-color: #000000;
}

#detail-bigPicture { /*detail 맨위 배경화면 */
	position: relative;
	margin: 0;
	height: 500px;
	background-repeat: no-repeat;
	background-size: contain;
	z-index: -1;
}

#detail-movieContainer { /*영화정보 위치 지정*/
	width: 100%;
	display: flex;
	padding-top : 400px;
}

#detail-poster {
	flex : 0 0 250px;
	left: 100px;
	top: 300px;
	margin-left : 30px;
}

#detail-nonPoster{		
	display: flex;
	min-width : 400px;
	flex-wrap: wrap;
	align-content : flex-start;
	padding-left : 20px;
	}

#detail-poster img { /*이미지 전부 채우게 함*/
	border: ridge #eee 8px;
	padding: 2px;
	width: 100%;
	object-fit: cover;
	max-width: 100%;
	opacity: 1;
	box-sizing: border-box;
}

#detail-title {	height : 60px;}
#detail-originalTitle {	height : 60px;} 	 /*제목 위치 지정*/
#detail-overview {width: 100%;}
#release_date{padding-left : 20px; }

#detail-genre {			 /*장르 박스*/
	border-radius:8px;
	display:inline-block;
	font-family: 'NanumSquareRound';
	font-size:14px;
	padding:6px 13px;
	margin : 5px;
}

.movie img { /*이미지 전부 채우게 함*/
	width: 100%;
	height: 100%;
	object-fit: cover;
	max-width: 100%;
	backface-visibility: hidden;
	vertical-align: top;
}


h1,h5,h6 {
	font-family: 'NanumSquareRoundBold';				/*글꼴*/
	color: #fff;}
#overview {
	font-family: 'NanumSquareRound';
	color: #fff;
	padding : 10px 20px 0px 30px;
	line-height : 130%;
	}



.movie-container {
	width: 100%;
	height: 320px;
	margin: 0 auto;
	position: relative;
}

.movie-innerContainer {
	display: flex;
	height: 100%;
	width: 4000px;
	align-items: center;
	position: absolute;
}

.movie {
	position: relative;
	padding: 0px;
	height: 270px;
	margin-right: 15px;
	flex-shrink: 0;
	flex-basis: 185px;
	overflow: hidden;
	color: #ffffff;
	text-align: left;
	font-size: 16px;
	background-color: #000000;
}

#detail-vote {
	display: flex;
	align-items: center;
	width: 180px;
 	height : 70px;
  padding: 10px;
  outline: none;
  text-align: center;
  color: hsla(0,0%,20%,1);
  text-shadow: hsla(0,0%,40%,.5) 0 -1px 0, hsla(0,0%,100%,.6) 0 2px 1px;
  font: bold "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif;
  box-shadow: inset hsla(0,0%,15%,  1) 0  0px 0px 4px, /* border */
  inset hsla(0,0%,0%, .25) 0 -1px 0px 7px, /* bottom SD */
  
  hsla(0,0%, 0%,.15) 0 -5px 6px 4px, /* outer SD */
  hsla(0,0%,100%,.5) 0  5px 6px 4px; /* outer HL */ 
  border-radius: 8px;
  background-color: hsl(0,0%,90%);
  background-image: -webkit-repeating-linear-gradient(left, hsla(0,0%,100%,0) 0%, hsla(0,0%,100%,0)   6%, hsla(0,0%,100%, .1) 7.5%),
    -webkit-repeating-linear-gradient(left, hsla(0,0%,  0%,0) 0%, hsla(0,0%,  0%,0)   4%, hsla(0,0%,  0%,.03) 4.5%),
    -webkit-repeating-linear-gradient(left, hsla(0,0%,100%,0) 0%, hsla(0,0%,100%,0) 1.2%, hsla(0,0%,100%,.15) 2.2%),
    linear-gradient(180deg, hsl(0,0%,78%)  0%, 
    hsl(0,0%,90%) 47%, 
    hsl(0,0%,78%) 53%,
    hsl(0,0%,70%) 100%);
}
#scoreGeek{
	width: 60%;
}

#scoreGeek .siteName{
	font-size: 1em;
	font-weight: 600;
}

#scoreGeek .Score{
	font-size: 2.3em;
	font-weight: 600;
}
#scoreImdb{
	width: 40%;
}
#scoreImdb .siteName{
	font-size: 0.8em;
	font-weight: 600;
}

#scoreImdb .Score{
	font-size: 1.7em;
}





</style>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
		
		$.ajax({							//받아온 영화 정보
        	type: 'GET',
        	url: `/movie/getMovieData?movieId=${movieId}&language=${language}`,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		console.log(data);
        		let str1;
        		let str2;
        		if(data.backdrop_path!=null){
        		str1 = 'https://image.tmdb.org/t/p/original/'+data.backdrop_path ;			//백드랍 이미지
        		}else{        		
        			str1 = '${pageContext.request.contextPath}/resources/img/wall.jpg' ;	
        		}
        		if(data.poster_path!=null){
        		str2 = "<img src='https://image.tmdb.org/t/p/w500/"+data.poster_path+"'>"    //포스터
        		}else{
        			str2 = "<img src='${pageContext.request.contextPath}/resources/img/noImage.jpg'>"
        		}
        		let str3 = "<h1 style='text-shadow: -2px 0 #000, 0 2px #000, 2px 0 #000, 0 -2px #000;'>"+data.title+"</h1>"      //제목
        		let str5 = "<p id='overview'>"+data.overview+"</p>";				//오버뷰
        		let str7 = "<h6 id='release_date'>"+data.release_date+" 개봉/"+data.runtime+"mins</h6>"

        		
        		$("#detail-bigPicture").css({"background":"linear-gradient(to bottom,rgba(0,0,0,0) 80%,rgba(0,0,0,0.5) 90%,rgba(0,0,0,1) 100%), url("+ str1 +")"});   //배경화면 및 그라데이션 
        		$("#detail-poster").html(str2);
        		$("#detail-title").html(str3)
        		if (data.title!=data.original_title){
        			let	str4 = "<h5 style='text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;'>"+data.original_title+"</h5>" 
            		$("#detail-originalTitle").html(str4)}
        		$("#detail-overview").html(str5);
        		let str6 = "";
        		data.genres.forEach(function(item){
        			str6 += "<div id='detail-genre' style='background-color:"+colorMap.get(item.id)[0]+"; border:4px solid "+colorMap.get(item.id)[1]+"; color:"+colorMap.get(item.id)[2]+"; 	text-shadow:0px 1px 0px "+colorMap.get(item.id)[3]+";'>"+item.name+"</div>"
        		})
        		$("#detail-genres").html(str6);
        		$("#detail-release").html(str7);
        		$("#scoreImdb .Score").html(data.vote_average);    //imdb 점수 표시
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        	
        })
		
		
	})
</script>




</head>

<body>


	<div id="detail-bigPicture">
		<div id="detail-MovieContainer">
			<div id="detail-poster"></div>
			<div id="detail-nonPoster">
				<div id="detail-title"></div>
				<div id="detail-originalTitle"></div>
				<div id="detail-overview"></div>
				<div id="detail-genres"></div>
				<div id="detail-release"></div>
				<div class="spacing" style="width: 95%; height: 120px; display:flex; flex-direction: row-reverse;">
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
	</div>


	<div class="spacing" style="width: 100%; height: 500px;"></div>


	<div id="related-movie">
		<h3>관련있는 영화</h3>
		<div class="movie-container">
			<div class="movie-innerContainer">
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
				<div class="movie"></div>
			</div>
		</div>
	</div>


</body>
</html>
