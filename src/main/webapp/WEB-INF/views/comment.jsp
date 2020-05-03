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

<!-- css파일 -->
<script src="<c:url value='/resources/js/viewer.js'/>"></script>
<link rel="stylesheet" href="<c:url value='resources/css/viewer.css'/>">
<meta charset="UTF-8">
<title>전체 댓글</title>
<script>
$(function(){
	moveComment = function(bookpartnumber, page){

		location.href="moveComment?bookpartnumber=" + bookpartnumber + "&currentPage=" + page;
	}	

	insertCommentForm = function(bookpartnumber){
		location.href="insertCommentForm?bookpartnumber=" + bookpartnumber;
	}

	viewer = function(bookpartnumber, part_booknumber){
		location.href="viewer?bookpartnumber=" + bookpartnumber + "&part_booknumber=" + part_booknumber; 
	}

	$(".comment_like").click(function(){

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

	$(".comment_delete").click(function(){

		var data = $(this).data();
		location.href="commentDelete?commentnumber=" + data.a + "&part_booknumber=" + data.b + "&bookpartnumber=" + data.c; 
		
	})

	$(".comment_update").click(function(){
		var data = $(this).data();
		location.href="updateCommentForm?commentnumber=" + data.a + "&usercomment=" + data.b + "&part_booknumber=" + data.c + "&bookpartnumber=" + data.d;
	})


})



</script>
</head>
<body>
<div style="background:black ;">

	<div class="viewer_header">
	 	<div class="header_left">
	 		<a class="viewer_title" href="javascript:viewer('${bookpartnumber }','${part_booknumber }')">
	 			<span class="fas fa-angle-left" aria-hidden="true"></span>
	 		</a>
	 		<span class="comment_title">댓글</span>
	 		<span class="comment_title2">${count}</span>	
	 	</div>
	 	<div class="header_right">
			<div class="insert_comment">
				<a href="javascript:insertCommentForm(${bookpartnumber})" style="color:#a0a0a0">댓글 쓰기</a>
			</div>
	 	</div>
	 </div>
	
	 	<div id="commentBoard">
	 		<div class="text_contents" style="color:white;">
				 <c:choose>
					<c:when test="${empty comment }">
						<div class="comment_empty">
							<div class="reply_empty_icon"><i class="far fa-comment-dots"></i></div>
							<div class="reply_empty_comment">등록된 댓글이 없습니다.</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="comment_section">
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
											<button class="comment_update" data-a="${cm.COMMENTNUMBER }" data-b = "${cm.USERCOMMENT }" data-c = "${part_booknumber }" data-d="${bookpartnumber }">수정</button>
											<button class="comment_delete" data-a="${cm.COMMENTNUMBER }" data-b = "${part_booknumber }" data-c="${bookpartnumber }">삭제</button>

										</c:if>
										<button class="comment_like" data-a="${cm.COMMENTNUMBER }" id="comment${cm.COMMENTNUMBER }"><i class="far fa-thumbs-up"></i> ${cm.HITS }</button>
									</div>
								</div>
							</div>	
							
						</c:forEach> 
							
							<!-- 페이징 처리 -->
							<center>
								<a href="javascript:moveComment('${bookpart.bookpartnumber }','${navi.currentPage - navi.pagePerGroup }')" >◁◁</a>
								<a href="javascript:moveComment('${bookpart.bookpartnumber }','${navi.currentPage - 1}')">◀</a>
								<c:forEach var="counter" begin="${navi.startPageGroup }" end="${navi.endPageGroup }">
									<a href="javascript:moveComment('${bookpart.bookpartnumber }','${counter}')">${counter }</a>
								</c:forEach>
								<a href="javascript:moveComment('${bookpart.bookpartnumber }','${navi.currentPage + 1}')">▶</a>
								<a href="javascript:moveComment('${bookpart.bookpartnumber }','${navi.currentPage + navi.pagePerGroup }')">▷▷</a>
							
							</center>
					</div>	
					</c:otherwise>
				</c:choose> 
			</div>
	 	</div>
</div>
</body>
</html>