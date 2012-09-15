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
        noResultsText: "No contacts found.",
        hintText: "Type in a user name."

    getContacts: ->
      $.getJSON "/admin/contacts/available", (data) ->
        tokeninput.inputify data

    init: ->
      tokeninput.getContacts()

  tokeninput.init()

    