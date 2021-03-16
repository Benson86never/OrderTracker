
<link href = "https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.20/css/dataTables.bootstrap.min.css" rel = "stylesheet">
<script src = "https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.20/js/jquery.dataTables.min.js"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.20/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">

  
  $('.deactivateUser').click(function(){
      var businessId = $(this).attr('businessId'); 
      $('#modal-showAlert .modal-title').html('Deactivate Business');
      $('#modal-showAlert .modal-body').html('Are you sure you want to deactivate this Business?');
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
 /* $('.reactivateUser').click(function(){
      var userId = $(this).attr('userid');
      $('#modal-showAlert .modal-title').html('Reactivate User');
      $('#modal-showAlert .modal-body').html('Are you sure you want to reactivate this user?');
      $('#modal-showAlert .modal-footer .ok').hide();
      $('#modal-showAlert .modal-footer .yes').show();
      $('#modal-showAlert .modal-footer .no').show();
      $('#modal-showAlert .modal-footer .yes').click(function(){
        $.ajax({
          url: 'index.cfm?action=ajax.manageUser',
          type: 'post',
          data: {
            userId : userId,
            active: 1
          },
          success: function(data){
            location.reload();
          }
        });
      });
      $('#modal-showAlert').modal('show');
  });
  $('.activateUser').click(function(){
      var userId = $(this).attr('userid');
      $('#modal-showAlert .modal-title').html('Reactivate User');
      $('#modal-showAlert .modal-body').html('Are you sure you want to reactivate this user?');
      $('#modal-showAlert .modal-footer .ok').hide();
      $('#modal-showAlert .modal-footer .yes').show();
      $('#modal-showAlert .modal-footer .no').show();
      $('#modal-showAlert .modal-footer .yes').click(function(){
        $.ajax({
          url: 'index.cfm?action=ajax.manageUser',
          type: 'post',
          data: {
            userId : userId,
            active: 1,
            sendmailtouser : 1
          },
          success: function(data){
            location.reload();
          }
        });
      });
      $('#modal-showAlert').modal('show');
  });*/
</script>