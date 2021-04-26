<style>
	.panel-default > .panel-heading {
  text-align: center;
  font-size: 24px;
  }
  .panel-body {
      margin-left: 15%;
    }
   #subject {
      width: 510px;
    }
   #description {
      width: 510px;
    }
   .s1 {
       margin-left: 25px;
    }
   .r1 {
      margin-left: 10%;
     }
    @media (max-width: 767px) {
       
          .panel-body {
               margin-left: 3% !important;
               /*font-size: 10px !important;*/
            }
          .container {
              padding: 0 !important;
              margin: 0 !important;
            }
          .inputelement {
            width: 95% !important;
            margin-top: 6px !important;
          }
       .r1 {
             margin-left: 60% !important;
           }
          .s1 {
            margin-left: 0px !important;
          }
          
   }
</style>
<cfoutput>
  <cfif structKeyExists(session, 'userResult') AND session.userResult.error>
    <div class="row">
      <div class="col-sm-6 alert alert-danger">
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
  <div class="row" style="margin :0px;padding :0px;">
   <div class="panel panel-default">
      <div class="panel-heading">Help</div>
      <div class="panel-body">
    <form class="form-inline" method = "post" id="formSubmit" name="formSubmit">
      <div class="row">
        <div class="col-sm-1 labelname">
          Full Name:
        </div>
        <div class="col-sm-2 ">
          <input type="text" class="form-control inputelement" id="firstName" name="firstName" value="#variables.firstName#&nbsp;#variables.lastname#" readonly autocomplete="off">
        </div>
        <div class="col-sm-1 labelname s1">
          Email:
        </div>
        <div class="col-sm-2 ">
          <input type="text" class="form-control inputelement" id="email"  name="email" value="#variables.email#" readonly autocomplete="off" >
        </div>
      </div>
      <div class="row">
          <div class="col-sm-1 labelname">
            Subject:
          </div>
          <div class="col-sm-2 ">
            <input type="text" class="form-control inputelement" id="subject" name="subject" value="Application Error or Query in Application" readonly autocomplete="off" >
          </div>        
      </div>
      <div class="row">
        <div class="col-sm-1 labelname">
          Issue Description<span style="color: red"><b>*<b></span>:
        </div>
        <div class="col-sm-2 ">
          <textarea  class="form-control inputelement" type="text" id="description" name="description" value="" rows="8" columns="335"></textarea>
        </div>        
      </div>
      <div class="row">
        <div class="col-sm-12" id="passwordERR" style="color: red;text-align: center"></div>
      </div>
      <div class="row r1">
        <div class="col-sm-7 text-right">          
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
  </div>
</cfoutput>
 