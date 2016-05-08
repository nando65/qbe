//Select2
 function ready_qbe(){
            $(".endorsement").select2();
          }
        $(document).ready(ready_qbe);
        $(document).on('page:load', ready_qbe);

 function ready_display(){
            $(".select2-search").keydown(function(){

              $(".select2-results").css("display", "block");
               var value=$.trim($(".select2-search input").val());

              if(value.length<2)
              {
               $(".select2-results").css("display", "none");
              }
      });

          }
        $(document).ready(ready_display);
        $(document).on('page:load', ready_display);

function search_bar() {
    $('.searchBar').click(function() {
      var a = document.location.href.split('/');
      if( a[ a.length - 1 ].indexOf('search') < 0){
        //Turbolinks.visit("/search");
        window.location.href = '/search';
        $('#searchInput').focus(), 500;

        // document.getElementById('input').focus();
      }
    });
}
$(document).ready(search_bar);
$(document).on('page:load', search_bar);



// function search() {
//     $('.searchBar input').keydown(function() {
//       $.ajax('/search/search',{
//         data: {query: $(this).val() },
//         success: function(data){
//           $('.tab-pane.active').html('');
//           for(var i = 0 ; i < data.users.length ; i++){
//             $('.tab-pane.active').append('<div class="title-subtitle-search">' + data.users[i].first_name+" "+data.users[i].last_name+'</div>');
//           }
//         }
//       });
//     });
// }
// $(document).ready(search);
// $(document).on('page:load', search);

function search_people() {
    $('.searchBar input').keydown(function() {
      $.ajax('/search/search_people',{
        data: {query: $(this).val() },
        success: function(result){
              $('#people').html(result);
            }

      });
    });
}
$(document).ready(search_people);
$(document).on('page:load', search_people);

function search_virtue() {
    $('.searchBar input').keydown(function() {
      $.ajax('/search/search_virtue',{
        data: {query: $(this).val() },
        success: function(result){
              $('#virtue').html(result);
            }

      });
    });
}
$(document).ready(search_virtue);
$(document).on('page:load', search_virtue);