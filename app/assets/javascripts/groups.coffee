$ ->
  tokeninput =
    $field: $("#contacts")
    loaded: false
    group_id: window.location.pathname.match(/\d+/)

    addContact: (contact) ->
      console.log contact

    getContacts: ->
      if not tokeninput.loaded
        $.getJSON "/admin/contacts/available?group=#{tokeninput.group_id}", (data) ->
          tokeninput.inputify data.available_contacts, data.existing_contacts
          tokeninput.loaded = true

    inputify: (available_contacts, existing_contacts) ->
      tokeninput.$field.tokenInput available_contacts,
        minChars: 2,
        onAdd: tokeninput.addContact,
        disableCache: true,
        noResultsText: "No contacts found.",
        hintText: "Type in a user name.",
        prePopulate: existing_contacts

    init: ->
      tokeninput.getContacts()

  hints_tooltip =
    $field: $("#hint")

    init: ->
      hints_tooltip.$field.tooltip
        effect: "fade",
        opacity: 0.7,
        position: "center right",
        offset: [-2, 10]

  tokeninput.init() if window.location.pathname.indexOf("groups") != -1
  hints_tooltip.init()
