$(document).on("turbolinks:load", function(){
  const tag_container = $('.tags-incremental');

  $(function(){
    function appendTags(tag){
      let html = 
      `<div class="append-tag">
        <p>${tag.name}</p>
       </div>
       `
       tag_container.append(html);
    }

    function appendTagFrom(){
      let html = 
      `
      <label class="review-form__label" for="tags[]">
        タグ
      </label>
      <input class="review-form__text-field--tag" type="text" name="tags[]" id="tags[]">
      `
      $(".review-form__tag").append(html);
    }

    // タグ入力フォームを追加する
    $(document).on("click", ".append-tag", function(e){
      e.preventDefault();
      clickTag = $(this).children("p").text();
      $(".review-form__text-field--tag").val(clickTag);
      tag_container.empty();
      if ($(".review-form__text-field--tag").length < 3 ){
        appendTagFrom();
      }
    });
  
    // タグのインクリメンタルサーチ
    $(document).on('keyup', '.review-form__text-field--tag', function(){
      let input = $(this).val();

      if (input) {
        $.ajax({
          type: 'GET',
          url: '/tags/search',
          data: {tag: input },
          dataType: 'json'
        })
        .done(function(tags){
          tag_container.empty();
          if (tags.length !== 0) {
            tags.forEach(function(tag){
              appendTags(tag);
            });
          }
        })
        .fail(function(){
          alert("検索できませんでした");
        });
      }
      else {
        tag_container.empty();
      }
    });
  });
});