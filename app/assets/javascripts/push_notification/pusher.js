$( document ).ready(function() 
  {
    PUSHER.Subscription()
    $(".notify").click(function(event) {
     event.preventDefault();
     API.SendRequest($(this).find("a").attr("href"))
   });

});

