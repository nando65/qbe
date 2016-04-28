# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).on "page:change", ->
  $('#people-link').click (event) ->
    event.preventDefault()
    $( $(this).data('link') ).fadeToggle()

$(document).on "page:change", ->
  $('#virtue-link').click (event) ->
    event.preventDefault()
    $( $(this).data('link') ).fadeToggle()


