// 가입부분 체크
const login_signUpCheck = () => {
	//Input들을 각각 변수에 대입
	const id = document.regiform.id;
	const password = document.regiform.password;
	
	var error = document.querySelectorAll('.error_next_box');
	
	//id 값이 비어 있으면 실행.
	if (id.value == '') {
		error[0].innerHTML = "필수 정보입니다.";
		error[0].style.display = "block";
		//alert('아이디를 입력해주세요');
		document.getElementById("idError").innerHTML = "필수 정보입니다.";
		id.focus();
		//console.log("id 부분 : "+flag);
		return false;
	}
	// password 값이 비어있으면 실행.
	if (password.value == '') {
		error[1].innerHTML = "필수 정보입니다.";
		error[1].style.display = "block";
		//document.getElementById("passwordError").innerHTML = "필수 정보입니다.";
		password.focus();
		return false;
	}
	return true;
}




