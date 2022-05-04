<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	String id = (String)session.getAttribute("id");
	if(id == null) id= "product";
	String password = (String)session.getAttribute("password");
	String name =(String)session.getAttribute("name");
	String birthday = (String)session.getAttribute("birthday");
	String gender =(String)session.getAttribute("gender");
	System.out.println(id);
	System.out.println(birthday);
%>

<%if(id=="product"){%>
	<script>
		alert('비정상 접근입니다. 로그인 후 이용 바랍니다.');
		document.location.href="/movie";
	</script>
<%}%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My page Test</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage_style.css?ver=2">
</head>
</head>
<body>
	<div id="regist_wrap" class="wrap">
      <div>
         <h1>마이페이지</h1>
         <!-- form method : post 방식 -->
         <form method="post" name="regiform" id="regist_form" class="form">
		 <table>
		 	<tr>
		 		<td width="200px"><label id="must_id"> * </label> <label id="text_id">아이디 :</label></td>
		 		<td width="250px"><input type="hidden" name="id" value="id"><label id="text_id"><%=id%></label><br></td>
		 	</tr>
		 	<tr>
		 		<td width="200px"><label id="must_password"> * </label><label id="text_id">비밀번호 :</label></td>
		 		<td width="250px"><input type="hidden" name="password" value="password"><label id="text_id"><%=password%></label></td>
		 	</tr>
		 	<tr>
		 		<td width="200px"><label id="must_name"> * </label><label id="text_id"> 이름 :</label></td>
		 		<td width="250px"><input type="hidden" name="name" value="name"><label id="text_id"><%=name%></label></td>
		 	</tr>
		 	<tr>
		 		<td width="200px"><label id="must_birthday"> * </label><label id="text_id"> 생년월일 :</label></td>
		 		<td width="250px"><input type="hidden" name="birthday" value="birthday"><label id="text_id"><%=birthday%></label></td>
		 	</tr>
		 	<tr>
		 		<td width="200px"><label id="must_gender"> * </label><label id="text_id"> 성별 : </label></td>
		 		<td width="250px"><input type="hidden" name="gender" value="gender"><label id="text_id"><%=gender%></label></td>
		 	</tr>
		 </table>
		</form>
			<div class="hr">
				<hr>
			</div>
		 	<p>
			<input type="button" value = "회원정보 수정" class="signup_btn1" onclick="location.href='user_update_mypage'">
			</p>
			<p>
			<input type="submit" value="회원 탈퇴" class="signup_btn2" onclick="location.href='user_delete_mypage'">
			</p>
		</div>
	</div>
</body>
</html>