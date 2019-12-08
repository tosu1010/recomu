$(document).on('turbolinks:load', function() {
  $(function(){
    function buildHTML(comment){
      let content = comment.content.replace(/\n/g, '<br>');
      let html = `<li class="comment">
                    <div class="comment__user-nickname">
                      ${comment.user_name}
                    </div>
                    <div class="comment__content">
                      ${content}
                    </div>
                    <div class="comment__time">
                      ${comment.created_at}
                    </div>
                  </li>`
  
      return html
    }
  
    $('#comment-form').on('submit', function(e){
      e.preventDefault();
      let formData = new FormData(this);
      let url = $(this).attr('action');
      $.ajax({
        type: 'POST',
        url: url,
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(comment){
        let html = buildHTML(comment);
        $('#comments').append(html);
        $('#comment-form')[0].reset();
      })
      .fail(function(){
        alert('文字を入力してください')
      })
      .always(function(){
        $('#post-comment__submit').removeAttr('disabled');
      })
    })
  });
});