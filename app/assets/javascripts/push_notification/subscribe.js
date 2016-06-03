var PUSHER = (function()
 {
  UTILS =
  {
    Subscription: function()
    {
      var client = new Faye.Client('http://localhost:9292/faye');
      $.get("/chatroom", function (data)
      {
        var UserId = data.user
        client.subscribe("/notification/"+UserId+"", function(data)
        {
          $('.bubble').html(data)
          $('.bubble').css("display", "block")
        })
       
        client.subscribe("/message/"+UserId+"", function(data)
        {
          alert (data)
        })
      });
    }
  }
  return UTILS;
 })();
