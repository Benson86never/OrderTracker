
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<script>
$(document).ready(function(){

    
    if($('#password').val() !== "********"){
        $('#showPaasword').show();
    }
    else{
        $('#showPaasword').hide();
    }

    $("#showPaasword").click(function(){
        var password = document.getElementById("password");
        if (password.type === "password") {
            password.type = "text";
        } else {
            password.type = "password";
        }
    });

    $('#save').click(function(){ 
        if($('#password').val() === "********"){
             var passwordRegex = true;
        }
        else{
              var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/.test($('#password').val());
        }
        var emailRegex = /([A-Z0-9a-z_-][^@])+?@[^$#<>?]+?\.[\w]{2,4}/.test($('#Email').val());
        var dynamicFields = "Below fields are missing: <br/><br/>"
        if( $("#password").val()!=="" || $("#cpassword").val()!=="" || ($("#password").val()=="" && $("#password").val()=="") || ($("#password").val()!=="" && $("#password").val()!=="" && ($("#password").val() !== $("#cpassword").val()))  || ($("#password").val()!=="" && passwordRegex === false)){
                    
            dynamicFields += ($("#password").val() === "" ? "Please enter Password <br/>" : "");
            dynamicFields += (passwordRegex === false && $("#password").val() !== ""? "Password should contain Uppercase letters, Lowercase letters,Numbers and Symbol <br/>" : "");
            dynamicFields += ($("#cpassword").val() === "" ? "Please enter confirm Password <br/>" : "");
            dynamicFields += ($("#password").val()!=="" && $("#password").val()!=="" && ($("#password").val() !== $("#cpassword").val()) === "" ? "Pasword and  confirm Password should be same <br/>" : "");
        }
       if(dynamicFields === "Below fields are missing: <br/><br/>"){
             
            $('#modal-showAlert').modal('show');             
            $('.modal-header').css('background-color','white');
            $('#headerText').html('Password Information');
            $('.close').css('color','black');
            $('#modal-showAlert .modal-body').html("Your Password Successfully Changed.");       
            $('#modal-showAlert .modal-footer .ok').show();    
            $('#modal-showAlert .modal-footer .yes').hide();
            $('#modal-showAlert .modal-footer .no').hide();   
             $('.ok').click(function()
             {
                $('#formSubmit').submit();
             });
               
             
          //

       }
       else{
          //alert(dynamicFields);
            $('#modal-showAlert').modal('show');
            $('.modal-header').css('background-color','white');
            $('#headerText').html('Missing Information');
            $('.close').css('color','black');
            $('#modal-showAlert .modal-body').html(dynamicFields);
            $('#modal-showAlert .modal-footer .ok').show();
            $('#modal-showAlert .modal-footer .yes').hide();
            $('#modal-showAlert .modal-footer .no').hide();
       }
    });

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

     $('#password').on('blur', function(){
      if(this.value != '********') {
        $('#showPaasword').show();
        var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/.test(this.value);
        if(!passwordRegex) {
            $('#password').css("border-color","red");
        } 
        else{
            $('#password').css("border-color","");
        }
      }
      else{
           $('#showPaasword').hide();
      }
    });
});
</script>