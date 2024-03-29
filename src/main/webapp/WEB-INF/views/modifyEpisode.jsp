<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>DynaBook</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcur icon" href="/resources/css/img/icon/favicon.ico" type="image/x-icon">
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
	    function submitCK(){
	    	$('#submitBtn').hide();
	    	$('#cancleBtn').hide();
	    	$('#loadingTag').show();
	    	return true;
	    }
	
	    function numberCheck() {
			if(event.keyCode<48 || event.keyCode>57) {
				event.returnValue=false;
			}
	  	}


		$(document).ready(function() {

				$('#cancleBtn').on('click',function(){
					
					window.location.href='books?booknumber='+`${book.booknumber}`+'';
				});	
			
				$('#summernote').summernote({
			   	    placeholder: '내용을 입력하세요',
			   	   	toolbar: false,
			   	    minHeight: 370,
			   	    maxHeight: null,
			   	   focus: true, 
			   	   lang : 'ko-KR',
			   	  });
		});
	  </script>
</head>
<body>
    <div class="container-fluid" id="mainlayout">
        <div class="container-xl container-fluid">
            <div class="row" id="mainrow">
                <div class="col-lg-1 col-0 blank"></div>
                <div class="col-lg-2 col-3" id="logo"><a href="/"><img id="homelogo" src="/resources/css/img/icon/logo.png"></a></div>
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
	<div class="container-fluid writeformBackground">
		<div class="container-xl container-fluid">
			<div class="row writeformRow">
			<div class="col-12">
				<div class="uploadNovelTitle">에피소드 정보 수정</div>
			</div>
			<div class="col-12 borderbottom">
				<div class="dsc_rule">
					저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시물은 이용약관 및 관련 법률에 의하여 제재를 받을 수 있습니다. <p />
					작품 및 회차 연재 시 운영원칙에 동의한 것으로 간주합니다. 성인물, 폭력물 등 운영원칙에 위배되는 작품은 통보 없이 삭제될 수 있습니다. 
				</div>			
			</div>
			
		<form action="/updateDynabookpart" method="post" id="insertDynabookpart" autocomplete="off" onsubmit="return submitCK()">
			<input type="hidden" name="bookpartnumber" value="${bookpart.bookpartnumber}">
			<div class="borderbottom">
			<table class="col-12 episodetable">
				<tr>
					<td>
						<!-- 에피소드 제목 -->
						<input class="inputEpisodeTitle" name="episodetitle" type="text" value="${bookpart.episodetitle }">
					</td>
					<td>
						<!-- 회차 번호 -->
						<input class="inputEpisodeNum" name="episode" type="text" value="${bookpart.episode }" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');">
					</td>
				</tr>
			</table>
			</div>
			
			<!-- 요금 -->
			<div class="col-12 borderbottom">
				<div class="setPriceArea"> 회차별 가격을 입력해주세요. 
						<input class="setPrice" name="price" type="text" value="${bookpart.price }" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"> 원
				</div>
			</div>
			
			<!-- 내용 -->
			<div class="col-12 borderbottom writeContext">
				<div class="contextArea"> 내용 </div>
				<textarea class="contextEpisode" id='summernote' name="text" rows="15" cols="55">${bookpart.text}${bookpart.text1}${bookpart.text2}${bookpart.text3}${bookpart.text4}${bookpart.text5}${bookpart.text6}${bookpart.text7}${bookpart.text8}${bookpart.text9}</textarea>
			</div>
			<!-- 작가의 말 DB 추가 필요 -->
			<div class="col-12 borderbottom">
				<textarea class="writerComment" id="writerComment" name="writercomment" rows="7" cols="55">${bookpart.writercomment }</textarea>
			</div>
			<div class="col-12 buttonArea">
				<input type="submit" class="saveBtn" id="submitBtn" value="저장">
				<input type="button" class="cancleBtn" id="cancleBtn" value="취소">
				<div id="loadingTag">
					<img alt="loadingIMg" src="<c:url value='/resources/css/img/gif/loadingIMG.gif'/>">
					<div id="loadingMsg">감정분석 및, 키워드 분석중입니다. 이 페이지를 벗어날 시 해당 정보가 저장되지 않습니다.</div>
				</div>
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