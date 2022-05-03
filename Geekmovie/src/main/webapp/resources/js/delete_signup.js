// 가입부분 체크
const signUpCheck = () => {
	//Input들을 각각 변수에 대입
	const id = document.regiform.id;
	const password = document.regiform.password;
	const passwordCheck = document.regiform.passwordCheck;
	const name = document.regiform.name;
	const gender = document.regiform.gender.value;
	
	var id_check = $('#id').val();
	var flag = true;
	var error = document.querySelectorAll('.error_next_box');
	
	// password 값이 비어있으면 실행.
	if (password.value == '') {
		error[1].innerHTML = "필수 정보입니다.";
		error[1].style.display = "block";
		//document.getElementById("passwordError").innerHTML = "필수 정보입니다.";
		password.focus();
		console.log("password : "+flag)
		flag = false;
		return flag;
	}
	// passwordCheck 값이 비어있으면 실행.
	if (passwordCheck.value == '') {
		//alert("비밀번호를 다시 입력해주세요.");
		//document.getElementById("passwordCheckError").innerHTML = "비밀번호를 다시 입력해주세요."
		error[2].innerHTML = "비밀번호를 다시 입력해주세요.";
		error[2].style.display = "block";
		passwordCheck.focus();
		flag = false;
		return flag;
	} else {
		document.getElementById("passwordCheckError").innerHTML = ""
	}
	if (password.value != passwordCheck.value) {
		error[2].innerHTML = "비밀번호가 동일하지 않습니다.";
		error[2].style.display = "block";
		passwordCheck.focus();
		flag = false;
		return flag;
	}
	return flag;
}


