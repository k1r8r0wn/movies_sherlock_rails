# when the page is ready for manipulation
$(document).ready ->
# when the load more link is clicked
  $('a.load_more').click (e) ->
# prevent the default click action
    e.preventDefault()
    # hide load more link
    $('.load_more').hide()
    # show the loading icon
    $('.loading_icon').show()
    # get the last id and save it in a variable 'last-id'
    last_id = $('.user_movie').last().attr('data-id')
    # make an ajax call passing along our last users movie id
    $.ajax
      type: 'GET'
      url: $(this).attr('href')
      data: id: last_id
      dataType: 'script'
      success: ->
        # hide the loading icon
        $('.loading_icon').hide()
        # show our load more link
        $('.load_more').show()
        return
    return
  return
