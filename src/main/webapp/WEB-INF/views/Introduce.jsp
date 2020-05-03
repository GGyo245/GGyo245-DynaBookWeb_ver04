<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>DynaBook</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcur icon" href="<c:url value='/resources/css/img/icon/favicon.ico'/>" type="image/x-icon">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
     integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<!-- 사용자 설정 -->
    <script src="<c:url value='/resources/js/default.js'/>"></script>
    <script src="<c:url value='/resources/js/myWrite.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='/resources/css/default.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/myPage.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/Introduce.css'/>">
</head>
<body style="overflow-x:hidden">
    <div class="container-fluid" id="mainlayout">
        <div class="container-xl container-fluid">
            <div class="row" id="mainrow">
                <div class="col-lg-1 col-0 blank"></div>
                <div class="col-lg-2 col-3" id="logo"><a href="/"><img id="homelogo" src="<c:url value='/resources/css/img/icon/logo.png'/>"></a></div>
                <div class="col-lg-5 col-6" id="serachMenu">
                    <div id="serach">
                        <svg class="bi bi-search" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                          <path fill-rule="evenodd" d="M12.442 12.442a1 1 0 011.415 0l3.85 3.85a1 1 0 01-1.414 1.415l-3.85-3.85a1 1 0 010-1.415z" clip-rule="evenodd"></path>
                          <path fill-rule="evenodd" d="M8.5 14a5.5 5.5 0 100-11 5.5 5.5 0 000 11zM15 8.5a6.5 6.5 0 11-13 0 6.5 6.5 0 0113 0z" clip-rule="evenodd"></path>
                        </svg>
                       <form autocomplete="off" action="/searh" onsubmit="return searchCK()">
                            <input id="serachForm" type="text" autocomplete="off" autocapitalize="off" aria-required="true" placeholder="제목, 저자 검색" name="title">
                            <input id="orderForm" type="hidden" name="order">
                        </form>
                    </div>
                </div>
                <c:choose>
					<c:when test="${sessionScope.loginId != null}">
						<div class="col-lg-3 col-6 ml-auto" id="userForm">
	                    <a href="/user/logout">
	                        <button class="mainLayoutButton">로그아웃</button>
	                    </a>
	                    <a href="/user/myPage">
	                        <button class="mainLayoutButton2">${sessionScope.loginNick}님</button>
	                    </a>
	                </div>
					</c:when>
					<c:otherwise>
						<script>
							alert('잘못된 요청')
							location.href="/loginpage";
						</script>
						<div class="col-lg-3 col-6 ml-auto" id="userForm">
		                    <a href="/joinpage">
		                        <button class="mainLayoutButton">회원가입</button>
		                    </a>
		                    <a href="/loginpage">
		                        <button class="mainLayoutButton2">로그인</button>
		                    </a>
	               		</div>
					</c:otherwise>
				</c:choose>
                <div class="col-lg-1 col-0 blank"></div>
            </div>
            <div class="row" id="secondRow">
                <div class="col-lg-1 col-0 blank"></div>
                <div class="col-lg-1 col-3 navi1">
                   	<a href='/'><span class="css-nih33d-labelStyle" style="padding-left: 7px;">홈</span></a>
               </div>
               <div class="col-lg-1 col-3 navi1">
                   <a href="/popular"><span class="css-nih33d-labelStyle">인기</span></a>
               </div>
               <div class="col-lg-1 col-3 navi1">
                   <a href="/newBook"><span class="css-nih33d-labelStyle">신작</span></a>
               </div>
               <div class="col-lg-1 col-3 navi1">
                   <a href="/genre"><span class="css-nih33d-labelStyle">장르</span></a>
               </div>
               <div class="col-lg-6 col-0"></div>
               <div class="col-lg-1 col-0 blank"></div>
           </div>
           <div class="row">
           <div class="col-lg-1 col-0 blank"></div>
               <div class="col-lg-1 col-3 navi1">
               </div>
           </div>
       </div>
   </div>
   <!-- 파란색 부분 네비 끝 -->
	
	<!-- 하얀색 부분 네비 -->
    <div class="container-fluid" id="secondlayout">
        <div class="container-xl container-fluid">
            <div class="row" id="whiterow">
                <div class="col-lg-1 blank"></div>
                <div class="col-lg-1 col-3 navi2"><a href="/">일반</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myWriteBook">글쓰기</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="#" style="color : #1F8CE6;">소개</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myPage">My</a></div>
            </div>
        </div>
    </div>
	
	<!-- 메인 부분 -->
	
	<div class="container-xl container-fluid">
		 <!-- 왼쪽 사이드메뉴 -->
         <div class="row" id="sidenavi">
            <div id="mysidenav" class="sidenav">
				<p style="font-size:x-large; font-family:nexonbold;">DYNABOOK</p>
				<hr />
				<a href="/user/myPage">내 정보 변경</a>
				<a href="/user/mylist">마이 리스트</a>
				<a href="/user/myWriteBook">소설 쓰기</a>
				<a href="#" style="color:#1F8CE6;">DynaBook이란?</a>
				<a href="/">다이나북 홈으로</a>
			</div>
		<!-- /왼쪽 사이드메뉴 끝  -->
		<!-- 본문 내용 -->
			<div class="content">
				<div class="modifyTitle">
					DynaBook이란?
				</div>
				<div class="row" id="contentRow">
					<div>
						<img id="dynabookLogoImg" src="<c:url value='/resources/css/img/icon/logo4.png'/>">
					</div>
					<div id="introduceText" style="font-family: nanumgothic;">
						<p style="width: 80%; font-weight: 600;">
							DynaBook은 텍스트 분석 기술을 사용하는 국내 최초  소설 플랫폼입니다. 
							DynaBook은 유저들에게 더욱 즐겁게 소설을 읽을 수 있도록 소설 내 텍스트의 감정이나 키워드를 자동으로 분석하여 활용하고 있습니다. 
							지금 바로 DynaBook과 함께 이야기 속으로 빠져보세요.
						 </p>
						<br/>
						<p style="font-size: large;font-weight: 600;">Dynabook이 제공하는 혁신적인 기술</p>
						<br/>
						<p style="font-weight: 600;">1. 텍스트 감정분석을 이용한 배경음악 제공</p>
						<p style="font-weight: 600; padding-top: 2%;">감정 분석 예시 )</p>
						<img style="width: 80%; padding-top: 2%;" id="dynabookLogoImg" src="<c:url value='/resources/css/img/text/introduce01.JPG'/>">
						<img style="width: 80%;" id="dynabookLogoImg" src="<c:url value='/resources/css/img/text/introduce02.JPG'/>">
						<p style="font-weight: 600; width: 80%;"> 이와같이 텍스트를 분석하고 텍스트에 대한 감정을 분석하여 5개의 분야별로 점수를 산출하여 해당 글과 분위기에 맞는 음악을 골라 유저들에게 제공합니다.</p>
						<p style="font-weight: 600; padding-top: 5%">2. 텍스트 키워드 분석을 이용한 이미지 제공</p>
						<p style="font-weight: 600; padding-top: 2%;">키워드 분석 예시 )</p>
						<img style="padding-top: 2%;" id="dynabookLogoImg" src="<c:url value='/resources/css/img/text/introduce03.JPG'/>">
						<img style="vertical-align: top; margin-left: 5%; margin-top: 3%;" id="dynabookLogoImg" src="<c:url value='/resources/css/img/text/introduce04.JPG'/>">
						<p style="font-weight: 600; font-size: smaller;">※ 키워드 추출, 개체 분석</p>
						<p style="font-weight: 600; padding-top: 2%">이와 같은 키워드 특정기술로 해당 소설에 나오는 유효한 키워드를 골라 이미지로 제공하고 있습니다.</p>
					</div>
				</div>	
			</div>
		<!-- /본문 끝 -->	
         </div>
    </div>
		
	<!-- 메인 부분 종료 -->	
	
	<!-- 밑 부분 정보 시작 -->
	<div class="container-fluid" id="bottomlayout">
        <div class="container-xl container-fluid">
        	<div class="row" id="noticerow">
        		<div class="col-lg-1 col-0 blank"></div>
        		<div class="col-lg-3 col-12">
        			<div id="noticeInfo">고객센터</div>
        			<div id="noticeInfo2">공지사항</div>
        		</div>
        		<div class="col-lg-8 col-12" id="DynaBookAllInfo">
        			<div class="DynaBookInfo">DynaBook</div>
        			<div class="DynaBookInfo">콘텐츠 제공 문의</div>
        			<div class="DynaBookInfo">페이스북</div>
        			<div class="DynaBookInfo">회사소개</div>
        			<br/>
        			<div id="DynaInforow2">
	        			<div class="DynaBookInfo"><a>다이나캐시 충전</a></div>
	        			<div class="DynaBookInfo"><a>제휴 문의</a></div>
	        			<div class="DynaBookInfo"><a>인스타그램</a></div>
	        			<div class="DynaBookInfo"><a>오류신고</a></div>
        			</div>
        		</div>
        	</div>
        	<div class="row" id="addressrow">
        		<div class="col-lg-1 col-0 blank"></div>
        		<div class="col-lg-11" id="address">
        			<div class="address">광주광역시 광산구 무진대로 282 (우산동) 무역회관 7층</div>
        			<div class="address2">SWDO Master3기 4조</div>
  				</div>
  			</div>
        	<div class="row" id="bottomrow">
        		<div class="col-lg-1 col-0 blank"></div>
        		<div class="col-lg-11">
        			<div id="company">㈜DynaBook.</div>
        			<div class="companyInfo" id="companyInfo1"><a>이용 약관</a></div>
        			<div class="companyInfo"><a>개인 정보 처리 방침</a></div>
        			<div class="companyInfo"><a>청소년 보호 정책</a></div>
        			<div class="companyInfo"><a>사업자 정보 확인</a></div>
        		</div>
        	</div>
    	</div>
    </div>
</body>
</html>

