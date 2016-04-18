$(document).ready(function(){



  $('.new_comment').on("ajax:success", function(e, data, status){

    $(this).replaceWith($(data));

  }).on("ajax:error", function(e, xhr, status, error){
    console.log(error);
  });



});