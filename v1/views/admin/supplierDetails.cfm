<style>
  body {
      color: #404E67;
      background: #F5F7FA;
      font-family: 'Open Sans', sans-serif;
  }
  .table-wrapper {
      width: 97%;
  }
  .table-title {
      padding-bottom: 10px;
      margin: 0 0 10px;
  }
  .table-title h2 {
      margin: 6px 0 0;
      font-size: 22px;
  }
  .table-title .add-new {
      float: right;
      height: 30px;
      font-weight: bold;
      font-size: 12px;
      text-shadow: none;
      min-width: 100px;
      border-radius: 50px;
      line-height: 13px;
  }
  .table-title .add-new i {
      margin-right: 4px;
  }
  table.table {
      table-layout: fixed;
  }
  table.table tr th, table.table tr td {
      border-color: #e9e9e9;
  }
  table.table th i {
      font-size: 13px;
      margin: 0 5px;
      cursor: pointer;
  }
  table.table th:last-child {
      width: 100px;
  }
  table.table td a {
      cursor: pointer;
      display: inline-block;
      margin: 0 5px;
      min-width: 24px;
  }
  table.table td a.edit {
      color: #FFC107;
  }
  table.table td a.delete {
      color: #E34724;
  }
  table.table td i {
      font-size: 19px;
  }  
  table.table .form-control {
      height: 32px;
      line-height: 32px;
      box-shadow: none;
      border-radius: 2px;
  }
  table.table .form-control.error {
      border-color: #f50000;
  }
  table.table td .add, table.listtable td .addlist {
      display: none;
  }
  .addlist {
      display: none;
      margin-left: 10px;
  }
  input[type="text"] {
    width: 90%;
  }
  </style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
  <div class="panel panel-default">
  <div class="panel-heading">Supplier Details</div>
  <div class="panel-body">
    <div class="container-lg">
      <div class="table-responsive">
          <div class="table-wrapper">
              <div class="table-title">
                  <div class="row">
                      <div class="col-sm-8"></div>
                      <div class="col-sm-4">
                          <!---<button type="button" class="btn btn-info add-new"><i class="fa fa-plus"></i> Add New</button>--->
                      </div>
                  </div>
              </div>
              <table class="table table-bordered">
                  <thead>
                      <tr>
                          <th>Name</th>
                          <!--- <th>Actions</th>--->
                      </tr>
                  </thead>
                  <tbody>
                    <cfoutput>
                      <cfloop array="#rc.supplierDetails#" item="supplier">
                        <tr>
                            <td>#supplier.name#</td>
                           <!---  <td>
                               <a class="add" id="#supplier.id#" title="Add" ><i class="fa fa-plus"></i></a>
                                <a class="delete" id="#supplier.id#" title="Delete" ><i class="fa fa-trash"></i></a>
                            </td>--->
                        </tr>
                      </cfloop>
                    </cfoutput>
                  </tbody>
              </table>
          </div>
      </div>
  </div>     
  </div>
</div>
<script>
  $(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
    var actions = $("table td:last-child").html();
    // Append table with add row form on add new button click
      $(".add-new").click(function(){
      $(this).attr("disabled", "disabled");
      var index = $("table tbody tr:last-child").index();
          var row = '<tr>' +
              '<td><input type="text" class="form-control" name="name" id="name"></td>' +
        '<td>' + actions + '</td>' +
          '</tr>';
        $("table").append(row);		
        $("table tbody tr").eq(index + 1).find(".add, .edit").toggle();
      });
    // Add row on add button click
    $(document).on("click", ".add", function(){
      var empty = false;
      var input = $(this).parents("tr").find('input[type="text"]');
          input.each(function(){
        if(!$(this).val()){
          $(this).addClass("error");
          empty = true;
        } else{
                  $(this).removeClass("error");
              }
      });
      $(this).parents("tr").find(".error").first().focus();
      if(!empty){
        input.each(function(){
          $(this).parent("td").html($(this).val());
        });
        $(this).parents("tr").find(".add, .edit").toggle();
        $(".add-new").removeAttr("disabled");
        $.ajax({
          url: '../v1/model/services/admin.cfc?method=addSupplier',
          type: 'post',
          data: {
            name : $(this).val()
          },
          success: function(data){
            location.reload();
          }
        });
      }		
    });
    // Edit row on edit button click
    $(document).on("click", ".edit", function(){		
          $(this).parents("tr").find("td:not(:last-child)").each(function(){
        $(this).html('<input type="text" class="form-control" value="' + $(this).text() + '">');
      });		
      $(this).parents("tr").find(".add, .edit").toggle();
      $(".add-new").attr("disabled", "disabled");
      });
    // Delete row on delete button click
    $(document).on("click", ".delete", function(){
          $(this).parents("tr").remove();
      $(".add-new").removeAttr("disabled");
      });
  });
  </script>