// 가입부분 체크
function signUpCheck(){
	console.log('signUpCheck 호출')
	
	let id = document.getElementById("id").value
	let password = document.getElementById("password").value
	let passwordCheck = document.getElementById("passwordCheck").value
	let name = document.getElementById("name").value
	let year = document.getElementById("year").value
	let month = document.getElementById("month").value
	let day = document.getElementById("day").value
	let gender = document.getElementById("gender").value
	let check = true;
	
	console.log(id);
	console.log(password);	
	console.log(passwordCheck);
	console.log(name);
	console.log(year);
	console.log(month)
	console.log(day);
	console.log(gender);
	
	// id 확인
	if(id.includes('~')){
		//let id_false = ["~","!","@","#","$","%","^", "&" ,"*" ,"(" ,")","?","/","."];
		document.getElementById("idError").innerHTML="5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다."
		check =false
		console.log(check);
	}
}