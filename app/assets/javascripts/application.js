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
//= require twitter/bootstrap
//= require turbolinks
//=require_tree .

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

  function AjaxUpdateImage(url,id) {
      var dataToSend = new FormData($('#'+id)[0]);
      var image = dataToSend.get('user[avatar]')
      $.ajax({
           type: "POST",
           url: url,
           processData: false, // Don't process the files
           contentType: false, // Set content type to false as jQuery will tell the server its a query string request
           data: dataToSend, // serializes the form's elements.
           success: function(data){
               display_image(data)
           },
           error: function (data)
           {   
               console.log (data)
           }
      })
  }

  function display_image(data) {
     if (data.message["flag"]== true)
      {
        VIEW.ChangeSrcAfterImageUpload(data) 
      }
    
    else
    {
     alert (data.message)
    }
  }

$( document ).on('page:change',(function() {

    $("#change-picture").click(function() {
     $("#update_pic").show()
    });
  
    $(".edit_user #fb_up").click(function() {
       API.UpdateUserImageFromFb()
    });

    $(".usero .del-usr.btn-link").click(function(e) 
     {
        var confirmation = confirm('Are You sure to delete this member ?')
        if (confirmation) {
          API.RemoveUser($(this).attr("value"))
        }
     });

    $(".messages-chat").click(function(event) {
     event.preventDefault();
     node = VIEW.GetHtmlOfChatBox($(this))
     $("#chat-room").addClass('show')
     $(".foot").append(node)
    });

   $(document).on('keypress', '.message_post', function(e){
    if (e.which == 13) { 
     API.SendRequest($(this).attr('channel'), $(this).val() )
     }
 });

  }));

