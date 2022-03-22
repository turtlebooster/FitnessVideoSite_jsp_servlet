let joinId = document.getElementById("joinId");
joinId.addEventListener("keyup", () => {
	requestIdCheck(joinId.value);
})

function requestIdCheck(idVal) {
	let xhr = new XMLHttpRequest();
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				console.log('서블릿 결과 : ', xhr.responseText);
				
				let msg = "이미 사용중인 아이디입니다."
				if (xhr.responseText == 'success') {
					msg = "사용 가능한 아이디입니다."
					if (idVal === "") 	msg = "";					
				} 
				document.getElementById("idCheckMsg").innerText = msg;
			}
		}
	};
	xhr.open("GET", "main?action=idCheck&joinId=" + idVal);
	xhr.send();
}