function advice(){

  $('#new_advise').on("ajax:success", function(e, data, status){
    if(data.result == 'success'){
      $(this).parents(".profile").find('.advice .advices-display').prepend(data.data);
      $(this).find('textarea').val('');
      var com_f = $(this);
      setTimeout(function(){

        var com = com_f.parents(".profile").find('.advice .advices-display #advice-body:first');
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

}

$(document).ready(advice);
$(document).on('page:load', advice);