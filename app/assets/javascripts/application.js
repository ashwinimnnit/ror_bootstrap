// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//=require_tree .

  function RemoveUser(id){
    var confirmation = confirm('Are You sure to delete this member ?')
      if (confirmation){
        $.ajax({
          type: 'post',
          url: '/check/to_delete_id',
          data: { key: id },
          success: function(data){
            $('#'+id).remove();
            console.log('#usere'+id)
            $('#usere-'+id).remove();
          }
        });
      }
  }


  function ForaAotucompleteFiled(availableTags){
    $('#data-set').html('');
      $(function(){
        $('#role_userole').autocomplete({
        source: availableTags,
        })
        .autocomplete('instance')
        ._renderItem = function( ul, item ){
          return $('<div>')
          .append( "<input type='checkbox' name= users[] value = " + item.id + '>' +
          item.firstname + item.lastname + '(' + item.email + ')' + '</input>')
          .appendTo( '#data-set' );
        };
      });
  }

  function EditUser(){
    $('.usero').hide();
    $('.usere').show();
    $('#update-usr').show();
    $('#userebuton').hide();
  }

    function CheckUserEmail(){
      if (validateEmail()){
        user_email = $( "#user_email" ).val()
        $.post( "check_availability/email", { email: user_email },
        function(data){
          if (data.length){
             if ($('#email-validation').length == 0){
               node = "<span class = 'email-validation' id = 'email-validation'> Email Alerady Exist </span>"
               $('#user_email').after(node);
             }
             return false
          }
          else{
            $('#email-validation').remove()
          }
        });
      }
    }

  function validateEmail(){
    var x = $('#user_email').val();
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
      if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
        return false;
      }
      else {
        return true;
      }
  }

  $( document ).on('page:change',(function() {
    $("#change-picture").click(function() {
     $("#update_pic").show()
    });
  }));

  function AjaxUpdateImage(url,id) {
      var dataToSend = new FormData($('#'+id)[0]);
      var f = dataToSend.get('user[avatar]')
      $.ajax({
           type: "POST",
           url: url,
           processData: false, // Don't process the files
           contentType: false, // Set content type to false as jQuery will tell the server its a query string request
           data: dataToSend, // serializes the form's elements.
           success: function(data){
               display_image(f)
           },
           error: function (data)
           {
                console.log(data)
           }
      })
  }

  function display_image(input) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#dis-img')
        .attr('src', e.target.result)
        .width(225)
        .height(300);
      };
      reader.readAsDataURL(input);
  }

  //$(document).on('page:change', function() { alert ('hiee world') })

