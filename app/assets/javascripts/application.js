// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.raty
//= require ratyrate
//= require ckeditor/init
//= require_tree .

$(document).ready(function() {
  
  var showReplies = function(){
      $(document).on('click','.comment-reply', function() {
      $("#replies_all_" + ($(this).attr('id').split("_"))[2]).toggle();
      $(this).hide();
      $("#comment_hide_" + ($(this).attr('id').split("_"))[2]).show();
    });
  };

  var hideReplies = function(){
      $(document).on('click','.comment-hide', function() {
      $("#replies_all_" + ($(this).attr('id').split("_"))[2]).toggle();
      $(this).hide();
      $("#comment_show_" + ($(this).attr('id').split("_"))[2]).show();
    });
  };    
  
  var showReplyForm = function(){
      $(document).on('click','.reply', function() {
      $("#reply_div" + ($(this).attr('id').split("_")[1])).toggle();
    });
  };

  showReplies();
  hideReplies();
  showReplyForm();
});
