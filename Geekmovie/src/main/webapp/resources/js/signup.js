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
	
	//아이디 중복 체크 구문
	$.ajax({
		url: 'idCheck',
		type: 'post',
		data: { id: id_check },
		success: function(cnt) { //컨트롤러에서 넘어온 cnt값을 받는다 
			if (cnt == 1) { // cnt가 1일 경우 -> 이미 존재하는 아이디
				id.focus();
				flag = false;
				console.log(flag);
				return flag;
			}	
		
		}
	});
	
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
		error[0].innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
		error[0].style.display = "block";
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
		error[1].innerHTML = "필수 정보입니다.";
		error[1].style.display = "block";
		//document.getElementById("passwordError").innerHTML = "필수 정보입니다.";
		password.focus();
		console.log("password : "+flag)
		return false;
	}
	// passwordCheck 값이 비어있으면 실행.
	if (passwordCheck.value == '') {
		//alert("비밀번호를 다시 입력해주세요.");
		//document.getElementById("passwordCheckError").innerHTML = "비밀번호를 다시 입력해주세요."
		error[2].innerHTML = "비밀번호를 다시 입력해주세요.";
		error[2].style.display = "block";
		passwordCheck.focus();
		return false;
	} else {
		document.getElementById("passwordCheckError").innerHTML = ""
	}
	if (password.value != passwordCheck.value) {
		error[2].innerHTML = "비밀번호가 동일하지 않습니다.";
		error[2].style.display = "block";
		passwordCheck.focus();
		return false;
	} else {
		document.getElementById("passwordCheckError").innerHTML = "비밀번호 동일"
	}

	// userpw값이 6자 이상 20자 이하를 벗어나면 실행.
	if (password.value.length < 6 || password.value.length > 20) {
		alert("비밀번호는 6자 이상 20자 이하로 입력해 주세요.");
		password.focus();
		return false;
	}

	// username값이 비어있으면 실행.
	if (name.value == '' || flag == false) {
		error[3].innerHTML = "이름을 입력해 주세요.";
		error[3].style.display = "block";
		name.focus();
		return false;
	}
	return true;
}




