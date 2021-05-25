
<style>
     th {
         font-size: 12px;
        }
     td {
         font-size: 12px;
        }
     @media (max-width: 767px) {
        .container {
           padding: 0 !important;
           margin: 0 !important;
          }
        .sectionHeader {
           font-size:12px !important;
           margin-left: 10px !important;
          }
       }
</style>
<cfoutput>
    <cfset permissionobj = CreateObject("Component","v1.model.services.managepermissions")>
    <cfif isDefined("form.role_access_Id")>
        <cfdump var="#form#">
        <cfset add_access_role = permissionobj.addAccessRoles(data = form.chk1)>
        <cflocation url="manageaccess.cfm" addtoken="no">
    </cfif>
    <cfinclude template="includes/secure.cfm" >
    <cfinclude template="includes/header.cfm" >
    <cfset accessroles = permissionobj.getAccessRoles()>
    <cfset role = permissionobj.getRoles()>
    <cfset access = permissionobj.getAccess()>
    <div class="container">
        <div class="row">
            <form action="" method="post" name="role_access_Id">
               <div class="row">
                    <div class = "col-xs-4 sectionHeader" style="font-size:22px;padding-top:40px;">
                         Manage Access Permissions
                    </div>
                    <div class="col-xs-2" style="font-size:16px;padding-top:40px;float:right;">
                        <a href="manageaccessroles.cfm">Manage Access/Roles</a>
                    </div>
                </div>
                <table class="table table-hover table-responsive-sm table-bordered" cellspacing = "0">
                    <thead>
                        <tr>
                            <th>AccessPermission</th>
                            <cfloop query="role">
                                 <th>
                                    <input type="checkbox" 
                                         id="rolechk1" 
                                         name="rolechk" 
                                         value="#role.RoleID#" 
                                         onchange="selectcheck()">#role.Name#
                                 </th>
                            </cfloop>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="access">
                            <tr>
                                <td>#access.Name#</td>
                                    <input type="hidden" 
                                        id="hidval" 
                                        name="hidval1" 
                                        value="#access.AccessID#">
                                <cfloop query="role">
                                    <cfset checked = "">
                                    <cfif structKeyExists(accessroles, '#access.AccessID#')
                                        AND structKeyExists(accessroles['#access.AccessID#'], '#role.RoleID#')>
                                        <cfset checked = "checked">
                                    </cfif>
                                    <td>
                                        <input type="checkbox"
                                            id="#role.RoleID#"
                                            name="chk1"
                                            value="#role.RoleID#_#access.AccessID#"
                                            class="c1"
                                            #checked#>
                                    </td>
                                </cfloop>
                            </tr>
                         </cfloop>
                    </tbody>
                </table>
                <div class="pull-right">
                    <input type="submit" id="saveBtn" value="Save" name="role_access_Id" class="btn btn-success">
                </div>
            </form>
        </div>
    </div>
</cfoutput>
<script>
    var checkboxes = document.getElementsByName("rolechk");
    var datacheck=document.getElementsByName("chk1");
    var dataval= document.getElementsByName("hidval1");
    function selectcheck(){
        for (var i = 0; i < checkboxes.length; i++) {
            if(checkboxes[i].checked){
                //console.log(checkboxes[i].value);
                    for(var j = 0; j < datacheck.length; j++){
                        console.log($(datacheck[j]).attr("id"))
                        if(checkboxes[i].value == $(datacheck[j]).attr("id")){
                            datacheck[j].checked = true;
                        }

                    }
            }
            else{
                    //console.log(checkboxes[i].value);
                    for(var j = 0; j < datacheck.length; j++){
                        if(checkboxes[i].value == $(this).attr("id")){
                            console.log(datacheck[j].value);
                            datacheck[j].checked = false;
                        }
                    }
                }
        }
    }
</script>