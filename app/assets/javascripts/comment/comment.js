$(document).ready(function() {
  $(function(){
    function buildHTML(comment){
      let content = comment.content.replace(/\n/g, '<br>');
      let html = `<li class="comment">
                    <div class="comment__user-name">
                      ${comment.user_name}
                    </div>
                    <div class="comment__time">
                      ${comment.created_at}
                    </div>
                    <div class="comment__content">
                      <p>
                        ${content}
                      </p>
                    </div>
                  </li>`
  
      return html
    }

    $(document).on('ajax:success', '#comment-form', function(data){
      let html = buildHTML(data.detail[0]);
      $('#comments').append(html);
      $('#comment-form')[0].reset();
      $('#post-comment__submit').removeAttr('disabled');
    });

    $(document).on('ajax:error', '#comment-form', function(){
      $('#post-comment__submit').removeAttr('disabled');
      alert('文字を入力してください');
    });
  });
});