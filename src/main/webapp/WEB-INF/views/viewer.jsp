<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>	
<!-- for Awesome cdn -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css" />

<!-- bootstrap cdn -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
				
<!-- slick -->
<link rel="stylesheet" type="text/css" href="<c:url value='resources/slick-1.8.1/slick-1.8.1/slick/slick-theme.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='resources/slick-1.8.1/slick-1.8.1/slick/slick.css'/>"/>

<!-- css파일 -->
<script src="<c:url value='/resources/js/viewer.js'/>"></script>
<link rel="stylesheet" href="<c:url value='resources/css/viewer.css'/>">

<meta charset="UTF-8">
<title>Viewer</title>
<link rel="shortcur icon" href="<c:url value='/resources/css/img/icon/favicon.ico'/>" type="image/x-icon">
<script type="text/javascript">
$(function(){
		var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
		var count = 0;
		var intext = "";
		var text0 = `${bookpart.text}`;
		var text1 = `${bookpart.text1}`;
		var text2 = `${bookpart.text2}`;
		var text3 = `${bookpart.text3}`;
		var text4 = `${bookpart.text4}`;
		var text5 = `${bookpart.text5}`;
		var text6 = `${bookpart.text6}`;
		var text7 = `${bookpart.text7}`;
		var text8 = `${bookpart.text8}`;
		var text9 = `${bookpart.text9}`;
		
		var text = text0;
		
		if(text1.length != 0){
			text = text + text1;
		}
		if(text2.length != 0){
			text = text + text2;
		}
		if(text3.length != 0){
			text = text + text3;
		}
		if(text4.length != 0){
			text = text + text4;
		}
		if(text5.length != 0){
			text = text + text5;
		}
		if(text6.length != 0){
			text = text + text6;
		}
		if(text7.length != 0){
			text = text + text7;
		}
		if(text8.length != 0){
			text = text + text8;
		}
		if(text9.length != 0){
			text = text + text9;
		}
		
		
		var textsplit = text.split('</p>');

	 	for(var i = 0; i < textsplit.length; i++){
			intext += textsplit[i]+"</p>";
			count++;
			if(count==15||i==textsplit.length-1){
				$(".text_contents").append("<div>" + intext + "</div>");
				count=0;
				intext="";
			}
			
		}

		//음소거 여부 체크 변수
		var mute = "";
		var genre = "${book.genre}";
	 	$.ajax({
			url:"getMusic"
			,type:"post"
			,data : {"emotion_bookpartnumber" :${bookpart.bookpartnumber}
					 ,"pagenumber" : 0
					 ,"genre" : genre}
			,datatype:"json"
			,success:function(result){
				
				$(".audio_wrapper").html('<audio autoplay loop' + mute + ' id="music"><source type="audio/mp3" src="'+result+'"></audio>' );
			}
		})
		
		$('body').on('click', '.slick-arrow', function () {
			var pagenumber = $('.slick-active').attr('data-slick-index');
			 
			$.ajax({
				url:"getMusic"
				,type:"post"
				,data : {"emotion_bookpartnumber" :${bookpart.bookpartnumber}
						 ,"pagenumber" : pagenumber
						 ,"genre" : genre}
				,datatype:"json"
				,success:function(result){
					
					$(".audio_wrapper").html('<audio autoplay loop' + mute + ' id="music"><source type="audio/mp3" src="'+result+'"></audio>' );
				}
			})
		})

		$(".text_contents").slick({
			dots:true,
			infinite:true
		});
			
		$(".viewer_header").hide();
		$(".viewer_footer").hide();
		$(".side_toggle").hide();
		
		$(".viewer_wrapper").click(function(){
			$(".viewer_header").slideToggle();
			$(".viewer_footer").slideToggle();
			$(".side_toggle").hide();
			
		});

		$("#button_setting").click(function(){
			$(".side_toggle").slideToggle();
		});


		$("#button_home").click(function(){
			location.href="/";
		});

		$("#button_mylist").click(function(){
			location.href="/user/mylist";
		});

		$(".button_comment").click(function(){
			var bookpartnumber = $(this).data();
			location.href="moveComment?bookpartnumber=" + bookpartnumber.a + "&part_booknumber=" + bookpartnumber.b;
		});

		$(".comment_button").click(function(){

			var commentnumber = $(this).data();
			$.ajax({
				url:"hitsFunction"
				,type:"post"
				,data : {"commentnumber" : commentnumber.a}
				,datatype:"json"
				,success:function(result){
					$("#comment"+commentnumber.a).html('<i class="far fa-thumbs-up"></i>' + ' ' + result);
					
				}


			})
		})
		


		likeFunction = function(bookPartNumber){

			var bookPartNumber = bookPartNumber;
			

			$.ajax({
				url:"likeFunction"
				,type:"post"
				,data : {"bookmark_bookPartNumber" :bookPartNumber}
				,datatype:"json"
				,success:function(result){
					if(result == 1){
						$(".header_right").html('<div class="button_unlike"><a onclick="javascript:unlikeFunction(${bookpart.bookpartnumber})"><i class="fas fa-heart"></i></a></div>');
						
						
					}
					
				}


			})

		};

		unlikeFunction = function(bookPartNumber){
			
			var bookPartNumber = bookPartNumber;
			
			$.ajax({
				url:"unlikeFunction"
				,type:"post"
				,data : {"bookmark_bookPartNumber" : bookPartNumber}
				,datatype:"json"
				,success:function(result){
					if(result == 1){
						
						$(".header_right").html('<div class="button_like"><a onclick="javascript:likeFunction(${bookpart.bookpartnumber})"><i class="far fa-heart"></i></a></div>');
						
						
					}
					
				}


			})
		};

		prePart=function(episode, part_booknumber){

			if(episode==1){
				alert("첫 화 입니다.");
				return false;
			}	
			location.href="prePart?episode="+episode + "&part_booknumber=" + part_booknumber;
			
		};

		nextPart=function(episode, part_booknumber){
			$.ajax({
				url : "searchLastPart"
				,type : "post"
				,data : {"part_booknumber" : part_booknumber}
				,datatype:"json"
				,success:function(result){
					if(result == episode){
						alert("최신 화 입니다.")
						return false;
					}
					else{
						location.href="nextPart?episode="+episode + "&part_booknumber=" + part_booknumber;
					}
				}

			})
		};

		$("#button_home").click(function(){
			location.href="/";
		})

		$("#buttion_mylist").click(function(){
			location.href="myPage"
		})

		$(".minus_button").click(function(){
			var fontarea = $(".slick-slide").children("p");
			var fontsize = fontarea.css("font-size");
			var fontvalue = parseInt(fontsize);
			if(fontvalue!=14){
				fontarea.css("font-size", fontvalue-2);
			}
		})

		$(".plus_button").click(function(){
			var fontarea = $(".slick-slide").children("p");
			var fontsize = fontarea.css("font-size");
			var fontvalue = parseInt(fontsize);
			if(fontvalue!=26){
				fontarea.css("font-size", fontvalue+2);
			}
		})

		$(".font_button_gothic").click(function(){
			var fontarea = $(".slick-slide").children("p");

			fontarea.css("font-family", "nanumgothic");
		})

		$(".font_button_nexon").click(function(){
			var fontarea = $(".slick-slide").children("p");

			fontarea.css("font-family", "nexonregular");
		})
		
		$('input:checkbox[id="checkmusic"]').click(function(){
			
			var check = $('#checkmusic').is(":checked");
			
			var audio = document.getElementById('music');
			if(check){
				mute = "";
				$("#music").removeAttr("muted");
				audio.load();
				audio.play();
			}else{
				mute = " muted";
				audio.pause();
			};
		});

		$('input:checkbox[id="checkimg"]').click(function(){
			
			var check = $('#checkimg').is(":checked");
			if(check){
				  var pagenumber = $('.slick-active').attr('data-slick-index');
				  $.ajax({
						url:"/getBackground"
						,type:"post"
						,data : {"background_bookpartnumber" : hashes[0].substring(hashes[0].indexOf("=")+1)
								 ,"pagenumber" : pagenumber}
						,dataType:"text"
						,success:function(result){
							if(check){
								$('#backGroundIMG').css({"background":"url(resources/js/img/"+result+".jpg)"}).css("background-size","cover").css("background-attachment","fixed");
							}
						}

					});
			}else{
				$('#backGroundIMG').css({"background":"black"});
			};
		});
		

		insertCommentForm = function(bookpartnumber){
		      location.href="insertCommentForm?bookpartnumber=" + bookpartnumber;
		}

		$(".comment_update").click(function(){
			var data = $(this).data();
			location.href="updateCommentForm?commentnumber=" + data.a + "&usercomment=" + data.b + "&part_booknumber=" + data.c + "&bookpartnumber=" + data.d;
		})

		$(".comment_delete").click(function(){

		var data = $(this).data();
		location.href="commentDelete?commentnumber=" + data.a + "&part_booknumber=" + data.b + "&bookpartnumber=" + data.c; 
		
	})
		   
		

})

</script>
</head>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">



<div id="backGroundIMG">

	<div class="viewer_header">
	 	<div class="header_left">
	 		<a class="viewer_title" href="/">
	 			<span class="fas fa-angle-left" aria-hidden="true"></span>
	 			<span class="viewer_title">${book.title }</span>
	 		</a>		
	 	</div>
	 	
	 	<div class="header_right">
	 		<c:choose>
	 			<c:when test="${bookmark.bookmark_bookPartNumber != 0 }">
	 				<div class="button_unlike">
	 					<a onclick="javascript:unlikeFunction(${bookpart.bookpartnumber})"><i class="fas fa-heart"></i></a>
	 				</div>
	 			</c:when>
	 			<c:otherwise>
	 				<div class="button_like">
	 					<a onclick="javascript:likeFunction(${bookpart.bookpartnumber})"><i class="far fa-heart"></i></a>
	 				</div>
	 			</c:otherwise>
	 		</c:choose>
	 	</div>
	 </div>
	 		
	 <div class="row" style="width:100%">
	 	<div class="col-3 viewer_wrapper audio_wrapper"></div>
	 	<div class="col-6" id="textBoard">
	 		<div class="text_contents" style="color:white;">
	 			
	 		</div>
	 	</div>
	 	<div class="col-3 viewer_wrapper"></div>
	 </div>	
	
	<div class="container-fluid" style="background-color: gray;">
		<div class="row" style="color:white;">
			<div class="col-12">
				댓글
			</div>
			<div class="reply col-12">
				 <c:choose>
					<c:when test="${empty comment }">
						<div class="reply_empty">
							<div class="reply_empty_icon"><i class="far fa-comment-dots"></i></div>
							<div class="reply_empty_comment">베스트 댓글이 없습니다.</div>
							<div class="reply_empty_newCommnet"><a data-a="${bookpart.bookpartnumber }" data-b="${bookpart.part_booknumber }" class="new_comment button_comment">전체 댓글 보기</a></div>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${comment }" var="cm" varStatus="status">
							<div class="comment_wrapper">	
								<div class="comment">
									<p class="comment_text">${cm.USERCOMMENT }</p>
									<ul class="comment_meta">
										<li classs="meta_id">
											${cm.NICK }
										</li>
										<li class="meta_date">
											${cm.COMMENTDATE}
										</li>
									</ul>
									<div class="comment_button">
										<c:if test="${sessionScope.loginId == cm.EMAIL}">
											<button class="comment_update" data-a="${cm.COMMENTNUMBER }" data-b = "${cm.USERCOMMENT }" data-c = "${bookpart.part_booknumber }" data-d="${bookpart.bookpartnumber }">수정</button>
											<button class="comment_delete" data-a="${cm.COMMENTNUMBER }" data-b = "${bookpart.part_booknumber }" data-c="${bookpart.bookpartnumber }">삭제</button>
										</c:if>
										<button class="comment_like" data-a="${cm.COMMENTNUMBER }" id="comment${cm.COMMENTNUMBER }"><i class="far fa-thumbs-up"></i> ${cm.HITS }</button>
									</div>
								</div>
							</div>	
						</c:forEach> 
					</c:otherwise>
				</c:choose> 
			</div>
		</div>
	</div>
	
	<div class="viewer_footer">
		<div class="viewer_footer_top">	
			<div class="footer_top_left">
				<span>${bookpart.episode }. ${bookpart.episodetitle }</span>
			</div>
			
			<div class="footer_top_right">
				<div class="pre_episode">
					<a href="javascript:prePart(${bookpart.episode},${bookpart.part_booknumber })">
						<span class="fas fa-angle-left" aria-hidden="true"></span>
						<span>이전화</span>
					</a>
				</div>
				
				<div class="next_episode">
					<a href="javascript:nextPart(${bookpart.episode},${bookpart.part_booknumber })">
						<span >다음화</span>	
						<span class="fas fa-angle-right" aria-hidden="true"></span>
					</a>
				</div>
					
			</div>
		</div>
		
		<div class="viewer_footer_bottom">
			<div class="button_layout">
				<div class="button_wrapper">
					<button class="footer_button" id="button_home">
						<span class="fas fa-home"></span>
						<span class="footer_button_title">홈 이동</span>
					</button>
				</div>
				
				<div class="button_wrapper">
					<button class="footer_button" id="button_mylist">
						<span class="far fa-heart"></span>
						<span class="footer_button_title">내 보관함</span>
					</button>
				</div>
				
				<div class="button_wrapper">
					<button class="footer_button button_comment"  data-a="${bookpart.bookpartnumber }" data-b="${bookpart.part_booknumber }">
						<span class="far fa-comment-dots"></span>
						<span class="footer_button_title">댓글 보기</span>
					</button>
				</div>
				
				<div class="button_wrapper">
					<button class="footer_button" id="button_setting">
						<span class="fas fa-bars"></span>
						<span class="footer_button_title">설정</span>
					</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="side_toggle">
			<div class="setting_body">
				<ul class="setting_group">
					<li class="setting_list">
						<div class="setting_icon">
							<span class="fas fa-font"></span>
						</div>
						
						<div class="setting_wrapper">
							<div class="setting_title">
								글꼴
							</div>
							
							<div class="setting_fonttype">
								<ul class="fonttype_list">
									<li class="font">
										<button class="font_button_gothic">
										 	Font 1
										</button>
									</li>
									<li class="font">
										<button class="font_button_nexon">
											 Font 2
										</button>
									</li>
								</ul>
							</div>
						</div>
					</li>
					<li class="setting_list">
						<div class="setting_icon">
							<span class="fas fa-text-height setting_icon"></span>
						</div>
						
						<div class="setting_wrapper">
							<div class="setting_title">
								글자 크기
							</div>
							
							<div class="setting_fontsize">
								<ul class="fontsize_list">
									<li class="fontsize_button_li">
										<button class="minus_button">
											 감소
										</button>
									</li>
									<li class="fontsise_button_li">
										<button class="plus_button">
											증가
										</button>
									</li>
								</ul>
							</div>
						</div>
					</li>
					<li class="setting_list">
						<div class="setting_icon">
							<span class="fas fa-music"></span>
						</div>
							
						<div class="setting_wrapper">	
							<div class="setting_title">
								배경 음악
							</div>
							
							
								<section class="setting content-center">
   									<label class="btn-switch">
     								<input type="checkbox" checked id="checkmusic">
     								<i class="slide-object"></i>
  									</label>
								</section>
							
						</div>
					</li>
					<li class="setting_list">
						<div class="setting_icon">
							<span class="fas fa-image setting_icon"></span>
						</div>
							
						<div class="setting_wrapper">	
							<div class="setting_title">
								배경 화면
							</div>
							
								
							<div class="setting_image">
								<section class="setting content-center">
   									<label class="btn-switch">
     								<input type="checkbox" checked id="checkimg">
     								<i class="slide-object"></i>
  									</label>
								</section>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
</div>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="resources/slick-1.8.1/slick-1.8.1/slick/slick.min.js"></script>

</body>
</html>