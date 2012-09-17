$ ->
  tokeninput =
    $field: $("#groups")
    loaded: false
    contact_id: window.location.pathname.match(/\d+/)

    addGroup: (group) ->
      console.log group

    getGroups: ->
      if not tokeninput.loaded
        $.getJSON "/admin/groups/available?contact=#{tokeninput.contact_id[0]}", (data) ->
          tokeninput.inputify data.available_groups, data.existing_groups
          tokeninput.loaded = true

    inputify: (available_groups, existing_groups) ->
      tokeninput.$field.tokenInput available_groups,
        minChars: 2,
        onAdd: tokeninput.addGroup,
        disableCache: true,
        noResultsText: "No groups found.",
        hintText: "Type in a group name.",
        prePopulate: existing_groups

    init: ->
      tokeninput.getGroups()

  tokeninput.init() if window.location.pathname.indexOf("contacts") != -1
