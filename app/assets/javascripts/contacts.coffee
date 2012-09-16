$ ->
  tokeninput =
    $field: $("#groups")
    loaded: false

    addGroup: (group) ->
      console.log group

    inputify: (groups) ->
      tokeninput.$field.tokenInput groups,
        minChars: 2,
        onAdd: tokeninput.addGroup,
        disableCache: true,
        noResultsText: "No groups found.",
        hintText: "Type in a group name."

    getGroups: ->
      if not tokeninput.loaded
        $.getJSON "/admin/groups/available", (data) ->
          tokeninput.inputify data
          tokeninput.loaded = true

    init: ->
      tokeninput.getGroups()

  tokeninput.init() if window.location.pathname == "/admin/contacts/new"

    