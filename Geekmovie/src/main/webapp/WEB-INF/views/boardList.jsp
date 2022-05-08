<%@page import="com.geekmovie.board.vo.BoardVo"%>
<%@page import="java.util.List"%>
<%@page import="com.geekmovie.board.vo.PageVo"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="path" value="${pageContext.request.contextPath}"/>
 
<%
	String language = "ko-KR";
%>

<%
PageVo pagination = (PageVo)request.getAttribute("pagination");
	
	int listCnt = pagination.getListCnt(); // 전체 페이지 숫자
	int curPage = pagination.getPage();  // 현재 페이지
	int listSize = pagination.getListSize(); // 페이지당 목록 갯수
	
	int rangeSize = pagination.getRangeSize();
	int range = pagination.getRange();
	int startPage = pagination.getStartPage();
	int endPage = pagination.getEndPage();
	int pageCnt = pagination.getPageCnt();
	boolean prev = pagination.isPrev();
	boolean next = pagination.isNext();
	
	int maxRange = (int) Math.ceil(pageCnt/(float)rangeSize);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardList</title>
<link rel="stylesheet" href="${path}/resources/css/globalModal.css?"/>
<link rel="stylesheet" href="${path}/resources/css/movieSearch.css"/>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>

<script   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload = function(){	

	var windowResize = function(){					//리사이징 함수

		fontResize()
		
	}

	windowResize();
	var ResizeTimer;
	window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
		 windowResize();
	}, 20), true);		


	
document.querySelector("#b_create").onclick = function(){
	console.log(onclick);
	if('${sessionScope.id}'==''){
		var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
		if(result){
		    location.href = 'user_join';
		}
	}else{
		location.href = 'boardCreate';
	}
};

		
	$(".movieId").each(function(i, e){//movieId로부터 영화제목 가져오기
		var movieId = $(e).html()
		$.ajax({	
        	type: 'GET',
        	url: `/movie/getMovieData?movieId=`+movieId+`&language=<%=language %>`,
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

InputSearch("kg1", "movieIdInput", "checkImg", "searchType", "kg2", "SearchResultsContainer", '<%=language %>', '${path}', 'boardList');	  


	function InputSearch(inputBoxId, movieBoxId, checkImgId, searchModeId, searchButtonId, SearchResultsContainerId, language, pageContext, SearchUrl){		//모달창 있어야함

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
		
		
		
		function searchMovieSelect(movieId, movieTitle){			//영화검색결과를 누르면 movieId 달아줌
		document.getElementById(inputBoxId).value = movieTitle;
		document.getElementById(movieBoxId).value = movieId;
		document.getElementById(inputBoxId).className = "movieSelected";
		document.getElementById(inputBoxId).readOnly = true;
		document.getElementById(checkImgId).className = "visualized";
		$("#"+SearchResultsContainerId).empty();
		$(".modal").fadeOut();
		};
		
		$(document).on("click", ".movie-searchContainer", function(e){
			searchMovieSelect(e.currentTarget.dataset.id, e.currentTarget.dataset.title)

		})
		$(document).on("click", "#"+SearchResultsContainerId+" .search-result", function(e){
			searchMovieSelect(e.currentTarget.dataset.id, e.currentTarget.dataset.title)

		})
		
		
		
		
		

		var inputBox = document.getElementById(inputBoxId);
		var movieBox = document.getElementById(movieBoxId);
		var checkImg = document.getElementById(checkImgId);
		var SearchMode = document.getElementById(searchModeId);
		var modalExit = document.querySelector('.modalExit');
		var SearchButton = document.getElementById(searchButtonId);	
		
		function movieSelected(){					//영화선택되면 색깔변경
			inputBox.className = "movieSelected";
		}
		
		
		checkImg.addEventListener('click', function(e){	//체크박스 누르면 색깔변경 사라짐
			inputBox.classList.remove("movieSelected");
			inputBox.readOnly = false;
			checkImg.classList.remove("visualized");
	    }); 
		
		
		SearchMode.addEventListener('click', function(e){ //서치모드 변경시 색깔변경 사라짐
			inputBox.classList.remove("movieSelected");
			inputBox.readOnly = false;
			checkImg.classList.remove("visualized");
	    }); 
		
		modalExit.addEventListener('click', function(e){ //X박스 누르면 모달창 제거
		    $(".modal").fadeOut();
	    }); 
		
		
		function SearchResultMoreEventListenerAllocator(searchresultmore){				//영화 정보 완료되면 이벤트 설정  - searchResultmore는 더보기 버튼
		searchresultmore.addEventListener('click', function(e){
				const query = inputBox.value;
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
		
		
		SearchButton.addEventListener('click', function(e){					//서치버튼 클릭
		
		var query = inputBox.value;
		console.log(query)
		if(query!=""){
		let isReady = inputBox.classList.contains("movieSelected");
		if (SearchMode.value != 'M_id' || isReady){		
			if(!!SearchUrl){
				if(SearchMode.value == 'M_id'){
					query = movieBox.value;
					}
				var url = SearchUrl+'?SearchType='+SearchMode.value+'&bKeyword='+query+'&page=1';		//서치 실행 url
				location.href = url;
				}

		}else{				//만약 체크가 안되어있다면 모달창으로
			modalSearch(1, query, language);
		}
		}
		});
		
		inputBox.onkeydown = function(event){				//인풋박스에서 엔터해도 서치버튼 클릭으로 인식
		if (event.keyCode === 13) {
		    event.preventDefault();
		    let clickEvent = new Event("click");
		    SearchButton.dispatchEvent(clickEvent);
		}
		};
		
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
	        				imageUrl = pageContext+`/resources/img/noImage.jpg`       		//사진이 없을때 이미지			
	        			}
						var year = '';
						if(!!item.release_date){
							year = item.release_date.substr(0,4);
						}else{
							year = "Year Unknown"
						}
	        			str += '<div class="movie-searchContainer" data-id ="'+item.id+'" data-title="'+item.title+'" style="cursor:pointer;"><div class="movie-pictureContainer"><div class="movie-picture" style="background: url(\'';
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
		
		
		inputBox.addEventListener("propertychange", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
		inputBox.addEventListener("change", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
		inputBox.addEventListener("keyup", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
		inputBox.addEventListener("paste", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
		inputBox.addEventListener("input", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
		
		
		
		function InputBoxSearch(){				//한줄평 5개 영화목록 서치
		const query = inputBox.value;
		if (!query || SearchMode.value != "M_id" || inputBox.classList.contains("movieSelected")){
				$("#"+SearchResultsContainerId).empty();	
				return false;
			}else{
			  let inputUrl = '/movie/searchMovieList?query='+query+'&language='+language+'&page=1';
			  $.ajax({							//searchMovieList 출력
		        	type: 'GET',
		        	url: inputUrl,
		        	dataType : 'json',
		        	contentType : 'application/json', 
		        	success: function(data){
		        		$("#"+SearchResultsContainerId).empty();	
		        		if (data.total_results>0){
		        			let index=0;
		        			var str = '';
		            		while(index<5 && data.total_results>index){
		            			str +='<div class="search-result-container">';
								str += '<div class="search-result" tabindex:"'+(index+1)+'" data-id ="'+data.results[index].id+'" data-title="'+data.results[index].title+'">';
								if(!!data.results[index].poster_path){
			        				imageUrl = "https://image.tmdb.org/t/p/w92"+data.results[index].poster_path;
			        			}else{
			        				imageUrl = pageContext+`/resources/img/noImage.jpg`       		//사진이 없을때 이미지			
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
							$("#"+SearchResultsContainerId).append(str);
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
		
		
		
		

	}

		
	
	
	
	
oneLineReviewMakePagination( Number(`<%=startPage %>`), Number(`<%=endPage %>`), Number(`${curpage}`), Number(`<%=pageCnt %>`), '${searchType}', '${keyword}')

function oneLineReviewMakePagination(pageFirst,pageLast, pageNow, pageNum, searchMode, query){               //한줄평 페이징 기능 구현
    var str ='';
    if (pageNow==1){
        str += '<a>처음</a>'
        }else{
            str += `<a href="/movie/boardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=1&range=1">처음</a>`         //처음(페이지 1로)
        }
    if (pageNow<11){
    str += '<a>&laquo;</a>'
    }else{
        str += `<a href="/movie/boardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=`+(pageFirst+1)+`&range=<%=range-1 %>">&laquo;</a>`      //앞쪽 10페이지의 처음(페이지25에 있다면 페이지 20으로)
    }
    var index = 0
    while(pageFirst+index<=pageNum && pageFirst+index<=pageLast){
       if(pageFirst+index==pageNow){
          str += `<a class="active">`+(pageFirst+index)+'</a>'      //현재 페이지
       }else{
       str += `<a href="/movie/boardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=`+(pageFirst+index)+`&range=<%=range %>">`+(pageFirst+index)+'</a>'    //페이지 10개 생성
       }
          index +=1
    }
    if(pageLast>=pageNum){
       str += '<a>&raquo;</a>'
    }else{
       str += `<a href="/movie/boardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=`+(pageLast+1)+`&range=<%=range+1 %>">&raquo;</a>`   //뒤쪽 10페이지의 처음(페이지25에 있다면 페이지 31로)
    }
    if(pageNow==pageNum){
       str += '<a>끝</a>'
    }else{
       str += `<a href="/movie/boardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=`+(pageNum)+`&range=<%=maxRange %>">&nbsp;끝&nbsp;</a>` //맨뒤로
    }
    $('.oneLineReviewSearchPagination').html(str);
    }
}
</script>
<link rel="stylesheet" href="${path}/resources/css/pagination.css?ver=1"/>

<style>

	body {
		height: 1500px;
		overflow-x: hidden;
		background-color: #000000;
		margin: 0;
		padding-top : 100px;
	}
	
	section {
		/*
		background-color : white;
		*/
		width : 100%; height : 100%;
	}
	
	.listWrap {
		width : 70%; height : 100%;
		margin : auto;
	}
	
	.listHeader {
	
		margin-bottom : 50px;
		border-bottom : 3px solid red;
	}
	
	h1 {
		/*
		background-color : white;
		*/
		font-size : 40px;
		color : white;
		padding-left : 80px;
	}

	/* .listMain {
		background-color: white;
		border : 5px solid green;
	} */
	
	th {
		border: 0px;
		height:40px;
		background-color: #474040;
		padding: 3px;
		margin-bottom: 10px;
	}
	
	th.th_title {
		width: 40%;
	}
	
	th.th_cnt {
		width: 5%;
		font-size: 12px;
	}
	
	th.th_likes {
		width: 5%;
		font-size: 12px;
	}
	
 	td {
		height: 25px;
		background-color: #454343;
		padding: 10px;
	}
		
	td>a {
		text-decoration: none;
		color: #f2f5dc;
	}
	

	#boardTable {
		width : 1000px;
		margin : 0 auto 30px;
		background-color: #000000;
		text-align: center;
		color : #f2f5dc;
	}
	
	#b_create {
		width: 120px; height: 40px;
		float: right;
		margin-right: 35px;
		border: 1px solid white;
		background-color: #000000;
		color: white;
		padding: 5px;
	}
	
	#b_create:hover {
		color: white;
		background-color: #696565;
	}

	.search-container {
		width: 800px; height:60px;
		display: flex;
		margin: 0 auto;
		justify-content: center;
	}
	
	.typeGroup select {
		width: 130px; height: 40px;
		border: 1px solid white;
		background-color: #000000;
		color: white;
		text-align: center;
		margin-right: 10px;
	}
	
	.typeGroup select:hover {
		color: white;
		background-color: #696565;
	}
	
	#kg1 {
		width: 500px; height: 35px;
		border: 1px solid white;
		background-color: #000000;
		color: white;
		padding-left: 15px;
		font-size: 16px;
		box-sizing: border-box;
	}
	
	#kg2 {
		width:100px; height: 40px;
		border: 1px solid white;
		background-color: #000000;
		color: white;
		font-size: 16px;
	}
	
	#kg2:hover {
		color: white;
		background-color: #696565;
	}
	
	#SearchResultsContainer{
position : absolute;
    width: 500px;
    top: 38px;
}
#checkImg{
    left: 465px;
    top: 8px;
position: absolute;
max-width : 30px;
max-height : 30px;
display : none;
}

.keywordGroup{
position : relative;
}

#kg1.movieSelected{
background-color : #ffff88;
color : black;
}
#checkImg.visualized{display : block;
}
#modalExitImage{
	width: 30px;
	height: 30px;
	transform : rotate(0.02deg);	
}
#search-result-more{
text-align: center;
font-size : 1rem;
}
</style>


</head>

<!-- Body! -->
<body>

<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  

<section>
	<div class="listWrap">
	
		<div class="listHeader">
			<h1>리뷰게시판</h1>
		</div>
		
		<div class="listMain">
		<!-- List -->
			<table id="boardTable" >
				<tr>
					<th>번호</th>
					<th class="th_movie_id">영화이름</th>
					<th class="th_title">제목</th>
					<th class="th_writer">작성자</th>
					<th class="th_regdate">작성일</th>
					<th class="th_cnt">조회수</th>
					<th class="th_likes">추천수</th>
				</tr>
				<c:forEach var="b" items="${data}">
					<tr>
						<td>${b.seq}</td>
						<td class="movieId">${b.movie_id}</td>
						<td><a href="boardDetail?seq=${b.seq}&searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">${b.title}</a></td>
						<td>${b.writer}</td>
						<td>${b.regdate}</td>
						<td>${b.cnt}</td>
						<td>${b.likes}</td>
					</tr>
				</c:forEach>
			</table>
			<button id="b_create">글 작성</button>
		</div>
		<!-- listMain end -->
		
		<div class="listFooter">
			<!-- Page -->
			<div class="pagination-container" style="margin-top : 30px;">
			   <div class="pagination oneLineReviewSearchPagination"></div>
			</div>
			<!-- Search -->
			<div >
				<form class="search-container" accept-charset="utf-8">
					<div class="typeGroup">
						<select id="searchType" name="searchType">
							<option value="TC"  <c:if test="${searchType == 'TC'}">selected="selected"</c:if> >제목+내용</option>
							<option value="Wr" <c:if test="${searchType == 'Wr'}">selected="selected"</c:if>>작성자</option>
							<option value="M_id" <c:if test="${searchType == 'M_id'}">selected="selected"</c:if>>영화이름</option>
						</select>
					</div>
					<div class="keywordGroup">
						<div id="SearchResultsContainer"></div>
						<img id="checkImg" src="${path}/resources/img/check.png" onmouseover="this.style.cursor='pointer'">
						<input id="kg1" type="text" placeholder="검색" name="bKeyword" />
						<input id="movieIdInput" type="hidden" name="movieId" />
						<input type="hidden" name="page" value="1" />
						<input id="kg2" type="button" value="검색">
						
					</div>
				</form>
			</div>
		</div>
		<!-- listFooter end -->
		
	</div>
	<!-- listWrap end -->

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
	</div>
</section>

</body>
</html>
