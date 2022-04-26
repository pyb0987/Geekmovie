<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/csstest.css?ver=1">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
	<h1>회원가입</h1>
	<div id="header">
		<div id="wrapper">
		<form method="post" name="regiform" id="regist_form" class="form"
				onsubmit="return signUpCheck()">
			<!-- 아이디 입력 받는 구문 -->
			<div id="content">
				<div>
					<h3>
						<label for="id">아이디</label>
					</h3>
					<span class="box int_id"> <input type="text" id="id"
						class="int" maxlength="20">
					</span><span class="error_next_box"></span>
				</div>
				<!-- 비밀번호 입력 받는 구문 -->
				<div>
					<h3>
						<label for="password">비밀번호</label>
					</h3>
					<span class="box int_pass"> <input type="text" id="password"
						class="int" maxlength="20">
					</span> <span class="error_next_box"></span>
				</div>
				<!-- 비밀번호 재확인 받는 구문 -->
				<div>
					<h3>
						<label for="password">비밀번호 재확인</label>
					</h3>
					<span class="box int_pass_check"> <input type="text" id="password_check"
						class="int" maxlength="20">
					</span> <span class="error_next_box"></span>
				</div>
				
				<div>
				<!-- 생년월일 입력 받는 구문 -->
				<h3>
					<label for="yy">생년월일</label>
				</h3>
				<div id="bir_wrap">
					<!-- 년도 입력구문 -->
					<div id="bir_yy">
						<span class="box"> <input type="text" id="yy" class="int"
							maxlength="4" placeholder="년(4자)">
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
				<span class="error_next_box"></span>
			</div>
			<!-- 가입하기 버튼-->
			<div class="btn_area">
				<input type="submit" id="btnJoin" value="가입하기"/>
			</div>
		</div>
		</form>	
		</div>
	</div>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/signup2.js?ver=1"></script>
</html>