$( document ).on('page:change',(function() 
  {
    $(".notify").click(function(event) {
     event.preventDefault();
   var client = new Faye.Client('http://localhost:9292/faye');
   $.get("/chatroom", function (data) 
   {
     var UserId = data.user
     client.subscribe("/message/"+UserId+"", function(data) 
     {
        $('.bubble').html(data)
        $('.bubble').css("display", "block")
     });
   })
   API.SendRequest($(this).find("a").attr("href"))
   });
}));

