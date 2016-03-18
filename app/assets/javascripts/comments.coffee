# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->

  $('#comments').on 'click', '.comment-close', (e)->
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      method:"DELETE"
      url: $(this).attr("href")
      dataType: "json"
      success: (data)->
        $("#comment-"+data.id).fadeOut()
  
  if($(".endless-scroll").length)
    $(window).scroll ->
      console.log($(window).scrollTop())
      console.log $(document).height()
      url = $('.pagination .next').children(":first").attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html('</br><i style="font-size: 40px;" class="fa fa-spinner fa-pulse"></i>')
        $.getScript(url)
    $(window).scroll()
  else
    $(window).unbind('scroll')
     
  if($(".message-modal-opener").length)
    $(".message-modal-opener").on 'click', ->
      $(".message_modal").modal('toggle') 
