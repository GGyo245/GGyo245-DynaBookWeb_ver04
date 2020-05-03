<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>DynaBook</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcur icon" href="<c:url value='/resources/css/img/icon/favicon.ico'/>" type="image/x-icon">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
      integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  	<!-- include libraries(jQuery, bootstrap) -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	<!-- 사용자 설정 -->
	<link rel="stylesheet" href="<c:url value='/resources/css/default.css'/>">
    <script src="<c:url value='/resources/js/default.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='/resources/css/uploadNovel.css'/>">
    
    <script type="text/javascript">
	    function numberCheck() {
			if(event.keyCode<48 || event.keyCode>57) {
				event.returnValue=false;
			}
	  	}

		function uploadCheck(){
			return true;
		}
	
		$(document).ready(function() {
			$('#summernote').summernote({
			   	   placeholder: '내용을 입력하세요',
			   	   toolbar: false,
			   	   minHeight: 370,
			   	   maxHeight: null,
			   	   focus: true, 
			   	   lang : 'ko-KR',
		   	  });

		   	  $('#cancleBtn').on('click', function(){
			   	  window.location.href="/user/myWriteBook";
			  });
		});
    </script>
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
                            <input id="serachForm" type="text" autocomplete="off" autocapitalize="off" aria-required="true" placeholder="제목, 저자 출판사 검색" name="title">
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
						<script>
							alert('로그인이 필요한 서비스입니다.');
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
                   	<a href='/' style="padding-left: 7px"><span class="css-nih33d-labelStyle">홈</span></a>
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
                <div class="col-lg-1 col-3 navi1">
                </div>
                <div class="col-lg-1 col-3 navi1">
                </div>
            </div>
        </div>
    </div>
    <!-- 파란색 부분 끝 -->
    
    
	<!-- 하얀색 부분 네비 -->
    <div class="container-fluid" id="secondlayout">
        <div class="container-xl container-fluid">
            <div class="row" id="whiterow">
                <div class="col-lg-1 blank"></div>
                <div class="col-lg-1 col-3 navi2"><a href="/">일반</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myWriteBook">글쓰기</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/introduce">소개</a></div>
                <div class="col-lg-1 col-3 navi2"><a href="/user/myPage">My</a></div>
            </div>
        </div>
    </div>
	
	<!-- 메인 부분 -->
	
	<!-- 배경화면 css지정 -->
	<div class="container-fluid writeformBackground">
		<div class="container-xl container-fluid">
			<div class="row writeformRow">
				<div class="col-12">
					<div class="uploadNovelTitle">새 작품 쓰기</div>
				</div>
				<div class="col-12 borderbottom">
					<div class="dsc_rule">
						저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시물은 이용약관 및 관련 법률에 의하여 제재를 받을 수 있습니다. <p />
						작품 및 회차 연재 시 운영원칙에 동의한 것으로 간주합니다. 성인물, 폭력물 등 운영원칙에 위배되는 작품은 통보 없이 삭제될 수 있습니다. 
					</div>			
				</div>
				<form action="insertDynabook" method="post" id="insertDynabook" autocomplete="off" enctype="multipart/form-data" onsubmit="return uploadCheck()">
					<!-- 제목 -->
					<div class="col-12 borderbottom">
						<input class="inputTitle" name="title" type="text" placeholder="작품제목을 입력하세요">
					</div>
					<!-- 필명 -->
					<div class="col-12 borderbottom">
							<input id="penName" name="penname" type="text" placeholder="작품에 사용할 필명을 입력하세요">
					</div>
					<!-- 장르 -->
					<div class="col-12 borderbottom selectgenreArea">
						<div id="genreRow" class="selectGenreTitle"> 장르 </div>
						<select class="genreSelect" name="genre">
							<option value="default">장르 선택</option>
							<option value="THRILLER">스릴러</option>
							<option value="ROMANCE">로맨스</option>
							<option value="FANTASY">판타지</option>
						</select>
					</div>
					
					<!-- 작품 소개 -->
					<div class="col-12 borderbottom">
						<div class="introduceNovel">
							작품 소개
						</div>
						<textarea id="summernote" name="introduce" rows="15" cols="55"></textarea>
					</div>
					<!-- 표지 이미지 샘플 -> 수정 -->
					<div class="col-12 borderbottom">
						<div class="coverImage">
							표지 이미지 등록 (등록하지 않을 시 기본 이미지로 대체됩니다)
							<div id="fileupload">
								<input type="file" accept=".jpg" name="upload">
							</div>
						</div>
					</div>
					<!-- 수정/취소 영역 취소누를경우 이전 화면으로 이동하도록 -->
					<div class="col-12 buttonArea">
						<input type="submit" id="saveBtn" class="saveBtn" value="저장">
						<input type="button" id="cancleBtn" class="cancleBtn" value="취소">
					</div>
				</form>
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
</body>
</html>