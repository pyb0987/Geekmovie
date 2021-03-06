<%@page import="java.util.List"%>
<%@page import="com.geekmovie.board.vo.ReplyVo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.geekmovie.board.service.BoardService"%>
<%@page import="com.geekmovie.board.vo.BoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%
BoardVo data = (BoardVo) request.getAttribute("data");
List<ReplyVo> replyList = (List<ReplyVo>)request.getAttribute("reply");

String wr = data.getWriter();

String id = (String) session.getAttribute("id");
Timestamp gendate = data.getRegdate();
String formattedgenDate = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss").format(gendate);

String language = "ko-KR";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GeekReviewDetail</title>


<link
	href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap"
	rel="stylesheet">
<!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css" />
<link rel="stylesheet" href="${path}/resources/css/movieLike.css" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript" src="${path}/resources/js/movieLike.js"></script>

<script type="text/javascript">

function deleteCheck(){
	console.log("delete");
	if('${sessionScope.id}'=='${data.writer}'){
		var result = confirm("삭제하면 복구할 수 없습니다. \n 그래도 삭제 하시겠습니까?");
		if(result){
		    var deleteform = document.deleteform;
		    deleteform.submit();
		}
	}
};

function modifyCheck(){
	if('${sessionScope.id}'!='${data.writer}'){
		var result = confirm("작성자만 이용하실 수 있습니다.");
		if(result){
		    location.href = 'boardDetail?seq=${data.seq}';
		}
	}else{
		location.href = 'boardUpdate?seq=${data.seq}';
	}
};

// 로그인 회원만 글 작성하게
function replyWriteCheck(){
	if('${sessionScope.id}' == '') {
		var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
		if(result) {
			location.href = 'user_join';
		}
	} else {
		var replywriteform = document.replywriteform;
		replywriteform.submit();
	}
};

// 댓글 삭제 기능
function replydeleteCheck(){
	console.log("reply delete");
		var result = confirm("삭제하면 복구할 수 없습니다. \n 그래도 삭제 하시겠습니까?");
		if(result){
		    var deleteform = document.replydeleteform;
		    deleteform.submit();
		}
};

// 댓글 수정 기능
function replyModify(f) {
	console.log("reply modify");
	var result = confirm("저장 하시겠습니까?");
	if(result) {
		f.submit();
	}
	
	
};

	function modal(i){

	console.log(i);
	var zIndex = 9999;
	
	// 모달 뒷배경 레이어
	var bg = document.createElement('div');
	bg.setStyle({
		position: 'fixed',
		zIndex: zIndex,
		left: '0px',
		top: '0px',
		width: '100%',
		height: '100%',
		overflow: 'auto',
		// 레이어 색상 변경
		backgroundColor: 'rgba(0,0,0,0.4)'
	});
	document.body.append(bg);
	
	//const close = document.querySelector('.modal_close_btn');
	
	var doc = document.getElementById("modify_modal");
	
	for(var j =0 ; j <doc.length; j++){
		// 닫기 버튼 처리, 레이어 & 모달 삭제
		doc[j].addEventListener('click', function(){
			bg.remove();
			doc[j].style.display = 'none';
		});
		
		 doc[j].setStyle({
			position: 'fixed',
			display: 'block',
			boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
			
			zIndex: zIndex + 1, // 레이어 위에 위치
			
			// div center 정렬
			top: '50%',
			left: '50%',
			transform: 'translate(-50%, -50%)',
			mtransform: 'translate(-50%, -50%)',
			webkitTransform: 'translate(-50%, -50%)'
		});
	}
	
}


// Element에 style 한번에 오브젝트로 설정하는 함수 추가
Element.prototype.setStyle = function(styles) {
	for (var k in styles) this.style[k] = styles[k];
	return this;
};



window.onload = function(){
		
		var windowResize = function(){					//리사이징 함수
		
			fontResize()
		
		}
	
		windowResize();
		var ResizeTimer;
		window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
	 		windowResize();
		}, 20), true);	

		movieLike('${sessionScope.id}');	//영화좋아요/add 적용 


	var starSize = 1.8;
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

		$.fn.generateStars = function() {			//별점생성함수 - 크기는 1.8rem
			return this.each(function(i,e){
				let score = $(e).text()
				$(e).html($('<span/>').width(score*starSize/2+'rem'));
				$(e)[0].dataset.score = score;
		});
	}

	$.ajax({							//받아온 영화 정보 디테일로 만들기
		type: 'GET',
		url: `/movie/getMovieData?movieId=${data.movie_id}&language=<%=language%>`,
		dataType : 'json',
		contentType : 'application/json', 
		success: function(data){
			let str1;
			let str2;
			if(!!data.backdrop_path){
				str1 = 'https://image.tmdb.org/t/p/original/'+data.backdrop_path ;			//백드랍 이미지
			}else{        		
				str1 = '${path}/resources/img/wall.jpg' ;	
			}
			if(!!data.poster_path){
				str2 = "<img src='https://image.tmdb.org/t/p/w500/"+data.poster_path+"'>"    //포스터
			}else{
				str2 = "<img src='${path}/resources/img/noImage.jpg'>"
			}
				let str3 = "<h1 style='text-shadow: -2px 0 #000, 0 2px #000, 2px 0 #000, 0 -2px #000; margin-bottom: 0;'>"+data.title+"</h1>"      //제목
		let str7 = "<h6 id='release_date'>"+data.release_date+" 개봉</h6>"
		
		   		
		$("#detail-bigPicture").css({"background":'linear-gradient(to bottom,rgba(0,0,0,0) 80%,rgba(0,0,0,0) 90%,rgba(0,0,0,1) 100%), url('+ str1 +')', "background-repeat": "no-repeat", "background-size": "cover"});   //배경화면 및 그라데이션 
		$("#detail-poster").html(str2);
		$("#detail-title").html(str3)
		let str6 = "";
		data.genres.forEach(function(item){
			str6 += "<div class='detail-genre' style='background-color:"+colorMap.get(item.id)[0]+"; border:4px solid "+colorMap.get(item.id)[1]+"; color:"+colorMap.get(item.id)[2]+"; 	text-shadow:0px 1px 0px "+colorMap.get(item.id)[3]+";'>"+item.name+"</div>"
		})
		$("#detail-genres").html(str6);
		$("#detail-release").html(str7);
		let countryAry = [];
		data.production_countries.forEach(function(item){
			countryAry.push(item.name);
		})
		$(".detail-Click.clickBox").data("id", '${data.movie_id}');
	   	$(".detail-Click.clickBox").activeLikeMovie();
	   	$('.star-rating').generateStars();		//별점생성함수 호출
	   	
	   	$(".movieName").html(data.title);
	   	
	   	$(".movieName").click(function(){
	   		location.href='http://localhost:8080/movie/movieDetail?movieId=${data.movie_id}&language=<%=language%>';
										});
						return false;
					},
					error : function(request, status, error) {
						console.log(request, status, error)
					}

				})

		document.querySelector(".toListButton").addEventListener('click',function() {
							if ('${recommend}' == 'true') {
								location.href = "boardRecommendList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}"
							} else {
								location.href = "boardList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}"
							}
						})
		//===========================좋아요 기능

		$.fn.activeLikeButtons = function() { // - 이미 눌린 좋아요 버튼 active효과주기
		this.each(function(i, e) {
	
						let mode = Number($(e).hasClass("like-button"));
						$.ajax({
									url : 'board/like/${data.seq}?userId=${sessionScope.id}&mode='+ mode,
									method : "GET",
									success : function(data) {
										if (data == 1) {
											$(e).addClass("active");
										} else {
											$(e).removeClass("active");
										}
									},
									error : function(request, status, error) {
										console.log(request, status, error)
									}
								});
					});
		}
	if ('${sessionScope.id}' != '') {
		$(".like-button, .dislike-button").activeLikeButtons();
	}
	
	$.ajax({ //로드완료하면 좋아요 개수 세기
		url : 'board/freeCount/${data.seq}?mode=1',
		method : "GET",
		success : function(data) {
			document.querySelector(".like-button .like-dislike-button-span").innerText = data;
		},
		error : function(request, status, error) {
			console.log(request, status, error)
		}
	});
	
	$.ajax({ //로드완료하면 싫어요 개수 세기
		url : 'board/freeCount/${data.seq}?mode=0',
		method : "GET",
		success : function(data) {
			document
					.querySelector(".dislike-button .like-dislike-button-span").innerText = data;
		},
		error : function(request, status, error) {
			console.log(request, status, error)
		}
	});
	
	$(document).on("click",".like-button, .dislike-button",function(e) { //좋아요 버튼 누를때 이벤트
		if ('${sessionScope.id}' == '') {
			var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
				if (result) {
					location.href = 'user_join';
				}
				} else {
					var button = e.currentTarget;
					var likeData = {};
					var likeButton = button.parentElement
							.querySelector(".like-button");
					var dislikeButton = button.parentElement
							.querySelector(".dislike-button");
					likeData['mode'] = Number(button.classList
							.contains("like-button"));
					likeData['userId'] = '${sessionScope.id}';
					
					$.ajax({
						url : 'board/like/${data.seq}',
						method : "POST",
						data : JSON.stringify(likeData),
						dataType : "json",
						contentType : "application/json;charset=UTF-8",
						success : function(data) {
							if (data == 1 || data == 2) { //성공시 정보 업데이트
								$.ajax({
									url : 'board/freeCount/${data.seq}?mode=1',
									method : "GET",
									success : function(data) {
										likeButton.querySelector(".like-dislike-button-span").innerText = data;
										document.querySelector('.movieLikes').innerText = "좋아요 : " + data;},
										error : function(request,status,error) {
										console.log(request,status,error)}
												});
										$.ajax({
										url : 'board/freeCount/${data.seq}?mode=0',
										method : "GET",
										success : function(data) {
												dislikeButton.querySelector(".like-dislike-button-span").innerText = data;
												},
												error : function(request,status,error) {
												console.log(request,status,error)
													}
												});
										$(likeButton).activeLikeButtons();
										$(dislikeButton).activeLikeButtons();
									} else {
										console.log(data)
										alert("존재하지 않는 대상입니다.");
									}
								},
								error : function() {
									alert("의견이 반영되지 않았습니다.");
								}
							});

				}

			})

	
	



} // window onload

</script>

<style>
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

body {
	overflow-x: hidden;
	background-color: #000000;
	margin : 0;
	padding-top : 100px;
}
	.BoardHeader h1 {
		padding-left : 50px;
		margin : 30px;
		color : black;
	}
	
.BoardContainer{
width : 80%;
margin : 0 auto;
top : 3rem;
}	
	.BoardWrap {
    border-radius: 10px;
    padding: 50px;
    background-color: white;

	}
	.BoardHeader {
		border-top: 3px solid red;
	}
	.Boardbody{
		display : grid;
		grid-template-columns: repeat(5, auto);

	}
	#detail-bigPictureContainer{
	position : relative;
	width : 100%;
	padding-bottom : 25%;
	}
	
	#detail-bigPicture { /*detail 맨위 배경화면 */
	position: absolute;
	width: 100%;
	height : 100%;
	
}
	#spacing{
	position : relative;
	width : 100%;
	height: 200px;
	}
	
	#detail-MovieContainer{ /*영화정보 위치 지정*/
	position: absolute;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: space-around;
    align-items: flex-start;
    transform: translateY(50%);
	}
	#detail-nonPoster{
	justify-content: flex-end;
	    width: 800px;
    margin-right: 50px;
        display: flex;
    width: 800px;
    margin-right: 50px;
    flex-direction: column;
    align-items: flex-end;
	}
	#detail-title{
	text-align: right;
	}

#detail-nonPoster {
    display: flex;
    flex-direction: column;
    align-items: flex-end;

}

.detail-Click{
	display : flex;
	align-items: center;
	margin-right : 2rem;
	margin-left: -1rem;
}
.detail-Click .addClick{
	margin-left: -1rem;
}

.detail-genre {			 /*장르 박스*/
	border-radius:8px;
	display:inline-block;
	font-family: 'Nanum Gothic', sans-serif;
	font-size:0.9rem;
	padding:6px 13px;
	margin : 5px;
}
#detail-poster img { /*이미지 전부 채우게 함*/
	border: ridge #eee 8px;
	width: 100%;
	object-fit: cover;
	max-width: 100%;
	opacity: 1;
	box-sizing: border-box;
	
}
#onleft {
	flex : 0 0.5 200px;
	min-width : 120px;
	margin-left : 30px;
}
#detail-release{
text-align: end;

}
#release_date{
    margin: 10px 0;
}
.Detail-body-header{
display : flex;
justify-content: space-between;
grid-column: 1 / 6;

}
.movieLikes, .movieWatchCount{
    text-align: end;
}
.movieName{
	cursor : pointer;
}
.movieName:hover{
	color : #f2f5dccc;
}

.movieScore{
    display: flex;
    align-items: center;
    justify-content: space-around;
}

.movieContent{
grid-column: 1 / 6;
    margin: 3% 0;
    padding: 0 2%;
     border: solid 2px #444;
    border-radius: 10px;
min-height : 500px;
}

.movieContent h5{
	    font-weight: 400;
	    color : black;
}
.BoardDate{
grid-column: 1 / 3;
}
.BoardColored{
background-color: #555;
box-sizing : border-box;
padding: 0 10px;
    border: 1px solid black;
    margin: 1px;

}
.BoardColored h5, .BoardColored h4{
font-weight : 400;
color: #f2f5dc;
}

.toList{
    text-align: center;
	grid-column: 5 / 6;
	grid-row: 5 / 6;
}
.toList a{
    text-decoration: none;
}
.toList:hover h4{
	color : #f2f5dccc;
}
.writer{
display : flex;
    justify-content: space-evenly;
    align-items: center;
}

.like-dislike{
	grid-column: 3 / span 2;
	display : flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 20px; 

	
}

.like-dislike-button{
	width: 8rem;
    height: 4rem;
    margin: 0.7rem;
    padding: 0.1rem;
	border-radius: 0.6rem;
	display: flex;
	align-items: center;
	justify-content: space-around;
	border : solid 3px skyblue;
	position: relative;
	background-color:white;
	transition: all 0.3s;
	cursor : pointer;
}

.like-dislike-button:hover{
  background: skyblue;
  border : solid 3px white;
}

.like-dislike-button.active{
  background: skyblue;
  border : solid 3px white;
}

.like-dislike-button:active{
  background: rgb(219, 228, 231);
}
.like-icon{
	width: 50%;
	height: 50%;
	object-fit: contain;
}
.dislike-icon{
	width: 50%;
	height: 50%;
	object-fit: contain;
}

.likedislike{
justify-content: center;
}

.writer button, input{
	border: none;
    background: none;
    color : #f2f5dc;
}
#b_delete h5 input{
 font-size : 1rem;
}

.writer button:hover h5, input:hover{
	color : #f2f5dccc;
}

#comments-container {
	background-color: white;
	margin-top: 10px;
	padding: 15px;
	border-radius: 0.6rem;
	border: solid 2px #000000;
}

#comments-container h5 {
	color: #000000;
	font-size: 22px;
}

#replywriteform {
	background-color: #474040;
	padding: 8px;
}

#r_writer {
	font-size: 18px;
	margin-bottom: 10px;
	color: #f2f5dc;
}

#replywritebox {
	/* 
	background-color: red;
	*/
	display: flex;
	padding: 10px;
}

#replywritebox textarea {
	width: 90%;
	border-radius: 0.6rem;
	border: solid 2px #000000;
	resize: none;
}

#replywritebox textarea::placeholder {
}

#reply_write {
    background-color: #555;
    box-sizing: border-box;
    border: 1px solid black;
    margin-left: 8px;
    height: 40px; width: 60px;
}

#reply_box{
	background-color: #3d3d40;
	padding: 10px;
}

#reply_data {
	display : flex;
	height: 60px;
	background-color: #454343;
	margin: 5px;
	border: solid 0.05px #30302e;
	color: #f2f5dc;
	font-size: 16px;
}

.r1 {
	margin: auto;
	padding-left: 10px;
	width: 60%
}

.r2 {
	margin: auto;
	text-align: center;
	width: 20%
}

.r3 {
	margin: auto;
	text-align: center;
	width: 10%
}

.r4 {
	width: 10%;
	margin: auto;
}

.modify_modal {
		display: none;
		width: 600px;
		padding: 10px 30px;
		background-color: #333131;
		border: 1px solid #888;
		border-radius: 
	}
	
.modify_modal .modal_close_btn{
		position: absolute;
		top: 10px;
		right: 10px;
	}

.modal_open_btn {
	background: none;
	border: none;
	color: #f2f5dc;
}

</style>
</head>
<body>
	<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="${language}"/>  
</jsp:include>  
	<div id="detail-bigPictureContainer">
	<div id="detail-bigPicture"></div>
	<div id="detail-MovieContainer">
		<div id="onleft">
			<div id="detail-poster"></div>
		</div>
		<div id="detail-nonPoster">
			<div id="detail-title"></div>
			<div id="detail-genres"></div>
			<div id="detail-release"></div>
				<div class="detail-Click clickBox">
				<div class="heartClickBig heartClick"><div class="heartClickBigClicker heartClickClicker"></div></div>
				<div class="addClick addClickBig">
            		<svg viewBox="0 0 44 44">
                		<path d="M14,24 L21,31 L39.7428882,11.5937758 C35.2809627,6.53125861 30.0333333,4 24,4 C12.95,4 4,12.95 4,24 C4,35.05 12.95,44 24,44 C35.05,44 44,35.05 44,24 C44,19.3 42.5809627,15.1645919 39.7428882,11.5937758" transform="translate(-2.000000, -2.000000)"></path>
            		</svg>
        		</div>


			</div>
		</div>
	</div>
	</div>
	
	<div id="spacing"></div>
	<div class="BoardContainer">

	<div class="BoardWrap">
	<div class="BoardHeader">
			<h1>${data.title}</h1>
	</div>
	
	<div class="Boardbody">
			<div class="Detail-body-header BoardColored">
			<h4>작성자 : ${data.writer}</h4><h4 class="movieName"></h4>
		</div>
		<div class="BoardColored BoardDate">
	
		<h5><%=formattedgenDate %></h5>
		</div>
		<div class="movieScore BoardColored">
		<h5>평가 : </h5><span class="star-rating">${data.b_score}</span>
		</div>
		<div class="BoardColored">
		<h5 class="movieWatchCount">조회수 : ${data.cnt}</h5>
		</div>
		<div class="BoardColored">
		<h5 class="movieLikes">좋아요 : ${data.likes}</h5>
		</div>
	
		<div class="movieContent">
		<h5>${data.contents} </h5>
		</div>
		
		<div class="Detail-body-header likedislike">
		<div class="like-dislike">
					<div class="like-button like-dislike-button"><span class="like-button-span like-dislike-button-span">${data.likes}</span><img class="like-icon" src="${path}/resources/img/like.png"></div>
					<div class="dislike-button like-dislike-button"><span class="dislike-button-span like-dislike-button-span">${data.likes}</span><img class="dislike-icon" src="${path}/resources/img/dislike.png"></div>
				</div>
		</div>
		
		<div class="BoardColored toList">
	
		<a class="toListButton"><h4>목록</h4></a>
		</div>
	
		<%if(id != null && id.equals(wr)) {%>
		<div class="BoardColored writer">
			<button id="b_modify" onclick=" modifyCheck();"><h5>게시글 수정</h5></button>
		</div>	
		<div class="BoardColored writer">
	
			<form name='deleteform' id="b_delete" action="boardDelete" method="post">
				<input type="hidden" name="seq" value="${data.seq}" />
				<h5><input type="button" value="삭제" onclick="deleteCheck();" ></h5>
			</form>
		<%} %>
		</div>
	</div>

	<!-- 댓글 부분 -->
	<div id="comments-container">
		<h5>댓글 목록</h5>
		<form id="replywriteform" name="replywriteform" method="post" action="/movie/write">
			<label id="r_writer">
				${sessionScope.id}님 <input type="hidden" name="writer" value="${sessionScope.id}" />
			</label>
			<div id="replywritebox">
				<textarea id="reply_text" rows="2" cols="80" name="content" placeholder="댓글을 남겨주세요."></textarea>
				<input type="hidden" name="seq" value="${data.seq}" />
				<input type="button" id="reply_write" onclick="replyWriteCheck();" value="작성">
			</div>
		</form>
		<div id="reply_box">
			<%for(ReplyVo reply : replyList) {%>
				<div id="reply_data">
					<div class="r1"><%=reply.getContent() %></div>
					<div class="r2"><%=reply.getWriter() %></div>
					<div class="r3"><fmt:formatDate value="<%=reply.getRegDate() %>" pattern="yy-MM-dd"/></div>
					<%if(id != null && id.equals(reply.getWriter()) ) {%>
					<div class="r4">
						<div class="modify_modal" id="modify_modal">
							<h4><%=reply.getRno() %></h4>
							<a class="modal_close_btn">X</a>
							<div id="modal_reply_writer"><%=reply.getWriter() %>님</div>
							<div class="reply-modify">
								<form name="replymodifyform" data-rno="<%=reply.getRno()%>" method="post" action="/movie/modify">
									<textarea rows="2" cols="80" name="content" placeholder="댓글을 입력해주세요"></textarea>
									<input type="hidden" name="seq" value="<%=reply.getSeq()%>">
									<input type="hidden" name="rno" value="<%=reply.getRno()%>">
									<input type="button" onclick="replyModify(this.form);" value="저장"/>
								</form>
							</div>
						</div>
						<input type="button" data-rno="<%=reply.getRno()%>" id="modal_open_btn<%=reply.getRno()%>" class="modal_open_btn_" onclick="modal(this.id);" value="<%=reply.getRno()%>"/>
						<form name="replydeleteform" action="/movie/delete" method="post">
							<input type="hidden" name="rno" value="<%=reply.getRno()%>">
							<input type="hidden" name="seq" value="<%=reply.getSeq()%>">
							<input type="button" data-rno="<%=reply.getRno()%>" value="삭제" onclick="replydeleteCheck();"/>
						</form>
					</div>
					<%} %>
				</div>
			 
			<%} %>
		</div>
	</div>

	<div class="spacing" style="height:200px"></div>
</div>
		<jsp:include page="./common/footer.jsp">  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  

</body>

</html>