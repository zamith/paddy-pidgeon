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
        noResultsText: "No unselected groups found...",
        hintText: "Type a user name to be selected..."

    getGroups: ->
      $.getJSON "/admin/groups/available", (data) ->
        tokeninput.inputify data

    init: ->
      tokeninput.getGroups()

  tokeninput.init()

    