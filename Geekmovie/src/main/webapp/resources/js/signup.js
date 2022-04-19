// 가입부분 체크
function signUpCheck() {
	//console.log('signUpCheck 호출')

	let id = document.getElementById("id").value
	let password = document.getElementById("password").value
	let passwordCheck = document.getElementById("passwordCheck").value
	let name = document.getElementById("name").value
	let year = document.getElementById("year").value
	let month = document.getElementById("month").value
	let day = document.getElementById("day").value
	let gender = document.getElementById("gender").value
	let birthday
	let check = true;

	console.log(id);
	//console.log(password);
	//console.log(passwordCheck);
	//console.log(name);
	//console.log(year);
	//console.log(month)
	//console.log(day);
	//console.log(gender);


	// id 확인
	if (id === "") {
		document.getElementById("idError").innerHTML = "아이디 입력은 필수 입니다."
		document.getElementById("id").focus();
		check = false
	}
	else if (id.includes('~') || id.includes("!") ||
		id.includes('@') || id.includes("#") ||
		id.includes('$') || id.includes("%") ||
		id.includes('^') || id.includes("&") ||
		id.includes('*') || id.includes("(") ||
		id.includes(')') || id.includes(",") ||
		id.includes('?') || id.includes("/") ||
		id.includes('<') || id.includes(">") ||
		id.includes('.') || id.includes(":") ||
		id.includes('-') || id.includes("+") ||
		id.includes('~') || id.includes(" ")) {
		//let id_false = ["~","!","@","#","$","%","^", "&" ,"*" ,"(" ,")","?","/","."];
		document.getElementById("idError").innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다."
		check = false
	}else{
		// id가 옳게 입력 되었을때
		document.getElementById("idError").innerHTML = "멋진 아이디네요!"
		check = true
	}
	
	// password 확인
	if (password !== passwordCheck) {
		document.getElementById("passwordError").innerHTML = ""
		document.getElementById("passwordCheckError").innerHTML = "비밀번호가 동일하지 않습니다."
		check = false
	} else {
		document.getElementById("passwordError").innerHTML = ""
		document.getElementById("passwordCheckError").innerHTML = ""
	}
	if (password === "") {
		document.getElementById("passwordError").innerHTML = "비밀번호를 입력해주세요"
		document.getElementById("password").focus();
		check = false
	} else {
		//
	}
	if (passwordCheck === "") {
		document.getElementById("passwordCheckError").innerHTML = "비밀번호를 다시 입력해주세요."
		document.getElementById("passwordCheck").focus();
		check = false
	} else {
		//
	}

	// 이름확인
	if (name === "") {
		document.getElementById("nameError").innerHTML = "이름이 올바르지 않습니다."
		document.getElementById("name").focus();
		check = false
	} else {
		document.getElementById("nameError").innerHTML = ""
		check = true
	}

	// 생년월일
	if(isNaN(year) || year ===""){
		document.getElementById("yearError").innerHTML = "태어난 년도 4자리를 정확하게 입력하세요."
		check = false
	}else{
		document.getElementById("yearError").innerHTML = ""
		check = true
	}
	if(isNaN(day) || day===""){
		document.getElementById("dayError").innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요."
		check = false
	}else{
		document.getElementById("dayError").innerHTML = ""
		check = true
	}
	
	if(check){
	//비동기 처리이벤트
    setTimeout(function() {
	birthday = year+"-"+month+"-"+day
	console.log(birthday)
    alert("가입이 완료되었습니다.")
	},0);
	let test = document.getElementById('user_form').submit()
	console.log(test)
}
  
	
	





























}