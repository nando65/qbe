function ready(){

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

  $('.show-more-comments-link').click(function(){
    var lc = $(this).siblings('.last-comment').val();
    var pi = $(this).siblings('.post-info').val();
    var sml = $(this);
    $.ajax('/comments/get_next_three',{
      data: {
        post_id: pi,
        last_comment: lc,
      },
      success: function(data){
        if( !data.html ){
          //alert('There are no more comments to load.');
          sml.fadeOut(function(){
            sml.prop('style','display:none !important');
          });
        }
        sml.parents('.comments').find('.comment-body:last').after(data.html);
        sml.siblings('.last-comment').val( data.new_last_comment );
      }, error: function(){
        alert('Sorry, could not load new comments. Please try again.');
      },
      method: 'post'
    });
    return false;
  });

}

$(document).ready(ready);
$(document).on('page:load', ready);


