
  <cfset personid = decrypt(url.userid, application.uEncryptKey, "BLOWFISH", "Hex")>
    <cfquery name="qrySelectPerson" datasource="#application.dsn#">
    select * from person where personid = #personid#
    </cfquery>
  <cfif qrySelectPerson.account_active eq 1 >
  <cflocation url="../login_ctrl.cfm?action=logout">
  <cfelse>
    <cfif isdefined("url.login") and url.login eq 1>
  <cfscript>
      variables.email = "";      
      variables.personid = "";     
      variables.password = "";    
  </cfscript>  
  <cfelse>
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
        variables.personid = rc.userDetails[1]["personid"];
        variables.password = "********";
    }
    else{    
      variables.email = "";      
      variables.personid = "";     
      variables.password = "";
    }
  </cfscript>
  </cfif>
<cfoutput>
  <div class="container">
    <form class="form-inline" method = "post" id="formSubmit" name="formSubmit" >     <br><br><br><br><br><br><br><br><br><br>
      <div class="row">
        <div class="col-md-1 labelname">
          Email<span style="color: red"><b><b></span>:
        </div>
        <div class="col-md-2  required">
          <input type="text" class="form-control inputelement" id="Email" placeholder="Enter Email" name="Email" autocomplete = "new-password" value="#variables.email#"  readonly>
        </div>        
      </div><br><br><br><br>
      <div class="row">
        <div class="col-md-1 labelname">
          Password<span style="color: red"><b>*<b></span>:
        </div>
        <div class="col-md-2">
          <input type="password" class="form-control inputelement" id="password" placeholder="Enter Password" name="password" value="" autocomplete="off" required  minlength="8">
          <i class="fa fa-2x fa-eye" aria-hidden="true" id="showPaasword"></i>
           <span style="margin-top: 1%;font-size: 10px"><i>Password should contain Uppercase letters, Lowercase letters,Numbers and Symbol</i></span>
        </div>
          <div class="col-md-1 labelname">
            Confirm Password<span style="color: red"><b>*<b></span>:
          </div>
          <div class="col-md-2 ">
            <input type="password" class="form-control inputelement" id="cpassword" placeholder="Enter Password" name="cpassword" value="" autocomplete="off" required minlength="8">
          </div>
      </div>
      <div class="row">
        <div class="col-md-12" id="passwordERR" style="color: red;text-align: center"></div>
      </div>
      <div class="row">
        <div class="col-md-7 text-right">
            <a class="btn btn-danger" href="../login_ctrl.cfm?action=logout">
              <i class="fa fa-times" aria-hidden="true"></i>
            </a>
          <button type="button" class="btn btn-success" name="save" id="save">
            <i class="fa fa-check" aria-hidden="true"></i>
          </button>
        </div>
      </div>
    </form>
  </div>
</cfoutput>
 </cfif>
 