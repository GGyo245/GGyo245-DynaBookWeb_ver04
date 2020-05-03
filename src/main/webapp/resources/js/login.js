/**
 * 
 */
//사이즈 변경시 클래스 변경되는 소스입니다. ※이부분에 소스 적용시 default.css에도 해당 클래스를 적용해야 됩니다.
$(document).ready(function(){
	
	$( window ).resize(function() {
        
		var width=window.innerWidth;
		//작아질시 ( 여기에 작성하면 커질시에도 다시 돌아올 클래스를 적용해야함 )
		if (width < 991){
			$('#inputEmail,#inputPassword').attr('class','loginForm')
			$('#submitbtn').attr('id','submitbtn2')
			$('#keepcheck').attr('id','keepcheck3')
			$('.loginmenu').css('font-size','35px')
			
		//커질 시 , 되돌아올 시 
		}else if(width > 991){
			$('#inputEmail,#inputPassword').attr('class','form-control')
			$('#submitbtn2').attr('id','submitbtn')
			$('#keepcheck3').attr('id','keepcheck')
			$('.loginmenu').css('font-size','inherit')
			
	    }
	}).resize();
	$(window).trigger('resize')
})