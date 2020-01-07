$(function(){
  function appendTags(object, tag_name){
    let html = 
    `<div class="append-tag">
      <p>${tag_name}</p>
     </div>
    `
    object.append(html);
  }

  // クリックしたタグをフォーム内に格納
  $(document).on('click', '.append-tag', function(e){
    e.preventDefault();
    let parent = $(this).parent();
    let value = $(this).children('p').text();
    parent.siblings('#tag-field').val(value);
    parent.empty();
    parent.removeClass('tags-incremental--show');
  })

  // タグのインクリメンタルサーチ
  $(document).on('keyup', '.review-form__text-field--tag', function(){
    let input = $(this).val();

    if (input) {
      $.ajax({
        type: 'GET',
        url: '/tags/search',
        data: {tag: input},
        dataType: 'json',
        context: $(this)
      })
      .done(function(tags){
        this.siblings('.tags-incremental').empty();
        this.siblings('.tags-incremental').addClass('tags-incremental--show')
        let add_tag_object = this.siblings('.tags-incremental');
        if (tags.length !== 0) {
          tags.forEach(function(tag){
            appendTags(add_tag_object, tag.name);
          });
        }
      })
      .fail(function(){
        alert("検索できませんでした");
      });
    }
    else {
      $(this).siblings('.tags-incremental').empty();
      $(this).siblings('.tags-incremental').removeClass('tags-incremental--show');
    }
  });
});
