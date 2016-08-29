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
//= require tinymce-jquery
//= require social-share-button
//= require_tree .
$(document).ready(function() {

  $('.comment-reply').on('click', function() {
    $("#replies_all_" + ($(this).attr('id').split("_"))[2]).toggle();
    $(this).hide();
    $("#comment_hide_" + ($(this).attr('id').split("_"))[2]).show();
  });

  $('.comment-hide').on('click', function() {
    $("#replies_all_" + ($(this).attr('id').split("_"))[2]).toggle();
    $(this).hide();
    $("#comment_show_" + ($(this).attr('id').split("_"))[2]).show();
  });
  
  $('.reply').on('click', function() {
    $("#reply_div" + ($(this).attr('id').split("_")[1])).toggle();
  });

  $("#search-user-form").keyup(function() {
    $.get($("#search-user-form").attr("action"),
    		 $("#search-user-form").serialize(), null, "script");
    return false;
  });
  $("#search-post-form").keyup(function() {
    $.get($("#search-post-form").attr("action"),
         $("#search-post-form").serialize(), null, "script");
    return false;
  });
  $("#search-myblogs-form").keyup(function() {
    $.get($("#search-myblogs-form").attr("action"),
         $("#search-myblogs-form").serialize(), null, "script");
    return false;
  });
});
