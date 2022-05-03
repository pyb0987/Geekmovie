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
		 		<td width="200px"><label id="must_id"> * </label> 아이디 : </td>
		 		<td width="250px"><input type="hidden" name="id" value="id"><%=id%><br></td>
		 	</tr>
		 	<tr>
		 		<td width="200px"><label id="must_password"> * </label> 비밀번호 : </td>
		 		<td width="250px"><input type="hidden" name="password" value="password"><%=password%></td>
		 	</tr>
		 	<tr>
		 		<td width="200px"><label id="must_name"> * </label> 이름 : </td>
		 		<td width="250px"><input type="hidden" name="name" value="name"><%=name%></td>
		 	</tr>
		 	<tr>
		 		<td width="200px"><label id="must_birthday"> * </label> 생년월일 : </td>
		 		<td width="250px"><input type="hidden" name="birthday" value="birthday"><%=birthday%></td>
		 	</tr>
		 	<tr>
		 		<td width="200px"><label id="must_gender"> * </label> 성별 : </td>
		 		<td width="250px"><input type="hidden" name="gender" value="gender"><%=gender%></td>
		 	</tr>
		 </table>
		 <hr>
		</form>
		 	<p>
			<input type="button" value = "회원정보 수정" class="signup_btn" onclick="location.href='user_update_mypage'">
			</p>
			<p>
			<input type="submit" value="회원 탈퇴" class="signup_btn" onclick="location.href='user_delete_mypage'">
			</p>
		</div>
	</div>
</body>
</html>