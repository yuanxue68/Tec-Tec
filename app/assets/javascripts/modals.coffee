$(document).on "page:change", ->
  if($(".message-modal-opener").length)
    $(".message-modal-opener").on 'click', ->
      $(".message_modal").modal('toggle') 
