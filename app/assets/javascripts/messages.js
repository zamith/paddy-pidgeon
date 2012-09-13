$ ->
  messages_counter =
    $field: $("#message_text")

    count: ->
      $field.on 'keypress', (event) ->
        console.log ($field.text().length/160)+1