
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<script>
$(document).ready(function(){
    $(":input").inputmask();
    $("#Phone").inputmask({"mask": "(999) 999-9999"});

    $('#Email').on('keypress,blur', function() {
        var emailRegex = /([A-Z0-9a-z_-][^@])+?@[^$#<>?]+?\.[\w]{2,4}/.test(this.value);
        if(!emailRegex) {
            $('#Email').css("border-color","red");
        } 
        else {
            $('#Email').css("border-color","");
        }
    });

    $('#phoneExtension').keypress(function(event){
       if(event.which > 57 || event.which < 48){
           event.preventDefault();
       }
   });

});

</script>