<cfoutput>
  <cfif structKeyExists(session, 'userResult') AND session.userResult.error>
    <div class="row">
      <div class="col-md-6 alert alert-danger">
        #session.userResult.errorMsg#
      </div>
      <cfset structDelete(session, 'userResult')>
    </div>
  </cfif>
  <cfscript>
    if(structKeyExists(rc, "userDetails")){       
        variables.email = rc.userDetails[1]["email"];
        variables.firstName = rc.userDetails[1]["firstName"];
        variables.lastname = rc.userDetails[1]["lastname"];       
    }
    else{     
      variables.email = "";
      variables.firstName = "";
      variables.lastname = "";      
    }
  </cfscript>
  <div class="container">
   <div class="panel panel-default">
      <div class="panel-heading">Help</div>
      <div class="panel-body" style="margin-left: 200px;">
    <form class="form-inline" method = "post" id="formSubmit" name="formSubmit">
      <div class="row">
        <div class="col-md-1 labelname">
          Full Name :
        </div>
        <div class="col-md-2 ">
          <input type="text" class="form-control inputelement" id="firstName" name="firstName" value="#variables.firstName#&nbsp;#variables.lastname#" readonly autocomplete="off">
        </div>
        <div class="col-md-1 labelname" style="margin-left: 60px;">
          Email:
        </div>
        <div class="col-md-2 ">
          <input type="text" class="form-control inputelement" id="email"  name="email" value="#variables.email#" readonly autocomplete="off" >
        </div>
      </div>
      <div class="row">
          <div class="col-md-1 labelname">
            Subject :
          </div>
          <div class="col-md-2 ">
            <input type="text" class="form-control inputelement" id="subject" name="subject" value="Application Error or Query in Application" readonly autocomplete="off" style="width:530px;">
          </div>        
      </div>
      <div class="row">
        <div class="col-md-1 labelname">
          Issue Description<span style="color: red"><b>*<b></span>:
        </div>
        <div class="col-md-2 ">
          <textarea type="text" class="form-control inputelement" id="description" name="description" value="" rows="8" columns="335" style="width:530px;"></textarea>
        </div>        
      </div>
      <div class="row">
        <div class="col-md-12" id="passwordERR" style="color: red;text-align: center"></div>
      </div>
      <div class="row" style="margin-left:220px;">
        <div class="col-md-7 text-right">          
           <a class="btn btn-danger" href="../list.cfm">
              <i class="fa fa-times" aria-hidden="true"></i>
            </a>     
          <button type="button" class="btn btn-success" name="save" id="save">
            <i class="fa fa-check" aria-hidden="true"></i>
          </button>
        </div>
      </div>
    </form>
    </div>
      </div>
      </div>      
  </div>
</cfoutput>
 