


// 방법 1

// 	window.onload = function(){
// 		var name = document.getElementById("name");
// 		var id = document.getElementById("id");
// 		var pw = document.getElementById("pw");
// 		var email = document.getElementById("email");
// 		var division = document.getElementsByName("division");
// 		var idNo = document.getElementById("idNo");
// 		var address = document.getElementById("address");
// 		if(${checkedId} == 0){
// 			alert("이미 존재하는 아이디 입니다.");
// 			name.value='${member.username}';
// 			id.value='${member.id}';
// // 			pw.value='${member.pw}';
// 			email.value='${member.email}';
// 			if("${member.division}"=="개인"){
// 				division[0].checked= true;
// 			}else{
// 				division[1].checked = true;
// 			}
// 			idNo.value='${member.idNo}';
// 			address.value='${member.address}';
// 		}else if(${checkedId} == 1){
// 			alert("가입 가능한 아이디 입니다.");
// 			name.value='${member.username}';
// 			id.value='${member.id}';
// // 			pw.value='${member.pw}';
// 			email.value='${member.email}';
// 			if("${member.division}"=="개인"){
// 				division[0].checked = true;
// 			}else{
// 				division[1].checked = true;
// 			}
// 			idNo.value='${member.idNo}';
// 			address.value='${member.address}';
// 			document.getElementById("signup").onclick=function send(){
// 				var form = document.getElementById("form");
// 				var name = document.getElementById("name").value;
// 				var id = document.getElementById("id").value;
// 				var pw = document.getElementById("pw").value;
// 				var checkPw = document.getElementById("checkPw").value;
// 				var email = document.getElementById("email").value;
// 				var idNo = document.getElementById("idNo").value;
// 				var address = document.getElementById("address").value;

// 				if(name.trim().length==0||
// 						id.trim().length==0||
// 						pw.trim().length==0||
// 						checkPw.trim().length==0||
// 						email.trim().length==0||
// 						idNo.trim().length==0||
// 						address.trim().length==0){
// 					alert("정보를 입력해주세요");
// 				}else if(pw!=checkPw){
// 					alert("패스워드가 맞지 않습니다.")
// 				}else{
// 					form.submit();
// 				}
// 			}
// 		}
// 	}

	function idCheck(){
		var id = document.getElementById("id").value;
		if(id.trim().length==0){
			alert("아이디를 입력하세요");
		}else{
		var win = window.open("idCheck","win","width=280, height=180, left=650, top=300");
		}
	}
	
	//방법 2//
	function notice(){
		var onoff = document.getElementById("onoff").value;
		if(onoff!=1){
		alert("아이디 중복체크를 해주세요");
		}else{
			var form = document.getElementById("form");
				var name = document.getElementById("name").value;
				var id = document.getElementById("id").value;
				var pw = document.getElementById("pw").value;
				var checkPw = document.getElementById("checkPw").value;
				var email = document.getElementById("email").value;
				var idNo = document.getElementById("idNo").value;
				var address = document.getElementById("address").value;

				if(name.trim().length==0||
						id.trim().length==0||
						pw.trim().length==0||
						checkPw.trim().length==0||
						email.trim().length==0||
						idNo.trim().length==0||
						address.trim().length==0){
					alert("정보를 입력해주세요");
				}else if(pw!=checkPw){
					alert("패스워드가 맞지 않습니다.")
				}else{
					form.submit();
			}
		}
	}

// 	function check(){
// 		var form = document.getElementById("form");
// 		var id = document.getElementById("id").value;

// 		if(id.trim().length==0){
// 			alert("아이디를 입력하세요");
// 		}else{
// 			form.action="check";
// 			form.method="post";
// 			form.submit();
// 		}
// 	}