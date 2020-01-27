$(document).on('turbolinks:load', function(){
  $(function(){
    $('.js-modal-delete-review').each(function(){
      $(this).on('click', function(){
        let target = $(this).data('target');
        let modal = document.getElementById(target);
        $(modal).fadeIn();
        return false;
      });
    });
    $('js-modal-close').on('click', function(){
      $('.js-modal').fadeOut();
      return false;
    })
  });
});