$(function(){
  // 再生処理
  $(document).on('click', '.track__audio__button', function() {
    let audio = $(this).siblings('.prev-audio')[0]
    audio.play();
    $(this).hide()
    $(this).siblings('.track__audio__button--stop').show();

    // 再生終了時のリセット処理
    audio.addEventListener('ended', function(){
      audio.pause();
      audio.currentTime = 0;
      $(this).siblings('.track__audio__button--stop').hide();
      $(this).siblings('.track__audio__button').show();
    }, false)
  });

  // 一時停止処理
  $(document).on('click', '.track__audio__button--stop', function() {
    $(this).siblings('.prev-audio')[0].pause();
    $(this).hide()
    $(this).siblings('.track__audio__button').show();
  });
});
