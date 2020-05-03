/**
 * 
 */
window.onload = function(){
	document.getElementById('newNick').onkeyup = function () {
        var msg = '',
          val = this.value;
        var check_NickName1 = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/;
        var check_NickName2 =  /^[가-힣]{2,4}|[a-zA-Z]{2,10}$/;
        if (!check_NickName1.test(val) && check_NickName2.test(val)) {
          msg = '<svg class="bi bi-check-circle" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M17.354 4.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3-3a.5.5 0 11.708-.708L10 11.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> <path fill-rule="evenodd" d="M10 4.5a5.5 5.5 0 105.5 5.5.5.5 0 011 0 6.5 6.5 0 11-3.25-5.63.5.5 0 11-.5.865A5.472 5.472 0 0010 4.5z" clip-rule="evenodd"></path> </svg>올바른 입력입니다.'
          document.getElementById('idMsg').setAttribute("class","success");
        } else {
          msg = '<svg class="bi bi-check" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M15.854 5.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L8.5 12.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> </svg> 올바른 형식이 아닙니다.'
          document.getElementById('idMsg').setAttribute("class","warning");
        };
        document.getElementById('idMsg').innerHTML = msg;
      };
      
      document.getElementById('currentPw').onkeyup = function () {
          var msg = '',
            val = this.value;
          var check_pw = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}/;
          if (check_pw.test(val)) {
            msg = '<svg class="bi bi-check-circle" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M17.354 4.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3-3a.5.5 0 11.708-.708L10 11.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> <path fill-rule="evenodd" d="M10 4.5a5.5 5.5 0 105.5 5.5.5.5 0 011 0 6.5 6.5 0 11-3.25-5.63.5.5 0 11-.5.865A5.472 5.472 0 0010 4.5z" clip-rule="evenodd"></path> </svg>올바른 입력입니다.'
            document.getElementById('pwMsg').setAttribute("class","success");
          } else {
            msg = '<svg class="bi bi-check" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M15.854 5.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L8.5 12.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> </svg> 8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.'
            document.getElementById('pwMsg').setAttribute("class","warning");
          };
          document.getElementById('pwMsg').innerHTML = msg;
        };
        
        document.getElementById('modifyPw').onkeyup = function () {
            var msg = '',
              val = this.value;
            var check_pw1234 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}/;
            if (check_pw1234.test(val)) {
              msg = '<svg class="bi bi-check-circle" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M17.354 4.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3-3a.5.5 0 11.708-.708L10 11.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> <path fill-rule="evenodd" d="M10 4.5a5.5 5.5 0 105.5 5.5.5.5 0 011 0 6.5 6.5 0 11-3.25-5.63.5.5 0 11-.5.865A5.472 5.472 0 0010 4.5z" clip-rule="evenodd"></path> </svg>올바른 입력입니다.'
              document.getElementById('pwMsg2').setAttribute("class","success");
            } else {
              msg = '<svg class="bi bi-check" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M15.854 5.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L8.5 12.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> </svg> 8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.'
              document.getElementById('pwMsg2').setAttribute("class","warning");
            };
            document.getElementById('pwMsg2').innerHTML = msg;
          };
         
          document.getElementById('modifyPw2').onkeyup = function () {
              var msg = '',
                val = this.value;
              var check_pw1 = $("#modifyPw").val();
              var check_pw2 = $("#modifyPw2").val();
              if (check_pw1 != "" || check_pw2 != "") {
                if (check_pw1 == check_pw2) {
                  msg = '<svg class="bi bi-check-circle" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M17.354 4.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3-3a.5.5 0 11.708-.708L10 11.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> <path fill-rule="evenodd" d="M10 4.5a5.5 5.5 0 105.5 5.5.5.5 0 011 0 6.5 6.5 0 11-3.25-5.63.5.5 0 11-.5.865A5.472 5.472 0 0010 4.5z" clip-rule="evenodd"></path> </svg>올바른 입력입니다.'
                  document.getElementById('pwMsg3').setAttribute("class","success");
                } else {
                  msg = '<svg class="bi bi-check" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M15.854 5.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L8.5 12.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> </svg> 비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.'
                document.getElementById('pwMsg3').setAttribute("class","warning");
                }
              }
              document.getElementById('pwMsg3').innerHTML = msg;
            };
          
};

function NickCK(){
	let Join = document.forms['NickForm'];
	let check_sc = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/; //특문 검사
	let check_sc2 = /^[가-힣]{2,4}|[a-zA-Z]{2,10}$/; //숫자검사
	
	if (!(!check_sc.test(Join['newNick'].value) && check_sc2.test(Join['newNick'].value))) {
		alert('닉네임을 재대로 입력하세요.');
	     return false;
	}
	return true;
}

function passwordCK(){
	let Join = document.forms['PWForm'];
	let check_pw = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}/; // 비밀번호
	
	if (!check_pw.test(Join['currentPw'].value)) {
	      alert('비밀번호를 재대로 입력하세요.');
	      return false;
	}
	if (!check_pw.test(Join['modifyPw'].value)) {
	      alert('비밀번호를 재대로 입력하세요.');
	      return false;
	}
	if (Join['modifyPw'].value == Join['modifyPw2'].value) {
        
    } else {
      alert('비밀번호가 일치하지 않습니다.');
      return false;
    }
	return true;
}

function deleteCK(){
	if(confirm("정말 탈퇴하시겠습니까?")){
		return true;
	}else{
		return false;
	}
}
