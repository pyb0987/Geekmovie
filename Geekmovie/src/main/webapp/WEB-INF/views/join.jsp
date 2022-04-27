<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/joinstyle.css?ver=1">
</head>
<body>
	<div id="regist_wrap" class="wrap">
		<div>
			<h1>로그인</h1>
			<!-- form method : post 방식 -->
			<form method="post" name="regiform" id="regist_form" class="form" onsubmit="return login_signUpCheck()">

				<!-- id 적용 -->
				<div>
					<input type="text" name="id" id="id" placeholder="ID"> 
					<span class="error_next_box" id="idError"></span>
				</div>

				<!-- password 적용 -->
				<div>
					<input type="text" name="password" id="password" placeholder="Password"> 
					<span class="error_next_box" id="passwordError"></span>
				</div>
				
				<!-- 로그인 페이지 -->
				<p>
					<input type="submit" value="Sign Up" class="signup_btn">
				</p>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/login_signup.js?ver=3"></script>
</html>