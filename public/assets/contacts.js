(function(){$(function(){var e;e={$field:$("#groups"),loaded:!1,contact_id:window.location.pathname.match(/\d+/),addGroup:function(e){return console.log(e)},getGroups:function(){if(!e.loaded)return $.getJSON("/admin/groups/available?contact="+e.contact_id[0],function(t){return e.inputify(t.available_groups,t.existing_groups),e.loaded=!0})},inputify:function(t,n){return e.$field.tokenInput(t,{minChars:2,onAdd:e.addGroup,disableCache:!0,noResultsText:"No groups found.",hintText:"Type in a group name.",prePopulate:n})},init:function(){return e.getGroups()}};if(window.location.pathname.indexOf("contacts")!==-1)return e.init()})}).call(this);