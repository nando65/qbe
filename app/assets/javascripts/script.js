$(document).ready(function(){

  $('.new_comment').on("ajax:success", function(e, data, status){
    if(data.result == 'success'){
      $(this).parents(".post-body").find('.comments').append(data.data);
      $(this).find('textarea').val('');
      var com_f = $(this);
      setTimeout(function(){

        var com = com_f.parents(".post-body").find('.comments .comment-body:last');
        $('html, body').animate({
          scrollTop: com.offset().top - 100
        }, 500);

      },100);

    }else{
      alert( data.result );
    }
  }).on("ajax:error", function(e, xhr, status, error){
    console.log(error);
  });

});