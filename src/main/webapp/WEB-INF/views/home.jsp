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
    <link rel="stylesheet" href="<c:url value='/resources/css/default.css'/>">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
    <link rel="stylesheet" href="<c:url value='/resources/css/ADimg.css'/>">
    <script src="<c:url value='/resources/js/home.js'/>"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/titleslide.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/home.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/listtitle.css'/>"/>
    
    
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
	                        <button class="mainLayoutButton2">${loginNick}님</button>
	                    </a>
	                </div>
					</c:when>
					<c:otherwise>
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
                   	<a href='#'><span class="css-nih33d-labelStyle" style="padding-left: 7px;">홈</span></a>
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
              		<span class="buttonLine"></span>
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
                <div class="col-lg-1 col-3 navi2"><a href="#" style="color : #1F8CE6;">일반</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myWriteBook">글쓰기</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/introduce">소개</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myPage">My</a></div>
            </div>
        </div>
    </div>
	
	<!-- 메인 부분 -->
	
	<!-- 첫번째 슬라이드 -->
	<div class="swiper-container" id="ckpoint">
	    <div class="swiper-wrapper">
	      <div class="swiper-slide"><img class="cardImg" src="<c:url value='/resources/css/img/SlideAD/AD1.png'/>"></div>
	      <div class="swiper-slide"><img class="cardImg" src="<c:url value='/resources/css/img/SlideAD/AD2.png'/>"></div>
	      <div class="swiper-slide"><img class="cardImg" src="<c:url value='/resources/css/img/SlideAD/AD3.png'/>"></div>
	      <div class="swiper-slide"><img class="cardImg" src="<c:url value='/resources/css/img/SlideAD/AD4.png'/>"></div>
	    </div>
	    <!-- Add Pagination -->
	    
	    <!-- Add Arrows -->
	    <div class="swiper-button-next"></div>
	    <div class="swiper-button-prev"></div>
 	</div>
 	
    <div class="container-xl container-fluid">
    	<div class="row">
    		<div class="col-12">
    			<div id="subtitle">Music&Novel! DynaBook</div>
    		</div>
    	</div>
    </div>
	
	<!-- 두번째 슬라이드 -->
	<div id="slide2back">
		<div class="category">
			<div id="categoryText1">다이나북, 추천리스트</div>
		</div>
		<div class="your-class">
	        <div>
	        	<a href="/books?booknumber=60">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/60.jpg'/>">
	        	</a>
	        	<div class="booktextType1"><p>최고의 전략가</p><p>'100 vs 300결과는?'</p></div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=61">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/61.jpg'/>">
	        	</a>
	        	<div class="booktextType1">로맨스릴러<br/>'소심남 + 소심녀'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=62">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/62.jpg'/>">
	        	</a>
	        	<div class="booktextType1">이젠 도련님이라 불러<br/>'빙의 9년차 + 집착'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=63">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/63.jpg'/>">
	        	</a>
	        	<div class="booktextType1">황녀가 돼야겠다<br/>'어도남 + 능력녀'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=64">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/64.jpg'/>">
	        	</a>
	        	<div class="booktextType1">나를 망가뜨린 남자<br/>'삼각관계 + 복수'</div>
	        </div>
	         <div>
	        	<a href="/books?booknumber=60">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/60.jpg'/>">
	        	</a>
	        	<div class="booktextType1"><p>최고의 전략가</p><p>'100 vs 300결과는?'</p></div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=61">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/61.jpg'/>">
	        	</a>
	        	<div class="booktextType1">로맨스릴러<br/>'소심남 + 소심녀'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=62">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/62.jpg'/>">
	        	</a>
	        	<div class="booktextType1">이젠 도련님이라 불러<br/>'빙의 9년차 + 집착'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=63">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/63.jpg'/>">
	        	</a>
	        	<div class="booktextType1">황녀가 돼야겠다<br/>'어도남 + 능력녀'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=64">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/64.jpg'/>">
	        	</a>
	        	<div class="booktextType1">나를 망가뜨린 남자<br/>'삼각관계 + 복수'</div>
	        </div>
	    </div>
	</div>
	
	<!-- 북 리스트 타입 -->
	 <div class="container-xl container-fluid ListContainer">
    	<div class="row" id="listTitleRow">
    		<div class="col-12" id="listCategory">베스트 셀러</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=69">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/69.jpg'/>">
    			</a>
    			<div class="listTitleText">내가 널 사랑할 때</div>
    			<div class="listWriterText">류향</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=37">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/37.jpg'/>">
    			</a>
    			<div class="listTitleText">낙원의 이론</div>
    			<div class="listWriterText">정선우</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=70">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/70.jpg'/>">
    			</a>
    			<div class="listTitleText">너와의 계절</div>
    			<div class="listWriterText">향기바람이</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=71">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/71.jpg'/>">
    			</a>
    			<div class="listTitleText">그랑 주떼</div>
    			<div class="listWriterText">희우</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=72">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/72.jpg'/>">
    			</a>
    			<div class="listTitleText">세 번째 소원</div>
    			<div class="listWriterText">미친</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=73">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/73.jpg'/>">
    			</a>
    			<div class="listTitleText">너는 어디에</div>
    			<div class="listWriterText">이조히</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=74">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/74.jpg'/>">
    			</a>
    			<div class="listTitleText">도피처</div>
    			<div class="listWriterText">윤여빈</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=75">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/75.jpg'/>">
    			</a>
    			<div class="listTitleText">부도덕한 훈육</div>
    			<div class="listWriterText">지렁띠</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol" id="LastListTitle">
    			<a href="/books?booknumber=76">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/76.jpg'/>">
    			</a>
    			<div class="listTitleText">시들지 않아</div>
    			<div class="listWriterText">나나리</div>
    		</div>
    	</div>
    </div>
	
	
	<!-- 세번째 슬라이드 -->
	<div id="slide3back">
		<div class="category">
			<div id="categoryText2">로맨스 추천리스트</div>
		</div>
		<div class="your-class">
	        <div>
	        	<a href="/books?booknumber=21">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/21.jpg'/>">
	        	</a>
	        	<div class="booktextType2">술이 문제야 문제<br/>'삼각관계 + 엉뚱녀'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=65">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/65.jpg'/>">
	        	</a>
	        	<div class="booktextType2">역하렘 아카데미<br/>'원작소설 + 환생'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=66">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/66.jpg'/>">
	        	</a>
	        	<div class="booktextType2">당신은 내 아내야<br/>'은서정 + 절륜남'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=67">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/67.jpg'/>">
	        	</a>
	        	<div class="booktextType2">200% 포인트백<br/>'순정남 + 역하렘'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=68">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/68.jpg'/>">
	        	</a>
	        	<div class="booktextType2">우리는 친구였다<br/>'짝사랑 + 계략남'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=21">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/21.jpg'/>">
	        	</a>
	        	<div class="booktextType2">술이 문제야 문제<br/>'삼각관계 + 엉뚱녀'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=65">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/65.jpg'/>">
	        	</a>
	        	<div class="booktextType2">역하렘 아카데미<br/>'원작소설 + 환생'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=66">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/66.jpg'/>">
	        	</a>
	        	<div class="booktextType2">당신은 내 아내야<br/>'은서정 + 절륜남'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=67">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/67.jpg'/>">
	        	</a>
	        	<div class="booktextType2">200% 포인트백<br/>'순정남 + 역하렘'</div>
	        </div>
	        <div>
	        	<a href="/books?booknumber=68">
	        		<img class="slidetitleimg" src="<c:url value='/resources/css/img/TitleImg/68.jpg'/>">
	        	</a>
	        	<div class="booktextType2">우리는 친구였다<br/>'짝사랑 + 계략남'</div>
	        </div>
	    </div>
	</div>
	
		<!-- 북 리스트 타입 -->
	 <div class="container-xl container-fluid ListContainer">
    	<div class="row" id="listTitleRow">
    		<div class="col-12" id="listCategory">베스트 셀러</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=69">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/69.jpg'/>">
    			</a>
    			<div class="listTitleText">내가 널 사랑할 때</div>
    			<div class="listWriterText">류향</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=37">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/37.jpg'/>">
    			</a>
    			<div class="listTitleText">낙원의 이론</div>
    			<div class="listWriterText">정선우</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=70">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/70.jpg'/>">
    			</a>
    			<div class="listTitleText">너와의 계절</div>
    			<div class="listWriterText">향기바람이</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=71">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/71.jpg'/>">
    			</a>
    			<div class="listTitleText">그랑 주떼</div>
    			<div class="listWriterText">희우</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=72">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/72.jpg'/>">
    			</a>
    			<div class="listTitleText">세 번째 소원</div>
    			<div class="listWriterText">미친</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=73">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/73.jpg'/>">
    			</a>
    			<div class="listTitleText">너는 어디에</div>
    			<div class="listWriterText">이조히</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=74">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/74.jpg'/>">
    			</a>
    			<div class="listTitleText">도피처</div>
    			<div class="listWriterText">윤여빈</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol">
    			<a href="/books?booknumber=75">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/75.jpg'/>">
    			</a>
    			<div class="listTitleText">부도덕한 훈육</div>
    			<div class="listWriterText">지렁띠</div>
    		</div>
    		<div class="col-lg-4 col-6 listTitlecol" id="LastListTitle">
    			<a href="/books?booknumber=76">
    				<img class="listTitleImg" src="<c:url value='/resources/css/img/TitleImg/76.jpg'/>">
    			</a>
    			<div class="listTitleText">시들지 않아</div>
    			<div class="listWriterText">나나리</div>
    		</div>
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
    
    
    <!-- 슬라이드 설정 JS -->
	<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <!-- 두번째 타입 슬라이드 사용자 설정 스크립트 -->
    <script src="<c:url value='/resources/js/SlideType02.js'/>"></script>
   	
</body>
</html>

