
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<script>
$(document).ready(function(){    
    $('#save').click(function(){ 

        var emailRegex = /([A-Z0-9a-z_-][^@])+?@[^$#<>?]+?\.[\w]{2,4}/.test($('#email').val());
        var dynamicFields = "Below fields are missing: <br/><br/>"

        if($("#firstName").val() === "" || $("#subject").val() === "" || $("#email").val() === "" || $("#description").val() === "" || ($("#email").val() !== "" && emailRegex === false) ){
            dynamicFields += ($("#firstName").val() === "" ? "Please enter first name <br/>" : "");
            dynamicFields += ($("#subject").val() === "" ? "Please enter subject <br/>" : "");
            dynamicFields += ($("#description").val() === "" ? "Please enter issue description <br/>" : "");
            dynamicFields += ($("#email").val() === "" ? "Please enter Email <br/>" : "");
            dynamicFields += (emailRegex === false && $("#email").val() !== ""? "Please enter correct email <br/>" : "");
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
});

</script>