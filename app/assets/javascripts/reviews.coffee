# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->

  $('#reviews').on 'click', '.comment-close', (e)->
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      method:"DELETE"
      url: $(this).attr("href")
      dataType: "json"
      success: (data)->
        $("#review-"+data.id).fadeOut()
