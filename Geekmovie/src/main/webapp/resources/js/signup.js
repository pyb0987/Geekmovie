// 가입부분 체크
const signUpCheck = () => {
	//Input들을 각각 변수에 대입
	const id = document.regiform.id;
	const password = document.regiform.password;
	const passwordCheck = document.regiform.passwordCheck;
	const name = document.regiform.name;
	const gender = document.regiform.gender.value;
	
	var error = document.querySelectorAll('.error_next_box');
	
	//id 값이 비어 있으면 실행.
	if (id.value == '') {
		document.getElementById("idError").innerHTML = "필수 정보입니다.";
		id.focus();
		return false;
	}
	if (id.value.includes('~') || id.value.includes("!") ||
		id.value.includes('@') || id.value.includes("#") ||
		id.value.includes('$') || id.value.includes("%") ||
		id.value.includes('^') || id.value.includes("&") ||
		id.value.includes('*') || id.value.includes("(") ||
		id.value.includes(')') || id.value.includes(",") ||
		id.value.includes('?') || id.value.includes("/") ||
		id.value.includes('<') || id.value.includes(">") ||
		id.value.includes('.') || id.value.includes(":") ||
		id.value.includes('-') || id.value.includes("+") ||
		id.value.includes('~') || id.value.includes(" ")) {
		//let id_false = ["~","!","@","#","$","%","^", "&" ,"*" ,"(" ,")","?","/","."];
		//document.getElementById("idError").innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다."
		return false;
	}
	// id 값이 4자이상 12자 이하를 벗어나면 실행.
	/*
	if (id.value.length < 4 || id.value.length > 12) {
		alert("아이디는 4자 이상 12자 이하로 입력해주세요.");
		id.focus();
		return false;
	}
	*/
	// password 값이 비어있으면 실행.
	if (password.value == '') {
		alert('비밀번호를 입력해주세요');
		password.focus();
		return false;
	}
	// passwordCheck 값이 비어있으면 실행.
	if (passwordCheck.value == '') {
		//alert("비밀번호를 다시 입력해주세요.");
		document.getElementById("passwordCheckError").innerHTML = "비밀번호를 다시 입력해주세요."
		passwordCheck.focus();
		return false;
	} else {
		document.getElementById("passwordCheckError").innerHTML = ""
	}
	if (password.value != passwordCheck.value) {
		document.getElementById("passwordCheckError").innerHTML = "비밀번호가 동일하지 않습니다."
		passwordCheck.focus();
		return false;
	}else{
		document.getElementById("passwordCheckError").innerHTML = "비밀번호 동일"
	}

	// userpw값이 6자 이상 20자 이하를 벗어나면 실행.
	if (password.value.length < 6 || password.value.length > 20) {
		alert("비밀번호는 6자 이상 20자 이하로 입력해주세요.");
		password.focus();
		return false;
	}

	// username값이 비어있으면 실행.
	if (name.value == '') {
		document.getElementById("nameError").innerHTML = "이름이 올바르지 않습니다."
		name.focus();
		return false;
	}

	return true;
}




