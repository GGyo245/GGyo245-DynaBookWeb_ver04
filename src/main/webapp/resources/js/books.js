/**
 * 
 */
$(function(){ 
	//전체선택 체크박스 클릭 
	$(".bookpartCKboxAll").click(function(){ 
		//만약 전체 선택 체크박스가 체크된상태일경우 
		if($(".bookpartCKboxAll").prop("checked")) { 
			//해당화면에 전체 checkbox들을 체크해준다 
			$("input[type=checkbox]").prop("checked",true);
			// 전체선택 체크박스가 해제된 경우 
		} else { 
			//해당화면에 모든 checkbox들의 체크를해제시킨다. 
			$("input[type=checkbox]").prop("checked",false); 
		} 
	})
	
	//계산 로직
	$('input[type=checkbox]').click(function(){
		
		let result = 0;
		var episode = '';
		var price = '';
		var length = $('.bookpartCKbox:checked').length;
		
		for(let i = 0 ; i < length ; i++){
			
			episode = $('.bookpartCKbox:checked').parent()[i];
			price = $(episode).children('.bookpartPrice').text();
			
			if(!(isNaN(parseInt(price)))){
				
				result += parseInt(price);
			}
		}
		$('#bookpartPrice').text('총'+result+'원')
		$('#bookpartCount').text('총 '+length+'권')
		$('#resultPrice').val(result);
	})
	
	
	goViewer = function(bookpartnumber, booknumber){
		location.href="viewer?bookpartnumber=" + bookpartnumber + "&part_booknumber=" + booknumber;
	}
	
	
	if(window.document.location.search.indexOf("err") != -1){
		
		var tag = '<div id="DBerr"></div>';
		var text = window.document.location.search.split("err=");
		var result = decodeURIComponent(text[1]).replaceAll("+"," ");
		
		$('#listRow').append(tag);
		$('#DBerr').text(result);
	}
	
})
//replaceAll 메서드
String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}
function purchase(id){
	var form = document.purchaseForm;
	var length = $('.bookpartCKbox:checked').length;
	if(length == 0){
		alert("구매 하실 책을 선택하세요.")
		return false;
	}
	if(id.length == 0){
		alert("로그인이 필요한 서비스 입니다.")
		return false;
	}
	
	form.submit();
}

