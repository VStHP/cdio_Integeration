function check_empty() {
if (document.getElementById('name').value == "" || document.getElementById('email').value == "" || document.getElementById('msg').value == "") {
alert("Fill All Fields !");
} else {
document.getElementById('form').submit();
alert("Form Submitted Successfully...");
}
}
//Function To Display Popup
function div_show() {
document.getElementById('abc').style.display = "block";
}
//Function to Hide Popup
function div_hide(){
document.getElementById('abc').style.display = "none";
}
$(document).on('click', '.pagination a', function (event) {
  event.preventDefault();
  $.getScript($(this).attr('href'));
  return false;
});
$(document).on('click', '.btn-load',function(){
  $('#img-load').show();
});
$(document).on('click', '#profile-cancel',function(){
  $('#profile-form-update').remove();
  $('#profile-content').show();
});
$(document).ready(function(){
  $('#select_all_added').change(function() {
    var checkboxes = $(this).closest('form').find(':checkbox');
    checkboxes.prop('checked', $(this).is(':checked'));
  });
  $('#select_all_adding').change(function() {
    var checkboxes = $(this).closest('form').find(':checkbox');
    checkboxes.prop('checked', $(this).is(':checked'));
  });
  $('#active-timeline').click(function(){
    if($('#member').hasClass('active')){
      $('#timeline').addClass('active');
      $('#member').removeClass('active');
    }
  });
  $('#active-member').click(function(){
    if($('#timeline').hasClass('active')){
      $('#member').addClass('active');
      $('#timeline').removeClass('active');
    }
  });
  $(document).on('click', '#show-course-description', function(){
    if( $('#course-description').css("display") == "none"){
      $('#course-description').show();
    }
    else{
      $('#course-description').hide();
    }
  });
});
