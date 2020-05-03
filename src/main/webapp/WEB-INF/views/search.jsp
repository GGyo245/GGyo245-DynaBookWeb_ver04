<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<html>
<head>
	<title>DynaBook</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcur icon" href="<c:url value='/resources/css/img/icon/favicon.ico'/>" type="image/x-icon">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
     integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value='/resources/css/default.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/search.css'/>">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="<c:url value='/resources/js/default.js'/>"></script>
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
                        <form name="searchForm" autocomplete="off" action="/searh" onsubmit="return searchCK()">
                            <input id="serachForm" type="text" autocomplete="off" autocapitalize="off" aria-required="true" placeholder="제목, 저자, 출판사 검색" name="title">
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
                <div class="col-lg-1 col-3 navi2"><a href="#">일반</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myWriteBook">글쓰기</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/introduce">소개</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myPage">My</a></div>
            </div>
        </div>
    </div>
	
	<!-- 메인 부분 -->
	<div class="container-xl container-fluid" id="searchContainer">
		<div class="row" id="searchRow">
			<c:if test="${fn:length(book) != 0}">
				<div class="col-12" id="searchWord">
					<div id="searchKeyword">'${search}'</div> 검색 결과
				</div>
				<div class="col-12" id="searchOption">
					<a href="javascript:searchOrder('')" class="Category" id="CategoryPopular" style="color: #1F8CE6;">인기순</a>
					<a href="javascript:searchOrder('new')" class="Category" id="CategoryNew" style="color: #636c73;">최신순</a>
					<a href="javascript:searchOrder('review')" class="Category" id="CategoryReview" style="color: #636c73;">리뷰 많은순</a>
					<a href="javascript:searchOrder('price')" class="lastCategory" id="CategoryPrice" style="color: #636c73;">낮은 가격순</a>
				</div>
			</c:if>
			
			
			<!-- 검색결과 예시
			<div class="col-12 searchResult">
				<img class="searchImg" src="<c:url value='/resources/css/img/TitleImg/36.jpg'/>">
				<div class="infoLayout">
					<div class="searchBookTitle">절벽에 뜬 달</div>
					<div class="searchSubInfos">
						<div class="searchSubInfo">조회수</div>
						<div class="searchSubInfo">작가명</div>
						<div class="searchSubInfo">총0권</div>
					</div>
					<div class="searchBookIntroduce">
						절벽 위에 외로이 있는 초가집 하나.
						그곳에는 왕의 자리에서 폐위된 사내가 유폐되어 있다.
						나는 병든 아비를 대신하여 그를 감시한다.
						어떤 이들은 그가 친모와 간음을 했다고 하고,
						절벽 위에 외로이 있는 초가집 하나.
						그곳에는 왕의 자리에서 폐위된 사내가 유폐되어 있다.
						나는 병든 아비를 대신하여 그를 감시한다.
						어떤 이들은 그가 친모와 간음을 했다고 하고,
					</div>
					<div class="searchPrice">
						가격정보
						<div class="priceNumber">1000원</div>
						전권구매
						<div class="priceNumber">50000원</div>
					</div>
				</div>
			</div>
			 -->
			<c:choose>
				<c:when test="${fn:length(book) != 0}">
					<c:forEach items="${book}" var="book">
						<div class="col-12 searchResult">
							<a href="/books?booknumber=${book.BOOKNUMBER}">
								<img class="searchImg" src="<c:url value='/resources/css/img/TitleImg/${book.BOOKNUMBER}.jpg'/>" onerror="this.src='<c:url value='/resources/css/img/TitleImg/${book.GENRE}.jpg'/>'">
							</a>
							<div class="infoLayout">
								<a href="/books?booknumber=${book.BOOKNUMBER}">
									<div class="searchBookTitle">${book.TITLE}</div>
								</a>
								<div class="searchBookGenre">장르 > 
									<c:choose>
										<c:when test="${book.GENRE eq 'FANTASY'}">
											판타지
										</c:when>
										<c:when test="${book.GENRE eq 'ROMANCE'}">
											로맨스
										</c:when>
										<c:when test="${book.GENRE eq 'THRILLER'}">
											스릴러
										</c:when>
										<c:otherwise>
											기타
										</c:otherwise>
									</c:choose>
								</div>
								<div class="searchSubInfos">
									<div class="searchSubInfo">
										<c:if test="${book.BOOKPARTHITS == null}">총 조회수0회</c:if>
										<c:if test="${book.BOOKPARTHITS != null}">총 조회수${book.BOOKPARTHITS}회</c:if>
									</div>
									<div class="searchSubInfo">${book.PENNAME}</div>
									<div class="searchSubInfo2">총${book.BOOKPARTCOUNT}권</div>
								</div>
								<div class="searchBookIntroduce">
									${book.INTRODUCE}
								</div>
								<div class="searchPrice">
									가격정보
									<div class="priceNumber">
										<c:if test="${book.BOOKPARTPRICE == null}">없음</c:if> 
										<c:if test="${book.BOOKPARTPRICE != null}">${book.BOOKPARTPRICE}원</c:if>
									</div>
									전권구매
									<div class="priceNumber">
										<c:if test="${book.BOOKPARTALLPRICE == null}">없음</c:if>
										<c:if test="${book.BOOKPARTALLPRICE != null}">${book.BOOKPARTALLPRICE}원</c:if>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="col-12" id="notFound">'${search}'에 대한 검색 결과가 없습니다.</div>
					
					<div class="col-12" id="returnHome">
						<a href="/">
							<img id="questionImg" alt="questionmark" src="<c:url value="/resources/css/img/icon/questionMark.png"/>">
							<div id="questionText">다이나북 홈으로</div>
						</a>
					</div>
					
				</c:otherwise>
			</c:choose>
			
			
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

