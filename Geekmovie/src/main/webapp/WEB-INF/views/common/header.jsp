<%@page import="com.geekmovie.user.vo.userVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>header</title>
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css"
	rel="stylesheet">
<style>


#header{
	display: flex;
	height : 100px;
	top : 0;
	left : 0;
    width: 100%;
    /*background-color: #242608;*/
    background-color: darkred;
    align-items: center;
    position : fixed;
    z-index : 4;
}

    /*-- menu button --*/
#menu-container{
    width: 140px;
    min-width: 70px;
    height: 30px;
    display: flex;
    justify-content: center;
}
#menu{

    width: 40px;
    height: 30px;
    position:relative;
}
.menubar{
    position: absolute;
    width: 100%;
    height: 13%;
    background-color: #f8efc5;
    border-radius: 4px;
    transition : all 0.2s;
}
.menubar2{transform: translateY(13px);}
.menubar3{transform: translateY(26px);}
.menubar1.active-menu  { transform : translateY(13px) rotate(30deg); }
.menubar2.active-menu  { opacity: 0; }
.menubar3.active-menu  { transform : translateY(13px) rotate(-30deg); }




    /*-- logo --*/
#logo-img{
    
}
#logo{
	width: 150px;
    min-width : 100px;
    height: 40px;
    font-family: 'Square Peg', cursive;
    font-size: 30px;
    color : #f8efc5;
    letter-spacing: -4px;
    line-height : 40px;
    text-decoration: none;
    transfrom : rotate(0.02deg);
}





    /*-- searchbox --*/    
#searchbox{
	display: flex;
    min-width : 430px;
    height: 40px;
    border-radius: 35px;
    background-color: white;
    border: 3px solid red;

}
#inputbox-container{
	display : flex;
	flex-direction : column;
    flex-grow : 1;
}

#inputbox{				
    border: none;
    height: 35px;
    font-size: 1.2rem;
}

option{
	font-size: 1rem;
} 

#searchbutton-container{
    width: 70px;
    height: 40px;
    flex-grow : 0;
}
#searchbox-container{
    width: 650px;
    padding-left : 25px;
    padding-right : 25px;
    margin : auto;
        
}
#searchbutton{
    width: 100%;
    height: 100%;
    display: flex;
    align-items : center;
}

#search-image{
	width: 30px;
	height: 30px;
	transfrom : rotate(0.02deg);	
}
#searchMode{
font-family: 'NanumSquareRound';
margin-left : 20px;
    border: none;
    flex-grow : 0;

}
#keywordSearch{
display : flex;
flex-grow : 1;
align-items : baseline;
margin : auto;
}

.search-result-container{				    /*-- search result --*/    
height : 80px;
padding : 7px;
background-color : white;
border-top : solid 1px;
border-image: linear-gradient(to left, rgba(255, 255, 255, 1) 1%, rgba(127, 127, 127, 0.3) 50%, rgba(255, 255, 255, 1) 100%) 
              100% 0 100% 0/1.5px 0 0 0 stretch;
cursor : pointer;              
box-sizing : border-box;
}
.search-result-container:hover{				
border-image: none;
border : solid 3px black;       
padding : 4px;
padding-top : 5px;
box-sizing : border-box;
}
.search-result{	
display : flex;
height : 100%;
padding-left : 5%;
padding-right : 5%;
}

.result-picture{
	flex-shrink : 0;
	height:100%;
	width: 50px;
}

.result-nonPicture{
display : flex;
padding-left:10%;
flex-direction : column;
justify-content: space-around;
 overflow: hidden;
 
}


.result-title-font{
font-family: 'NanumSquareRoundBold';
font-size : 0.9rem;
 white-space: nowrap;
color : #373737;
}

.result-font{
font-family: 'NanumSquareRound';
font-size : 0.7rem;
 white-space: nowrap;
color : #555555;
}


#user-menu1, #user-menu2{				    /*-- user interface --*/    
 color : #f8efc5e0;
   margin-right : 10px;
   white-space : nowrap;

} 

#user-menu1:hover, #user-menu2:hover{
 color : #f8efc570;
} 

#foldMenuContainer{						    /*-- hidden menubar --*/    
 width : 20%;
 max-width : 250px;
 height : 100%;
 top : 100px;
left : 0;
 position : fixed;
 z-index : 3;
 background-color : #252525;
 border-right : solid 10px #1D1D1D;
 
 transform : translateX(-100%);
 transition : all 0.3s;
}

#foldMenuContainer.active-menu{

	transform : translateX(0);
}

#foldMenu{
 width : 100%;
 height : 100%;
 
display : flex;
flex-direction: column;
}

.menuButton{
box-sizing: border-box;
 width : 100%;
 height : 80px;
 line-height : 80px;
 color : white;
 font-family: 'NanumSquareRound';
 text-align : center;
 font-size: 1.1rem;
 white-space : nowrap;
 overflow : hidden;
 cursor : pointer;          
 border-right: 1px solid #323235;
 border-left: 1px solid rgba(255, 255, 255, 0.2);
 background-image: -moz-linear-gradient(top, #535357, #3c3c3f);
 background-image: -ms-linear-gradient(top, #535357, #3c3c3f);
 background-image: -webkit-linear-gradient(top, #535357, #3c3c3f);
 background-image: linear-gradient(top, #535357, #3c3c3f);
           
 -webkit-box-shadow: inset 0 1px 0px rgba(255, 255, 255, 0.2), 0 1px 0px #292929;
 -moz-box-shadow: inset 0 1px 0px rgba(255, 255, 255, 0.2), 0 1px 0px #292929;
 box-shadow: inset 0 1px 0px rgba(255, 255, 255, 0.2), 0 1px 0px #292929;
}
.menuButton:hover{
background-image: -moz-linear-gradient(top, #484852, #383839);
 background-image: -ms-linear-gradient(top, #484852, #383839);
 background-image: -webkit-linear-gradient(top, #484852, #383839);
 background-image: linear-gradient(top, #484852, #383839);        
box-shadow: -2px 2px 16px rgba(0, 0, 0, 0.6);
box-shadow: -1px 1px 16px rgba(0, 0, 0, 0.6);
}


#screen{				
 width : 100vw;
 height : 100vh;
 position : fixed;
 z-index : -2;
}

#screen.active-menu{
 z-index : 2;
}

</style>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/debounce.js"></script>
<script>

$(document).ready(function(){		
	
	var language = '<%=request.getParameter("language")%>';
	
	
	
document.querySelector("#menu").onclick=function(){
    $("#menu").children().toggleClass("active-menu");			//메뉴 버튼 모양 토글            
    $("#foldMenuContainer").toggleClass("active-menu");
    $("#screen").toggleClass("active-menu");  
};


document.querySelector("#screen").onclick=function(){
	document.querySelector("#menu").onclick();
};


 function session_check(){ 							//메뉴 세션 체크
     var UserVo = '<%=request.getParameter("session")%>';

      if(UserVo=="null"){ 
         let str1 = "<a id='user-menu1' href='login'>로그인</a>"
         let str2 = "<a id='user-menu2' href='createUser'>회원가입</a>"
    	$("#user-menu1-container").html(str1);
    	$("#user-menu2-container").html(str2);
      }
      else{
         location.replace("/user/mypageForm.jsp");
      }
}   
 
	session_check();					//메뉴 세션 체크 실행

 
	
	$("#inputbox").on("propertychange change keyup paste input",  debounce(function(){  //자동완성을 위한 키업 이벤트리스너
		inputBoxSearch();
	}, 500, false));															//키를 받을때마다 실행 - debounce
	
	
	
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
	
			
	function inputBoxSearch(){	
		const query = $("#inputbox").val();
		if (!query){
			$("#search-results-container").empty();	
		}else{
		  let inputUrl = '/movie/searchMovieList?query='+query+'&language='+language+'&page=1';
		  $.ajax({							//searchMovieList 출력
	        	type: 'GET',
	        	url: inputUrl,
	        	dataType : 'json',
	        	contentType : 'application/json', 
	        	success: function(data){
	        		$("#search-results-container").empty();	
	        		if (data.total_results>0){
	        			let index=0;
	        			var str = '';
	            		while(index<5 && data.total_results>index){
	            			str +='<div class="search-result-container">';
							str += '<div class="search-result" tabindex:"'+(index+1)+'" onclick="location.href=\'/movie/movieDetail?movieId='+data.results[index].id+'&language='+language+'\'">';
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
						$("#search-results-container").append(str);
	        		}

	        	
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





	
})

</script>

<body>
<header>
	<div id="header">
		<div id="menu-container">
			<div id="menu" onmouseover="this.style.cursor='pointer'">
				<div class="menubar menubar1"></div>
				<div class="menubar menubar2"></div>
				<div class="menubar menubar3"></div>
			</div>
		</div>
		<div id="logo-img">
			<a id="logo" href="/movie">Geekmovie</a>
		</div>
		<div id="searchbox-container">
				<div id="searchbox">
					<form id="keywordSearch" name="keywordSearch" accept-charset="utf-8" action="search" method="get">
						<select name="searchMode" id="searchMode">
							<option value="movie">영화이름</option>
							<option value="keyword">게시글</option>
						</select> 
						<div id="inputbox-container">  
						<input type="text" id="inputbox" name="query" autocomplete='off' maxlength=50 placeholder="검색할 키워드를 입력하세요">
						<input type="hidden" name="language" value="<%=request.getParameter("language") %>">
						<input type="hidden" name="page" value="1">
						<div id="search-results-container">
						</div>
						</div>
					</form>
					<div id="searchbutton-container">
						<div id="searchbutton" onmouseover="this.style.cursor='pointer'">
							<img id="search-image"
								src="${pageContext.request.contextPath}/resources/img/searchIcon.png"
								alt="search">
						</div>
					</div>
				</div>
			</div>
		<div id="user-menu1-container"></div>
		<div id="user-menu2-container"></div>
	</div>
	<div id='screen'></div>
	<div id="foldMenuContainer">
		<div id="foldMenu">
		<div class="menuButton">최신영화</div>
		<div class="menuButton">인기영화</div>
		<div class="menuButton">장르별 영화보기</div>

		<div class="menuButton" onclick="location.href='boardList';">최신게시글</div>
		<div class="menuButton" onclick="location.href='/movie/oneLineReview';">한줄평</div>
		<div class="menuButton">랜덤영화</div>
		<div class="menuButton">마이페이지</div>
		<div class="menuButton">lanuguage</div>
		</div>
	</div>
	
	</header>
</body>
</html>







