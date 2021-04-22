<cfif NOT isdefined('rc.listDetails')>
  <cfset page = "manageitem">
  <cfparam  name="url.businessid" default="#session.secure.subaccount#">
  <cfset variables.businessid = url.businessid>
  <cfset rc.listDetails = CreateObject("Component","v1.model.services.admin").getListDetails(businessId = url.businessid)>
  <style>
    
input, select{
  font-size: 12px !important;
}
.table-wrapper {
    background: #fff;
    padding: 20px;	
    box-shadow: 0 1px 1px rgba(0,0,0,.05);
    font-size: 12px !important;
}
    .save, .cancel {
      display: none;
    }
    .savesupplier, .cancelsupplier {
      display: none;
    }
    .addlist, .addsupplier {
        display: none;
        margin-left: 8px;
    }
    input[type="text"] {
      width: 90% !important;
    }
    .editlist, .editsupplier {
      margin-left: 5px;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
</cfif>
<div class="panel panel-default">
  <cfif NOT isdefined('page')>
    <div class="panel-heading">List Details</div>
  </cfif>
  <div class="panel-body">
    <div class="container-lg">
      <div class="table-responsive">
          <div class="table-wrapper">
              <div class="table-title">
                  <div class="row">
                      <div class="col-sm-6"></div>
                      <div class="col-sm-5 text-right">
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
                      <cfloop array="#rc.listDetails#" item="list">
                        <tr>
                            <td>#list.name#</td>
                            <td>
                                <button class="delete btn btn-danger" id="#list.id#" title="Delete" >
                                  <i class="fa fa-trash-alt"></i>
                                </button>
                                <button class="addlist btn btn-success" id="#list.id#" title="Add" >
                                  <i class="fa fa-plus"></i>
                                </button>
                                <button class="editlist btn btn-success" id="#list.id#" title="Edit" >
                                  <i class="fa fa-pencil-alt"></i>
                                </button>
                                <button class="cancel cancellist btn btn-danger" id="#list.id#" title="Cancel" >
                                  <i class="fa fa-times"></i>
                                </button>
                                <button class="save btn btn-success" id="#list.id#" title="Save" >
                                  <i class="fa fa-save"></i>
                                </button>
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
    var actions = '<button class="delete btn btn-danger" id="0" title="Delete" ><i class="fa fa-trash-alt"></i></button>'+
                  '<button class="editlist btn btn-success" style="margin-left: 8px !important;" id="0" title="Edit" ><i class="fa fa-pencil-alt"></i></button>'+
                  '<button class="addlist btn btn-success" id="0" title="Add" ><i class="fa fa-plus"></i></button>';
    // Append table with add row form on add new button click
      $(".add-newlist").click(function(){
      $(this).attr("disabled", "disabled");
      var index = $(".listtable tr").length;
          var row = '<tr>' +
              '<td><input type="text" class="form-control" name="name" id="name"></td>' +
        '<td>' + actions + '</td>' +
          '</tr>';
        $(".listtable").append(row);		
        $(".listtable tbody tr").eq(index-1).find(".addlist, .editlist").toggle();
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
        actions = $(this).parents("tr").find(".addlist, .editlist");
        $.ajax({
          url: 'v1/model/services/admin.cfc?method=addList',
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
            actions.toggle();
            $(".add-newlist").removeAttr("disabled");
            <cfif NOT isdefined('page')>
              location.reload();
            <cfelse>
              location.href = 'manageitem.cfm?page=lists';
            </cfif>
          }
        });
      }		
    });
    // Edit row on edit button click
    $(document).on("click", ".editlist", function(){		
      $(this).parents("tr").find("td:not(:last-child)").each(function(){
        currentValue = $(this).text();
        $(this).html('<input type="text" name="name" id="name" class="form-control" value="' + currentValue + '">');
      });		
      $(this).parents("tr").find(".delete, .editlist").toggle();
      $(this).parents("tr").find(".save, .cancel").toggle();
      $(".add-newlist").attr("disabled", "disabled");
    });
    $(document).on("click", ".cancellist", function(){		
          $(this).parents("tr").find("input").each(function(){
            $(this).parent("td").html($(this).val());
          });
        $(this).parents("tr").find(".delete, .editlist").toggle();
        $(this).parents("tr").find(".save, .cancellist").toggle();
        $(".add-newlist").removeAttr("disabled");
      });
    // Delete row on delete button click
    $(document).on("click", ".delete", function(){
      $(this).parents("tr").remove();
      $(".add-newlist").removeAttr("disabled");
      $.ajax({
          url: 'v1/model/services/admin.cfc?method=deleteList',
          type: 'post',
          data: {
            listId : $(this).attr('id')
          },
          success: function(data){
            input.each(function(){
              $(this).parent("td").html($(this).val());
            });
            $(this).parents("tr").find(".addlist, .editlist").toggle();
            $(".add-newlist").removeAttr("disabled");
            <cfif NOT isdefined('page')>
              location.reload();
            <cfelse>
              location.href = 'manageitem.cfm?page=lists';
            </cfif>
          }
        });
    });
    $(document).on("click", ".save", function(){
      $(".add-newlist").removeAttr("disabled");
      var input = $(this).parents("tr").find('input[type="text"]');
      var actions = $(this).parents("tr").find(".save, .cancel, .editlist, .delete");
      var listname = $(this).parents("tr").find('#name').val();
      $.ajax({
          url: 'v1/model/services/admin.cfc?method=updatelist',
          type: 'post',
          data: {
            listId : $(this).attr('id'),
            listname : listname
          },
          success: function(data){
            input.each(function(){
              $(this).parent("td").html($(this).val());
            });
            actions.toggle();
            $(".add-newlist").removeAttr("disabled");
            <cfif NOT isdefined('page')>
              location.reload();
            <cfelse>
              location.href = 'manageitem.cfm?page=lists';
            </cfif>
          }
        });
    });
  });
  </script>