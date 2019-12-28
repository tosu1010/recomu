$(document).on("turbolinks:load", function(){

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
    })
  
    // タグのインクリメンタルサーチ
    $(document).on('keyup', '.review-form__text-field--tag', function(){
      let input = $(this).val();
      let this_content = $(this);

      if (input) {
        $.ajax({
          type: 'GET',
          url: '/tags/search',
          data: {tag: input},
          dataType: 'json'
        })
        .done(function(tags){
          $('.tags-incremental').empty();
          let add_tag_object = this_content.siblings('.tags-incremental')
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
        this_content.siblings('.tags-incremental').empty();
      }
    });
  });
});