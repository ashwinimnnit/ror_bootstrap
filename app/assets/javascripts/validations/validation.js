var VALIDATION = (function()
 {
   UTILS =
   {
      validateEmail: function()
      {
        var x = $('#user_email').val();
        var atpos = x.indexOf("@");
        var dotpos = x.lastIndexOf(".");
        if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
          return false;
         }
        else {
        return true;
        }
      },
     
      CheckAvailabilityOfEmail: function()
      { 
        $("#email_not_available").remove()
        $("#email_available").remove() 
        WaitingSignal = "<span id = 'inprogess'> Please Wait ....</span>"
        // $('#user_email').after(WaitingSignal)
        $('.new_user #commit').attr('disabled', 'disabled');
        if (VALIDATION.validateEmail()) {
           $('#user_email').after(WaitingSignal)
          API.CheckEmailAvailability()
        }
      } 
     
   }
    return  UTILS
 })();

  $( document ).on('page:change',(function() {
       $(".signup #user_email").blur(function() {
       VALIDATION.CheckAvailabilityOfEmail()
       });
   }));


