<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>DynaBook</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcur icon" href="<c:url value='/resources/css/img/icon/favicon.ico'/>" type="image/x-icon">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
      integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value='/resources/css/default.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/books.css'/>">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="<c:url value='/resources/js/default.js'/>"></script>
    <script src="<c:url value='/resources/js/books.js'/>"></script>
</head>
<body>
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
                <div class="col-lg-1 col-3 navi1"></div>
                <div class="col-lg-1 col-3 navi1"></div>
            </div>
        </div>
    </div>
    <!-- 파란색 부분 끝 -->
    
    
	<!-- 하얀색 부분 네비 -->
    <div class="container-fluid" id="secondlayout">
        <div class="container-xl container-fluid">
            <div class="row" id="whiterow">
                <div class="col-1 blank"></div>
                <div class="col-lg-1 col-3 navi2"><a href="/">일반</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myWriteBook">글쓰기</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/introduce">소개</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myPage">My</a></div>
            </div>
        </div>
    </div>
	
	<!-- 메인 부분 -->
	<div class="container-xl container-fluid" id="booksContainer">
		<div class="row" id="booksRow">
			<div class="left-Layout">
				<img class="titleImg" src="<c:url value='/resources/css/img/TitleImg/${book.booknumber}.jpg'/>" onerror="this.src='<c:url value='/resources/css/img/TitleImg/${book.genre}.jpg'/>'"/>
			</div>
			<div class="right-Layout">
				<div id="bookTitle">${book.title}</div>
				<c:if test="${requestScope.writer.email eq sessionScope.loginId}">
					<a href="/modifyNovel?booknumber=${book.booknumber}" class="bookModify" style="color: #fff">책 정보 수정</a>
				</c:if>
				<div id="bookGenre">장르 > 
					<c:choose>
						<c:when test="${book.genre eq 'FANTASY'}">
							판타지
						</c:when>
						<c:when test="${book.genre eq 'ROMANCE'}">
							로맨스
						</c:when>
						<c:when test="${book.genre eq 'THRILLER'}">
							스릴러
						</c:when>
						<c:otherwise>
							기타
						</c:otherwise>
					</c:choose>
				</div> 
				<div id="BookSubInfo">
					<div id="writer">${book.penname}</div>
					<div id="bookLength">총 ${fn:length(bookpart)}권</div>
				</div>
				<div id="bookIntroduce">
					<div id="bookIntroduce_notice">책소개</div>
					<div id="bookIntroduce_text">
						${book.introduce}
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container-xl container-fluid" id="listContainer">
		<div class="row" id="listRow">
			<div class="col-12" id="listOption">
				<div class="optionTitle">구매하기</div>
				<div id="userOption">
					<input type="checkbox" class="bookpartCKboxAll" id="all">
					<label class="CKLabelAll" for="all"></label>
					<div id="allText">전체 선택</div>
					<a href="javascript:purchase('${sessionScope.loginId}')"><div id="buyingbutton">선택 구매</div></a>
					<div id="bookpartPrice">0원</div>
					<div id="bookpartCount">총 0권</div>
				</div>
			</div>
			<c:choose>
				<c:when test="${fn:length(bookpart) != 0}">
					<form action="purchaseBook" method="post" name="purchaseForm">
					<input type="hidden" value="${book.booknumber}" name="booknumber">
					<input id="resultPrice" type="hidden" value="0" name="price">
					<c:forEach items="${bookpart}" var="part">
						<div class="col-12 episode">
							<input type="checkbox" name="partnumber" class="bookpartCKbox" id="${part.bookpartnumber}" value="${part.bookpartnumber}">
							<label class="CKLabel" for="${part.bookpartnumber}"></label>
							<img class="bookpartList" src="<c:url value='/resources/css/img/TitleImg/${book.booknumber}.jpg'/>" onerror="this.src='<c:url value='/resources/css/img/TitleImg/${book.genre}.jpg'/>'">
							<div class="bookpartTitle">${part.episodetitle}</div>
							<c:choose>
								<c:when test="${part.price == 0}">
									<div class="byingbtn"><a href="javascript:goViewer(${part.bookpartnumber }, ${book.booknumber })" style="color: #fff">바로감상</a></div>
									<c:if test="${requestScope.writer.email eq sessionScope.loginId}">
										<a class="modifybtn" style="color: #fff">수정</a>
									</c:if>
									
									<div class="bookpartPrice">무료</div>
								</c:when>
								<c:when test="${fn:length(pur) != 0}">
									<c:set var="PurCount" value="0"/>
									<c:forEach items="${pur}" var="pur">
										<c:if test="${pur.purchase_bookpartnumber == part.bookpartnumber}">
											<div class="byingbtn"><a href="javascript:goViewer(${part.bookpartnumber }, ${book.booknumber })" style="color: #fff">바로감상</a></div>
											<c:if test="${requestScope.writer.email eq sessionScope.loginId}">
												<a href="/modifyEpisode?bookpartnumber=${part.bookpartnumber}" class="modifybtn" style="color: #fff">수정</a>
											</c:if>
											<div class="bookpartPrice">구매한 목록</div>
											<c:set var="PurCount" value="${PurCount + 1}"/>
										</c:if>
									</c:forEach>
									<c:if test="${PurCount == 0}">
											<c:if test="${requestScope.writer.email eq sessionScope.loginId}">
												<a href="/modifyEpisode?bookpartnumber=${part.bookpartnumber}" class="modifybtn" style="color: #fff">수정</a>
											</c:if>
										<div class="bookpartPrice">${part.price}원</div>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${requestScope.writer.email eq sessionScope.loginId}">
										<a href="/modifyEpisode?bookpartnumber=${part.bookpartnumber}" class="modifybtn" style="color: #fff">수정</a>
									</c:if>
									<div class="bookpartPrice">${part.price}원</div>
								</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
					</form>
				</c:when>
				<c:otherwise>
					<div id="emptyMsg" class="col-12">죄송합니다 업데이트 된 에피소드가 없습니다.</div>
				</c:otherwise>
			</c:choose>	
			<c:if test="${requestScope.writer.email eq sessionScope.loginId}">
				<div class="col-12">
					<div style="text-align: -webkit-center;">
						<a href="/uploadEpisode?booknumber=${book.booknumber}" style="color: white;"><div id="uploadEpisodeBtn">에피소드 등록</div></a>
					</div>			
				</div>
			</c:if>
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