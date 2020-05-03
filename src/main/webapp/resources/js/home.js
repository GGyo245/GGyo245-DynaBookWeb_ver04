/**
 * 
 */
//사이즈 변경시 클래스 변경되는 소스입니다. ※이부분에 소스 적용시 default.css에도 해당 클래스를 적용해야 됩니다.
$(document).ready(function(){
	
	//두번째 타입 슬라이드 설정값
	var imgHeight = $('.slidetitleimg').height();
	var back = imgHeight + (imgHeight / 10 * 6)
	var back2 = imgHeight + (imgHeight / 10 * 4.5)
	$('#slide2back').css('height',back)
	$('#slide3back').css('height',back)
	$('.your-class').css('height',imgHeight+60)
	
	$( window ).resize(function() {
		
		var serachText = '<div class="col-lg-5 col-12" id="serachMenu">'
		serachText += '<div id="serach">'
		serachText += '<svg class="bi bi-search" width="1em" height="1em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg">'
		serachText += '<path fill-rule="evenodd" d="M12.442 12.442a1 1 0 011.415 0l3.85 3.85a1 1 0 01-1.414 1.415l-3.85-3.85a1 1 0 010-1.415z" clip-rule="evenodd"></path>'
		serachText += '<path fill-rule="evenodd" d="M8.5 14a5.5 5.5 0 100-11 5.5 5.5 0 000 11zM15 8.5a6.5 6.5 0 11-13 0 6.5 6.5 0 0113 0z" clip-rule="evenodd"></path>'
		serachText += '</svg>'
		serachText += '<form autocomplete="off" action="/search" onsubmit="return searchCK()">'
		serachText += '<input id="serachForm" type="text" autocomplete="off" autocapitalize="off" aria-required="true" placeholder="제목, 출판사 검색" name="title">'
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
			
			//첫번째 슬라이드 설정값
			var swiper = new Swiper('.swiper-container', {
				
				  autoplay: {
				    delay: 3000,
				  },
				  slidesPerView: 1,
			      spaceBetween: 30,
			      slidesPerGroup: 1,
			      loop: true,
			      loopFillGroupWithBlank: true,
			      pagination: {
			        el: '.swiper-pagination',
			        clickable: true,
			      },
			      navigation: {
			        nextEl: '.swiper-button-next',
			        prevEl: '.swiper-button-prev',
			      },
			});
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
			
			//첫번째 슬라이드 설정값
			var swiper = new Swiper('.swiper-container', {
				
				  autoplay: {
				    delay: 3000,
				  },
				  slidesPerView: 2,
			      spaceBetween: 30,
			      slidesPerGroup: 1,
			      loop: true,
			      loopFillGroupWithBlank: true,
			      pagination: {
			        el: '.swiper-pagination',
			        clickable: true,
			      },
			      navigation: {
			        nextEl: '.swiper-button-next',
			        prevEl: '.swiper-button-prev',
			      },
			});
			
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
			
			//첫번째 슬라이드 설정값
			var swiper = new Swiper('.swiper-container', {
				
				  autoplay: {
				    delay: 3000,
				  },
				  slidesPerView: 3,
			      spaceBetween: 30,
			      slidesPerGroup: 1,
			      loop: true,
			      loopFillGroupWithBlank: true,
			      pagination: {
			        el: '.swiper-pagination',
			        clickable: true,
			      },
			      navigation: {
			        nextEl: '.swiper-button-next',
			        prevEl: '.swiper-button-prev',
			      },
			});
	    }
		

		
	}).resize();
	
	//컴퓨터 환경에서 반응형 이미지크기를 실시간으로 확인하는 함수 불안정할때 새로고침
	
	var filter = "win16|win32|win64|mac";
	 
	//컴퓨터 환경 확인
    if( navigator.platform  ){
        if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
        	//모바일 접속
        	//두번째 타입 슬라이드 작아질시 설정 값
			$('#slide2back').css('height',back2)
			$('#slide3back').css('height',back2)
        }else{
            //pc접속
        	/*
        	setInterval(function() { 
        		console.log("카드형 슬라이드 반응형 검사 함수 실행중")
        		
        		if($('.cardImg').height() > ($('#ckpoint').height()*1.2)){
        			document.location.reload()
        		}
        		if($('.cardImg').height() < ($('#ckpoint').height() / 2)){
        			document.location.reload()
        		}
        	},300);
        	*/
        }
    }

	
})

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
