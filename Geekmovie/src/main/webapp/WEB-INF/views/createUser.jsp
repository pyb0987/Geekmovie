<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/signup.js"></script>
</head>
<body>
	<h1>회원가입</h1>
	<!-- 전체 class  -->
	<div class="wrapper">
		<!-- id 적용 -->
		<div class="id">
		<h4>아이디</h4>
		<input type="text" id="id" placeholder="아이디를 입력해주세요.">
			<div id="idError" class="error"></div>
		</div>
		
		<!-- password 적용 -->
		<div class="password">
		<h4>비밀번호</h4>
		<input type="text" id="password" placeholder="비밀번호를 입력해주세요.">
			<div id="passwordError" class="error"></div>
		</div>
		
		<!-- password 재확인 적용 -->
		<div class="passwordCheck">
		<h4>비밀번호 재확인</h4>
		<input type="text" id="passwordCheck" placeholder="비밀번호를 다시 입력해주세요.">
			<div id="passwordCheckError" class="error"></div>
		</div>
		
		<!-- 이름 적용 -->
		<div class="name">
			<h4>이름</h4>
			<input type="text" id="name" placeholder="이름을 입력해주세요.">
			<div id="nameError" class="error"></div>
		</div>
		
		<!-- 생년월일 적용 -->
		<div class="birthday">
			<h4>생년월일</h4>
			
			<!-- 년도 -->
			<div class ="year">
			<input type="text" id="year" placeholder="년(4자)">
			<div id="yearError" class="error"></div>
			</div>
			
			<!-- 월 -->
			<div class = "month">
			<select id="month"> 
    			<option selected disabled>월</option> <!-- 월 입력창 -->
	    		<option>1</option>
	    		<option>2</option>
	    		<option>3</option>
	    		<option>4</option>
	    		<option>5</option>
	    		<option>6</option>
	    		<option>7</option>
	    		<option>8</option>
	    		<option>9</option>
	    		<option>10</option>
	    		<option>11</option>
	    		<option>12</option>
			</select>
			<div class="monthError" class="error"></div>
			</div>
			
			<!-- 일 -->
			<div class ="day">
			<input type="text" id="day" placeholder="일">
			<div id="dayError" class="error"></div>
			</div>
			
			<!-- 성별 -->
			<div class ="gender">
			<h4>성별</h4>
			<select id="gender">
				<option>남자</option>
				<option>여자</option>
			</select>
			<div id="genderError" class="error"></div>
			</div>
		</div>
		<hr>
		<div class = "signUp">
			<button id="signUpButton" onclick="signUpCheck()">가입하기</button>
		</div>
	</div>
</body>
</html>