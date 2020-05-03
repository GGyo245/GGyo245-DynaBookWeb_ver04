/**
 * 
 */

//사이즈 변경시 클래스 변경되는 소스입니다. ※이부분에 소스 적용시 default.css에도 해당 클래스를 적용해야 됩니다.
$(document).ready(function(){
	
	$( window ).resize(function() {
		
		var serachText = '<div class="col-lg-5 col-12" id="serachMenu">'
		serachText += '<div id="serach">'
		serachText += '<svg class="bi bi-search" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg">'
		serachText += '<path fill-rule="evenodd" d="M12.442 12.442a1 1 0 011.415 0l3.85 3.85a1 1 0 01-1.414 1.415l-3.85-3.85a1 1 0 010-1.415z" clip-rule="evenodd"></path>'
		serachText += '<path fill-rule="evenodd" d="M8.5 14a5.5 5.5 0 100-11 5.5 5.5 0 000 11zM15 8.5a6.5 6.5 0 11-13 0 6.5 6.5 0 0113 0z" clip-rule="evenodd"></path>'
		serachText += '</svg>'
		serachText += '<form name="searchForm" autocomplete="off" action="/search" onsubmit="return searchCK()">'
		serachText += '<input id="serachForm" type="text" autocomplete="off" autocapitalize="off" aria-required="true" placeholder="제목, 저자 검색" name="title">'
		serachText += '<input id="orderForm" type="hidden" name="order">'
		serachText += '</form></div></div>'
        
		var width=window.innerWidth;
		//작아질시 ( 여기에 작성하면 커질시에도 다시 돌아올 클래스를 적용해야함 )
		if(width < 600){
			
			jQuery('#secondRow').css('text-align','center')
			jQuery('#userForm').css('padding-top','0')
			jQuery('#serachMenu').css('padding-top','0')
			jQuery('#whiterow').css('text-align','center')
			jQuery('.buttonLine').css('width','100%')
			jQuery('.blank').attr('class','blank2')
			jQuery('#serachMenu').remove()
			jQuery('#userForm').after(serachText)
			jQuery('#DynaBookAllInfo').css('margin-top','3%')
			$('.address2').css('display','block')
			$('#company').css('display','block')
			
		}
		// 600크기와 동일한 스크립트를 적어줘야 갑자기 줄어들어도 적용됨
		else if (width < 991){
			jQuery('#secondRow').css('text-align','center')
			jQuery('#userForm').css('padding-top','0')
			jQuery('#serachMenu').css('padding-top','0')
			jQuery('#whiterow').css('text-align','center')
			jQuery('.buttonLine').css('width','100%')
			jQuery('.blank').attr('class','blank2')
			jQuery('#serachMenu').remove()
			jQuery('#userForm').after(serachText)
			jQuery('#DynaBookAllInfo').css('margin-top','3%')
			$('.address2').css('display','block')
			$('#company').css('display','block')
			
			
		//커질 시 , 되돌아올 시 
		}else if(width > 991){
			jQuery('#userForm').css('padding-top','10px')
			jQuery('#serachMenu').css('padding-top','10px')
			jQuery('#secondRow').css('text-align','start')
			jQuery('#whiterow').css('text-align','start')
			jQuery('.buttonLine').css('width','54%')
			jQuery('.blank2').attr('class','col-lg-1 col-0 blank')
			jQuery('#serachMenu').remove()
			jQuery('#logo').after(serachText)
			jQuery('#DynaBookAllInfo').css('margin-top','0%')
			$('.address2').css('display','inline')
			$('#company').css('display','inline')
			
	    }
	}).resize();
	$(window).trigger('resize')
	
	
	var order = window.location.search.substr(window.location.search.indexOf("order=")+6);
	//검색순서에 대해 css 바꾸기
	if(order == ''){
		console.log('인기')
		$('.Category').css('color','#636c73')
		$('.lastCategory').css('color','#636c73')
		$('#CategoryPopular').css('color','#1F8CE6')
	}else if(order == 'new'){
		console.log('신작')
		$('.Category').css('color','#636c73')
		$('.lastCategory').css('color','#636c73')
		$('#CategoryNew').css('color','#1F8CE6')
	}else if(order == 'review'){
		console.log('리뷰')
		$('.Category').css('color','#636c73')
		$('.lastCategory').css('color','#636c73')
		$('#CategoryReview').css('color','#1F8CE6')
	}else if(order == 'price'){
		console.log('가격')
		$('.Category').css('color','#636c73')
		$('.lastCategory').css('color','#636c73')
		$('#CategoryPrice').css('color','#1F8CE6')
	}
	
});

function searchCK(){
	var txt = $('#serachForm').val();
	
	if(txt.length == 0){
		alert("검색어를 입력하세요")
		return false;
	}
	else if(txt.length == 1){
		alert("최소 2글자 이상은 입력하세요")
		return false;
	}else{
		return true;
	}
}

function searchOrder(order){
	var title = window.location.search.substr(window.location.search.indexOf("title=")+6,window.location.search.indexOf("&order=")-7)
	
	$('#serachForm').val(decodeURIComponent(title));
	$('#orderForm').val(order);
	
	searchForm.submit();
}
