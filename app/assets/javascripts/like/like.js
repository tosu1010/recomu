$(document).on('turbolinks:load', function(){
  $(function(){
    $('.like').on('click', '.like__button', function() {
      $(this).find('.like__icon').addClass('clicked');
    });
  });
})