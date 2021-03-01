component accessors="true" {
    property adminService;
    public any function init( fw ) {
      variables.fw = fw;
      return this;
    }
    public any function login() {
    }
    public void function viewProfile(rc){
      rc.getuserInfo = adminService.adduserBasicInfo(countryId = 1);
      rc.countries = rc.getuserInfo.countries;
      rc.states = rc.getuserInfo.states;
      rc.roles = rc.getuserInfo.roles;
      rc.accounts = rc.getuserInfo.accounts;
      rc.params = "";
      if(structKeyExists(rc, 'userid')) {
        rc.decryptuserid = decrypt(rc.userid, application.uEncryptKey, "BLOWFISH", "Hex");
        rc.userDetails = adminService.getUserDetails(userid = rc.decryptuserid).users;
        rc.params = "&userId=#rc.userid#";
        rc.active = rc.userDetails[1]["active"];
      }
      if(structKeyExists(form, 'EMAIL')) {
        session.userResult = adminService.saveUser(userDetails = form);
       if(isDefined("session.userResult.errorMsg")
        && session.userResult.errorMsg == ""){
          location("index.cfm?action=user.viewProfile&userid=#encrypt(session.secure.personId, application.uEncryptKey, "BLOWFISH", "Hex")#", false);
       }
      }
    }
  }