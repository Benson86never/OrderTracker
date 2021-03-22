<div class="panel panel-default">
  <div class="panel-heading">List Details</div>
  <div class="panel-body">
    <div class="container-lg">
      <div class="table-responsive">
          <div class="table-wrapper">
              <div class="table-title">
                  <div class="row">
                      <div class="col-sm-8"></div>
                      <div class="col-sm-4">
                          <button type="button" class="btn btn-info add-newlist"><i class="fa fa-plus"></i> Add New</button>
                      </div>
                  </div>
              </div>
              <table class="listtable table table-bordered">
                  <thead>
                      <tr>
                          <th>Name</th>
                          <th>Actions</th>
                      </tr>
                  </thead>
                  <tbody>
                    <cfoutput>
                      <cfloop array="#rc.listDetails#" item="supplier">
                        <tr>
                            <td>#supplier.name#</td>
                            <td>
                                <a class="addlist" id="#supplier.id#" title="Add" ><i class="fa fa-plus"></i></a>
                                <a class="delete" id="#supplier.id#" title="Delete" ><i class="fa fa-trash"></i></a>
                            </td>
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
    var actions = '<a class="addlist" id="0" title="Add" ><i class="fa fa-plus"></i></a>'+
                  '<a class="delete" id="0" title="Delete" ><i class="fa fa-trash"></i></a>';
    // Append table with add row form on add new button click
      $(".add-newlist").click(function(){
      $(this).attr("disabled", "disabled");
      var index = $(".listtable tr").length;
          var row = '<tr>' +
              '<td><input type="text" class="form-control" name="name" id="name"></td>' +
        '<td>' + actions + '</td>' +
          '</tr>';
        $(".listtable").append(row);		
        $(".listtable tbody tr").eq(index-1).find(".addlist, .edit").toggle();
      });
    // Add row on add button click
    $(document).on("click", ".addlist", function(){
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
        $.ajax({
          url: '../v1/model/services/admin.cfc?method=addList',
          type: 'post',
          data: {
            name : $(this).parents("tr").find('#name').val(),
            businessId : '<cfoutput>#variables.businessId#</cfoutput>',
            orderBy : $(this).parents("tr").length
          },
          success: function(data){
            input.each(function(){
              $(this).parent("td").html($(this).val());
            });
            $(this).parents("tr").find(".addlist, .edit").toggle();
            $(".add-newlist").removeAttr("disabled");
          }
        });
      }		
    });
    // Edit row on edit button click
    $(document).on("click", ".edit", function(){		
          $(this).parents("tr").find("td:not(:last-child)").each(function(){
        $(this).html('<input type="text" class="form-control" value="' + $(this).text() + '">');
      });		
      $(this).parents("tr").find(".addlist, .edit").toggle();
      $(".add-newlist").attr("disabled", "disabled");
      });
    // Delete row on delete button click
    $(document).on("click", ".delete", function(){
          $(this).parents("tr").remove();
      $(".add-newlist").removeAttr("disabled");
      });
  });
  </script>