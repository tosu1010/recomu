$(function(){
  $('.review-form__text-field--tag').on('keyup', function(){
    let input = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/tags/search',
      data: {tag: input },
      dataType: 'json'
    })
    .done(function(tags){
      
    })
  })
});