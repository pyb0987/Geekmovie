<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.geekmovie.board.vo.FreeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<% FreeVo data = (FreeVo)request.getAttribute("data"); %>
<% String wr = data.getWriter(); %>
<% String id = (String)session.getAttribute("id");
Timestamp gendate = data.getRegdate();
String formattedgenDate = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss").format(gendate);

String language = "ko-KR";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GeekBoardDetail</title>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">  <!-- 글꼴설정 -->
<link rel="stylesheet" href="${path}/resources/css/globalFont.css"/>
<link rel="stylesheet" href="${path}/resources/css/pagination.css"/>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>


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


window.onload = function(){	
	
var windowResize = function(){					//리사이징 함수

	fontResize()
	
}

windowResize();
var ResizeTimer;
window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
	 windowResize();
}, 20), true);	


document.querySelector(".toListButton").addEventListener('click', function(){
	if('${recommend}'=='true'){
		location.href="freeboardRecommendList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}"
	}else{		
		location.href="freeboardList?searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}"
	}
 })
 
 //===========================좋아요 기능
 
	$.fn.activeLikeButtons = function() {			// - 이미 눌린 좋아요 버튼 active효과주기
	this.each(function(i,e){
	let mode = Number($(e).hasClass("like-button"));
 	 $.ajax({
		 url: 'freeboard/like/${data.seq}?userId=${sessionScope.id}&mode='+mode,
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


$.ajax({					//로드완료하면 좋아요 개수 세기
	   url: 'freeboard/freeCount/${data.seq}?mode=1',
	   method: "GET",
    success: function(data){
 	   document.querySelector(".like-button .like-dislike-button-span").innerText = data;
		},
     error: function(request, status, error){
     	console.log(request, status, error)
		}
		});
$.ajax({					//로드완료하면 싫어요 개수 세기
	   url: 'freeboard/freeCount/${data.seq}?mode=0',
	   method: "GET",
    success: function(data){
    	document.querySelector(".dislike-button .like-dislike-button-span").innerText = data;
		},
		error: function(request, status, error){
     	console.log(request, status, error)		
		}
		});
 
$(document).on("click", ".like-button, .dislike-button", function(e){		//좋아요 버튼 누를때 이벤트
	 if('${sessionScope.id}'==''){
			var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
			if(result){
			    location.href = 'user_join';
			}
		}else{
		var button = e.currentTarget;
   		var likeData = {};
   		var likeButton = button.parentElement.querySelector(".like-button");
   		var dislikeButton = button.parentElement.querySelector(".dislike-button");
   		likeData['mode'] = Number(button.classList.contains("like-button"));
   		likeData['userId'] = '${sessionScope.id}';
			$.ajax({
				   url: 'freeboard/like/${data.seq}',
				   method: "POST",
				   data: JSON.stringify(likeData),
		           dataType: "json",
		           contentType:"application/json;charset=UTF-8",
		           success: function(data){
			           if(data==1 || data==2){				//성공시 정보 업데이트
			        	   $.ajax({
							   url: 'freeboard/freeCount/${data.seq}?mode=1',
							   method: "GET",
					           success: function(data){
					        	   likeButton.querySelector(".like-dislike-button-span").innerText = data;
					        	   document.querySelector('.movieLikes').innerText = "좋아요 : "+data;
					       		},
				                error: function(request, status, error){
				                	console.log(request, status, error)
					       		}
					       		});
			        	   $.ajax({
							   url: 'freeboard/freeCount/${data.seq}?mode=0',
							   method: "GET",
					           success: function(data){
					        	   dislikeButton.querySelector(".like-dislike-button-span").innerText = data;
					       		},
					       		error: function(request, status, error){
				                	console.log(request, status, error)		
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





 
 // ======================댓글기능
 var PageNow = 1;

$(document).on("click", ".pagination a", function(e){		//페이징 버튼 누를때 이벤트
	var button = e.currentTarget;
	if(!!button.dataset.page){
		PageNow = button.dataset.page;
		refreshReply(PageNow);
	}
	});
 
 
$.fn.activeReplyLikeButtons = function() {			// - 이미 눌린 좋아요 버튼 active효과주기
	this.each(function(i,e){
	let replyId = e.parentElement.dataset.replyid;
	
 	 $.ajax({
		 url: 'freeboard/reply/'+replyId+'/like?userId=${sessionScope.id}',
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

 
 

function refreshReply(pageNow){				//댓글 로드(refresh)
	$.ajax({
		   url: 'freeboard/${data.seq}/reply?page='+pageNow,
		   type : "GET",
       dataType: "JSON",
       success: function(data){
    	   console.log(data)
    	   document.querySelector("#comments-header").innerText = "댓글"+data.replyCnt+"개";
    	   var str = '';
    	   for (var reply of data.data){
    		   var stylestr = ""
    		   if(reply.depth>0){
    			   var stylestr = 'style="background-color: #fafafa; border-left: solid 4.2px #777; margin-left : '+(20*(reply.depth))+'px"'
    		   }
    		    
    		   str += '<div class="comment-container"'+stylestr +' data-replyId="'+reply.replyId+'" data-ancesterid="'+reply.ancestorId+'" data-depth="'+reply.depth+'" data-orderserial="'+reply.orderserial+'">';
    		   if(reply.deleted=="Y"){
    			   str += '삭제된 댓글입니다.</div>'
    		   }else{
    			let date = new Date(reply.create_date) 
    			var functionstr = '';
    			if('${sessionScope.id}'==reply.writer){functionstr = '<div class="update-button comment-function"><span>수정</span></div><div class="delete-button comment-function"><span>삭제</span></div>';}
    			
    		   str += '<div class="comment-id">'+reply.writer+'</div><div class="comment-content">'+reply.content+'</div><div class="comment-like"><span class="like-button-span like-dislike-button-span">'
    		   str += reply.likes+'</span><img class="like-icon" src="${path}/resources/img/like.png"></div><div class="comment-pack"><div class="comment-gendate">'
    		   str += date.toLocaleString('ko-KR')+'</div>'+functionstr+'</div></div>'
    		   }
    	}
    	   str += '<div class="pagination"></div>';
    	   document.querySelector('#comments-container').innerHTML = str;
    	   
    	   makePagination(data.endPage, pageNow);
    		if('${sessionScope.id}'!=''){
    			$(".comment-container .comment-like").activeReplyLikeButtons();
    		}
	 },
	error: function(request, status, error){
 	console.log(request, status, error)
	}
	});
}
refreshReply(PageNow);
 
$(".comment-write-content textarea").on("propertychange change keyup paste input", throttle(function(e){			//입력시 한줄평 입력칸의 크기를 100ms마다 바꿈
	 if('${sessionScope.id}'==''){
			var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
			if(result){
			    location.href = 'user_join';
			}
		}
	$(this).css("height", 'auto');
	$(this).height(this.scrollHeight);
	}, 200));
 
$(document).on("keydown", ".comment-write-content textarea", function(e){			//엔터치면 바로 등록
	if(e.keyCode === 13){
		e.currentTarget.parentElement.parentElement.querySelector('.comment-write-submit.commentButton').click();
	}
})
 
 
$(document).on("click", ".comment-write-submit.commentButton", function(e){		//작성 버튼 누를때 이벤트
	 if('${sessionScope.id}'==''){
			var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
			if(result){
			    location.href = 'user_join';
			}
	 }else{
		var button = e.currentTarget;	
		if(button.parentElement.querySelector("textarea").value!=""){
			var replyData = {};
			replyData["writer"] = '${sessionScope.id}';
			replyData["content"]=button.parentElement.querySelector("textarea").value
			replyData["depth"] = button.dataset.depth;
			replyData["ancestorId"]=button.dataset.ancestorid;
			replyData["orderserial"] = button.dataset.orderserial;
			$.ajax({
				   url: 'freeboard/${data.seq}/reply',
				   method: "POST",
				   data: JSON.stringify(replyData),
		           dataType: "json",
		           contentType:"application/json;charset=UTF-8",
		           success: function(data){
		        	   if(data==1){
		        		   button.parentElement.querySelector("textarea").value='';
		        		   refreshReply(PageNow);
		        	   }
		           },
		          	error: function(request, status, error){
		            	console.log(request, status, error)
		           	}
		           
			})
		}
		}
})

$(document).on("click", ".comment-function.delete-button", function(e){		//삭제 버튼 누를때 이벤트
			var result = confirm("삭제하면 복구할 수 없습니다. \n그래도 삭제 하시겠습니까?");
			if(result){
				var replyId = e.currentTarget.parentElement.parentElement.dataset.replyid
				$.ajax({
		        url: 'freeboard/reply/'+replyId,
		        method: "DELETE",
		          }).done(function(response){
		        	 if(response==1){
		        	 alert("성공적으로 삭제가 완료되었습니다.");
		        	 refreshReply(PageNow);
		        	 }else{
			        	 alert("삭제가 실패했습니다. \n다시 시도해 주세요.");	        		 
		        	 }
		          });
		        };
		 });



 $(document).on("dblclick", ".comment-container", function(e){
	 if('${sessionScope.id}'!='' && e.currentTarget.dataset.depth<5){
		 $('#comments-container .comment-write').remove();
		str = '<div class="comment-write" style="margin-left : '+(20*(Number(e.currentTarget.dataset.depth)+1))+'px"><div class="comment-write-id">${sessionScope.id}</div><div class="comment-write-content">'
		str +='<textarea rows=4 cols=40 placeholder="게시물 작성자에게 댓글은 큰 힘이 됩니다."></textarea></div><button class="comment-write-submit commentButton" data-depth="'+(Number(e.currentTarget.dataset.depth)+1)+'" data-ancestorid="'+e.currentTarget.dataset.ancesterid+'" data-orderserial="'+e.currentTarget.dataset.orderserial+'">작성</button></div>'
		 $(e.currentTarget).after(str)
		 
		 
	 }	 
 })


 
function makePagination(pageNum, pageNow){					//아래쪽 페이징 기능 구현

    var pageFirst = parseInt((pageNow-1)/10)*10
    var str ='';
    if (pageNow==1){
        str += '<a>처음</a>'
        }else{
            str += `<a style="cursor : pointer" data-page='1'>처음</a>`
        }
    if (pageNow<11){
    str += '<a>&laquo;</a>'
    }else{
        str += `<a style="cursor : pointer" data-page='`+pageFirst+`'>&laquo;</a>`
    }
    var index = 1
    while(pageFirst+index<=pageNum && index<11){
    	if(pageFirst+index==pageNow){
    		str += `<a class="active">`+(pageFirst+index)+'</a>'
    	}else{
    	str += `<a style="cursor : pointer" data-page='`+(pageFirst+index)+`'>`+(pageFirst+index)+'</a>'
    	}
    		index +=1
    }
    if(pageFirst+10>=pageNum){
    	str += '<a>&raquo;</a>'
    }else{
    	str += `<a style="cursor : pointer" data-page='`+(pageFirst+11)+`'>&raquo;</a>`
    }
    if(pageNow==pageNum){
    	str += '<a>끝</a>'
    }else{
    	str += `<a style="cursor : pointer" data-page='`+pageNum+`'>&nbsp;끝&nbsp;</a>`
    }
    
    $('.pagination').html(str);
		}
    

	 
	$(document).on("click", ".comment-like", function(e){		//좋아요 버튼 누를때 이벤트
		 if('${sessionScope.id}'==''){
				var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
				if(result){
				    location.href = 'user_join';
				}
			}else{
			let button = e.currentTarget;
			let replyId = button.parentElement.dataset.replyid;
	   		var likeData = {};
	   		likeData['mode'] = 1;
	   		likeData['userId'] = '${sessionScope.id}';
				$.ajax({
					   url: 'freeboard/reply/'+replyId+'/like',
					   method: "POST",
					   data: JSON.stringify(likeData),
			           dataType: "json",
			           contentType:"application/json;charset=UTF-8",
			           success: function(data){
				           if(data==1 || data==2){				//성공시 정보 업데이트
				        	   $.ajax({
								   url: 'freeboard/reply/'+replyId+'/replyCount',
								   method: "GET",
						           success: function(data){
						        	   button.querySelector(".like-dislike-button-span").innerText = data;
						       		},
					                error: function(request, status, error){
					                	console.log(request, status, error)
						       		}
						       		});
				        	   $(button).toggleClass('active');
				           }else{
				        	   console.log(data)
						       alert("존재하지 않는 대상입니다.");	        		 
					       }
				       },
				       error: function(){  alert("의견이 반영되지 않았습니다.");  }
				       });
				
			}
		 
	})

 
 
 
}


</script>
<style>

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
		margin-bottom : 50px;
	}
		#spacing{
	position : relative;
	width : 100%;
	height: 100px;
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

.like-dislike-button:hover, .comment-like:hover, .comment-function:hover{
  background: skyblue;
  border : solid 3px white;
}

.like-dislike-button.active, .comment-like.active, .comment-function.active{
  background: skyblue;
  border : solid 3px white;
}

.like-dislike-button:active, .comment-like:active, .comment-function:active{
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
#f_delete h5 input{
 font-size : 1rem;
}

.writer button:hover h5, input:hover{
	color : #f2f5dccc;
}
.listHeader {
		width : 80%;
		margin : auto;
		margin-bottom : 50px;
		border-bottom : 3px solid red;
}


/* comment*/
#comments-container{
	width: 95%;
    margin-top: 20px;
    padding: 20px;
	border : solid 1px red;
	display : flex;
	justify-content: center;
	flex-direction: column;

}
#comments-header ~ .comment-write{
width : 95%;
}
.comment-write{
	border : solid 1px red;
	display : flex;
	align-items: center;
	padding : 20px;
	margin-top: 5px;
	background-color: #fafafa;
}
.comment-write-id, .comment-id{
	font-size : 0.9rem;
	padding-right : 20px;
	min-width : 50px;
	flex : 0 3 150px;
	word-break: break-all;
}
.comment-write-content, .comment-content{
flex : 6 4 250px;
}
.comment-write-content textarea{
width: 90%;
}

.comment-container{
    min-height: 30px;
	border-bottom : solid 1px red;
	display : flex;
	align-items: center;
	padding : 10px;
	margin-top: 5px;
}

.comment-like{
    margin: 0.7rem;
    padding: 0.1rem;
    border-radius: 0.6rem;
    display: flex;
    align-items: center;
    justify-content: space-around;
    width: 4rem;
    height: 3rem;
    border: solid 3px skyblue;
    position: relative;
    background-color: white;
    transition: all 0.3s;
    cursor: pointer;
}
.comment-function{
margin: 0.3rem;
    padding: 0.1rem;
    border-radius: 0.6rem;
    display: flex;
    align-items: center;
    justify-content: space-around;
    height: 1.4rem;
    border: solid 3px skyblue;
    position: relative;
    background-color: white;
    transition: all 0.3s;
    cursor: pointer;
}

.comment-gendate{
	font-size : 0.8rem;
	margin-left : 10px;
}
#comments-header{
	background-color: #666;
	color : white;
	width : 95%;
	
   padding: 7px 20px;
    margin: 20px 0;

}

button.commentButton {
 appearance: none;
 background-color: transparent;
 border: 0.125em solid #1A1A1A;
 border-radius: 0.9375em;
 box-sizing: border-box;
 color: #3B3B3B;
 cursor: pointer;
 display: inline-block;
 font-family: Roobert,-apple-system,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol";
 font-size: 1rem;
 font-weight: 600;
 line-height: normal;
 margin: 0;
 min-height: 3.75em;
 min-width: 0;
 outline: none;
 padding: 1em 2.3em;
 text-align: center;
 text-decoration: none;
 transition: all 300ms cubic-bezier(.23, 1, 0.32, 1);
 user-select: none;
 -webkit-user-select: none;
 touch-action: manipulation;
 will-change: transform;
 max-height: 4rem;
 white-space: nowrap;
}

button.commentButton:disabled {
 pointer-events: none;
}

button.commentButton:hover {
 color: #fff;
 background-color: #1A1A1A;
 box-shadow: rgba(0, 0, 0, 0.25) 0 8px 15px;
 transform: translateY(-2px);
}

button.commentButton:active {
 box-shadow: none;
 transform: translateY(0);
}

.pagination{
margin : 20px auto;
}
.pagination a {
  background-color: #000;
}

.pagination a.active {
  border: 1px solid #000;
}

</style>
</head>
<body>
	<jsp:include page="./common/header.jsp">
		<jsp:param name="session"
			value='<%=(String) session.getAttribute("UserVo")%>' />
		<jsp:param name="language" value="${language}" />
	</jsp:include>

	<div id="spacing"></div>
		<div class="listHeader">
			<h1>게시글 보기</h1>
		</div>
	
	<div class="BoardContainer">
		<div class="BoardWrap">
			<div class="BoardHeader">
				<h1>${data.title}</h1>
			</div>

			<div class="Boardbody">
				<div class="Detail-body-header BoardColored">
					<h4>작성자 : ${data.writer}</h4>
					<h4 class="movieName"></h4>
				</div>
				<div class="BoardColored BoardDate">
					<h5><%=formattedgenDate%></h5>
				</div>
				<div class="movieScore BoardColored">
					<h5>영화태그 : ${data.movie_id}</h5>
				</div>
				<div class="BoardColored">
					<h5 class="movieWatchCount">조회수 : ${data.cnt}</h5>
				</div>
				<div class="BoardColored">
					<h5 class="movieLikes">좋아요 : ${data.likes}</h5>
				</div>

				<div class="movieContent">
					<h5>${data.contents}</h5>
				</div>

				<div class="Detail-body-header likedislike">
					<div class="like-dislike">
						<div class="like-button like-dislike-button">
							<span class="like-button-span like-dislike-button-span">${data.likes}</span><img
								class="like-icon" src="${path}/resources/img/like.png">
						</div>
						<div class="dislike-button like-dislike-button">
							<span class="dislike-button-span like-dislike-button-span">${data.likes}</span><img
								class="dislike-icon" src="${path}/resources/img/dislike.png">
						</div>
					</div>
				</div>
				<div class="BoardColored toList">
					<a class="toListButton"><h4>목록</h4></a>
				</div>



				<%
				if (id != null && id.equals(wr)) {
				%>
				<div class="BoardColored writer">
					<button id="f_modify">
						<h5>게시글 수정</h5>
					</button>
				</div>
				<div class="BoardColored writer">
					<form name='deleteform' id="f_delete" action="boardDelete"
						method="post">
						<input type="hidden" name="seq" value="${data.seq}" />
						<h5>
							<input type="button" value="삭제" onclick="deleteCheck();">
						</h5>
					</form>
					</div>
					<%} %>
					
			</div>
			
					<div id="comments-header"></div>
					<div class="comment-write">
					<div class="comment-write-id">${sessionScope.id}</div>
					<div class="comment-write-content">
					<textarea rows=4 cols=40 placeholder="게시물 작성자에게 댓글은 큰 힘이 됩니다."></textarea></div>
					<button class="comment-write-submit commentButton" data-depth="0">작성</button>
					</div>

					<div id="comments-container">
					
					</div>
		</div>
	</div>


	<div class="spacing" style="height: 200px"></div>
	<jsp:include page="./common/footer.jsp">  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  
</body>
</html>