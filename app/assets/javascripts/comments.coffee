# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
commentHtml = (id, content)->
		comment = $('<div class="comment" id="comment-'+id+'">'+
			'<div>'+
				'<span>You </span>'+
				'<span>just now</span>'+
				'<a class="close comment-close" data-remote="true" '+
						'rel="nofollow" data-method="delete" href="/auctions/1/comments/'+id+'">'+
					'<span>×</span>'+
				'</a>'+
			'</div>'+ 
			'<div class="comment-content">'+
				content+
			'</div>'+
		'</div>')

$(document).on "page:change", ->
  $('#new_comment').on 'submit', (e)->
    comment = $(this).serialize()
    $.ajax
      method: "POST"
      data: comment
      url: $(this).attr('action')
      dataType: "json"
      error: (xhr, response, err)->
        $(".alert").remove()
        $("#comment_content").val("")
        $("#new_comment").prepend("<div class='alert alert-danger'>Failed to post comment </div>")
      success: (data)->
        $("#comment_content").val("")
        $("#comments").append(commentHtml(data.id, data.content))
        $("#comments").children(":last").hide().fadeIn()
    false

  $('#comments').on 'click', '.comment-close', (e)->
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      method:"DELETE"
      url: $(this).attr("href")
      dataType: "json"
      success: (data)->
        console.log($("#comment-"+data.id));
        $("#comment-"+data.id).fadeOut()
