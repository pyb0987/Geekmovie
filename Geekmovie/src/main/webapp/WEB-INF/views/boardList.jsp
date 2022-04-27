<%@page import="com.geekmovie.board.vo.PageVo"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
PageVo pagination = (PageVo)request.getAttribute("pagination");
	
	int listCnt = pagination.getListCnt(); // ��ü ������ ����
	int curPage = pagination.getPage();  // ���� ������
	int listSize = pagination.getListSize(); // �������� ��� ����
	
	int rangeSize = pagination.getRangeSize();
	int range = pagination.getRange();
	int startPage = pagination.getStartPage();
	int endPage = pagination.getEndPage();
	
	boolean prev = pagination.isPrev();
	boolean next = pagination.isNext();
%>

start : <%=startPage %> / end : <%=endPage %> / ���籸�� : <%=range %> / ���� ������ : <%=curPage %> / 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardList</title>
</head>
<body>
<!-- List -->
	<table border="1">
		<tr><th>seq</th><th>title</th><th>writer</th><th>regdate</th><th>cnt</th><th>likes</th></tr>
		<c:forEach var="b" items="${data}">
			<tr>
				<td>${b.seq}</td>
				<td><a href="boardDetail?seq=${b.seq }">${b.title}</a></td>
				<td>${b.writer}</td>
				<td>${b.regdate}</td>
				<td>${b.cnt}</td>
				<td>${b.likes}</td>
			</tr>
		</c:forEach>
	</table>
<!-- Page -->
<%if(prev) { %>
<a href="boardList?curPage=<%=startPage - rangeSize%>&range=<%=range -1 %>">[����<%=rangeSize%>��]</a>
<%} %>
<%for(int i = startPage; i<=endPage; ++i){ %>
<a href="boardList?curPage=<%=i%>&range=<%=range%>">[<%=i%>]</a>
<%} %>
<%if(next) { %>
<a href="boardList?curPage=<%=startPage + rangeSize%>&range=<%=range +1 %>">[����<%=rangeSize%>��]</a>
<%} %>

<!-- Search -->
	<form>
		<select name="b_search">
			<option value="����+����">����+����</option>
			<option value="�ۼ���">�ۼ���</option>
			<option value="��ȭ�̸�">��ȭ�̸�</option>
		</select>
		<input type="text" placeholder="�˻�" name="keyword" value="${keyword}" />
		<input type="submit" value="�˻�">
	</form>
	<a href="boardCreate">�Խñ� �ۼ�</a>
</body>
</html>