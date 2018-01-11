$(document).ready(function(){
  $('#avatarSelect').on('change',function(){
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    var imgtag = document.getElementById('avatar_image');
    imgtag.title = selectedFile.name;

    reader.onload = function(event) {
      imgtag.src = event.target.result;
    };

    reader.readAsDataURL(selectedFile);
  });
  $('#avatarCourse').on('change',function(){
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    var imgtag = document.getElementById('avatar_image_course');
    imgtag.title = selectedFile.name;

    reader.onload = function(event) {
      imgtag.src = event.target.result;
    };

    reader.readAsDataURL(selectedFile);
  });
  $('#bannerCourse').on('change',function(){
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    var imgtag = document.getElementById('banner_image_course');
    imgtag.title = selectedFile.name;

    reader.onload = function(event) {
      imgtag.src = event.target.result;
    };

    reader.readAsDataURL(selectedFile);
  });
});
