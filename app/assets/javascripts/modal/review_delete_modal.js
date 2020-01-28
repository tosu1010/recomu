$(document).on('turbolinks:load', function(){
  $(function(){
    $('.js-modal-delete-review').each(function(){
      $(this).on('click', function(){
        winScrollTop = $(window).scrollTop();
        let target = $(this).data('target');
        let modal = document.getElementById(target);
        $(modal).fadeIn();
        return false;
      });
    });
  });
});