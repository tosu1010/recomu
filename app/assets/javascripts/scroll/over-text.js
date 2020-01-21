$(document).on('turbolinks:load', function(){
  $(function(){
    $('.over-scroll').each(function(){
      let text = $(this).text().length;
      if(text > 11) {
        $(this).addClass('over-scroll--scroll');
      }
    });
  });
});