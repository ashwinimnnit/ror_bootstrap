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
