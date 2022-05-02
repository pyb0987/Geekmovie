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
	} else {
		document.getElementById("passwordCheckError").innerHTML = "비밀번호 동일"
	}

	// userpw값이 6자 이상 20자 이하를 벗어나면 실행.
	if (password.value.length < 6 || password.value.length > 20) {
		alert("비밀번호는 6자 이상 20자 이하로 입력해 주세요.");
		password.focus();
		flag = false;
		return flag;
	}

	// username값이 비어있으면 실행.
	if (name.value == '' ) {
		error[3].innerHTML = "이름을 입력해 주세요.";
		error[3].style.display = "block";
		name.focus();
		flag = false;
		return flag;
	}
	
	// 중복된 아이디가 있으면
	if(flag == false){
		error[0].innerHTML = "이미 사용 중인 아이디 입니다.";
		error[0].style.display = "block"
		id.focus();
		flag = false;
		return flag;
	}
	
	return flag;
}


