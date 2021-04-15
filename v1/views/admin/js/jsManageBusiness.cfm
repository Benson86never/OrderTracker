
<link href = "https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.20/css/dataTables.bootstrap.min.css" rel = "stylesheet">
<script src = "https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.20/js/jquery.dataTables.min.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.20/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">

  
  $('.deactivateBusiness').click(function(){
      var businessId = $(this).attr('businessId');
      var businessname = $(this).attr('businessname');
      $('#modal-showAlert .modal-title').html('Deactivate Business');
      $('#modal-showAlert .modal-header').addClass('alert-danger');
      $('#modal-showAlert .modal-body').html('Are you sure you want to deactivate the Business "' + businessname + '"?');
      $('#modal-showAlert .modal-footer .ok').hide();
      $('#modal-showAlert .modal-footer .yes').show();
      $('#modal-showAlert .modal-footer .no').show();
      $('#modal-showAlert .modal-footer .yes').click(function(){
        $.ajax({
          url: '../v1/model/services/admin.cfc?method=manageBusiness',
          type: 'post',
          data: {
            businessId : businessId,
            active: 0
          },
          success: function(data){
            location.reload();
          }
        });
      });
      $('#modal-showAlert').modal('show');
  });
  
  $('.reactivateBusiness').click(function(){
      var businessId = $(this).attr('businessId');
      var businessname = $(this).attr('businessname');
      $('#modal-showAlert .modal-header').addClass('alert-success');
      $('#modal-showAlert .modal-title').html('Reactivate Business');
      $('#modal-showAlert .modal-body').html('Are you sure you want to reactivate the Business "' + businessname + '"?');
      $('#modal-showAlert .modal-footer .ok').hide();
      $('#modal-showAlert .modal-footer .yes').show();
      $('#modal-showAlert .modal-footer .no').show();
      $('#modal-showAlert .modal-footer .yes').click(function(){
        $.ajax({
          url: '../v1/model/services/admin.cfc?method=manageBusiness',
          type: 'post',
          data: {
            businessId : businessId,
            active: 1
          },
          success: function(data){
            location.reload();
          }
        });
      });
      $('#modal-showAlert').modal('show');
  });
  $('#status').change(function(){
    location.href = 'index.cfm?action=admin.manageBusiness&status=' + $(this).val();
  });
</script>