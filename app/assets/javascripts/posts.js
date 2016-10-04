var showReplies = function(){
  $(document).on('click','.comment-reply', function() {
    $("#replies_all_" + ($(this).attr('id').split("_"))[2]).toggle();
    $(this).hide();
    $("#comment_hide_" + ($(this).attr('id').split("_"))[2]).show();
  });
},

hideReplies = function(){
  $(document).on('click','.comment-hide', function() {
    $("#replies_all_" + ($(this).attr('id').split("_"))[2]).toggle();
    $(this).hide();
    $("#comment_show_" + ($(this).attr('id').split("_"))[2]).show();
  });
},    
  
showReplyForm = function(){
  $(document).on('click','.reply', function() {
    $("#reply_div" + ($(this).attr('id').split("_")[1])).toggle();
  });
};

$(document).ready(function() {
  showReplies();
  hideReplies();
  showReplyForm();  
});
