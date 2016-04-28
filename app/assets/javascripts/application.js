// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require select2
//= require jquery
//= require bootstrap-switch
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require script
//= require_tree .

//Select2
 function ready_qbe(){
            $(".endorsement").select2();
          }
        $(document).ready(ready_qbe);
        $(document).on('page:load', ready_qbe);


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










