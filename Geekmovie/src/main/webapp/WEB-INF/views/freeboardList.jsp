<%@page import="com.geekmovie.board.vo.PageVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="path" value="${pageContext.request.contextPath}"/>
<%
	String language = "ko-KR";
%>

<%
PageVo pagevo = (PageVo)request.getAttribute("pagevo");
	
	int listCnt = pagevo.getListCnt(); // 전체 페이지 숫자
	int curPage = pagevo.getPage();  // 현재 페이지
	int listSize = pagevo.getListSize(); // 페이지당 목록 갯수
	
	int rangeSize = pagevo.getRangeSize();
	int range = pagevo.getRange();
	int startPage = pagevo.getStartPage();
	int endPage = pagevo.getEndPage();
	int pageCnt = pagevo.getPageCnt();
	boolean prev = pagevo.isPrev();
	boolean next = pagevo.isNext();
	
	int maxRange = (int) Math.ceil(pageCnt/(float)rangeSize);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GeekFreeBoard</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/throttle.js"></script>
<script type="text/javascript" src="${path}/resources/js/fontResize.js"></script>
<script type="text/javascript">
	window.onload = function() {
		
		
		var windowResize = function(){					//리사이징 함수

			fontResize()
			
		}

		windowResize();
		var ResizeTimer;
		window.addEventListener('resize', throttle(function() {				//리사이징에 throttle 적용
			 windowResize();
		}, 20), true);		

		
		
		
		
		
		
		document.querySelector("#f_create").onclick = function(){
			console.log(onclick);
			if('${sessionScope.id}'==''){
				var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
				if(result){
				    location.href = 'user_join';
				}
			}else{
				location.href = 'freeboardCreate';
			}
		};
		
		oneLineReviewMakePagination( Number(`<%=startPage %>`), Number(`<%=endPage %>`), Number(`<%=curPage %>`), Number(`<%=pageCnt %>`), '${searchType}', '${keyword}')

		function oneLineReviewMakePagination(pageFirst,pageLast, pageNow, pageNum, searchMode, query){               //한줄평 페이징 기능 구현
		    var str ='';
		    if (pageNow==1){
		        str += '<a>처음</a>'
		        }else{
		            str += `<a href="/movie/freeboardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=1&range=1">처음</a>`         //처음(페이지 1로)
		        }
		    if (pageNow<11){
		    	str += '<a>&laquo;</a>'
		    	}else{
		        	str += `<a href="/movie/freeboardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=`+(pageFirst+1)+`&range=<%=range-1 %>">&laquo;</a>`      //앞쪽 10페이지의 처음(페이지25에 있다면 페이지 20으로)
		    	}
		    var index = 0
		    while(pageFirst+index<=pageNum && pageFirst+index<=pageLast){
		       if(pageFirst+index==pageNow){
		          str += `<a class="active">`+(pageFirst+index)+'</a>'      //현재 페이지
	       		}else{
		       		str += `<a href="/movie/freeboardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=`+(pageFirst+index)+`&range=<%=range %>">`+(pageFirst+index)+'</a>'    //페이지 10개 생성
		       	}
		          index +=1
		    }
		    if(pageLast>=pageNum){
		       str += '<a>&raquo;</a>'
	    	}else{
	       		str += `<a href="/movie/freeboardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=`+(pageLast+1)+`&range=<%=range+1 %>">&raquo;</a>`   //뒤쪽 10페이지의 처음(페이지25에 있다면 페이지 31로)
	    	}
		    if(pageNow==pageNum){
	       		str += '<a>끝</a>'
	    	}else{
		       str += `<a href="/movie/freeboardList?searchType=`+searchMode+`&bKeyword=`+query+`&curPage=`+(pageNum)+`&range=<%=maxRange %>">&nbsp;끝&nbsp;</a>` //맨뒤로
		    }
		    $('.oneLineReviewSearchPagination').html(str);
	    }
		
	    $(".timeStamp").each(function(i,e){
	    	var date = new Date($(e).text());
	    	$(e).text(date.toLocaleString());
	    })
	}
</script>
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
		min-width: 500px;
    max-width: 1500px;
		margin : 0 auto 30px;
		background-color: #000000;
		text-align: center;
		color : #f2f5dc;
	}
	
#f_create,#f_switch {
		width: 120px; height: 40px;
		float: right;
		margin-right: 8px;
		border: 1px solid white;
		background-color: #000000;
		color: white;
		padding: 5px;
	}
	
	#f_create:hover, #f_switch:hover {
		color: white;
		background-color: #696565;
	}
		.typeGroup select {
		 height: 40px;
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
		width: 77%; height: 35px;
		border: 1px solid white;
		background-color: #000000;
		color: white;
		padding-left: 15px;
		font-size: 16px;
		box-sizing: border-box;
	}
	
	#kg2 {
		width: 20%; height: 40px;
		border: 1px solid white;
		background-color: #000000;
		color: white;
		font-size: 16px;
	}
	
	#kg2:hover {
		color: white;
		background-color: #696565;
	}
	.keywordGroup{
position : relative;
flex: 2 2 500px;
}

#kg1.movieSelected{
background-color : #ffff88;
color : black;
}
	.search-container {
		width: 100%;
    min-width: 500px;
     height:60px;
		display: flex;
		margin: 0 auto;
		justify-content: center;
	}
		#f_create:hover {
		color: white;
		background-color: #696565;
	}
	
	.hover:hover{
	color : #f2f5dccc;
}
</style>
<link rel="stylesheet" href="${path}/resources/css/pagination.css?ver=1"/>
</head>
<body>

<jsp:include page="./common/header.jsp">  
<jsp:param name="session" value='<%=(String)session.getAttribute("UserVo")%>'/>  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  

<section>
	<div class="listWrap">
	
		<div class="listHeader">
			<h1>자유게시판</h1>
		</div>

<div class="listMain">
		<!-- List -->
			<table id="boardTable" >
			
			<tr>
					<th>게시번호</th>
					<th class="th_title">제목</th>
					<th class="th_movie_id">태그</th>
					<th class="th_writer">작성자</th>
					<th class="th_regdate">작성일</th>
					<th class="th_cnt">조회수</th>
					<th class="th_likes">추천수</th>
				</tr>
			<c:forEach var="f" items="${data}">
					<tr>
						<td>${f.seq}</td>
						<td ><a class="hover" href="freeboardDetail?seq=${f.seq }&searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">${f.title}(+${f.reply})</a></td>
						<td class="movieId">${f.movie_id}</td>
				<td>${f.writer}</td>
				<td class="timeStamp">${f.regdate}</td>
				<td>${f.cnt}</td>
				<td>${f.likes}</td>
					</tr>
				</c:forEach>
			</table>
					<button id="f_switch" onclick="location.href='freeboardRecommendList?'">추천글</button>
			<button id="f_create">글 작성</button>
		</div>
		<!-- listMain end -->	
			<div class="listFooter">
			<!-- Page -->
			<div class="pagination-container" style="margin-top : 30px;">
			   <div class="pagination oneLineReviewSearchPagination"></div>
			</div>
			<!-- Search -->
				<form class="search-container" accept-charset="utf-8">
					<div class="typeGroup">
						<select id="searchType" name="searchType">
							<option value="TC"  <c:if test="${searchType == 'TC'}">selected="selected"</c:if> >제목+내용</option>
							<option value="Wr" <c:if test="${searchType == 'Wr'}">selected="selected"</c:if>>작성자</option>
							<option value="M_id" <c:if test="${searchType == 'M_id'}">selected="selected"</c:if>>태그</option>
						</select>
					</div>
					<div class="keywordGroup">
						<input id="kg1" type="text" placeholder="검색" name="bKeyword" />
						<input type="hidden" name="curPage" value="1" />
						<input id="kg2" type="submit" value="검색">
						
					</div>
				</form>
		</div>
		<!-- listFooter end -->
		
	</div>
	<!-- listWrap end -->
		


	<jsp:include page="./common/footer.jsp">  
<jsp:param name="language" value="<%=language%>"/>  
</jsp:include>  
</body>
</html>