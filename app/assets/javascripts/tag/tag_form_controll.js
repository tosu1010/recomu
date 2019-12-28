$(function(){

  const add_tag_button = 
  `
  <div class="review-from__tag__add-button">
    <button name="button" type="button" class="tag-button--add" id="tag-add-button">
      タグを追加
    </button>
  </div>
  `
  
  function appendTagFrom(){
    let html = 
    `
    <div class="review-form__tag__container">
      <label class="review-form__label" for="tag-field">
        タグ
      </label>
      <input class="review-form__text-field--tag" type="text" name="tags[]" id="tag-field">
      <button name="button" type="button" class="tag-button--remove" id="tag-remove-button">
        削除
      </button>
      <div class="tags-incremental">
       </div>
    </div>
    `
    $(".review-form__tag").append(html);
  }


  // タグ入力フォームを追加する
  $(document).on("click", '#tag-add-button', function(e){
    e.preventDefault();
    $(this).siblings('.tags-incremental').empty();
    let count_tag = $(".review-form__tag__container").length
    if (count_tag < 3 ){
      appendTagFrom();
      if (count_tag == 2) {
        $(this).parent().remove();
      }
    }
  });

  // タグ入力フォームを削除する
  $(document).on('click', '#tag-remove-button', function(e){
    e.preventDefault();
    let count_tag = $(".review-form__tag__container").length
    let presence_add_button = document.getElementById('tag-add-button');
    if (count_tag <= 3 && presence_add_button) {
      $(this).parent().remove();
    }
    else {
      $(this).parent().remove();
      $('.review-form__tag').after(add_tag_button);
    }
  })
});