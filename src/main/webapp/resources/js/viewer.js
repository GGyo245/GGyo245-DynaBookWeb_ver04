/**
 * 
 */
$(document).ready(function(){
	
	var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	
	$.ajax({
		url:"/getBackground"
		,type:"post"
		,data : {"background_bookpartnumber" : hashes[0].substring(hashes[0].indexOf("=")+1)
				 ,"pagenumber" : 0}
		,dataType:"text"
		,success:function(result){
			$('#backGroundIMG').css({"background":"url(resources/js/img/"+result+".jpg)"}).css("background-size","cover").css("background-attachment","fixed"); 
			
		}

	});
	
	$('body').on('click', '.slick-arrow', function () {
	    var pagenumber = $('.slick-active').attr('data-slick-index');
	    
	    $.ajax({
			url:"/getBackground"
			,type:"post"
			,data : {"background_bookpartnumber" : hashes[0].substring(hashes[0].indexOf("=")+1)
					 ,"pagenumber" : pagenumber}
			,dataType:"text"
			,success:function(result){
				$('#backGroundIMG').css({"background":"url(resources/js/img/"+result+".jpg)"}).css("background-size","cover").css("background-attachment","fixed");
			}

		});
	})
	
});