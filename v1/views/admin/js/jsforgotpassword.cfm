
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<script>
$(document).ready(function(){

        $('#save').click(function(){    
        var emailRegex = /([A-Z0-9a-z_-][^@])+?@[^$#<>?]+?\.[\w]{2,4}/.test($('#Email').val());
        var dynamicFields = "Below fields are missing: <br/><br/>"
        if( $("#Email").val() === "" || ($("#Email").val() !== "" && emailRegex === false) )
        {
              dynamicFields += ($("#Email").val() === "" ? "Please enter Email <br/>" : "");
            dynamicFields += (emailRegex === false && $("#Email").val() !== ""? "Please enter correct email <br/>" : "");
        }
       if(dynamicFields === "Below fields are missing: <br/><br/>"){
           $('#formSubmit').submit();
       }
       else{
          				
				 $("#Email").css('border-color', 'red');	
			     $("#errorEmailText").css({'color':'red','display':'block'});
			
       }
    });

    $('#Email').on('keypress,blur', function() {
        var emailRegex = /([A-Z0-9a-z_-][^@])+?@[^$#<>?]+?\.[\w]{2,4}/.test(this.value);
        if(!emailRegex) {
            $('#Email').css("border-color","red");
        } 
        else {
            $('#Email').css("border-color","");
        }
    });
   
   $("#Email").focusin(function(){  

		$("#Email").css('border','1px solid #0095ff');
		$("#Email").attr("placeholder",'');
		$("#labelEmail").css({'color':'#0095ff','display':'block'});
		
	});

$("#Email").focusout(function(){  
		$("#Email").css('border','1px solid #C0C0C0');
		$("#labelEmail").css({'color':'#C0C0C0','display':'none'});
		$("#Email").attr("placeholder",'Email');
		
	});
});


</script>