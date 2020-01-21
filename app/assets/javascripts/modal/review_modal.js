$(document).on('turbolinks:load', function(){
  $(function(){
    $('#js-modal-review').on('click',function(){
      winScrollTop = $(window).scrollTop();
      let modal = document.getElementById('post-review');
      $(modal).fadeIn();
      return false;
    });
    $('.js-modal-close').on('click',function(){
        $('.js-modal').fadeOut();
        $('body,html').stop().animate({scrollTop:winScrollTop}, 100);
        return false;
    });
  });
});