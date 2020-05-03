window.onload = function() {
    document.getElementById('inputName').onkeyup = function () {
        var msg = '',
        val = this.value;
        
        var check_kor = /^[가-힣]{2,4}|[a-zA-Z]{2,10}$/; // 한글, 영문 글자
        if (check_kor.test(val)) {
          msg = '<svg class="bi bi-check-circle" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M17.354 4.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3-3a.5.5 0 11.708-.708L10 11.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> <path fill-rule="evenodd" d="M10 4.5a5.5 5.5 0 105.5 5.5.5.5 0 011 0 6.5 6.5 0 11-3.25-5.63.5.5 0 11-.5.865A5.472 5.472 0 0010 4.5z" clip-rule="evenodd"></path> </svg>올바른 입력입니다.'
          document.getElementById('nameMsg').setAttribute("class","success");
        } else {
          msg = '<svg class="bi bi-check" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M15.854 5.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L8.5 12.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> </svg> 한글 또는 영문으로 입력'
          document.getElementById('nameMsg').setAttribute("class","warning");

        };
        document.getElementById('nameMsg').innerHTML = msg;
      };
      document.getElementById('inputEmail').onkeyup = function () {
        var msg = '',
          val = this.value;
        var check_email = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
        if (check_email.test(val)) {
          msg = '<svg class="bi bi-check-circle" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M17.354 4.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3-3a.5.5 0 11.708-.708L10 11.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> <path fill-rule="evenodd" d="M10 4.5a5.5 5.5 0 105.5 5.5.5.5 0 011 0 6.5 6.5 0 11-3.25-5.63.5.5 0 11-.5.865A5.472 5.472 0 0010 4.5z" clip-rule="evenodd"></path> </svg>올바른 입력입니다.'
          document.getElementById('emailMsg').setAttribute("class","success");
        } else {
          msg = '<svg class="bi bi-check" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M15.854 5.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L8.5 12.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> </svg> 올바른 형식이 아닙니다.'
          document.getElementById('emailMsg').setAttribute("class","warning");
        };
        document.getElementById('emailMsg').innerHTML = msg;
      };
      document.getElementById('inputNickName').onkeyup = function () {
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

      document.getElementById('inputPassword').onkeyup = function () {
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

      document.getElementById('inputPassword2').onkeyup = function () {
        var msg = '',
          val = this.value;
        var check_pw1 = $("#inputPassword").val();
        var check_pw2 = $("#inputPassword2").val();
        if (check_pw1 != "" || check_pw2 != "") {
          if (check_pw1 == check_pw2) {
            msg = '<svg class="bi bi-check-circle" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M17.354 4.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3-3a.5.5 0 11.708-.708L10 11.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> <path fill-rule="evenodd" d="M10 4.5a5.5 5.5 0 105.5 5.5.5.5 0 011 0 6.5 6.5 0 11-3.25-5.63.5.5 0 11-.5.865A5.472 5.472 0 0010 4.5z" clip-rule="evenodd"></path> </svg>올바른 입력입니다.'
            document.getElementById('pwMsg2').setAttribute("class","success");
          } else {
            msg = '<svg class="bi bi-check" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" d="M15.854 5.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L8.5 12.293l6.646-6.647a.5.5 0 01.708 0z" clip-rule="evenodd"></path> </svg> 비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.'
          document.getElementById('pwMsg2').setAttribute("class","warning");
          }
        }
        document.getElementById('pwMsg2').innerHTML = msg;
      };
};

function mysubmit() {
    let Join = document.forms['Join'];
    let check_kor = /^[가-힣]{2,4}|[a-zA-Z]{2,10}$/; // 한글, 영문자검사 (대충검사됨 더 걸러야댐)
    let check_email = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; //이메일 검사
    let check_sc = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/; //특문 검사
    let check_pw = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}/; // 비밀번호
    if (!check_kor.test(Join['name'].value)) {
      alert('이름을 재대로 입력하세요.');
      return false;
    } else if (!check_email.test(Join['email'].value)) {
      alert('이메일 주소를 다시 확인해주세요.');
      return false;
    } else if (check_sc.test(Join['nick'].value)) {
      alert('닉네임을 재대로 입력하세요.');
      return false;
    } else if (!check_pw.test(Join['pw'].value)) {
      alert('비밀번호를 재대로 입력하세요.');
      return false;
    } else if (Join['pw'].value != "" || Join['pw2'].value != "") {
      if (Join['pw'].value == Join['pw2'].value) {
          
      } else {
        alert('비밀번호가 일치하지 않습니다.');
        return false;
      }
    }
    return true;
  };