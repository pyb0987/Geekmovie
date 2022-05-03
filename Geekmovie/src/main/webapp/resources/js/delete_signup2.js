/*변수 선언*/
var id = document.querySelector('#id');
var pw1 = document.querySelector('#password');
var pw2 = document.querySelector('#passwordCheck');

/* error 불러오기*/
var error = document.querySelectorAll('.error_next_box');

// 핸들러에 각각의 요소 적용
pw1.addEventListener("change", checkPw);
pw2.addEventListener("change", comparePw);

// password check 부분
function checkPw() {
	var pwPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;
	if (pw1.value === "") {
		error[1].innerHTML = "필수 정보입니다.";
		error[1].style.display = "block";
	} else if (!pwPattern.test(pw1.value)) {
		error[1].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
		error[1].style.display = "block";
	} else {
		error[1].style.display = "none";
	}
}

// password 재확인 check 부분
function comparePw() {
	if (pw2.value === "") {
		error[2].innerHTML = "필수 정보입니다.";
		error[2].style.display = "block";
	}
	if (pw2.value === pw1.value) {
		error[2].style.display = "none";
	} else if (pw2.value !== pw1.value) {
		error[2].innerHTML = "비밀번호가 동일하지 않습니다.";
		error[2].style.display = "block";
	}
}
