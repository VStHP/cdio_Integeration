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
      $('#course-description').show(400);
    }
    else{
      $('#course-description').hide(400);
    }
  });
  $(document).on('click', '#show-details', function(){
    if( $('#details').css("display") == "none"){
      $(this).text('close');
      $('#details').show(500);
    }
    else{
      $(this).text('Show details');
      $('#details').hide(500);
    }
  });
  $(document).on('click', '#video-open', function(){
    var task_id = $(this).val();
    if( $('#video_task' + task_id).css("display") == "none"){
      $('#video_task' + task_id).show(400);
      $(this).removeClass('fa-caret-square-o-right');
      $(this).addClass('fa-times');
    }else{
      $('#video_task' + task_id).hide(400);
      $(this).removeClass('fa-times');
      $(this).addClass('fa-caret-square-o-right');
    }
  });
  $(document).on('click', '#catalogy-task', function(){
    if( $('#task-content').css("display") == "none"){
      $(this).removeClass('fa-angle-double-right');
      $(this).addClass('fa-angle-double-down');
      $('#task-content').show(600);
    }else{
      $(this).removeClass('fa-angle-double-down');
      $(this).addClass('fa-angle-double-right');
      $('#task-content').hide(600);
    }
  });
  $(document).on('click', '#catalogy-link', function(){
    if( $('#link-content').css("display") == "none"){
      $(this).removeClass('fa-angle-double-right');
      $(this).addClass('fa-angle-double-down');
      $('#link-content').show(600);
    }else{
      $(this).removeClass('fa-angle-double-down');
      $(this).addClass('fa-angle-double-right');
      $('#link-content').hide(600);
    }
  });
  $(document).on('click', '#registry', function(){
    var elmnt = document.getElementById("registry-div");
    elmnt.scrollIntoView({ behavior: 'smooth' });
  });
});
