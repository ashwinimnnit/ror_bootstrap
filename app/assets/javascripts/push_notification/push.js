$( document ).on('page:change',(function() 
  {
   var client = new Faye.Client('http://localhost:9292/faye');
   $.get("/chatroom", function (data) { 
   console.log(data)
   client.subscribe("/message/"+data.user+"", function(data) {
    eval(data);
  });
 })

}));

