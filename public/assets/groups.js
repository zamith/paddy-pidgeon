(function(){$(function(){var e;e={$field:$("#contacts"),loaded:!1,group_id:window.location.pathname.match(/\d/),addContact:function(e){return console.log(e)},getContacts:function(){if(!e.loaded)return $.getJSON("/admin/contacts/available?group="+e.group_id,function(t){return e.inputify(t.available_contacts,t.existing_contacts),e.loaded=!0})},inputify:function(t,n){return e.$field.tokenInput(t,{minChars:2,onAdd:e.addContact,disableCache:!0,noResultsText:"No contacts found.",hintText:"Type in a user name.",prePopulate:e.existing_contacts})},init:function(){return e.getContacts()}};if(window.location.pathname.indexOf("groups")!==-1)return e.init()})}).call(this);