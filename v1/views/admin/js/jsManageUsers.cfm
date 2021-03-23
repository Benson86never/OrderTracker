

<link href = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel = "stylesheet">
<link href = "https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap.min.css" rel = "stylesheet">
<script src = "https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script src = "https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">
  $('#sortTable').DataTable({
        "columnDefs": [ {
          "targets": 'no-sort',
          "orderable": false,
    } ]
  });
  $('.deactivateUser').click(function(){
      var userId = $(this).attr('userid');
      $('#modal-showAlert .modal-title').html('Deactivate User');
      $('#modal-showAlert .modal-header').addClass('alert-danger');
      $('#modal-showAlert .modal-body').html('Are you sure you want to deactivate this user?');
      $('#modal-showAlert .modal-footer .ok').hide();
      $('#modal-showAlert .modal-footer .yes').show();
      $('#modal-showAlert .modal-footer .no').show();
      $('#modal-showAlert .modal-footer .yes').click(function(){
        $.ajax({
          url: 'index.cfm?action=ajax.manageUser',
          type: 'post',
          data: {
            userId : userId,
            active: -1
          },
          success: function(data){
            location.reload();
          }
        });
      });
      $('#modal-showAlert').modal('show');
  });
  $('.reactivateUser').click(function(){
      var userId = $(this).attr('userid');
      $('#modal-showAlert .modal-header').addClass('alert-success');
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
  });
</script>