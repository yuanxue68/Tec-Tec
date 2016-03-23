$(document).on "page:change", ->
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
 
