$(document).on 'ready page:load', ->
  # 1. Enable foundation js

  $(document).foundation()

  # 2. Input for avatar functionality

  # For each .file element
  $('.file').each ->
    # Save some elements as variables
    $element = $(this)
    $input = $element.find('input')
    $value = $element.find('.file-value')
    # Bind event handlers to <input>
    $input.on
      # On change, update the visible elements
      change: ->
        # Get the value of the input
        val = $input.val()
        # Normalize strings
        val = val.replace(/\\/g, '/')
        # Remove the path
        val = val.substring(val.lastIndexOf('/') + 1)
        # Toggle the 'active' class based
        # on whether or not there is a value
        $element.toggleClass 'active', ! !val.length
        # Set the value text accordingly
        $value.text val
        return
      # On focus, add the focus class
      focus: ->
        $element.addClass 'focus'
        return
      # On blur, remove the focus class
      blur: ->
        $element.removeClass 'focus'
        return
    return
  return
