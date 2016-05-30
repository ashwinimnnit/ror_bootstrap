var VIEW = (function()
{
  FUNCTIONS = 
  {
    ChangeSrcAfterImageUpload: function (data)
      {
        $("#dis-img").attr("src", "/system/users/"+data.user+"/medium/"+data.img+"")
        $("img.user-thumb").attr("src", "/system/users/"+data.user+"/thumb/"+data.img+"")

     }
  }
 return FUNCTIONS
})();
