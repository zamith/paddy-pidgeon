$ ->
  tokeninput =
    $field: $("#contacts")
    loaded: false

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
      if not tokeninput.loaded
        $.getJSON "/admin/contacts/available", (data) ->
          tokeninput.inputify data
          tokeninput.loaded = false

    init: ->
      tokeninput.getContacts()

  tokeninput.init() if window.location.pathname.indexOf("groups") != -1

    