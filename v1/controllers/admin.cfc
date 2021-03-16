component accessors="true" {
    property adminService;
    public any function init( fw ) {
      variables.fw = fw;
      return this;
    }
    public void function manageusers(rc){
      param name="rc.businessId" default = 0;
      if(session.secure.rolecode == 4)
      {
        rc.businessid = encrypt(session.secure.SubAccount, application.uEncryptKey, "BLOWFISH", "Hex");
      }
      rc.userDetails = adminService.getUserDetails(
      businessId = rc.businessId).users;
    }
    
     public void function manageBusiness(rc){
      param name="rc.businessId" default = 0;
      if(session.secure.rolecode == 4)
      {
        rc.businessid =  session.secure.SubAccount;
      }
      rc.businessDetails = adminService.getBusinessDetails(businessid = rc.businessid).business;
      
     // writedump(rc.subBusinessNamesDetails);
    }
     public void function AddBusiness(rc){
       rc.BusinessNamesDetails = adminService.getBusinessnames().business;
      
       if(isDefined("url.businessId") && url.businessId NEQ 0) {
         //writedump(url.businessId);
            rc.decryptbusinessid = decrypt(url.businessId, application.uEncryptKey, "BLOWFISH", "Hex");
           // writeDump(rc.decryptbusinessid);
            rc.businessDetails = adminService.getBusinessDetails(businesssId = rc.decryptbusinessid).business;

            //rc.params = "&businessId=#rc.businessId#";
           //writeDump(rc.businessDetails)
          }
          if(structKeyExists(form, 'business')) {
            session.businessResult = adminService.saveBusiness(businessDetails = form); 
             if(isDefined("session.businessResult.errorMsg") && session.businessResult.errorMsg == ""){
              location("index.cfm?action=admin.manageBusiness", false);
            }
          }
    }
    public void function adduser(rc){
      rc.getuserInfo = adminService.adduserBasicInfo(countryId = 1);
      rc.countries = rc.getuserInfo.countries;
      rc.states = rc.getuserInfo.states;
      rc.roles = rc.getuserInfo.roles;
      rc.accounts = rc.getuserInfo.accounts;
      rc.params = "";
      if(isDefined("rc.userid")) {
        rc.decryptuserid = decrypt(rc.userid, application.uEncryptKey, "BLOWFISH", "Hex");
        rc.userDetails = adminService.getUserDetails(userid = rc.decryptuserid).users;
        rc.params = "&userId=#rc.userid#";
        rc.active = 1;
      } else {
      /*  if(structKeyExists(session, 'secure')
          && session.secure.RoleCode == 1) {
          rc.active = 1;
        } else {
          rc.active = 0;
        }*/
        rc.active=1;
      }
      if(structKeyExists(form, 'EMAIL')) {
        session.userResult = adminService.saveUser(userDetails = form);
       if(isDefined("session.userResult.errorMsg") && session.userResult.errorMsg == ""){
          location("index.cfm?action=admin.manageusers", false);
       }
      /* else if(isDefined("session.userResult.errorMsg") && session.userResult.errorMsg == "" && rc.active == 0){
        session.userResult.message = 'Account Created. You will be notified when the account is activated.'
        location("../index.cfm", false);
       }*/
      }
    }
    public void function changepassword(rc)
    {           
      if(isDefined("rc.userid")) {
        rc.decryptuserid = decrypt(rc.userid, application.uEncryptKey, "BLOWFISH", "Hex");
        rc.userDetails = adminService.getUserDetails(userid = rc.decryptuserid).users;             
        rc.params = "&userId=#rc.userid#";
        rc.active = 1;
      } else {     
        rc.active=1;
      } 
      if(structKeyExists(form, 'EMAIL')) {
        session.userResult = adminService.updatepassword(userDetails = form);
       if(isDefined("session.userResult.errorMsg") && session.userResult.errorMsg == ""){
          location("../login_ctrl.cfm?action=logout", false);
       }
      } 
    }

    public void function forgotpassword()
    {           
      if(structKeyExists(form, 'EMAIL')) {
        session.userResult = adminService.forgotpassword(userDetails = form);
       if(isDefined("session.userResult.errorMsg") && session.userResult.errorMsg == ""){
          location("../login_ctrl.cfm?action=logout", false);
       }
      } 
    }

  }