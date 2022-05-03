<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet"

   href="${pageContext.request.contextPath}/resources/css/createUserstyle.css?ver=2">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
   <div id="regist_wrap" class="wrap">
      <div>
         <h1>회원가입</h1>
         <!-- form method : post 방식 -->
         <form method="post" name="regiform" id="regist_form" class="form"
            onsubmit="return signUpCheck()">

				<!-- id 적용 -->
				<div>
					<input type="text" name="id" id="id" placeholder="ID" required oninput = "checkIdtest()"> 
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
				<!-- 생년 월일 -->
				<div id="bir_wrap">
					<!-- 년도 입력구문 -->
					<div id="bir_yy">
						<span class="box"> <input type="text" id="yy" class="int"
							maxlength="4" placeholder="년(4자)"> <span
							class="error_next_box" id="yyError"></span>
						</span>
					</div>
					<!-- 월일 입력구문 -->
					<div id="bir_mm">
						<span class="box"> <select id="mm">
								<option>월</option>
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
						</select>
						</span>
					</div>
					<!-- 일 입력구문-->
					<div id="bir_dd">
						<span class="box"> <input type="text" id="dd" class="int"
							maxlength="2" placeholder="일">
						</span>
					</div>

				</div>
				<!-- pass -->
				<p>
					<select name="gender" id="gender">
						<option value="남자">남자</option>
						<option value="여자">여자</option>
					</select>
				</p>
				<p>
					<input type="submit" value="Sign Up" class="signup_btn">
				</p>
				<p class="pre_btn">
					Are you join? <a href="join">Login.</a>
				</p>
			</form>
		</div>
	</div>
</body>
<!-- sumbit 누르지 않고 실시간 동작 : signup2.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/signup2.js?ver=1"></script>
<!-- sumbit 눌렀을때 동작 : signup.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/signup.js?ver=1"></script>

</html>