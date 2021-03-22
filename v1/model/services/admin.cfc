component  extends ="business" {
  public any function getUserDetails(
    numeric includeActiveOnly = 0,
    numeric userId = 0,
    string businessId = 0
  ){
    local.result = {'error' : false};
    local.users = [];
    local.condition = "";
    if(arguments.includeActiveOnly) {
      local.condition = "AND P.active = 1";
    }
    if(val(arguments.userId) > 0 ) {
      local.condition &= "AND P.personId = #arguments.userId#";
    }
    local.businessId = decrypt(arguments.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex");
    if(val(local.businessId) > 0) {
      local.condition &= "AND P.businessId = #local.businessId#";
    }
    local.userDetails = queryExecute("
      SELECT
        P.personId,
        P.firstName,
        P.lastname,
        b.streetaddress1, 
	      b.streetaddress2,
        b.City,
        b.State,
        b.Country,
        b.zip,
        P.email,
        P.phone,
        p.Type,
        P.carrier,
        p.Password,
        P.active,
        p.Salt,
        p.businessId,
        R.name,
        b.businessname AS subAccountName,
        p.account_active,
        p.PhoneExtension
      FROM 
          person P
          INNER JOIN roles R ON R.roleId = P.type
          INNER JOIN business b ON p.businessId = b.businessid
      WHERE 1=1
      #local.condition#
      AND p.active = 1
      ORDER BY P.active DESC, P.firstName;
      ",{},{datasource: application.dsn}
    );
    cfloop(query = "local.userDetails" ) {
      local.details = {};
      local.details['personid'] = local.userDetails.personId;
      local.details['firstName'] = local.userDetails.firstName;
      local.details['lastname'] = local.userDetails.lastname;
      local.details['address1'] = local.userDetails.streetaddress1;
      local.details['address2'] = local.userDetails.streetaddress2;
      local.details['City'] = local.userDetails.City;
      local.details['State'] = local.userDetails.State;
      local.details['Country'] = local.userDetails.Country;
      local.details['zip'] = local.userDetails.zip;
      local.details['email'] = local.userDetails.email;
      local.details['phone'] = local.userDetails.phone;
      local.details['type'] = local.userDetails.name;
      local.details['carrier'] = local.userDetails.carrier;
      local.details['Password'] = local.userDetails.Password;
      local.details['Salt'] = local.userDetails.Salt;
      local.details['subAccountName'] = local.userDetails.subAccountName;
      local.details['account_active'] = local.userDetails.account_active;
      local.details['active'] = local.userDetails.active;
      local.details['PhoneExtension'] = local.userDetails.PhoneExtension;
      local.details['accountid'] = local.userDetails.businessId;
      local.details['typeid'] = local.userDetails.Type;
      arrayAppend(local.users, local.details);
    }
    local.result['users'] = local.users;
    return local.result;
  }

  public any function saveUser(
    struct userDetails
  ){
    try{
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }
      if(arguments.userDetails.personId > 0) {
        local.result = updateUser(userDetails = arguments.userDetails);
      } else {
       local.result = addUser(userDetails = arguments.userDetails);
      }

    } catch(any e) {
      writeDump(e);abort;
    }
    return local.result;
  }
  public any function addUser(
    struct userDetails
  ){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }
      
      local.checkuserDetails = queryExecute("
        SELECT
          P.personId,  
          p.account_active
        FROM 
            person P
        WHERE
          email = :email
          AND active = 1;
        ",{
          email = {cfsqltype = "varchar", value = arguments.userDetails.email}
        },{datasource: application.dsn}
      ); 
   
       local.mailcontent = queryExecute("
        SELECT
          content_value
        FROM 
            Email_Content
        WHERE
        content_type=1
        ",{},{datasource: application.dsn}
      ); 
      if(local.checkuserDetails.recordcount == 0) {
       
        local.userDetails = queryExecute("
          INSERT INTO person
          (
            firstName,
            lastname,
            email,
            phone,
            type,
            carrier,
            account_active,
            active,
            businessId,
            PhoneExtension
          ) VALUES (
            :firstName,
            :lastname,
            :email,
            :phone,
            :type,
            :carrier,
            :account_active,
            :active,
            :businessId,
            :PhoneExtension
          )
        ",{
            firstname = {cfsqltype = "varchar", value = arguments.userDetails.firstName},
            lastname = {cfsqltype = "varchar", value = arguments.userDetails.lastname},
            email = {cfsqltype = "varchar", value = arguments.userDetails.email},
            phone = {cfsqltype = "varchar", value = arguments.userDetails.phone},
            type = {cfsqltype = "integer", value = arguments.userDetails.userType},
            carrier = {cfsqltype = "varchar", value = arguments.userDetails.carrier},
          
            account_active = 0,
            active = {cfsqltype = "varchar", value = arguments.userDetails.active},
            businessId = {cfsqltype = "integer", value = arguments.userDetails.account},
            PhoneExtension = {cfsqltype = "varchar", value = arguments.userDetails.PhoneExtension}
          },{datasource: application.dsn, result="local.userresult"}
        );
      local.personDetails = queryExecute("
        SELECT
          P.personId,  
          p.account_active,
          p.subaccountid
        FROM 
            person P
        WHERE
          email = :email
          AND active = 1;
        ",{
          email = {cfsqltype = "varchar", value = arguments.userDetails.email}
        },{datasource: application.dsn}
      ); 
         local.checkbusinessDetails = queryExecute("
        SELECT
          P.businessId,  
          p.email
        FROM 
            business P
        WHERE
          businessid = :businessid
          AND active = 1;
        ",{
          businessid = {cfsqltype = "varchar", value =local.personDetails.subaccountid}
        },{datasource: application.dsn}
      ); 
        msg=local.personDetails.personid;
        key=application.uEncryptKey; 
        encMsg = encrypt( msg, key, "BLOWFISH", "HEX");

        mail=new mail();
 
        // Set it's properties
        mail.setSubject( "Welcome Email" );
        mail.setTo( arguments.userDetails.email);
        mail.setFrom( local.checkbusinessDetails.email );
            
        // Add email body content in text and HTML formats
        mail.addPart( type="text", charset="utf-8", wraptext="72", body="Welcome to Ordertracker." ); 
        mail.addPart( type="html", charset="utf-8", body="#replace(replace(local.mailcontent.content_value , '{email}' , '#arguments.userDetails.email#'), '{passwordlink}', 'http://#cgi.server_name#/v1/index.cfm?action=admin.changepassword&login=1&userid=#encMsg#')#" );
        // Send the email
        mail.send();
      } else {
        local.result['error']  = true;
        local.result['errorMsg'] = 'User with this email already avaialble.';
      }
      return local.result;
    } catch (any e){
      //writeDump(arguments);
      writeDump(e);abort;
    }
  }

  public any function updateUser(
    struct userDetails
  ){
    //writeDump(userDetails);
    try {
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }
      local.checkuserDetails = queryExecute("
        SELECT
          P.personId
        FROM 
            person P
        WHERE
          email = :email
          AND personId != :personId 
          AND active = 1;
        ",{
          email = {cfsqltype = "varchar", value = arguments.userDetails.email},
          personId = {cfsqltype = "integer", value = arguments.userDetails.personId}
        },{datasource: application.dsn}
      );
      if(local.checkuserDetails.recordcount == 0) {
       
        
        local.userDetails = queryExecute("
          UPDATE
            person
          SET
            firstname = :firstname,
            lastname = :lastname,
            email = :email,
            phone = :phone,
            type = :type,
            carrier = :carrier,
            businessId = :businessId,
            PhoneExtension = :PhoneExtension
           
          WHERE
            personId = :personId
        ",{
            firstname = {cfsqltype = "varchar", value = arguments.userDetails.firstName},
            lastname = {cfsqltype = "varchar", value = arguments.userDetails.lastname},
            email = {cfsqltype = "varchar", value = arguments.userDetails.email},
            phone = {cfsqltype = "varchar", value = arguments.userDetails.phone},
            type = {cfsqltype = "integer", value = arguments.userDetails.userType},
            carrier = {cfsqltype = "varchar", value = arguments.userDetails.carrier},
          
            businessId = {cfsqltype = "integer", value = arguments.userDetails.account},
            PhoneExtension = {cfsqltype = "varchar", value = arguments.userDetails.PhoneExtension},
            personId = {cfsqltype = "integer", value = arguments.userDetails.personId}
          },{datasource: application.dsn}
        );
      }
      else{
        local.result['error']  = true;
        local.result['errorMsg'] = 'User with this email already avaialble.';
      }
        return local.result;
    } catch (any e){
      writeDump(e);abort;
    }
  }

  public any function manageUser(
    numeric personId,
    numeric active,
    numeric sendEmailtoUser = 0
  ){
    try {
      local.userDetails = queryExecute("
        UPDATE
          person
        SET
          active = :active
        WHERE
          personId = :personId
      ",{
          personId = {cfsqltype = "integer", value = arguments.personId},
          active = {cfsqltype = "integer", value = arguments.active}
        },{datasource: application.dsn}
      );
      /* add Notes for tracking*/
      /*savecontent variable = "local.mailBody" {
        writeOutput(
          "Your account is activated. Please click 
          <a href='#application.siteurl#'>here</a> to login the site."
        )
      }
      if(arguments.sendEmailtoUser) {
        new mail(
          to = ,
          from = "hostmaster@86never.com",
          subject = "Account Activated",
          body = local.mailBody,
          type = "html"
        ).send();
      }*/
      //send email to user that your account has been activated 
      //site link
    } catch(any e) {
      /* error email */
    }
  }

  public any function adduserBasicInfo(
    numeric countyId
  ){
    local.result = {
      'countries' : [],
      'states' : [],
      'roles' : [],
      'accounts' : []
    }
    try {
      /*local.countryDetails = queryExecute("
        SELECT
          country_Id,
          name,
          countryCode
        FROM
          country
      ",{},{datasource: application.dsn}
      );
      cfloop(query = "local.countryDetails") {
        local.details = {};
        local.details['id'] = local.countryDetails.country_Id;
        local.details['name'] = local.countryDetails.name;
        local.details['countrycode'] = local.countryDetails.countryCode;
        arrayAppend(local.result.countries, local.details);
      }
      local.stateDetails = queryExecute("
        SELECT
          state_Id,
          name,
          countryid,
          stateCode
        FROM
          state
        WHERE
          countryid = :countryId
      ",{
         countryId = {cfsqltype = "integer", value = arguments.countryId}
      },{datasource: application.dsn}
      );
      cfloop(query = "local.stateDetails") {
        local.details = {};
        local.details['id'] = local.stateDetails.state_Id;
        local.details['name'] = local.stateDetails.name;
        local.details['countryId'] = local.stateDetails.countryId;
        local.details['stateCode'] = local.stateDetails.stateCode;
        arrayAppend(local.result.states, local.details);
      }*/
      if(session.secure.RoleCode == 4)
      {
        
        local.rolecondition  = "where roleid!=1";
      }
      else
      {
        local.rolecondition  = "";
      }
      local.roleDetails = queryExecute("
        SELECT
          roleId,
          name
        FROM
          roles           
           #local.rolecondition# 
      ",{},{datasource: application.dsn}
      );
      cfloop(query = "local.roleDetails") {
        local.details = {};
        local.details['id'] = local.roleDetails.roleId;
        local.details['name'] = local.roleDetails.name;
        arrayAppend(local.result.roles, local.details);
      }
      local.accountDetails = queryExecute("
        SELECT
           businessId as businessId,
           businessname as name
        FROM
          business
        WHERE
          Active = 1          
      ",{},{datasource: application.dsn}
      );
      cfloop(query = "local.accountDetails") {
        if(session.secure.roleCode == 1 || session.secure.subaccount == local.accountdetails.businessId)
        {
        local.details = {};
        local.details['id'] = local.accountDetails.businessId;
        local.details['name'] = local.accountDetails.name;
        //local.details[id] = 
        arrayAppend(local.result.accounts, local.details);
        }
      }
      return local.result;
    } catch(any e) {
      writeDump(e); abort;
      /* error email */
    }
  }

  remote any function getAdressDetails(
    integer businessId
  )returnformat="JSON"{
    local.getAdress = queryExecute("
        SELECT
         sa.Address1,
         sa.Address2,
         sa.Zip,
         sa.City,
         sa.state,
        sa.country
        FROM 
          business sa
        WHERE
          businessId = :businessId
          AND active = 1;
        ",{
          businessId = {cfsqltype = "integer", value = arguments.businessId}
        },{datasource: application.dsn}
      );
      return local.getAdress;
  }

  public any function updatepassword(
    struct userDetails
  ){     
    //writeDump(userDetails);abort;
    try {
      local.result = {
        'error' : false,
        'errorMsg' : ''
      } 
      local.checkuserDetails = queryExecute("
        SELECT
          P.personId
        FROM 
            person P
        WHERE
          email = :email
          AND active = 1;
        ",{
          email = {cfsqltype = "varchar", value = arguments.userDetails.email}
        },{datasource: application.dsn}
      );
      if(local.checkuserDetails.recordcount == 1) {
        local.passwordCondition = "";
        local.salt = "";
        local.hashedPassword = "";
        if(arguments.userDetails.password != "********") {
          local.salt = Hash(GenerateSecretKey("AES"), "SHA-512");
          local.hashedPassword = Hash(arguments.userDetails.password & local.salt, "SHA-512");
          local.passwordCondition = ",salt='#local.salt#',password = '#local.hashedPassword#'"; 
        }
        local.userDetails = queryExecute("
          UPDATE
            person
          SET
            Password = :Password,
            Salt = :Salt,
            account_active = 1
          
          WHERE
            email = :email
        ",{
          
            Password = {cfsqltype = "varchar", value = local.hashedPassword},
            Salt = {cfsqltype = "varchar", value = local.Salt},           
           email = {cfsqltype = "varchar", value = arguments.userDetails.email}
          },{datasource: application.dsn}
        );
      }
      else{
        local.result['error']  = true;
        local.result['errorMsg'] = 'User with this email already avaialble.';
      }
        return local.result;
    } catch (any e){
      writeDump(e);abort;
    }
  }

  public any function forgotpassword(
    struct userDetails
  ){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }
      local.checkuserDetails = queryExecute("
        SELECT
          P.personId,
           p.account_active,
          p.subaccountid
        FROM 
            person P
        WHERE
          email = :email
          AND active = 1;
        ",{
          email = {cfsqltype = "varchar", value = arguments.userDetails.email}
        },{datasource: application.dsn}
      ); 
      if(local.checkuserDetails.recordcount > 0) {

        local.mailcontent = queryExecute("
        SELECT
          content_value
        FROM 
            Email_Content
        WHERE
        content_type=1
        ",{},{datasource: application.dsn}
      ); 
 
         local.checkbusinessDetails = queryExecute("
        SELECT
          P.businessId,  
          p.email
        FROM 
            business P
        WHERE
          businessid = :businessid
          AND active = 1;
        ",{
          businessid = {cfsqltype = "varchar", value =local.checkuserDetails.subaccountid}
        },{datasource: application.dsn}
      );  
        msg=local.checkuserDetails.personid;
        key=application.uEncryptKey; 
        encMsg = encrypt( msg, key, "BLOWFISH", "HEX");
        
        mail=new mail();
 
        // Set it's properties
        mail.setSubject( "Forgot Password Email" );
        mail.setTo( arguments.userDetails.email);
        mail.setFrom( local.checkbusinessDetails.email );
        mail.setCC( "smucharla@infoane.com" );
        mail.setBCC( "smucharla@infoane.com" );
      
        // Add email body content in text and HTML formats
       mail.addPart( type="text", charset="utf-8", wraptext="72", body="Welcome to Ordertracker." ); 
       mail.addPart( type="html", charset="utf-8", body="#replace(replace(local.mailcontent.content_value , '{email}' , '#arguments.userDetails.email#'), '{passwordlink}', 'http://#cgi.server_name#/v1/index.cfm?action=admin.changepassword&login=1&userid=#encMsg#')#" );
      
        // Send the email
        mail.send();
      } else { 
        local.result['error']  = true;
        local.result['errorMsg'] = 'User with this email already avaialble.';
      }
      return local.result;
    } catch (any e){
      //writeDump(arguments);
      writeDump(e);abort;
    }
  }

public any function sendQuery(
    struct userDetails
  ){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }     
      local.checkuserDetails = queryExecute("
        SELECT
          P.personId,
           p.account_active,
          p.subaccountid
        FROM 
            person P
        WHERE
          email = :email
          AND active = 1;
        ",{
          email = {cfsqltype = "varchar", value = arguments.userDetails.email}
        },{datasource: application.dsn}
      ); 
      local.checkbusinessDetails = queryExecute("
        SELECT
          P.businessId,  
          p.email
        FROM 
            business P
        WHERE
          businessid = :businessid
          AND active = 1;
        ",{
          businessid = {cfsqltype = "varchar", value =local.checkuserDetails.subaccountid}
        },{datasource: application.dsn}
      ); 
        mail=new mail();
        // Set it's properties
        mail.setSubject( "Application Error Or Query on Application" );
        mail.setTo( local.checkbusinessDetails.email);
        mail.setFrom( arguments.userDetails.email );
      
        // Add email body content in text and HTML formats
       mail.addPart( type="text", charset="utf-8", wraptext="72", body="Application Error Or Query on Application" ); 
       mail.addPart( type="html", charset="utf-8", body="#reReplace(arguments.userDetails.description, '\n', '<br />', 'ALL')#" );
      
        // Send the email
        mail.send();     
      return local.result;
    } catch (any e){
      //writeDump(arguments);
      writeDump(e);abort;
    }

   
  }








}
