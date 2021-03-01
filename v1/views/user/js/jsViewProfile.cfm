
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<script>
$(document).ready(function(){
    //When page loads 
   // getAddress();
    //onchange
    /*$("#subAccount").change(function(){ 
        getAddress();
    });*/

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
             var passwordRegex = /([A-Z0-9a-z_-][^@])+?@[^$#<>?]+?\.[\w]{2,4}/.test($('#Email').val());
        }
         var emailRegex = /([A-Z0-9a-z_-][^@])+?@[^$#<>?]+?\.[\w]{2,4}/.test($('#Email').val());
        var dynamicFields = "Below fields are missing: <br/><br/>"
        if($("#firstName").val() === "" || $("#lastName").val() === "" || $("#Email").val() === "" || $("#password").val()!=="" || $("#cpassword").val()!=="" ||($("#password").val()!=="" && $("#password").val()!=="" && ($("#password").val() !== $("#cpassword").val())) || ($("#Email").val() !== "" && emailRegex === false) || ($("#password").val()!=="" && passwordRegex === false)){
            dynamicFields += ($("#firstName").val() === "" ? "Please enter first name <br/>" : "");
            dynamicFields += ($("#lastName").val() === "" ? "Please enter last name <br/>" : "");
            dynamicFields += ($("#Email").val() === "" ? "Please enter Email <br/>" : "");
            dynamicFields += (emailRegex === false && $("#Email").val() !== ""? "Please enter correct email <br/>" : "");
            dynamicFields += ($("#password").val() === "" ? "Please enter Password <br/>" : "");
            dynamicFields += (passwordRegex === false && $("#password").val() !== ""? "Password should contain Uppercase letters, Lowercase letters,Numbers and Symbol <br/>" : "");
            dynamicFields += ($("#cpassword").val() === "" ? "Please enter confirm Password <br/>" : "");
            dynamicFields += ($("#password").val()!=="" && $("#password").val()!=="" && ($("#password").val() !== $("#cpassword").val()) === "" ? "Pasword and  confirm Password should be same <br/>" : "");
        }
       if(dynamicFields === "Below fields are missing: <br/><br/>"){
           $('#formSubmit').submit();
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

    $('#phoneExtension').keypress(function(event){
       if(event.which > 57 || event.which < 48){
           event.preventDefault();
       }
   });


});

function getAddress(){
    $.ajax({
        url : 'http://localhost:8500/ordertracker/v1/model/services/admin.cfc?method=getAdressDetails',
        type: "get",
        async : false,
        data: {
            "subAccountId" : $('#subAccount').val()
        },
        success: function (rawData){
            let parsedData = $.parseJSON(rawData)["DATA"];
            $("#address1").val(parsedData[0][0]);
            $("#address2").val(parsedData[0][1]);
            $("#Zip").val(parsedData[0][2]);
            $("#City").val(parsedData[0][3]);
            $("#state").val(parsedData[0][4]);
            $("#country").val(parsedData[0][5]);
        },
        error: function (xhr) {
            console.log('Sorry, there was an error: ' + xhr.responseText);
        }
    });
}
</script>