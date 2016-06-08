$( document ).ready(function() 
  {
    PUSHER.Subscription()
    $(".notify").click(function(event) {
     API.SendRequest($(this).find("a").attr("channel"))
   });

});

