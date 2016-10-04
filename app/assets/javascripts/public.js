var showOverlay = function() {
  $("#myNav").width("100%");
},
  
closeOverlay = function() {
  $(document).on('click','.closebtn', function(){
    $("#myNav").width("0%");
  });
};

$(document).ready(function() {
  showOverlay();
  closeOverlay();
});