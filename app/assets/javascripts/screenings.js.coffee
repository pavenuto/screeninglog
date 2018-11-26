# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '700px'

  film = $.urlParam('id')

  if film > 0
    console.log 'has film id'
    $('.chosen-select').val(film).trigger("chosen:updated");


$.urlParam = (name) ->
  results = new RegExp('[?&]' + name + '=([^&#]*)').exec(window.location.href)
  results[1] or 0