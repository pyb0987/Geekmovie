<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/signup.js?ver=1"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/createUserstyle.css?ver=1">
</head>
<body>
	<div id="regist_wrap" class="wrap">
		<div>
			<h1>회원가입</h1>
			<!-- form method : post 방식 -->
			<form method="post" name="regiform" id="regist_form" class="form" onsubmit="return signUpCheck()">
			
			<!-- id 적용 -->
			<div>
			<p><input type="text" name="id" id="id" placeholder="ID"></p>
			<div id="idError" class="error">&nbsp;</div>
			</div>
			
			<!-- password 적용 -->
			<div>
			<p><input type="text" name="password" id="password" placeholder="Password"></p>
			<div id="passwordError" class="error"></div>
			</div>
			
			<!-- passwordCheck 적용 -->
			<div>
			<p><input type="text" name="passwordCheck" id="passwordCheck" placeholder="Password Check"></p>
			<div id="passwordCheckError" class="error">&nbsp;</div>
			</div>
			
			<!-- name 적용 -->
			<div>
			<p><input type="text" name="name" id="name" placeholder="Name"></p>
			<div id="nameError" class="error">&nbsp;</div>
			</div>
			<!-- 생년 월일 -->
			<!-- pass -->
			<p><select name="gender" id="gender">
				<option value="남자">남자</option>
				<option value="여자">여자</option>
			</select></p>
			<p><input type="submit" value="Sign Up" class="signup_btn"></p>
            <p class="pre_btn">Are you join? <a href="join">Login.</a></p>
		</form>	
		</div>
	</div>
</body>
</html>