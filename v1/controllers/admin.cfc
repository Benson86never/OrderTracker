component accessors="true" {
    property adminService;
    public any function init( fw ) {
      variables.fw = fw;
      return this;
    }
    public void function manageusers(rc){
      rc.userDetails = adminService.getUserDetails().users;
    }
     public void function AddBusiness(rc){
       if(structKeyExists(form, 'business')) {
         //writeDump(form);
        session.userResult = adminService.addBusiness(businessDetails = form); 
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
        rc.active = rc.userDetails[1]["active"];
      } else {
        if(structKeyExists(session, 'secure')
          && session.secure.RoleCode == 1) {
          rc.active = 1;
        } else {
          rc.active = 0;
        }
      }
      if(structKeyExists(form, 'EMAIL')) {
        session.userResult = adminService.saveUser(userDetails = form);
       if(isDefined("session.userResult.errorMsg") && session.userResult.errorMsg == "" && rc.active == 1){
          location("index.cfm?action=admin.manageusers", false);
       }
       else if(isDefined("session.userResult.errorMsg") && session.userResult.errorMsg == "" && rc.active == 0){
        session.userResult.message = 'Account Created. You will be notified when the account is activated.'
        location("../index.cfm", false);
       }
      }
    }
  }