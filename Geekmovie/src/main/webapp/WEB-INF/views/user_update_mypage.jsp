<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% 
	String id = (String)session.getAttribute("id");
	String oldpassword = (String)session.getAttribute("password");
	String name =(String)session.getAttribute("name");
	String birthday = (String)session.getAttribute("birthday");
	String gender =(String)session.getAttribute("gender");
	System.out.println("기존 비밀번호 : "+oldpassword);
	System.out.println("기존 아이디 :"+id);
	System.out.println("기존 생년월일 :"+birthday);
	
	
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
<title>회원정보 수정 페이지</title>
<link rel="stylesheet"

   href="${pageContext.request.contextPath}/resources/css/createUserstyle.css?ver=1">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
   <div id="regist_wrap" class="wrap">
      <div>
         <h1>회원정보 수정</h1>
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
					<input type="text" name="password" id="password" placeholder="비밀번호"> 
					<span class="error_next_box" id="passwordError"></span>
				</div>

				<!-- passwordCheck 적용 -->
				<div>
					<input type="text" name="passwordCheck" id="passwordCheck" placeholder="비밀번호 재입력"> 
					<span class="error_next_box" id="passwordCheckError"></span>
				</div>

				<!-- name 적용 -->
				<div>
					<input type="text" name="name" id="name" placeholder="이름">
					<span class="error_next_box" id="nameError"></span>
				</div>
				<!-- 생년 월일 -->
				<div id="bir_wrap">
					<input type="hidden" id="birthday" name="birthday" value=""/>
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
					<input type="submit" value="회원정보 수정" class="signup_btn">
				</p>
			</form>
		</div>
	</div>
</body>
<!-- sumbit 누르지 않고 실시간 동작 : signup2.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/update_signup2.js?ver=1"></script>
<!-- sumbit 눌렀을때 동작 : signup.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/update_signup.js?ver=1"></script>

</html>