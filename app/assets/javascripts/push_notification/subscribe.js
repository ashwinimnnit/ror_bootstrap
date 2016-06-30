var PUSHER = (function()
 {
  UTILS =
  {
    Subscription: function()
    {
      var client = new Faye.Client('http://localhost:9292/faye');
       var cookiee = PUSHER.GetCookiee("user");
        var UserId = cookiee
        client.subscribe("/notification/"+UserId+"", function(data)
        { 
          $('.bubble').html(data)
          $('.bubble').removeClass("hide")
        })
       
        client.subscribe("/message/"+UserId+"", function(data)
        {
          var UserchatBox = $('#_chat-box').attr("channel")
          if (VIEW.ChatBoxExist(data.channel) )
          {
           API.GetChatBox(data.channel)
          }

          VIEW.AppendChat(data.message, "show-chat_", data.channel)
        })
    },

    GetCookiee: function(name)
    {
      console.log(typeof document.cookie)
      var CookieeObj = new Object;
      var CookieArray = document.cookie.split(";")
      for( i=0; i< CookieArray.length; i++) {
          var tmp = CookieArray[i].split("=")
          CookieeObj[tmp[0]] = tmp[1];
      }
       return CookieeObj[name]
    }
  }
  return UTILS;
 })();
