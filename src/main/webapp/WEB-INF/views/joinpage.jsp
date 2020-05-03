<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>DynaBook-Join</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcur icon" href="<c:url value='/resources/css/img/icon/favicon.ico'/>" type="image/x-icon">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
     integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
     <link rel="stylesheet" href="<c:url value='/resources/css/joinpage.css'/>">
</head>
<body>
	<c:if test="${sessionScope.loginId != null}">
		<script>
			alert('잘못된 요청')
			location.href="/";
		</script>
	</c:if>
	<div class="container-fluid">
	<div class="row" id="titleLine">
  		<div class="col-lg-4 col-lg-0"></div>
  		<div class="col-lg-4 col-lg-12">
  			<div id="homelogo">Welcome back</div>
  		</div>
  		<div class="col-lg-4 col-0"></div>
  	</div>
    <div class="row">
      <div class="col-lg-4 col-0"></div>
      <div class="col-lg-4 col-12">
        <header class="header_logo">
          <div class="text-center">
            <a id="headLine" href="/"><img id="logo" src="<c:url value='/resources/css/img/icon/logo4.png'/>"></a>
          </div>
        </header>
        <form action="/join" name="Join" class="form-horizontal" method=POST
          onsubmit='return mysubmit()'>
          <div class="form group">
            <label for="inputName" class="sr-only">이름</label>
            <input name='name' type="text" id="inputName" class="form-control" placeholder="이름">
          </div><span id="nameMsg" class="warning"></span>

          <div class="form group">
            <label for="inputEmail" class="sr-only">이메일</label>
            <input name='email' type="email" id="inputEmail" class="form-control" placeholder="이메일">
          </div><span id="emailMsg" class="warning"></span>

          <div class="form group">
            <label for="inputNickName" class="sr-only">닉네임</label>
            <input name='nick' type="text" id="inputNickName" class="form-control" placeholder="닉네임">
          </div><span id="idMsg" class="warning"></span>

          <div class="form group">
            <label for="inputPassword" class="sr-only">비밀번호</label>
            <input name='pw' type="password" id="inputPassword" class="form-control" placeholder="비밀번호">
          </div><span id="pwMsg" class="warning"></span>

          <div class="form group">
            <label for="inputPassword" class="sr-only">비밀번호 확인</label>
            <input name='pw2' type="password" id="inputPassword2" class="form-control" placeholder="비밀번호 확인">
          </div><span id="pwMsg2" class="warning"></span>

          <div class="form group">
            <button id="submitbtn" class="btn btn-lg btn-primary btn-block" type="submit">회원 가입</button>
          </div>
        </form>
        <div class="text-right" id="tologin">
          <a href="/loginpage"><strong>로그인 창으로</strong></a>
        </div>
      </div>
      <div class="col-md-lg col-0"></div>
    </div>
  </div>

  <script src="<c:url value='/resources/js/joincheck.js'/>"></script>
</body>
</html>