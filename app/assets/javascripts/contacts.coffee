$ ->
  tokeninput =
    $field: $("#groups")

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
      $.getJSON "/admin/groups/available", (data) ->
        tokeninput.inputify data

    init: ->
      tokeninput.getGroups()

  tokeninput.init()

    