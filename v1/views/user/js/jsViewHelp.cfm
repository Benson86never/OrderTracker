
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<script>
$(document).ready(function(){    
    $('#save').click(function(){ 
        if( $("#description").val() == "")
        {
            $('#modal-showAlert').modal('show');             
            $('.modal-header').css('background-color','white');
            $('#headerText').html('Password Information');
            $('.close').css('color','black');
            $('#modal-showAlert .modal-body').html("Please Enter Description.");       
            $('#modal-showAlert .modal-footer .ok').show();    
            $('#modal-showAlert .modal-footer .yes').hide();
            $('#modal-showAlert .modal-footer .no').hide();                
        }
        else
        {
            $('#modal-showAlert').modal('show');             
            $('.modal-header').css('background-color','white');
            $('#headerText').html('Password Information');
            $('.close').css('color','black');
            $('#modal-showAlert .modal-body').html("Your Request has been Successfully Submitted.");       
            $('#modal-showAlert .modal-footer .ok').show();    
            $('#modal-showAlert .modal-footer .yes').hide();
            $('#modal-showAlert .modal-footer .no').hide();   
            $('.ok').click(function()
            {
               $('#formSubmit').submit();
            });   
        }                   
    });        
});

</script>