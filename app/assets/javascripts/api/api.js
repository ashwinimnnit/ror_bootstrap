var API =  (function()
 {
  UTILS =
  {
    CheckEmailAvailability: function()
     {
       user_email = $( ".new_user #user_email" ).val()
       $.post( "check_availability/email", { email: user_email },function(data){
       $('#inprogess').remove()
       $('.new_user #commit').removeAttr('disabled');
            node = "<span class = 'email-validation' id = "+data.notice_class+" > "+data.message+" </span>"
             $('#user_email').after(node);
        });
     },
    
    UpdateUserImageFromFb: function()
     {
        $.post( "getuser/image", function( data ) {
          alert( "Image updated successfully" );
          VIEW.ChangeSrcAfterImageUpload(data)
        });

     },

     RemoveUser: function(value)
      {
       $.post( "/check/to_delete_id/" , { key: value }, function(data){
       $('#'+data).remove();
       $('#usere-'+data).remove();
      });
      },
 
   SendRequest: function(uri, data = "some default data")
   { 
       cookiee = PUSHER.GetCookiee("user")
       SenderId = cookiee
       notification = data
       $.post("/notifications", { url: uri, data: notification, sender: SenderId }, function(data){
       })
   },

   GetNotifications: function()
   {
    $.get("/getnotifications", function(data){
      console.log(data)
    })
   },
   
   GetChatBox: function(channel)
   {
    var html;
    sender = PUSHER.GetCookiee("user")
    $.ajax({
     url : "/chatroom",
     type: "GET",
     data: {url: channel},
     async: false,
     success: function(data){
     html = data
     }
     })
   return html
  }
  }
 return UTILS;
})();
