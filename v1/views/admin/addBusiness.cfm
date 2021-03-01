
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
    variables.sectionHeader ="Add Business"
  </cfscript>
  <cfparam  name="variables.countryid" default="1">
  <cfparam  name="variables.state" default="1">
  <cfparam  name="variables.roleid" default="2">
  <cfparam  name="variables.accountid" default="1">

  <div class = "col-xs-12 sectionHeader">
    #variables.sectionHeader#
  </div>
  <div class="container">
    <form class="form-inline" method = "post" id="formSubmit" name="formSubmit">
        <div class="row">
            <div class="col-md-1 labelname">
                Business:
            </div>
            <div class="col-md-2 ">
                <input type="text" class="form-control inputelement" id="business" placeholder="Enter Business" name="business" value="" autocomplete="off">
            </div>
        </div>
        <div class="row">
            <div class="col-md-1 labelname">
                Street <br> Address 1:
            </div>
            <div class="col-md-2 ">
                <input type="text" class="form-control inputelement" id="address1" placeholder="Enter Street Address 1" name="address1" value="" autocomplete="off">
            </div>
            <div class="col-md-1 labelname">
                Street <br> Address 2:
            </div>
            <div class="col-md-2 ">
                <input type="text" class="form-control inputelement" id="address2" placeholder="Enter  Street Address 2" name="address2" value="" autocomplete="off">
            </div>
        </div>
         <div class="row">
            <div class="col-md-1 labelname">
                Zip/Postal Code:
            </div>
            <div class="col-md-2 ">
                <input type="text" class="form-control inputelement" id="Zip" placeholder="Enter Zip" name="Zip"  value="" autocomplete="off">
            </div>
            <div class="col-md-1 labelname">
                City:
            </div>
            <div class="col-md-2 ">
                <input type="text" class="form-control inputelement" id="City" placeholder="Enter City" name="City" value="" autocomplete="off" value="">
            </div>
        </div>
        <div class="row">
            <div class="col-md-1 labelname">
                State/Province:
            </div>
            <div class="col-md-2 ">
                <input type="text" class="form-control inputelement" id="state" placeholder="Enter State" name="state" value="" autocomplete="off" value="">
            </div>
            <div class="col-md-1 labelname">
                 Country:
            </div>
            <div class="col-md-2 ">
                <input type="text" class="form-control inputelement" id="country" placeholder="Enter country" name="country" value="" autocomplete="off" value="">
            </div>
        </div>
        <div class="row">
            <div class="col-md-1 labelname">
                Email<span style="color: red"><b>*<b></span>:
            </div>
            <div class="col-md-2  required">
                <input type="text" class="form-control inputelement" id="Email" placeholder="Enter Email" name="Email" autocomplete = "new-password" value="" required autocomplete="off">
            </div>
            <div class="col-md-1 labelname">
                Phone:
            </div>
            <div class="col-md-1">
                <input type="text" class="form-control inputelement" id="Phone" placeholder="(___)-___-____" name="Phone" value="" autocomplete="off" style="width: 95%"> 
            </div>
            <div class="col-md-1 ">
                <input type="text" class="form-control inputelement" id="phoneExtension" placeholder="12345" name="phoneExtension" value="" autocomplete="off" style="width: 43%">  
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 ">
                <input type="checkbox" class="" id="subBusiness"  name="subBusiness" value="yes" autocomplete="off"><span style="margin-left: 5%">Sub Business<span>
            </div>
        </div>
        <div class="row">
        <div class="col-md-7 text-right">
          <cfif structKeyExists(session, 'secure')>
            <a class="btn btn-danger" href="../login_ctrl.cfm?action=logout">
              <i class="fa fa-times" aria-hidden="true"></i>
            </a>
          </cfif>
          <button type="submit" class="btn btn-success" name="save" id="save">
            <i class="fa fa-check" aria-hidden="true"></i>
          </button>
        </div>
      </div>
    </form>
  </div>
</cfoutput>
 