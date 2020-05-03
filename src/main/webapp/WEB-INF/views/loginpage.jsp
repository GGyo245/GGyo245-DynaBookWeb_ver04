<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<title>DynaBook-Login</title>
	<link rel="shortcur icon" href="<c:url value='/resources/css/img/icon/favicon.ico'/>" type="image/x-icon">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
     integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
     <link rel="stylesheet" href="<c:url value='/resources/css/loginpage.css'/>">
     <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
     <script src="<c:url value='/resources/js/login.js'/>"></script>
</head>
<body>
<body>
	<c:if test="${sessionScope.loginId != null}">
		<script>
			alert('잘못된 요청')
			location.href="/";
		</script>
	</c:if>
  <div class="container-fluid">
  	<div class="row" id="titleLine">
  		<div class="col-xl-4 col-lg-2 col-1"></div>
  		<div class="col-xl-4 col-lg-8 col-10">
  			<div id="homelogo">Welcome back</div>
  		</div>
  		<div class="col-xl-4 col-lg-2 col-1"></div>
  	</div>
    <div class="row">
      <div class="col-xl-4 col-lg-2 col-1"></div>
      <div class="col-xl-4 col-lg-8 col-10" id="LoginForm">
        <header class="header_logo">
          <div class="text-center" id="logo">
          		<a href="/"><img id="logo" src="<c:url value='/resources/css/img/icon/logo4.png'/>"></a>
          </div>
        </header>
        <div>
          <div class="text-center">
          </div>

          <form action="/user/login" method="POST" class="form-signin action">
           	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			
            <label for="inputEmail" class="sr-only">이메일</label>
            <input name="email" type="email" id="inputEmail" class="form-control" placeholder="이메일" value="${rememberId}" required autofocus>
            <label for="inputPassword" class="sr-only">비밀번호</label>
            <input name="pw" type="password" id="inputPassword" class="form-control" placeholder="패스워드" required>
            <div class="checkbox">
              <label id="keepcheck" style="color: #1F8CE6;">
                <input type="checkbox" name="remember" value="check"> 아이디 기억하기
              </label>
            </div>
            <button id="submitbtn" class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
          	<div id="errMsg" style="color:red; margin-top: 1%;"><c:if test="${errMsg != null}">${errMsg}</c:if></div>
          	<c:if test="${not empty param.fail}">
				<div id="errMsg" style="color:red; margin-top: 1%;">${SPRING_SECURITY_LAST_EXCEPTION.message}</div>
			</c:if>
          </form>
        </div>
        <br>
        <div class="text-center">
          <a href="#" class="loginmenu" style="color: #1F8CE6;">아이디 찾기</a>｜
          <a href="#" class="loginmenu" style="color: #1F8CE6;">비밀번호 찾기</a>｜
          <a href="/joinpage" class="loginmenu" style="color: #1F8CE6;">회원가입</a>
        </div>
      </div>
      <div class="col-xl-4 col-lg-2 col-1"></div>
    </div>
  </div>
</body>
</html>