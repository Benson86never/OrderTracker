
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
                $('#formSubmit').submit();          
       }
       else{
            if ($("#password").val() == "" && 	$("#cpassword").val() == "")
			{
				 $("#password").css('border-color', 'red');		
				 $("#cpassword").css('border-color', 'red');		
				 $("#errorPasswordText").css({'color':'red','display':'block'});	
				 $("#errorcPasswordText").css({'color':'red','display':'block'});	
		    }			 
			else if( $("#password").val() == "" )
			{ 
				 $("#password").css('border-color', 'red');	
				 $("#errorPasswordText").css({'color':'red','display':'block'});
				 $("#password").focus();	
				 	
			}
			else if ($("#cpassword").val() == "")
			{			
				 $("#cpassword").css('border-color', 'red');	
			     $("#errorcPasswordText").css({'color':'red','display':'block'});
				  $("#cpassword").focus();	
			}  
			else
		   {
			     if ($("#password").val() ===	$("#cpassword").val() )
               {
                      $('#formSubmit').submit();      
               }
               else
               {
                      $("#errorMessage").css({'color':'red','display':'block'});
               }		     
		   }             			     
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
       
      }
      else{
           $('#showPaasword').hide();
      }
    });

     $("#password").focusin(function(){  

        if($("#errorPasswordText").is(":visible") === true )
        {
	    	$("#password").css('border','1px solid red');
	    	$("#password").attr("placeholder",'');
	    	$("#labelPassword").css({'color':'red','display':'block'});
        }
        else
        {
        	$("#password").css('border','1px solid #0095ff');
		    $("#password").attr("placeholder",'');
		    $("#labelPassword").css({'color':'#0095ff','display':'block'});
        }		
	});

    $("#password").focusout(function(){  
        if($("#errorPasswordText").is(":visible") === true )
        {
		    $("#password").css('border','1px solid red');
		   if($("#password").val() === '')
			{
				$("#labelPassword").css({'color':'red','display':'none'});
			}
			else
			{
				$("#labelPassword").css({'color':'red','display':'block'});
			}
		    $("#password").attr("placeholder",'Password');
        }
        else
        {
            $("#password").css('border','1px solid #C0C0C0');
		    if($("#password").val() === '')
			{
				$("#labelPassword").css({'color':'#C0C0C0','display':'none'});
			}
			else
			{
				$("#labelPassword").css({'color':'#C0C0C0','display':'block'});
			}
		    $("#password").attr("placeholder",'Password');
        }		
	});

     $("#cpassword").focusin(function(){  

        if($("#errorcPasswordText").is(":visible") === true )
        {
	    	$("#cpassword").css('border','1px solid red');
	    	$("#cpassword").attr("placeholder",'');
	    	$("#labelcPassword").css({'color':'red','display':'block'});
        }
        else
        {
        	$("#cpassword").css('border','1px solid #0095ff');
		    $("#cpassword").attr("placeholder",'');
		    $("#labelcPassword").css({'color':'#0095ff','display':'block'});
        }		
	});

    $("#cpassword").focusout(function(){  
        if($("#errorcPasswordText").is(":visible") === true )
        {
		    $("#cpassword").css('border','1px solid red');
		   if($("#cpassword").val() === '')
			{
				$("#labelcPassword").css({'color':'red','display':'none'});
			}
			else
			{
				$("#labelcPassword").css({'color':'red','display':'block'});
			}
		    $("#cpassword").attr("placeholder",'Confirm Password');
        }
        else
        {
            $("#cpassword").css('border','1px solid #C0C0C0');
		     if($("#cpassword").val() === '')
			{
				$("#labelcPassword").css({'color':'#C0C0C0','display':'none'});
			}
			else
			{
				$("#labelcPassword").css({'color':'#C0C0C0','display':'block'});
			}
		    $("#cpassword").attr("placeholder",'Confirm Password');
        }		
	});
});
</script>