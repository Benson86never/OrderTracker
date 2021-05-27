
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
                                         id="rolechk_#role.RoleID#" 
                                         name="rolechk" 
                                         value="#role.RoleID#"
                                         class="roles_header"> #role.Name#
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
                                            id="id_#role.RoleID#_#access.AccessID#"
                                            name="chk1"
                                            value="#role.RoleID#_#access.AccessID#"
                                            class="c1_#RoleID#"
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
<cfinclude template="includes/footer.cfm" >
<script>
    var arr=[];
    $(".roles_header").click(function(){
        var id_val=$(this).attr("id");
        var value=$(this).val();
        if($('#'+id_val).is(':checked')) {
            let class_value=($(".c1_"+value));
            for (let i = 0; i < class_value.length; ++i) {
                let row_id=$(class_value[i]).attr("id");
                if($('#'+row_id).is(':checked')) {
                    arr.push(row_id);
                } else{
                    $('#'+row_id).attr("checked",true);
                }
            }
        } else {
            $(".c1_"+value).attr("checked",false);
            for(let i=0; i< arr.length; i++)
            {
                $('#'+arr[i]).attr("checked",true);
            }
        }
    });
</script>