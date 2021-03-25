component accessors="true" {
    property adminService;
    public any function init( fw ) {
      variables.fw = fw;
      return this;
    }
    public void function viewProfile(rc){
      rc.getuserInfo = adminService.adduserBasicInfo(countryId = 1);
      rc.countries = rc.getuserInfo.countries;
      rc.states = rc.getuserInfo.states;
      rc.roles = rc.getuserInfo.roles;
      rc.accounts = rc.getuserInfo.accounts;
      rc.params = "";
      //writeDump(rc.userid);abort;
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

     public void function viewHelp(rc)
     {
        if(structKeyExists(rc, 'userid')) {
          rc.decryptuserid = decrypt(rc.userid, application.uEncryptKey, "BLOWFISH", "Hex");
          rc.userDetails = adminService.getUserDetails(userid = rc.decryptuserid).users;
          rc.params = "&userId=#rc.userid#";
          rc.active = rc.userDetails[1]["active"];
        }
       writedump(rc)abort;
          //session.userResult = adminService.saveUser(userDetails = form);
      if(structKeyExists(form, 'EMAIL')) {
        session.userResult = adminService.sendQuery(userDetails = form);
              location("index.cfm?action=user.viewHelp&userid=#encrypt(session.secure.personId, application.uEncryptKey, "BLOWFISH", "Hex")#", false);
        }       
    }

    public void function viewTroubleHelp(rc)
     {
        if(structKeyExists(form, 'EMAIL')) {
        session.userResult = adminService.sendTroubleQuery(userDetails = form);
       if(isDefined("session.userResult.errorMsg") && session.userResult.errorMsg == ""){
          location("../login_ctrl.cfm?action=logout", false);
       }
      } 
    }
  
    
  }