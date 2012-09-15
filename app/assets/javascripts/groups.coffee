$ ->
  tokeninput =
    $field: $("#contacts")

    addContact: (contact) ->
      console.log contact

    inputify: (contacts) ->
      tokeninput.$field.tokenInput contacts,
        minChars: 2,
        onAdd: tokeninput.addContact,
        disableCache: true,
        noResultsText: "No unselected contacts found...",
        hintText: "Type a user name to be selected..."

    getContacts: ->
      $.getJSON "/admin/contacts/available", (data) ->
        tokeninput.inputify data

    init: ->
      tokeninput.getContacts()

  tokeninput.init()

    