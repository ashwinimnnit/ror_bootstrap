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
      console.log("=================="+chatbox+"")
     node = "<div class = 'gc'><span class = "+css+"> "+chat+" </span></div><br/>"
     $("div[channel = '"+chatbox+"'] #message_display").append(node)
    },

    ChatBoxExist: function(Channel)
     {
       var len = $("a[channel ='"+Channel+"'], div[channel ='"+Channel+"']").length
        if (len == 1)
        {
          return true
        }
        else
        { 
          return false
        }
     }

  }
 return FUNCTIONS
})();


$( document ).on('page:change',(function() {
   $(document).on('click', '#chat_header', function(){ 
   $("#message_display").slideToggle("fast");
 })

 $(".messlist .cl").click(function() {
   var Channel = $(this).attr("channel")
   var flag = VIEW.ChatBoxExist(Channel)
   console.log(flag)
   if (flag)
   {
     API.GetChatBox($(this).attr("channel"))
   }
 })

 

}));
