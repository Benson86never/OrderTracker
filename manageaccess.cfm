<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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
                            <th><input type="checkbox" id="rolechk1" name="rolechk" value="#role.RoleID#" onchange="selectcheck()">#role.Name#</th>
                            </cfloop>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="access">
                            <tr>
                                <td>#access.Name#</td>
                                <input type="hidden" id="hidval" name="hidval1" value="#access.AccessID#">
                                <cfloop query="role">
                                <td><input type="checkbox" id="#access.AccessID#" name="chk1" value="#role.RoleID#" class="c1"></td>
                                </cfloop>
                            </tr>
                         </cfloop>
                    </tbody>
                </table>
                <div class="buttondiv pull-right">
                    <input type="button" id="saveBtn" value="Save" class="btn btn-success" onclick="savedata()">
                </div>
            </div>
        </div>
</cfoutput>
<script>
<!---$(document).ready(function() {
    $.ajax({
                                   url: 'v1/model/services/managepermissions.cfc?method=getAccessRoles',
                                   type: 'get',
                                   dataType: 'json',
                                  success: function(data){
                                    //var result="";
                                   console.log(data)
                                   /*$.each(data.COLUMNS, function(index,item) {
                                   console.log(item.ROLE_ID);
                                  });*/
                                  for (var i in data) {
                                  console.log(data[i])
                                  }
                                  },
                                  error: function(data){
                                      alert(error)
                                  }
                            });
               
});--->
    var checkboxes = document.getElementsByName("rolechk");
    var datacheck=document.getElementsByName("chk1");
    var dataval= document.getElementsByName("hidval1");

       function selectcheck(){
            for (var i = 0; i < checkboxes.length; i++) {
                if(checkboxes[i].checked){
                    //console.log(checkboxes[i].value);
                       for(var j = 0; j < datacheck.length; j++){
                            if(checkboxes[i].value == datacheck[j].value){
                                datacheck[j].checked = true;
                            }

                        }
                }
                else{
                        //console.log(checkboxes[i].value);
                        for(var j = 0; j < datacheck.length; j++){
                            if(checkboxes[i].value == datacheck[j].value){
                                //console.log(datacheck[j].value);
                                datacheck[j].checked = false;
                            }
                        }
                    }
            }
    }
    function savedata(){
      /*$('[name=chk1]:checked').each(function () {
        alert('selected: ' + $('#hidval').val());
            });     
      }*/        
           for(var i=0; i < checkboxes.length; i++){

                if(checkboxes[i].checked){
                  for(var k=0; k < dataval.length; k++){

                    console.log(checkboxes[i].value);
                    console.log(dataval[k].value);
                //if(checkboxes[j].value == datacheck[i].value){
                            $.ajax({
                                   url: 'v1/model/services/managepermissions.cfc?method=addAccessRoles',
                                   type: 'get',
                                   data: {
                                   roleId : checkboxes[i].value,
                                   accessId : dataval[k].value
                                   },
                                  success: function(data){
                                   console.log(data)
                                  },
                                  error: function(data){
                                      alert(error)
                                  }
                            });

                }
                }
                
             
             else{
                    for(var j=0;j<datacheck.length;j++){
                      //for(var k=0; k < dataval.length; k++){

                     if(checkboxes[i].value == datacheck[j].value){

                           if(datacheck[j].checked){
                           console.log(checkboxes[i].value)
                            console.log($(datacheck[j]).attr('id'));
                             $.ajax({
                                   url: 'v1/model/services/managepermissions.cfc?method=addAccessRoles',
                                   type: 'get',
                                   data: {
                                   roleId : checkboxes[i].value,
                                   accessId : $(datacheck[j]).attr('id')
                                   },
                                  success: function(data){
                                   console.log(data)
                                  },
                                  error: function(data){
                                      alert(error)
                                  }
                            });
                           }
                           }
                    // }
                    
                    }
             
                }
           }
    }
   /*function getdata(){
       console.log(checkboxes.checked);
       console.log(datacheck.value);
       for(var i=0;i<checkboxes.length;i++){
       for(var j=0;j<datacheck.length;j++){
                  alert(datacheck[j].checked);
                 if(datacheck[j].checked){ 
                     $('[name=chk1]:checked').each(function () {
                        alert('selected: ' + $('#hidval').val());
                      });
                      if(!(checkboxes.checked) && (datacheck.value > 0)){  
                      alert("hi");
                      }
                      
                      }
   }
       }
   }*/
</script>