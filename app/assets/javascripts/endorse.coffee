# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $('#add-virtue-link').click (event) ->
    event.preventDefault()
    $( $(this).data('link') ).fadeToggle()
    $( $(this).data('link') ).find('#endorse_endorsement').focus()
