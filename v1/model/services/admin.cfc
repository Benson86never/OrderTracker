component  {
  public any function getUserDetails(
    numeric includeActiveOnly = 0,
    numeric userId = 0
  ){
    local.result = {'error' : false};
    local.users = [];
    local.condition = "";
    local.condition1 = "";
    if(arguments.includeActiveOnly) {
      local.condition = "AND P.active = 1";
    }
    if(val(arguments.userId) > 0 ) {
      local.condition &= "AND P.personId = #arguments.userId#";
    }
    if(isDefined("url.businessId") )
    { 
      local.condition1 &= "AND P.subaccountid = #decrypt(url.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex")#";     
    }
    local.userDetails = queryExecute("
      SELECT
        P.personId,
        P.firstName,
        P.lastname,
        S.address1, 
	      S.address2,
        S.City,
        S.State,
        S.Country,
        S.zip,
        P.email,
        P.phone,
        p.Type,
        P.carrier,
        p.Password,
        P.active,
        p.Salt,
        p.subaccountId,
        R.name,
        S.name AS subAccountName,
        A.name AS accountName,
        p.PhoneExtension
      FROM 
          person P
          INNER JOIN roles R ON R.roleId = P.type
          LEFT JOIN subaccount S ON S.SubAccountID = P.SubAccountID
            AND S.active = 1
          LEFT JOIN masteraccount A ON A.masterId = S.accountId
      WHERE 1=1
      #local.condition#
      #local.condition1#
      ORDER BY P.active DESC, P.firstName;
      ",{},{datasource: application.dsn}
    );
    cfloop(query = "local.userDetails" ) {
      local.details = {};
      local.details['personid'] = local.userDetails.personId;
      local.details['firstName'] = local.userDetails.firstName;
      local.details['lastname'] = local.userDetails.lastname;
      local.details['address1'] = local.userDetails.address1;
      local.details['address2'] = local.userDetails.address2;
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
      local.details['accountName'] = local.userDetails.accountName;
      local.details['active'] = local.userDetails.active;
      local.details['PhoneExtension'] = local.userDetails.PhoneExtension;
      local.details['accountid'] = local.userDetails.subaccountId;
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
      if(local.checkuserDetails.recordcount == 0) {
        local.salt = Hash(GenerateSecretKey("AES"), "SHA-512");
        local.hashedPassword = Hash(arguments.userDetails.password & local.salt, "SHA-512");
        local.userDetails = queryExecute("
          INSERT INTO person
          (
            firstName,
            lastname,
            email,
            phone,
            type,
            carrier,
            Password,
            Salt,
            active,
            subaccountid,
            PhoneExtension
          ) VALUES (
            :firstName,
            :lastname,
            :email,
            :phone,
            :type,
            :carrier,
            :Password,
            :Salt,
            :active,
            :subaccountid,
            :PhoneExtension
          )
        ",{
            firstname = {cfsqltype = "varchar", value = arguments.userDetails.firstName},
            lastname = {cfsqltype = "varchar", value = arguments.userDetails.lastname},
            email = {cfsqltype = "varchar", value = arguments.userDetails.email},
            phone = {cfsqltype = "varchar", value = arguments.userDetails.phone},
            type = {cfsqltype = "integer", value = arguments.userDetails.userType},
            carrier = {cfsqltype = "varchar", value = arguments.userDetails.carrier},
            Password = {cfsqltype = "varchar", value = local.hashedPassword},
            Salt = {cfsqltype = "varchar", value = local.Salt},
            active = {cfsqltype = "varchar", value = arguments.userDetails.active},
            subaccountid = {cfsqltype = "integer", value = arguments.userDetails.account},
            PhoneExtension = {cfsqltype = "varchar", value = arguments.userDetails.PhoneExtension}
          },{datasource: application.dsn, result="local.userresult"}
        );
        local.accountlink = queryExecute("
          INSERT INTO joinpersontosubaccount
          (
            PersonID,
            SubAccountID
          ) VALUES (
            :personId,
            :subAccountId
          )
        ",{
            personId = {cfsqltype = "varchar", value = local.userresult.generatedKey},
            SubAccountID = {cfsqltype = "varchar", value = arguments.userDetails.account}
          },{datasource: application.dsn}
        );
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
            firstname = :firstname,
            lastname = :lastname,
            email = :email,
            phone = :phone,
            type = :type,
            carrier = :carrier,
            subaccountid = :subaccountid,
            PhoneExtension = :PhoneExtension
            #local.passwordCondition#
          WHERE
            personId = :personId
        ",{
            firstname = {cfsqltype = "varchar", value = arguments.userDetails.firstName},
            lastname = {cfsqltype = "varchar", value = arguments.userDetails.lastname},
            email = {cfsqltype = "varchar", value = arguments.userDetails.email},
            phone = {cfsqltype = "varchar", value = arguments.userDetails.phone},
            type = {cfsqltype = "integer", value = arguments.userDetails.userType},
            carrier = {cfsqltype = "varchar", value = arguments.userDetails.carrier},
            Password = {cfsqltype = "varchar", value = local.hashedPassword},
            Salt = {cfsqltype = "varchar", value = local.Salt},
            subaccountid = {cfsqltype = "integer", value = arguments.userDetails.account},
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

  remote any function manageBusiness(
    integer businessId,
    integer active
  ){
    try {
      local.userDetails = queryExecute("
        UPDATE
          Business
        SET
          active = :active
        WHERE
          businessId = :businessId;

          update business set parentbusinessid = 0 where parentbusinessid = :businessid;
      ",{
          businessId = {cfsqltype = "integer", value = arguments.businessId},
          active = {cfsqltype = "integer", value = arguments.active}
        },{datasource: application.dsn}
      );
    } catch(any e) {
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
          subaccountId,
          name
        FROM
          subaccount
        WHERE
          Active = 1
      ",{},{datasource: application.dsn}
      );
      cfloop(query = "local.accountDetails") {
        local.details = {};
        local.details['id'] = local.accountDetails.subaccountId;
        local.details['name'] = local.accountDetails.name;
        //local.details[id] = 
        arrayAppend(local.result.accounts, local.details);
      }
      return local.result;
    } catch(any e) {
      writeDump(e); abort;
      /* error email */
    }
    
  }
  remote any function getAdressDetails(
    integer subAccountId
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
          subaccount sa
        WHERE
          SubAccountId = :subAccountId
          AND active = 1;
        ",{
          subAccountId = {cfsqltype = "integer", value = arguments.subAccountId}
        },{datasource: application.dsn}
      );
      return local.getAdress;
    }

    public any function saveBusiness(
    struct businessDetails
  ){
    try{
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }
      if(arguments.businessDetails.BusinessId > 0) {
        local.result = updateBusiness(businessDetails = arguments.businessDetails);
      } else {
       local.result = addBusiness(businessDetails = arguments.businessDetails);
      }

    } catch(any e) {
      writeDump(e);abort;
    }
    return local.result;
  }


    public any function addBusiness(
    struct businessDetails
  ){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }
        if(not isDefined("arguments.businessDetails.parentBusinessId") ){
          arguments.businessDetails.parentBusinessId = 0;
        }

        local.businessDetails = queryExecute("
          INSERT INTO Business
          (
            BusinessName,
            Email,
            Phone,
            phoneExtension,
            StreetAddress1,
            StreetAddress2,
            Zip,
            City,
            State,
            Country,
            parentBusinessId,
            active
          ) VALUES (
            :business,
            :Email,
            :Phone,
            :phoneExtension,
            :StreetAddress1,
            :StreetAddress2,
            :Zip,
            :City,
            :State,
            :Country,
            :parentBusinessId,
            :active
          )
        ",{
            business = {cfsqltype = "varchar", value = arguments.businessDetails.business},
            Email = {cfsqltype = "varchar", value = arguments.businessDetails.email},
            phone = {cfsqltype = "varchar", value = arguments.businessDetails.phone},
            phoneExtension = {cfsqltype = "varchar", value = arguments.businessDetails.phoneExtension},
            StreetAddress1 = {cfsqltype = "varchar", value = arguments.businessDetails.address1},
            StreetAddress2 = {cfsqltype = "varchar", value = arguments.businessDetails.address2},
            Zip = {cfsqltype = "integer", value =  arguments.businessDetails.Zip},
            City = {cfsqltype = "varchar", value = arguments.businessDetails.City},
            State = {cfsqltype = "varchar", value = arguments.businessDetails.State},
            Country = {cfsqltype = "varchar", value = arguments.businessDetails.Country},
            parentBusinessId = {cfsqltype = "varchar", value = arguments.businessDetails.parentBusinessId},
            active = {cfsqltype = "integer", value = "1" }
          },{datasource: application.dsn, result="local.userresult"}
        );
      return local.result;
    } 
    catch (any e){
      //writeDump(arguments);
      writeDump(e);abort;
    }
  }

   public any function updateBusiness(
    struct businessDetails
  ){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }
      if(not isDefined("arguments.businessDetails.parentBusinessId") ){
        arguments.businessDetails.parentBusinessId = 0;
      }
      local.businessDetails = queryExecute("
        UPDATE
          Business
        SET
          BusinessName = :business,
          Email = :Email,
          phone = :phone,
          StreetAddress1 = :StreetAddress1,
          StreetAddress2 = :StreetAddress2,
          Zip = :Zip,
          City = :City,
          PhoneExtension = :PhoneExtension,
          Country = :Country,
          parentBusinessId = :parentBusinessId
        WHERE
          BusinessId = :BusinessId
      ",{
          business = {cfsqltype = "varchar", value = arguments.businessDetails.business},
          Email = {cfsqltype = "varchar", value = arguments.businessDetails.email},
          phone = {cfsqltype = "varchar", value = arguments.businessDetails.phone},
          phoneExtension = {cfsqltype = "varchar", value = arguments.businessDetails.phoneExtension},
          StreetAddress1 = {cfsqltype = "varchar", value = arguments.businessDetails.address1},
          StreetAddress2 = {cfsqltype = "varchar", value = arguments.businessDetails.address2},
          Zip = {cfsqltype = "integer", value =  arguments.businessDetails.Zip},
          City = {cfsqltype = "varchar", value = arguments.businessDetails.City},
          State = {cfsqltype = "varchar", value = arguments.businessDetails.State},
          Country = {cfsqltype = "varchar", value = arguments.businessDetails.Country},
          parentBusinessId = {cfsqltype = "varchar", value = arguments.businessDetails.parentBusinessId},
          BusinessId = {cfsqltype = "integer", value = arguments.businessDetails.BusinessId}
        },{datasource: application.dsn}
      );
      return local.result;
    } catch (any e){
      writeDump(e);abort;
    }
  }

  public any function getBusinessDetails(
    numeric businesssId = 0
  ){
    local.result = {'error' : false};
    local.business = [];
    local.condition = "";
    
    if(val(arguments.businesssId) > 0) {
      local.condition &= "AND BusinessId = #arguments.businesssId#";
    }
    local.BusinessDetails = queryExecute("
      SELECT
        BusinessId,
        BusinessName,
        Email,
        Phone,
        phoneExtension,
        StreetAddress1,
        StreetAddress2,
        Zip,
        City,
        State,
        Country,
        parentBusinessId,
        fngetBusinees(BusinessId) as sortbusinessname
      FROM 
        Business
        WHERE 1=1
        AND active <> 0
        #local.condition#
        order by sortbusinessname;
      ",{},{datasource: application.dsn}
    );
    cfloop(query = "local.BusinessDetails" ) {
      local.details = {};
      local.details['BusinessId'] = local.BusinessDetails.BusinessId;
      local.details['BusinessName'] = local.BusinessDetails.BusinessName;
      local.details['Email'] = local.BusinessDetails.Email;
      local.details['Phone'] = local.BusinessDetails.Phone;
      local.details['phoneExtension'] = local.BusinessDetails.phoneExtension;
      local.details['StreetAddress1'] = local.BusinessDetails.StreetAddress1;
      local.details['StreetAddress2'] = local.BusinessDetails.StreetAddress2;
      local.details['zip'] = local.BusinessDetails.zip;
      local.details['City'] = local.BusinessDetails.City;
      local.details['State'] = local.BusinessDetails.State;
      local.details['Country'] = local.BusinessDetails.Country;
      local.details['parentBusinessId'] = local.BusinessDetails.parentBusinessId;
      local.details['sortbusinessname'] = local.BusinessDetails.sortbusinessname;
      arrayAppend(local.business, local.details);
    }
    local.result['business'] = local.business;
    return local.result;
  }
  public any function getBusinessnames(
  ){
    local.result = {'error' : false};
    local.business = [];
    local.BusinessNamesDetails = queryExecute("
      SELECT
        BusinessId,
        BusinessName,
        parentBusinessId,
        fngetBusinees(BusinessId) as sortbusinessname
      FROM 
        Business
        WHERE 1=1
        AND active =1
        ORDER BY sortbusinessname;
      ",{},{datasource: application.dsn}
    );
    cfloop(query = "local.BusinessNamesDetails" ) {
      local.details = {};
      local.details['BusinessId'] = local.BusinessNamesDetails.BusinessId;
      local.details['BusinessName'] = local.BusinessNamesDetails.BusinessName;
      local.details['parentBusinessId'] = local.BusinessNamesDetails.parentBusinessId;
      local.details['sortbusinessname'] = local.BusinessNamesDetails.sortbusinessname;
      arrayAppend(local.business, local.details);
    }
    local.result['business'] = local.business;
    return local.result;
  }
}