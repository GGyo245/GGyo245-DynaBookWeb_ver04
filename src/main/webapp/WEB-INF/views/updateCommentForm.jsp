<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>	
<link rel="shortcur icon" href="<c:url value='/resources/css/img/icon/favicon.ico'/>" type="image/x-icon">
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
	$(".comment_input").html("${comment.usercomment }");
	
	updateComment = function(bookpartnumber, part_booknumber, commentnumber){
		if($(".comment_input").val()==""){
			alert("내용을 입력하세요");
			return false;
		}

		location.href="updateComment?commentnumber=" + commentnumber + "&usercomment=" + $(".comment_input").val() + "&part_booknumber=" + part_booknumber + "&bookpartnumber=" + bookpartnumber;

	
	}


})



</script>

</head>
<body>
<div style="background:black ;">

	<div class="viewer_header">
	 	<div class="header_left">
	 		<span class="comment_title">댓글 수정</span>
	 			
	 	</div>
	 </div>
	
	 	<div id="commentBoard">
	 		<div class="text_contents" style="color:white;">
				<div class="comment_section">	
					<textarea class="comment_input"></textarea>
					<div class="insert_button">
						<button class="blue_button input_button submit_button" type="button" onclick="javascript:updateComment('${bookpart.bookpartnumber}','${bookpart.part_booknumber }','${comment.commentnumber }')">수정</button>
					</div>
					
				</div>	
			</div>
	 	</div>
</div>
</body>
</html>