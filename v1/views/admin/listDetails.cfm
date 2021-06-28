
<cfset page = "manageitem"> 
<style>
  input, select{
    font-size: 12px !important;
  }

  .table-responsive {
      width: 99%;
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
    .style1 {
      width: 55%;
    }
    td {
      font-size: 16px;
    }
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<div class="panel panel-default">
  <cfif NOT isdefined('page')>
    <div class="panel-heading">List Details</div>
  </cfif>
  <div class="panel-body">
    <div class="container">
      <div class="table-responsive">
          <div class="table-wrapper">
              <div class="table-title">
                  <div class="row" style="padding-bottom:10px;">
                      <div class="col-sm-6">
                        <cfif isdefined('page')>
                          <cfif session.secure.RoleCode eq 1>
                            <cfscript>
                              local.accounts = [];
                              local.accountDetails = queryExecute("
                              SELECT
                                B.businessId as businessId,
                                B.businessname as name
                              FROM
                                business B
                                INNER JOIN joinbusinesstotype JBT ON JBT.businessId = B.businessId AND JBT.typeId = 1
                              WHERE
                                B.Active = 1
                              ",{},{datasource: application.dsn}
                              );
                              cfloop(query = "local.accountDetails") {
                                local.details = {};
                                local.details['id'] = local.accountDetails.businessId;
                                local.details['name'] = local.accountDetails.name;
                                arrayAppend(local.accounts, local.details);
                              }
                            </cfscript>
                            Business: &nbsp;
                            <select name="business" onchange="changeBusinesslist(this.value)" class="form-select form-select-lg mb-3 form-control style1" >
                            <cfloop array="#local.accounts#" item="account">
                                <option
                                  <cfif isdefined("url.businessid") and url.businessid eq account.id>
                                    selected
                                  </cfif>
                                  value="<cfoutput>#account.id#</cfoutput>">
                                  <cfoutput>#account.name#</cfoutput>
                                  <cfset session.secure.bid="#account.id#">
                                </option>
                              </cfloop>
                            </select>
                          </cfif>
                        </cfif>
                      </div>
                      <div class="col-sm-5 text-right" style="padding-top:15px;">
                          <button type="button" class="btn btn-info add-newlist"><i class="fa fa-plus"></i> <span class="hidden-xs">Add New</span></button>
                      </div>
                  </div>
              </div>
              <table class="listtable table table-bordered">
                <thead>
                    <tr>
                        <th style="width:80%;padding-left:15px;">Name</th>
                        <th style="width:15%;padding-left:15px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                  <cfoutput>
                    <cfloop array="#rc.listDetails#" item="list">
                      <tr>
                          <td><a href="../list_organize.cfm?&businessid=#rc.businessid#&ListID=#list.id#">#list.name#</a></td>
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
                              <button class="btn btn-primary view" id="#list.id#" title="Items" >
                                <i class="fa fa-list" aria-hidden="true"></i>
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
          url: 'model/services/admin.cfc?method=addList',
          type: 'post',
          data: {
            name : $(this).parents("tr").find('#name').val(),
            businessId : '<cfoutput>#rc.businessid#</cfoutput>',
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
            location.href = 'index.cfm?action=admin.listDetails&businessid=<cfoutput>#rc.businessid#</cfoutput>';
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
          url: 'model/services/admin.cfc?method=deleteList',
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
              location.href = 'index.cfm?action=admin.listDetails&businessid=<cfoutput>#rc.businessid#</cfoutput>';
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
          url: 'model/services/admin.cfc?method=updatelist',
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
              location.href = 'index.cfm?action=admin.listDetails&businessid=<cfoutput>#rc.businessid#</cfoutput>';
            </cfif>
          }
        });
    });
    $('.view').click(function(){
      listid = $(this).attr('id');
      location.href = '../list_organize.cfm?&businessid=<cfoutput>#rc.businessid#</cfoutput>&ListID='+listid;
    });
  });
  
  function changeBusinesslist(businessId) {
      location.href = 'index.cfm?action=admin.listDetails&businessid=' + businessId
    }
  </script>