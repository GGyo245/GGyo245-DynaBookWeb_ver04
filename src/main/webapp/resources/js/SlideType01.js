/**
 * 
 */
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


	
	