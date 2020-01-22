$(document).on('turbolinks:load', function(){
  $(function(){
    $('.over-scroll').each(function(){
      let text = $(this).text().length;
      if($(window).width() > 768) {
        if(text > 11) {
          $(this).addClass('over-scroll--scroll');
        }
      } else {
        if(text > 6) {
          $(this).addClass('over-scroll--scroll');
        }
      }
    });
  });
});