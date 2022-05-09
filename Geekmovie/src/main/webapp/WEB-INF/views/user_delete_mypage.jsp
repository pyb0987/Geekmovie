<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
	String id = (String)session.getAttribute("id");
	String oldpassword = (String)session.getAttribute("password");
	System.out.println("기존 아이디 : "+id);
	System.out.println("기존 비밀번호 : "+oldpassword);
%>

<%if(id==null){%>
	<script>
		alert('비정상 접근입니다. 로그인 후 이용 바랍니다.');
		document.location.href="/movie";
	</script>
<%}%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 탈퇴 페이지</title>
<link rel="stylesheet"

   href="${pageContext.request.contextPath}/resources/css/createUserstyle.css?ver=1">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
	<div id="regist_wrap" class="wrap">
		<div>
			<h1>회원탈퇴</h1>
			<!-- form method : post 방식 -->
			<form method="post" name="regiform" id="regist_form" class="form"
				onsubmit="return signUpCheck()">

				<!-- id 적용 -->
				<div>
					<input type="text" name="id" id="id" value=<%=id%> readonly="readonly"> 
					<span class="error_next_box" id="idError"></span>
				</div>

				<!-- password 적용 -->
				<div>
					<input type="text" name="password" id="password"
						placeholder="비밀번호"> 
					<span class="error_next_box" id="passwordError"></span>
				</div>

				<!-- passwordCheck 적용 -->
				<div>
					<input type="text" name="passwordCheck" id="passwordCheck"
						placeholder="비밀번호 재입력"> 
					<span class="error_next_box" id="passwordCheckError"></span>
					<c:if test="${msg == 'failure'}">
						<div style="color:red">
						비밀번호가 일치하지 않습니다.
					</div>
					</c:if>
				</div>
				<!-- pass -->
				<p>
					<input type="submit" value="회원탈퇴" class="signup_btn">
				</p>
			</form>
		</div>
	</div>
</body>
<!-- sumbit 눌렀을때 동작 : signup.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/delete_signup.js?ver=2"></script>

</html>