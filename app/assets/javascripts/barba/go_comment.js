$(document).on('turbolinks:load', function(){
  $(function(){
    function event_off(event, selector){
      $(document).off(event, selector);
    }

    let pjaxLink = '.js-pjax';
    let pjaxContent = '#pjax-container';

    event_off('click', pjaxLink);
    $(document).on('click', pjaxLink, function(e){
      e.preventDefault();
      let href = $(this).attr('href');

      $(pjaxContent).animate({
        'opacity': '0'
      }, 'slow', function(){
        $.pjax({
          url: href,
          container: pjaxContent,
          fragment: pjaxContent,
          scrollTo: true,
          timeout: 2500
        });
      });
    });

    $(document).on('pjax:end', function(){
      $(pjaxContent).animate({
        'opacity': '1',
      }, 'slow')
    })

    $(document).on('pjax:popstate', function(){
      window.location.reload();
    });
  });
});