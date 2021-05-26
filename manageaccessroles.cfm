<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<style>
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
<cfinclude template="includes/secure.cfm" >
<cfinclude template="includes/header.cfm" >
<cfset role = CreateObject("Component","v1.model.services.managepermissions").getRoles()>
<cfset access = CreateObject("Component","v1.model.services.managepermissions").getAccess()>
<cfoutput><br>
     <a href="manageaccess.cfm" style="margin-left:20px;"><button type="button" class="btn btn-success" title="Back">
     <i class="fa fa-angle-double-left" aria-hidden="true"></i></button></a>
       <div class="container">
     <div class="row">
   <div class="panel panel-default">
    <!---<div class="panel-heading">List Details</div>--->
  <div class="panel-body">
      <div class="table-responsive">
          <div class="table-wrapper">
              <div class="table-title">
                  <div class="row">
                      <div class="col-sm-6 sectionHeader">
                      <b> Manage Access</b>
                        </div>
                      <div class="col-sm-5 text-right">
                          <button type="button" class="btn btn-info add-newlist"><i class="fa fa-plus"></i> Add New</button>
                      </div>
                  </div>
              </div>
              <table class="listtable table table-bordered" cellspacing="0">
                  <thead>
                      <tr>
                          <th>Name</th>
                          <th class="col-xs-2">Actions</th>
                      </tr>
                  </thead>
                  <tbody>
                  <cfloop query="access">
                            <tr>
                                <td>#access.Name#</td>
                                <td>
                                <button class="delete btn btn-danger" id="#access.AccessID#" title="Delete" >
                                  <i class="fa fa-trash-alt"></i>
                                </button>
                                <button class="addlist btn btn-success" id="#access.AccessID#" title="Add" style="display:none;">
                                  <i class="fa fa-plus"></i>
                                </button>
                                <button class="editlist btn btn-success" id="#access.AccessID#" title="Edit" >
                                  <i class="fa fa-pencil-alt"></i>
                                </button>
                                <button class="cancel cancellist btn btn-danger" id="#access.AccessID#" title="Cancel" style="display:none;">
                                  <i class="fa fa-times"></i>
                                </button>
                                <button class="save btn btn-success" id="#access.AccessID#" title="Save" style="display:none;">
                                  <i class="fa fa-save"></i>
                                </button>
                                </td>
                            </tr>
                         </cfloop>
                  </tbody>
              </table>
          </div>
      </div>
  </div>
  </div><br>
  <div class="panel panel-default">
    <!---<div class="panel-heading">List Details</div>--->
  <div class="panel-body">
      <div class="table-responsive">
          <div class="table-wrapper">
              <div class="table-title">
                  <div class="row">
                      <div class="col-sm-6 sectionHeader">
                       <b>Manage Roles</b>
                        </div>
                      <div class="col-sm-5 text-right">
                          <button type="button" class="btn btn-info add-newlist1"><i class="fa fa-plus"></i> Add New</button>
                      </div>
                  </div>
              </div>
              <table class="listtable1 table table-bordered" cellspacing="0">
                  <thead>
                      <tr>
                          <th>Name</th>
                          <th class="col-xs-2">Actions</th>
                      </tr>
                  </thead>
                  <tbody>
                  <cfloop query="role">
                            <tr>
                                <td>#role.Name#</td>
                                <td>
                                <button class="delete1 btn btn-danger" id="#role.RoleID#" title="Delete" >
                                  <i class="fa fa-trash-alt"></i>
                                </button>
                                <button class="addlist1 btn btn-success" id="#role.RoleID#" title="Add" style="display:none;">
                                  <i class="fa fa-plus"></i>
                                </button>
                                <button class="editlist1 btn btn-success" id="#role.RoleID#" title="Edit" >
                                  <i class="fa fa-pencil-alt"></i>
                                </button>
                                <button class="cancel1 cancellist1 btn btn-danger" id="#role.RoleID#" title="Cancel" style="display:none;">
                                  <i class="fa fa-times"></i>
                                </button>
                                <button class="save1 btn btn-success" id="#role.RoleID#" title="Save" style="display:none;">
                                  <i class="fa fa-save"></i>
                                </button>
                                </td>
                            </tr>
                         </cfloop>
                    </tbody>
              </table>
          </div>
      </div>
  </div>
</div>
</div>
</div>
</cfoutput>
<script>
  $(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
      var actions = '<button class="delete btn btn-danger" id="0" title="Delete" ><i class="fa fa-trash-alt"></i></button>'+
                    '<button class="addlist btn btn-success" id="0" title="Add" ><i class="fa fa-plus"></i></button>';
      var actions1 = '<button class="delete1 btn btn-danger" id="0" title="Delete" ><i class="fa fa-trash-alt"></i></button>'+
                     '<button class="addlist1 btn btn-success" style="margin-left: 8px;" id="0" title="Add" ><i class="fa fa-plus"></i></button>';              

    // Append table with add row for access
      $(".add-newlist").click(function(){
        $(this).attr("disabled", "disabled");
          var index = $(".listtable tr").length;
          var row = '<tr>' +
                    '<td><input type="text" class="form-control" name="name" id="name"></td>' +
                    '<td>' + actions + '</td>' +
                    '</tr>';
          $(".listtable").append(row);		
          $(".listtable tbody tr").eq(index).find(".addlist").toggle();
      });

    //append table with add for roles
      $(".add-newlist1").click(function(){
        $(this).attr("disabled", "disabled");
          var index = $(".listtable1 tr").length;
          var row = '<tr>' +
                    '<td><input type="text" class="form-control" name="name" id="name"></td>' +
                    '<td>' + actions1 + '</td>' +
                    '</tr>';
            $(".listtable1").append(row);		
            $(".listtable1 tbody tr").eq(index).find(".addlist").toggle();
      });

    // Add row on add button click for access
      $(document).on("click", ".addlist", function(){
        var empty = false;
        var input = $(this).parents("tr").find('input[type="text"]');
          input.each(function(){
            if(!$(this).val()){
              $(this).addClass("error");
              empty = true;
            }
            else{
                  $(this).removeClass("error");
                }
      });
      $(this).parents("tr").find(".error").first().focus();
        if(!empty){
          actions = $(this).parents("tr").find(".addlist, .editlist");
            $.ajax({
              url: 'v1/model/services/managepermissions.cfc?method=addAccess',
              data: {
                   nameaccess : $(this).parents("tr").find('#name').val()
                  },
              contentType: 'application/json',
              success: function(data){
                console.log(data);
                location.reload();
                $(".add-newlist").removeAttr("disabled");
              },
              error: function(xhr, textStatus, errorThrown){
                alert("Access name already exist");
              }
            });
        }		
      });
    // Add row on add button click for roles
    $(document).on("click", ".addlist1", function(){
      var empty = false;
      var input = $(this).parents("tr").find('input[type="text"]');
        input.each(function(){
          if(!$(this).val()){
            $(this).addClass("error");
            empty = true;
          } 
          else{
                  $(this).removeClass("error");
              }
    });
      $(this).parents("tr").find(".error").first().focus();
      if(!empty){
        actions = $(this).parents("tr").find(".addlist1, .editlist1");
          $.ajax({
            url: 'v1/model/services/managepermissions.cfc?method=addRoles',
            data: {
            nameroles : $(this).parents("tr").find('#name').val()
            },
            success: function(data){
            location.reload();
            $(".add-newlist1").removeAttr("disabled");
            },
            error: function(xhr, textStatus, errorThrown){
                alert("Role name already exist");
              }
          });
      }		
    });
    // Edit row on edit button click access
    $(document).on("click", ".editlist", function(){		
      $(this).parents("tr").find("td:not(:last-child)").each(function(){
        currentValue = $(this).text();
        $(this).html('<input type="text" name="name" id="name" class="form-control" value="' + currentValue + '">');
      });		
      $(this).parents("tr").find(".delete, .editlist").toggle();
      $(this).parents("tr").find(".save, .cancel").toggle();
      $(".add-newlist").attr("disabled", "disabled");
    });
    // Edit row on edit button click roles
    $(document).on("click", ".editlist1", function(){		
      $(this).parents("tr").find("td:not(:last-child)").each(function(){
        currentValue = $(this).text();
        $(this).html('<input type="text" name="name" id="name1" class="form-control" value="' + currentValue + '">');
      });		
      $(this).parents("tr").find(".delete1, .editlist1").toggle();
      $(this).parents("tr").find(".save1, .cancel1").toggle();
      $(".add-newlist1").attr("disabled", "disabled");
    });
    //cancel for access
    $(document).on("click", ".cancellist", function(){		
          $(this).parents("tr").find("input").each(function(){
            $(this).parent("td").html($(this).val());
          });
        $(this).parents("tr").find(".delete, .editlist").toggle();
        $(this).parents("tr").find(".save, .cancellist").toggle();
        $(".add-newlist").removeAttr("disabled");
    });
      //cancel for roles
    $(document).on("click", ".cancellist1", function(){		
          $(this).parents("tr").find("input").each(function(){
            $(this).parent("td").html($(this).val());
          });
        $(this).parents("tr").find(".delete1, .editlist1").toggle();
        $(this).parents("tr").find(".save1, .cancellist1").toggle();
        $(".add-newlist1").removeAttr("disabled");
    });
    // Delete row on delete button click Access
    $(document).on("click", ".delete", function(){
      $(this).parents("tr").remove();
      $(".add-newlist").removeAttr("disabled");
      $.ajax({
          url: 'v1/model/services/managepermissions.cfc?method=deleteAccess',
          type: 'post',
          data: {
            accessId : $(this).attr('id')
          },
          success: function(data){
            $(this).parents("tr").find(".addlist, .editlist").toggle();
            $(".add-newlist").removeAttr("disabled");
          }
      });
    });
    //delete on click of roles
    $(document).on("click", ".delete1", function(){
      $(this).parents("tr").remove();
      $(".add-newlist1").removeAttr("disabled");
      $.ajax({
          url: 'v1/model/services/managepermissions.cfc?method=deleteRoles',
          data: {
            roleId : $(this).attr('id')
          },
          success: function(data){
            input.each(function(){
              $(this).parent("td").html($(this).val());
            });
            $(this).parents("tr").find(".addlist1, .editlist1").toggle();
            $(".add-newlist1").removeAttr("disabled");
          }
        });
    });
    //save for access
    $(document).on("click", ".save", function(){
      $(".add-newlist").removeAttr("disabled");
      var input = $(this).parents("tr").find('input[type="text"]');
      var actions = $(this).parents("tr").find(".save, .cancel, .editlist, .delete");
      var listname = $(this).parents("tr").find('#name').val();
      $.ajax({
          url: 'v1/model/services/managepermissions.cfc?method=updateaccess',
          data: {
            accessId : $(this).attr('id'),
            accessName : listname
          },
          success: function(data){
            input.each(function(){
              $(this).parent("td").html($(this).val());
            });
            actions.toggle();
            $(".add-newlist").removeAttr("disabled");
          },
          error: function(xhr, textStatus, errorThrown){
                alert("Access name already exist");
                location.reload();
              }
        });
    });
     //save for roles
    $(document).on("click", ".save1", function(){
      $(".add-newlist1").removeAttr("disabled");
      var input = $(this).parents("tr").find('input[type="text"]');
      var actions = $(this).parents("tr").find(".save1, .cancel1, .editlist1, .delete1");
      var listname = $(this).parents("tr").find('#name1').val();
      $.ajax({
          url: 'v1/model/services/managepermissions.cfc?method=updateroles',
          data: {
            roleId : $(this).attr('id'),
            roleName : listname
          },
          success: function(data){
            input.each(function(){
              $(this).parent("td").html($(this).val());
            });
            actions.toggle();
            $(".add-newlist1").removeAttr("disabled");
          },
          error: function(xhr, textStatus, errorThrown){
                alert("Role name already exist");
                location.reload();
              }
        });
    });
  });
  </script>