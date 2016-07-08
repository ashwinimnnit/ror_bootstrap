(function($,W,D)
  {
    var JQUERY4U = {};
    JQUERY4U.UTIL =
    {
        setupFormValidation: function()
        {    //form validation rules
            $(".new_user").validate({
                rules: {
                    "user[firstname]": "required",
                    "user[lastname]": "required",
                    "user[email]": {
                        required: true,
                        email: true
                    },
                    "user[password]": {
                        required: true,
                        minlength: 8
                    },
                    agree: "required",
                   "user[password_confirmation]": {
                        required: true,
                        minlength:8,
                        equalTo: "#user_password"    
                     },
                     "user[avatar]": {
                        required: false,
                        extension: "jpg|gif|jpeg"
                     }
                },
                messages: {
                    "user[firstname]": "Please enter your firstname",
                    "user[lastname]": "Please enter your lastname",
                    "user[password]": {
                        required: "Please enter a password",
                        minlength: "Your password must be at least 8 characters long"
                    },
                    "user[password_confirmation]": {
                        required: "Please enter a confirm password",
		        minlength: "Your password must be at least 8 characters long",
                        equalTo: "Confirm Password doesn't match with Pasword"
                    },
                    "user[email]": {
                       required: "Please enter your email id" 
                     },
                    "user[avatar]": "File must be PNG, JPG, GIF "       
                },
                submitHandler: function(form) {
                    form.submit();
                }
            });
        }
        
  }

 $( document ).on('page:change',(function() {
        JQUERY4U.UTIL.setupFormValidation();
/* $(".new_user").validate({
                rules: {
                    "user[firstname]": "required",
                    "user[lastname]": "required",
                    "user[email]": {
                        required: true,
                        email: true
                    },
                    "user[password]": {
                        required: true,
                        minlength: 8
                    },
                    agree: "required",
                   "user[password_confirmation]": {
                        required: true,
                        minlength:8,
                        equalTo: "#user_password"
                     },
                     "user[avatar]": {
                        required: false,
                        extension: "png|jpg|gif|jpeg"
                     }
                },
                messages: {
                    "user[firstname]": "Please enter your firstname",
                    "user[lastname]": "Please enter your lastname",
                    "user[password]": {
                        required: "Please enter a password",
                        minlength: "Your password must be at least 8 characters long"
                    },
                    "user[password_confirmation]": {
                        required: "Please enter a confirm password",
                        minlength: "Your password must be at least 8 characters long",
                        equalTo: "Confirm Password doesn't match with Pasword"
                    },
                    "user[email]": {
                       required: "Please enter your email id"
                     },
                    "user[avatar]": "File must be PNG, JPG, GIF "
                },
                submitHandler: function(form) {
                    form.submit();
                }
            });*/

    }));

})(jQuery, window, document);

