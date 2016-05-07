function search_people_per_attribute() {

  //$('.attribute-link').click(function(){$.ajax('search/search_people'), function(data){$("#people").html(data);}});

           //   $.ajax('/search/search_people',{

           //
           //
           //              }

           //        });

           // }});


    // $('.searchBar input').keydown(function() {
    //   $.ajax('/search/search_people',{
    //     data: {query: $(this).val() },
    //     success: function(result){
    //           $('#people').html(result);
    //         }

    //   });
    // });
}
$(document).ready(search_people_per_attribute);
$(document).on('page:load', search_people_per_attribute);