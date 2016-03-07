# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  preview = $('.upload-preview img')

  $('.card-image img').each ->
    imageClass = this.width/this.height > 1 ? 'wide' : 'tall';
    $(this).addClass(imageClass)

  $('#auction_picture').bind 'change', (e) ->
    input = $(e.currentTarget)
    file = input[0].files[0]
    size_in_megabytes = file.size/1024/1024
    if size_in_megabytes > 5
      alert 'Maximum file size is 5MB, please choose a smaller file'
    else 
      reader = new FileReader()
      reader.onload = (e) ->
        image_base64 = e.target.result
        preview.attr 'src', image_base64
      reader.readAsDataURL(file)   
