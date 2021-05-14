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
        <cfinclude template="includes/secure.cfm" >
        <cfinclude template="includes/header.cfm" >
            <cfset role = CreateObject("Component","v1.model.services.managepermissions").getRoles()>
            <cfset access = CreateObject("Component","v1.model.services.managepermissions").getAccess()>
<!---<cfdump var="#role#">--->
        <div class="container">
            <div class="row">
                <div class = "col-xs-2 sectionHeader" style="font-size:22px;padding-top:40px;">
                     Manage Access
                </div>
                <table class="table table-hover table-responsive-sm table-bordered" cellspacing = "0">
                    <thead>
                        <tr>
                            <th>AccessPermission</th>
                            <cfloop query="role">
                            <th><input type="checkbox" id="rolechk1" name="rolechk" value="#role.RoleID#" onchange="selectcheck()">#role.Name#</th>
                            </cfloop>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="access">
                            <tr>
                                <td>#access.Name#</td>
                                <cfloop query="role">
                                <td><input type="checkbox" id="check1" name="chk1" value="#role.RoleID#"></td>
                                </cfloop>
                            </tr>
                         </cfloop>
                    </tbody>
                </table>
            </div>
        </div>
</cfoutput>
<script>
    function selectcheck(){
        var checkboxes = document.getElementsByName("rolechk");
        var datacheck=document.getElementsByName("chk1");
            for (var i = 0; i < checkboxes.length; i++) {
                if(checkboxes[i].checked){
                    console.log(checkboxes[i].value);
                       for(var j = 0; j < datacheck.length; j++){
                            if(checkboxes[i].value == datacheck[j].value){
                                datacheck[j].checked = true;
                            }
                        }
                }
                else{
                        console.log(checkboxes[i].value);
                        for(var j = 0; j < datacheck.length; j++){
                            if(checkboxes[i].value == datacheck[j].value){
                                console.log(datacheck[j].value);
                                datacheck[j].checked = false;
                            }
                        }
                    }
            }
    }
</script>