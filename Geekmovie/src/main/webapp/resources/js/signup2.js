/*변수 선언*/
var id = document.querySelector('#id');
var pw1 = document.querySelector('#password');
var pw2 = document.querySelector('#passwordCheck');
var userName = document.querySelector('#name');
var yy = document.querySelector('#yy');
var mm = document.querySelector('#mm');
var dd = document.querySelector('#dd');

/* error 불러오기*/
var error = document.querySelectorAll('.error_next_box');

// 핸들러에 각각의 요소 적용
id.addEventListener("change", checkId);
pw1.addEventListener("change", checkPw);
pw2.addEventListener("change", comparePw);
userName.addEventListener("change", checkName);
yy.addEventListener("change", isBirthCompleted);
mm.addEventListener("change", isMonthSelected);
dd.addEventListener("change", isDateCompleted);


//아이디 중복 체크 구문
function checkIdtest() {
	var id = $('#id').val();	
	$.ajax({
		url: 'idCheck',
		type: 'post',
		data: { id: id },
		success: function(cnt) { //컨트롤러에서 넘어온 cnt값을 받는다 
			if (cnt != 1) { //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
				error[0].innerHTML = "멋진 아이디네요!";
				error[0].style.color = "#08A600";
				error[0].style.display = "block";
				
				
			} else { // cnt가 1일 경우 -> 이미 존재하는 아이디
				error[0].innerHTML = "이미 사용중이거나 탈퇴한 아이디입니다.";
				error[0].style.color = "#ff0000";
				error[0].style.display = "block";
				
			}
		},
		error: function() {
			alert("에러입니다");
		}
	});
};


// id check 부분
function checkId() {
	var idPattern = /[a-zA-Z0-9_-]{5,20}/;
	if (id.value === "") {
		error[0].innerHTML = "필수 정보입니다.";
		error[0].style.color = "#FF0000";
		error[0].style.display = "block";
	} else if (!idPattern.test(id.value)) {
		error[0].innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
		error[0].style.display = "block";
	} 
}


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

// name check 부분
function checkName() {
	var namePattern = /[a-zA-Z가-힣]/;
	if (userName.value === "") {
		error[3].innerHTML = "필수 정보입니다.";
		error[3].style.display = "block";
	} else if (!namePattern.test(userName.value) || userName.value.indexOf(" ") > -1) {
		error[3].innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
		error[3].style.display = "block";
	} else {
		error[3].style.display = "none";
	}
}

//년도 체크 부분
function isBirthCompleted() {
	var yearPattern = /[0-9]{4}/;

	if (!yearPattern.test(yy.value)) {
		error[4].innerHTML = "태어난 년도 4자리를 정확하게 입력하세요.";
		error[4].style.display = "block";
	} else {
		isMonthSelected();
	}
}

//월 체크 부분
function isMonthSelected() {
	if (mm.value === "월") {
		error[4].innerHTML = "태어난 월을 선택하세요.";
		error[4].style.display = "block";
	} else {
		isDateCompleted();
	}
}

// 일 체크 부분
function isDateCompleted() {
	if (dd.value === "") {
		error[4].innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
		error[4].style.display = "block";
	} else {
		isBirthRight();
	}
}

// 생년 월일 확인 부분
function isBirthRight() {
	var datePattern = /\d{1,2}/;
	if (!datePattern.test(dd.value) || Number(dd.value) < 1 || Number(dd.value) > 31) {
		error[4].innerHTML = "생년월일을 다시 확인해주세요.";
	} else {
		checkAge();
	}
}

// 생년 월일 추가 부분
function checkAge() {
	if (Number(yy.value) < 1920) {
		error[4].innerHTML = "정말이세요?";
		error[4].style.display = "block";
	} else if (Number(yy.value) > 2023) {
		error[4].innerHTML = "미래에서 오셨군요. ^^";
		error[4].style.display = "block";
	} else if (Number(yy.value) > 2008) {
		error[4].innerHTML = "만 14세 미만의 어린이는 보호자 동의가 필요합니다.";
		error[4].style.display = "block";
	} else {
		error[4].style.display = "none";
	}
}