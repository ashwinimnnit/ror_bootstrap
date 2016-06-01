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
 
   SendRequest: function(uri)
   {
     data = "Some"
     $.post("/message", { url: uri, data: data }, function(data){
     console.log(data)
     })
   }
    
  }
 return UTILS;
})();
