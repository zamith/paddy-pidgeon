(function(){$(function(){var e;return e={$field:$("#message_text"),$counter:$("#no_of_messages"),count:function(t){var n;return n=e.$field.val()===""?0:Math.floor(t/160)+1,e.$counter.val(n)},keyup:function(){return e.$field.on("keyup",function(t){return e.count(e.$field.val().length)})},paste:function(){return e.$field.on("paste",function(t){return e.count(e.$field.val().length+t.originalEvent.clipboardData.getData("Text").length)})},cut:function(){return e.$field.on("cut",function(t){return e.count(e.$field.val().length-t.originalEvent.clipboardData.getData("Text").length)})},init:function(){return e.$field.val()!=null&&e.count(e.$field.val().length),e.keyup(),e.paste(),e.cut()}},e.init()})}).call(this);