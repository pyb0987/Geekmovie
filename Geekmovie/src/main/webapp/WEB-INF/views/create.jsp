<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>
	<h1>회원가입</h1>
	<form method="post">
	<h4><p>아이디<br></h4>
	<input type="text" name="id"></p> <!-- 아이디 입력창 -->
	<!-- -------------------------------------- -->
	<h4><p>비밀번호<br></h4>
	<input type="text" name="password"></p> <!-- 패스워드 입력창 -->
	<!-- -------------------------------------- -->
	<h4><p>비밀번호 재확인<br></h4>
	<input type="text" name="password2"></p> <!-- 패스워드 재확인 입력창 -->
	<!-- -------------------------------------- -->
	<h4><p>이름<br></h4>
	<input type="text" name="name"></p> <!-- 이름 입력창 -->
	<!-- -------------------------------------- -->
	<h4><p>생년월일<br></h4></p>
	<input type="text" name="year"> <!-- 년도 입력창 -->
	
	<!-- -------------------------------------- -->
	<select name="month" id="month"> 
    	<option value="month">월</option> <!-- 월 입력창 -->
	    <option value="1M">1</option>
	    <option value="2M">2</option>
	    <option value="3M">3</option>
	    <option value="4M">4</option>
	    <option value="5M">5</option>
	    <option value="6M">6</option>
	    <option value="7M">7</option>
	    <option value="8M">8</option>
	    <option value="9M">9</option>
	    <option value="10M">10</option>
	    <option value="11M">11</option>
	    <option value="12M">12</option>
	</select>
	<!-- -------------------------------------- -->
	<input type="day" name="day"><br> <!-- 일(day) 입력창 -->
	
	<h4><p>성별<br></h4></p>
	<select name="gender" id="gender">
		<option value="gender">성별</option>
		<option value="male">남</option>
		<option value="female">여</option>
	</select><br>	
	<p><input type="submit" value="가입하기"></p>
	</form>

</body>
</html>