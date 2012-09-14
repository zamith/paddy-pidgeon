$ ->
  messages_counter =
    $field: $("#message_text")
    $counter: $("#no_of_messages")

    count: (event) ->
      messages_counter.$counter.val(Math.floor(messages_counter.$field.val().length/160)+1)

    keydown: ->
      messages_counter.$field.on 'keydown', messages_counter.count

    paste: ->
      messages_counter.$field.on 'paste', messages_counter.count

    cut: ->
      messages_counter.$field.on 'cut', messages_counter.count

    init: ->
      messages_counter.keydown()
      messages_counter.paste()
      messages_counter.cut()
      $("#no_of_messages").val(0)

  messages_counter.init()