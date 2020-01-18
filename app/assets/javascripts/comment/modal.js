$(document).on('turbolinks:load', function(){
  $(function(){
    $('.js-modal-open').each(function(){
      $(this).on('click',function(){
        winScrollTop = $(window).scrollTop();
        let target = $(this).data('target');
        let modal = document.getElementById(target);
        $(modal).fadeIn();
        return false;
      });
    });
    $('.js-modal-close').on('click',function(){
        $('.js-modal').fadeOut();
        $('body,html').stop().animate({scrollTop:winScrollTop}, 100);
        return false;
    });
  });
});