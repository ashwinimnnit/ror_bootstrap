var VIEW = (function()
{
  FUNCTIONS = 
  {
    ChangeSrcAfterImageUpload: function(data)
      {
        $("#dis-img").attr("src", "/system/users/"+data.user+"/medium/"+data.img+"")
        $(".header-img .user-thumb").attr("src", "/system/users/"+data.user+"/thumb/"+data.img+"")

     },

    ChatSilder: function()
     {
   
     },
    
    AppendChat: function(chat, css = "show-chat", chatbox)
    { 
     node = "<div class = 'gc'><span class = "+css+"> "+chat+" </span></div><br/>"
     $("div[channel = '"+chatbox+"'] #message_display").append(node)
    },

    ChatBoxExist: function(Channel)
     {
       var len = $("a[channel ='"+Channel+"'], div[channel ='"+Channel+"']").length
       flag = (len == 1) ? true : false
       return flag
     },

    RemoveChatBox: function(chatbox)
    { 
      $("div[channel = '"+chatbox+"'].chat-box").remove()
    }


  }
 return FUNCTIONS
})();


$( document ).on('page:change',(function() {
   $(document).on('click', '#chat_header', function(){
    var channel = $(this).attr("room")
    $("#"+channel+"").slideToggle("fast");
 })

 $(".messlist .cl").click(function() {
   var Channel = $(this).attr("channel")
   if (VIEW.ChatBoxExist(Channel))
   {
     API.GetChatBox($(this).attr("channel"))
   }
  })

 $(document).on('click',".cls-chat", function(){
   VIEW.RemoveChatBox($(this).parent().attr("channel"))
 })
}));
