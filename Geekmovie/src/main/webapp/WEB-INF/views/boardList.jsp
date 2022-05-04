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

<script   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload = function(){	

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
	
		margin-bottom : 20px;
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
						<td>${b.movie_id}</td>
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
						<input id="kg1" type="text" placeholder="검색" name="bKeyword" />
						<input type="hidden" name="page" value="1" />
						<input id="kg2" type="submit" value="검색">
					</div>
				</form>
			</div>
		</div>
		<!-- listFooter end -->
		
	</div>
	<!-- listWrap end -->

	
</section>

</body>
</html>
