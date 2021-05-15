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
<cfoutput>
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
                       Manage Access
                        </div>
                      <div class="col-sm-5 text-right">
                          <a href=""><button type="button" class="btn btn-info add-newlist"><i class="fa fa-plus"></i> Add New</button></a>
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
                                <button class="editlist btn btn-success" id="#access.AccessID#" title="Edit" >
                                  <i class="fa fa-pencil-alt"></i>
                                </button>
                                </td>
                            </tr>
                         </cfloop>
                      <!---<cfloop array="#rc.listDetails#" item="list">
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
                      </cfloop>--->
                
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
                       Manage Roles
                        </div>
                      <div class="col-sm-5 text-right">
                          <a href=""><button type="button" class="btn btn-info add-newlist"><i class="fa fa-plus"></i> Add New</button></a>
                      </div>
                  </div>
              </div>
              <table class="table table-bordered" cellspacing="0">
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
                                <button class="delete btn btn-danger" id="#role.RoleID#" title="Delete" >
                                  <i class="fa fa-trash-alt"></i>
                                </button>
                                <button class="editlist btn btn-success" id="#role.RoleID#" title="Edit" >
                                  <i class="fa fa-pencil-alt"></i>
                                </button>
                                </td>
                            </tr>
                         </cfloop>
                      <!---<cfloop array="#rc.listDetails#" item="list">
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
                      </cfloop>--->
                
                  </tbody>
              </table>
          </div>
      </div>
  </div>
  </div>
</div>
</div>
</cfoutput>