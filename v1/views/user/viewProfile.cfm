<style>
.labelname{
  margin-left: 100px;
}
@media (max-width: 992px){
  .inputelement {
    width: 90% !important;
  }
  /*.container {
    padding: 0px !important;
    margin: 0px !important;
  }*/
}
</style>
<cfoutput>
  <cfif structKeyExists(session, 'userResult')
    AND session.userResult.error>
    <div class="row">
      <div class="col-md-6 alert alert-danger">
        #session.userResult.errorMsg#
      </div>
      <cfset structDelete(session, 'userResult')>
    </div>
  </cfif>
  <cfscript>
    if(structKeyExists(rc, "userDetails")){
        variables.City = rc.userDetails[1]["city"];
        variables.Country = rc.userDetails[1]["Country"];
        variables.State = rc.userDetails[1]["State"];
        variables.active = rc.userDetails[1]["active"];
        variables.carrier = rc.userDetails[1]["carrier"];
        variables.email = rc.userDetails[1]["email"];
        variables.firstName = rc.userDetails[1]["firstName"];
        variables.lastname = rc.userDetails[1]["lastname"];
        variables.personid = rc.userDetails[1]["personid"];
        variables.phone = rc.userDetails[1]["phone"];
        variables.address1 = rc.userDetails[1]["address1"];
        variables.address2 = rc.userDetails[1]["address2"];
        variables.subAccountName = rc.userDetails[1]["subAccountName"];
        variables.type = rc.userDetails[1]["type"];
        variables.zip = rc.userDetails[1]["zip"];
        variables.PhoneExtension = rc.userDetails[1]["PhoneExtension"];
        variables.personid = rc.userDetails[1]["personid"];
        variables.password = "********";
        variables.sectionHeader = "My Profile";
        variables.accountid = rc.userDetails[1]["accountid"];
        variables.roleid = rc.userDetails[1]["typeid"];
    }
    else{
      variables.City = "";
      variables.Country = "";
      variables.Stateid = "";
      variables.accountName = "";
      variables.active = "";
      variables.carrier = "";
      variables.email = "";
      variables.firstName = "";
      variables.lastname = "";
      variables.personid = "";
      variables.phone = "";
      variables.address1	= "";
      variables.address2 = "";
      variables.subAccountName = "";
      variables.type = "";
      variables.zip = "";
      variables.personid = 0;
      variables.password = "";
      variables.PhoneExtension = "";
      variables.sectionHeader = "Add User";
      variables.accountid = 1;
    }
  </cfscript>
  <cfparam  name="variables.countryid" default="1">
  <cfparam  name="variables.state" default="1">
  <cfparam  name="variables.roleid" default="2">
  <cfparam  name="variables.accountid" default="1">

 <!--- <div class = "col-xs-12 sectionHeader">
    #variables.sectionHeader#
  </div>--->

  <div class="container">
  <div class="row">
  <div class="panel panel-default">
      <div class="panel-heading">#variables.sectionHeader#</div>
      <div class="panel-body">
    <form class="form-inline" method = "post" id="formSubmit" name="formSubmit">
      <div class="row">
        <div class="col-md-1 labelname">
          First Name<span style="color: red"><b>*<b></span>:
        </div>
        <div class="col-md-2 ">
          <input type="text" class="form-control inputelement" id="firstName" placeholder="Enter First name" name="firstName" value="#variables.firstName#" required autocomplete="off">
          <input type="hidden" name="active" value="#rc.active#">
          <input type="hidden" name="personid" value="#variables.personid#">
          <input type="hidden" name="userType" value="#variables.roleid#">
          <input type="hidden" name="account" value="#variables.accountid#">
        </div>
        <div class="col-md-1 labelname">
          Last Name<span style="color: red"><b>*<b></span>:
        </div>
        <div class="col-md-2 ">
          <input type="text" class="form-control inputelement" id="lastName" placeholder="Enter Last name" name="lastName" value="#variables.lastName#" required autocomplete="off">
        </div>
      </div>
      <div class="row">
        <div class="col-md-1 labelname">
          Email<span style="color: red"><b>*<b></span>:
        </div>
        <div class="col-md-2  required">
          <input type="text" class="form-control inputelement" id="Email" placeholder="Enter Email" name="Email" autocomplete = "new-password" value="#variables.email#" required autocomplete="off">
        </div>
        <div class="col-md-1 labelname">
          Phone:
        </div>
        <div class="col-md-2 ">
          <input type="text" class="form-control inputelement" id="Phone" placeholder="(___)-___-____" name="Phone" value="#variables.phone#" autocomplete="off" style="width: 95%"> 
        </div>
        <div class="col-md-2 ">
          <input type="text" class="form-control inputelement" id="phoneExtension" placeholder="12345" name="phoneExtension" value="#variables.PhoneExtension#" autocomplete="off" style="width: 43%">  
        </div>
      </div>
      <div class="row">
        <div class="col-md-1 labelname">
          Carrier:
        </div>
        <div class="col-md-2 ">
          <select name="carrier" class="form-control  selectElement" style="width: 100%;">
            <option <cfif variables.carrier EQ "vzwpix.com">
              selected
            </cfif> value="vzwpix.com">Verizon</option>
            <option <cfif variables.carrier EQ "mms.att.net">
              selected
            </cfif> value="mms.att.net">AT&T</option>
            <option <cfif variables.carrier EQ "tmomail.net">
              selected
            </cfif> value="tmomail.net">T-Mobile</option>
            <option <cfif variables.carrier EQ "pm.sprint.com">
              selected
            </cfif> value="pm.sprint.com">Sprint</option>
          </select>
        </div>
      </div>
      <!---<div class="row">
        <div class="col-md-1 labelname">
          User Type:
        </div>
        <div class="col-md-2 ">
          <select class="form-control selectElement" name="userType" style="width: 100%;">
            <cfloop array="#rc.roles#" item="role">
              <option
                <cfif variables.roleid EQ role.id>
                  selected
                </cfif>
                value="#role.id#">
                #role.name#
              </option>
            </cfloop>
          </select>
        </div>
        <div class="col-md-1 labelname">
         Business Name<span style="color: red"><b>*<b></span>:
        </div>
        <div class="col-md-2 ">
          <select class="form-control selectElement" name="account" style="width: 100%;" id="subAccount">
            <cfloop array="#rc.accounts#" item="account">
              <option
                <cfif variables.accountid EQ account.id>
                  selected
                </cfif>
                value="#account.id#">
                #account.name#
              </option>
            </cfloop>
          </select>
        </div>
      </div>--->
      <div class="row">
        <div class="col-md-1 labelname">
          Password<span style="color: red"><b>*<b></span>:
        </div>
        <div class="col-md-2 ">
          <input type="password" class="form-control inputelement" id="password" placeholder="Enter Password" name="password" value="#variables.password#" autocomplete="off" required  minlength="8">
          <i class="fa fa-2x fa-eye" aria-hidden="true" id="showPaasword"></i>
           <span style="margin-top: 1%;font-size: 10px"><i>Password should contain Uppercase letters, Lowercase letters,Numbers and Symbol</i></span>
        </div>
        <div class="col-md-1 labelname">
          Confirm Password:
        </div>
        <div class="col-md-2 ">
          <input type="password" class="form-control inputelement" id="cpassword" placeholder="Enter Password" name="cpassword" value="#variables.password#" autocomplete="off" required minlength="8">
        </div>
      </div>
      <div class="row">
        <div class="col-md-12" id="passwordERR" style="color: red;text-align: center"></div>
      </div>
      <div class="row">
        <div class="col-md-9 text-right">
          <cfif structKeyExists(session, 'secure')
            AND session.secure.loggedin>
            <a class="btn btn-danger" href="index.cfm?action=admin.manageUsers">
              <i class="fa fa-times" aria-hidden="true"></i>
            </a>
          <cfelse>
            <a class="btn btn-danger" href="../login_ctrl.cfm?action=logout">
              <i class="fa fa-times" aria-hidden="true"></i>
            </a>
          </cfif>
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
 