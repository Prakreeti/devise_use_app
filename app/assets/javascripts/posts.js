$(document).ready(function() {
  $('.comment-reply').on('click', function() {
    $("#replies_" + ($(this).attr('id').split("_"))[1]).toggle();
  });
  $('.reply').on('click', function() {
    $("#reply_div" + ($(this).attr('id').split("_")[1])).toggle();
  });
});