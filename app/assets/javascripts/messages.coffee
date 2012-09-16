$ ->
  messages_counter =
    $field: $("#message_text")
    $counter: $("#no_of_messages")

    count: (size) ->
      no_chars = if messages_counter.$field.val() == "" then 0 else Math.floor(size/160)+1
      messages_counter.$counter.val(no_chars)

    keyup: ->
      messages_counter.$field.on 'keyup', (event) ->
        messages_counter.count messages_counter.$field.val().length

    paste: ->
      messages_counter.$field.on 'paste', (event) ->
        messages_counter.count messages_counter.$field.val().length + event.originalEvent.clipboardData.getData('Text').length

    cut: ->
      messages_counter.$field.on 'cut', (event) ->
        messages_counter.count messages_counter.$field.val().length - event.originalEvent.clipboardData.getData('Text').length

    init: ->
      messages_counter.keyup()
      messages_counter.paste()
      messages_counter.cut()
      $("#no_of_messages").val(0)

  messages_counter.init()