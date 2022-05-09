// 가입부분 체크
const signUpCheck = () => {
	//Input들을 각각 변수에 대입
	const id = document.regiform.id;
	const password = document.regiform.password;
	const passwordCheck = document.regiform.passwordCheck;
	const name = document.regiform.name;
	const gender = document.regiform.gender;
	const yy = document.regiform.yy;
	const mm = document.regiform.mm;
	const dd = document.regiform.dd;
	
	// 구문 값 가져오기
	var yearPattern = /[0-9]{4}/;
	var datePattern = /\d{1,2}/;
	

	// 생년월일 값 받아오기
	var yy_2 = $('#yy').val();
	var mm_2 = $('#mm').val();
	var dd_2 = $('#dd').val();
	
	// 생년월일 값 합치기
	birthday = yy_2 + "-" + mm_2 + "-" + dd_2;
	$('#birthday').val(birthday);

	// 에러문구 보여주는 구문
	var id_check = $('#id').val();
	var flag = true;
	var error = document.querySelectorAll('.error_next_box');
	
	//아이디 중복 체크 구문
	$.ajax({
		url: 'idCheck',
		type: 'post',
		async: false,
		data: { id: id_check },
		success: function(cnt) { //컨트롤러에서 넘어온 cnt값을 받는다 
			if (cnt == 1) { // cnt가 1일 경우 -> 이미 존재하는 아이디
				id.focus();
				flag = false;
				console.log("ajax : " + flag);
			}
			return flag;

		}
	});
	
	//id 값이 비어 있으면 실행.
	if (id.value == '') {
		error[0].innerHTML = "필수 정보입니다.";
		error[0].style.display = "block";
		//alert('아이디를 입력해주세요');
		document.getElementById("idError").innerHTML = "필수 정보입니다.";
		id.focus();
		console.log("id 부분 : " + flag);
		flag = false;
		return flag;
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
		flag = false;
		return flag;
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
		console.log(birthday);
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
	if (name.value === "") {
		error[3].innerHTML = "이름을 입력해 주세요.";
		error[3].style.display = "block";
		name.focus();
		flag = false;
		return flag;
	}
	// 생년월일 확인 구문
	
	// 년도 확인 구문
	if (!yearPattern.test(yy.value)) {
		error[4].innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
		error[4].style.display = "block";
		yy.focus();
		flag = false;
		return flag;
	}
	
	// 월 확인 구문
	if (mm.value == "월") {
		error[4].innerHTML = "태어난 월을 선택하세요.";
		error[4].style.display = "block";
		mm.focus();
		flag = false;
		return flag;
	}
	
	// 일 확인 구문
	if (dd.value === "") {
		error[4].innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
		error[4].style.display = "block";
		dd.focus();
		flag = false;
		return flag;
	}
	
	// 생년월일 추가 옵션 구문
	if (!datePattern.test(dd.value) || Number(dd.value) < 1 || Number(dd.value) > 31) {
		error[4].innerHTML = "생년월일을 다시 확인해주세요.";
		dd.focus();
		flag = false;
		return flag;
	}
	
	// 생년월일 추가 옵션 구문
	if (yy.value < 1920) {
		error[4].innerHTML = "정말이세요?";
		yy.focus();
		flag = false;
		return flag;
	} else if (yy.value > 2019) {
		error[4].innerHTML = "미래에서 오셨군요. ^^";
		yy.focus();
		flag = false;
		return flag
	} else if (yy.value > 2005) {
		error[4].innerHTML = "만 14세 미만의 어린이는 보호자 동의가 필요합니다.";
		yy.focus();
		flag = false;
		return flag
	} else {
		error[4].style.display = "none";
	}
	
	// 중복된 아이디가 있으면
	if (flag == false) {
		error[0].innerHTML = "이미 사용 중인 아이디 입니다.";
		error[0].style.display = "block"
		id.focus();
		flag = false;
		return flag;
	}
	
	
	return flag;

}


