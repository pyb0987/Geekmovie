<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String id = (String)session.getAttribute("id");
	if(id == null) id= "product";
	String password = (String)session.getAttribute("password");
	String name =(String)session.getAttribute("name");
	String gender =(String)session.getAttribute("gender");
	System.out.print(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/joinstyle.css?ver=2">
</head>
</head>
<body>
	<div id="regist_wrap" class="wrap">
      <div>
         <h1>마이페이지</h1>
         <!-- form method : post 방식 -->
         <form method="post" name="regiform" id="regist_form" class="form">

				<!-- id 적용 -->
				<div>
					<input type="text" name="id" id="id" readonly value="${id}"> 
					<span class="error_next_box" id="idError"></span>
				</div>

				<!-- password 적용 -->
				<div>
					<input type="text" name="password" id="password" placeholder="Password"> 
					<span class="error_next_box" id="passwordError"></span>
				</div>

				<!-- passwordCheck 적용 -->
				<div>
					<input type="text" name="passwordCheck" id="passwordCheck" placeholder="Password Check"> 
					<span class="error_next_box" id="passwordCheckError"></span>
				</div>

				<!-- name 적용 -->
				<div>
					<input type="text" name="name" id="name" placeholder="Name">
					<span class="error_next_box" id="nameError"></span>
				</div>
				<p>
					<input type="submit" value="Sign Up" class="signup_btn">
				</p>
			</form>
		</div>
	</div>
</body>
</html>