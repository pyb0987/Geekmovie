<%@page import="com.geekmovie.board.vo.PageVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="path" value="${pageContext.request.contextPath}"/>

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
<title>freeboardList.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	window.onload = function() {
		
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
		
		oneLineReviewMakePagination( Number(`<%=startPage %>`), Number(`<%=endPage %>`), Number(`${curpage}`), Number(`<%=pageCnt %>`), '${searchType}', '${keyword}')

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
	}
</script>
<link rel="stylesheet" href="${path}/resources/css/pagination.css?ver=1"/>
</head>
<body>
<h3>회원정보 : ${sessionScope.id}</h3>
<h1>자유 게시판</h1>
	<!-- List -->
	<table border="1">
		<tr><th>게시번호</th><th>영화이름</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th><th>추천수</th></tr>
		<c:forEach var="f" items="${data}">
			<tr>
				<td>${f.seq}</td>
				<td>${f.movie_id}</td>
				<td><a href="freeboardDetail?seq=${f.seq }&searchType=${searchType}&bKeyword=${keyword}&curPage=${curpage}&range=${range}">${f.title}</a></td>
				<td>${f.writer}</td>
				<td>${f.regdate}</td>
				<td>${f.cnt}</td>
				<td>${f.likes}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- Page -->
	<div class="pagination-container" style="margin-top : 30px;">
	   <div class="pagination oneLineReviewSearchPagination"></div>
	</div>
	<!-- search -->
	<form accept-charset="utf-8">
		<select id="searchType" name="searchType">
			<option value="TC"  <c:if test="${searchType == 'TC'}">selected="selected"</c:if> >제목+내용</option>
			<option value="Wr" <c:if test="${searchType == 'Wr'}">selected="selected"</c:if>>작성자</option>
			<option value="M_id" <c:if test="${searchType == 'M_id'}">selected="selected"</c:if>>영화이름</option>
		</select>
		<input type="text" placeholder="검색" name="bKeyword" />
		<input type="hidden" name="curPage" value="1" />
		<input type="submit" value="검색">
	</form>
	<button id="f_create">게시글 작성</button>
	
</body>
</html>