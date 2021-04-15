component  {
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
      ",{
          businessId = {cfsqltype = "integer", value = arguments.businessId},
          active = {cfsqltype = "integer", value = arguments.active}
        },{datasource: application.dsn}
      );
      local.updatebusiness = queryExecute("
          update business set parentbusinessid = 0 where parentbusinessid = :businessid;
      ",{
          businessId = {cfsqltype = "integer", value = arguments.businessId},
          active = {cfsqltype = "integer", value = arguments.active}
        },{datasource: application.dsn}
      );
      return true;
    } catch(any e) {
      writeDump(e);abort;
      return false;
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
    transaction {
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
              Zip = {cfsqltype = "integer", value =  arguments.businessDetails.Zip, null = trim(arguments.businessDetails.Zip) EQ ""},
              City = {cfsqltype = "varchar", value = arguments.businessDetails.City},
              State = {cfsqltype = "varchar", value = arguments.businessDetails.State},
              Country = {cfsqltype = "varchar", value = arguments.businessDetails.Country},
              parentBusinessId = {cfsqltype = "varchar", value = arguments.businessDetails.parentBusinessId},
              active = {cfsqltype = "integer", value = "1" }
            },{datasource: application.dsn, result="local.businessresult"}
          );
          for(local.type in arguments.businessDetails.businessType) {
            local.businesstypeDetails = queryExecute("
              INSERT INTO joinbusinesstotype
              (
                businessId,
                typeId
              ) VALUES (
                :businessId,
                :typeId
              )
            ",{
                businessId = {cfsqltype = "varchar", value = local.businessresult.generatedKey},
                typeId = {cfsqltype = "varchar", value = local.type}
              },{datasource: application.dsn, result="local.userresult"}
            );
          }
          
          transaction action="commit"; 
          return local.result;
      } 
      catch (any e){
        transaction action="rollback"; 
        //writeDump(arguments);
        writeDump(e);abort;
      }
    }
  }

  public any function updateBusiness(
    struct businessDetails
  ){
    transaction {
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
        local.businesstype = queryExecute("
            SELECT
              typeId
            FROM
              joinbusinesstotype
            WHERE
              businessId = :businessId
          ",{
              businessId = {cfsqltype = "varchar", value = arguments.businessDetails.BusinessId}
            },{datasource: application.dsn, result="local.userresult"}
        );
        local.typeList = valuelist(local.businesstype.typeId);
        for(local.type in arguments.businessDetails.businessType) {
          if(!listfind(local.typeList, local.type)) {
            local.businesstypeDetails = queryExecute("
              INSERT INTO joinbusinesstotype
              (
                businessId,
                typeId
              ) VALUES (
                :businessId,
                :typeId
              )
            ",{
                businessId = {cfsqltype = "varchar", value = arguments.businessDetails.BusinessId},
                typeId = {cfsqltype = "varchar", value = local.type}
              },{datasource: application.dsn, result="local.userresult"}
            );
          } else {
            local.typeList = ListDeleteAt(local.typeList, listFind(local.typeList, local.type));
          }
        }
        if(listlen(local.typeList)) {
          for(local.type in local.typeList) {
            local.businesstypeDetails = queryExecute("
              DELETE FROM joinbusinesstotype
              WHERE
                businessId = :businessId
                AND typeId = :typeId
            ",{
                businessId = {cfsqltype = "varchar", value = arguments.businessDetails.BusinessId},
                typeId = {cfsqltype = "varchar", value = local.type}
              },{datasource: application.dsn, result="local.userresult"}
            );
          }
        }
        transaction action="commit"; 
        return local.result;
      } catch (any e){
        transaction action="rollback"; 
        writeDump(e);abort;
      }
    }
  }

  public any function getSupplierDetails(
    numeric businessId = 0,
    numeric includeItems = 0,
    numeric linked = 0
  ) {
    local.supplier = [];
    local.condition = "";
    if(arguments.linked > 0) {
      local.condition = " AND JS.SupplierID IS NOT NULL";
    }
    local.supplierDetails = queryExecute("
      SELECT
        S.businessId AS supplierId,
        S.BusinessName AS NAME,
        JS.businessId AS businessId
      FROM 
        business S
        INNER JOIN joinbusinesstotype JBT ON JBT.businessId = S.businessId
        LEFT JOIN joinmasteraccounttosupplier JS ON S.businessId = JS.SupplierID
          AND JS.businessId = :businessId
      WHERE
        S.active = 1
        AND JBT.typeId = 2
        #local.condition#
      ",{
        businessId = {cfsqltype = "integer", value = arguments.BusinessId}
      },{datasource: application.dsn}
    );
    cfloop(query = "local.supplierDetails" ) {
      local.details = {};
      local.details['id'] = local.supplierDetails.SupplierID;
      local.details['name'] = local.supplierDetails.name;
      local.details['businessId'] = local.supplierDetails.businessId;
      local.qsellerDetails = queryExecute("
        SELECT
          P.personId,
          P.firstname,
          P.lastname
        FROM
          joinsuppliertoperson JSP
          INNER JOIN person P ON P.personId = JSP.personId
        WHERE
          JSP.SupplierID = :SupplierID
          AND JSP.businessId = :businessId
        ",{
          SupplierID = {cfsqltype = "integer", value = local.supplierDetails.SupplierID},
          businessId = {cfsqltype = "integer", value = arguments.BusinessId}
        },{datasource: application.dsn}
      );
      local.details['seller'] = [];
      cfloop(query = "local.qsellerDetails" ) {
        local.sellerdetails = {};
        local.sellerdetails['id'] = local.qsellerDetails.personId;
        local.sellerdetails['name'] = local.qsellerDetails.firstname & " " & local.qsellerDetails.lastname;
        arrayAppend(local.details['seller'], local.sellerdetails);
      }
      if(arguments.includeItems) {
        local.details['items'] = [];
        local.qitemDetails = queryExecute("
          SELECT
            I.itemId,
            I.name,
            U.name as unitName,
            I.unitId
          FROM 
            joinsuppliertoitem JSI
            INNER JOIN item I ON I.itemId = JSI.itemId
            INNER JOIN units U ON U.unitId = I.unitId
          WHERE
            JSI.supplierId = :supplierId
          ",{
            supplierId = {cfsqltype = "integer", value = local.supplierDetails.SupplierID}
          },{datasource: application.dsn}
        );
        cfloop(query = "local.qitemDetails" ) {
          local.itemdetails = {};
          local.itemdetails['id'] = local.qitemDetails.itemId;
          local.itemdetails['name'] = local.qitemDetails.name;
          local.itemdetails['unitName'] = local.qitemDetails.unitName;
          local.itemdetails['unitId'] = local.qitemDetails.unitId;
          arrayAppend(local.details['items'], local.itemDetails);
        }
      }
      arrayAppend(local.supplier, local.details);
    }
    return local.supplier
  }

  public any function getUnitDetails() {
    local.units = []
    local.unitDetails = queryExecute("
      SELECT
        U.unitId,
        U.NAME
      FROM 
        Units U
      ",{ },{datasource: application.dsn}
    );
    cfloop(query = "local.unitDetails" ) {
      local.details = {};
      local.details['id'] = local.unitDetails.unitId;
      local.details['name'] = local.unitDetails.name;
      arrayAppend(local.units, local.details);
    }
    return local.units;
  }
  
  public any function getListDetails(
    numeric businessId = 0,
    numeric includeItems = 0,
    numeric listId = 0
  ) {
    local.list = [];
    local.condition = "";
    if(val(arguments.listId) > 0) {
      local.condition &= "AND L.listId = #arguments.listId#";
    }
    local.listDetails = queryExecute("
      SELECT
        L.listId,
        L.NAME,
        L.subAccountId
      FROM 
        List L
      WHERE
        L.subAccountId = :businessId
        #local.condition#
      ",{
        businessId = {cfsqltype = "integer", value = arguments.BusinessId}
      },{datasource: application.dsn}
    );
    cfloop(query = "local.listDetails" ) {
      local.details = {};
      local.details['id'] = local.listDetails.listId;
      local.details['name'] = local.listDetails.NAME;
      arrayAppend(local.list, local.details);
      if(arguments.includeItems) {
        local.details['items'] = [];
        local.qitemDetails = queryExecute("
          SELECT
            JIL.ID,
            I.itemId,
            I.name,
            I.unitId,
            U.name as unitName,
            S.businessId AS SupplierID,
            S.BusinessName AS supplierName
          FROM 
            joinitemtolist JIL
            INNER JOIN item I ON I.itemId = JIL.itemId
            INNER JOIN joinsuppliertoitem JSI ON JSI.itemId = I.itemId
            INNER JOIN business S ON S.businessId = JSI.SupplierID
            INNER JOIN joinmasteraccounttosupplier JMS ON JMS.`SupplierID` = JSI.SupplierID AND JMS.businessId = :businessId
            INNER JOIN units U ON U.unitId = I.unitId
          WHERE
            JIL.listId = :listId
          ORDER BY JIL.orderby
          ",{
            listId = {cfsqltype = "integer", value = local.listDetails.listId},
            businessId = {cfsqltype = "integer", value = arguments.BusinessId}
          },{datasource: application.dsn}
        );
        cfloop(query = "local.qitemDetails" ) {
          local.itemdetails = {};
          local.itemdetails['id'] = local.qitemDetails.id;
          local.itemdetails['name'] = local.qitemDetails.name;
          local.itemdetails['itemId'] = local.qitemDetails.itemId;
          local.itemdetails['unitId'] = local.qitemDetails.unitId;
          local.itemdetails['unitName'] = local.qitemDetails.unitName;
          local.itemdetails['SupplierID'] = local.qitemDetails.SupplierID;
          local.itemdetails['supplierName'] = local.qitemDetails.supplierName;
          arrayAppend(local.details['items'], local.itemDetails);
        }
      }
    }
    return local.list;
  }

  public any function getBusinessDetails(
    numeric businessId = 0,
    string status = 1
  ){
    local.result = {'error' : false};
    local.business = [];
    local.condition = "";
    
    if(val(arguments.businessId) > 0) {
      local.condition &= "AND B.BusinessId = #arguments.businessId#";
    }
    if(arguments.status != "") {
      local.condition &= " AND B.active = #arguments.status#";
    }
    local.result['supplier'] = [];
    local.result['list'] = [];
    local.BusinessDetails = queryExecute("
      SELECT
        B.BusinessId,
        B.BusinessName,
        B.Email,
        B.Phone,
        B.phoneExtension,
        B.StreetAddress1,
        B.StreetAddress2,
        B.Zip,
        B.City,
        B.State,
        B.Country,
        B.parentBusinessId,
        fngetBusinees(B.BusinessId) as sortbusinessname,
        GROUP_CONCAT(BT.name) AS businessTypes,
        GROUP_CONCAT(BT.businesstype_id) AS businessTypeIds,
        B.active
      FROM
        Business B
        INNER JOIN joinbusinesstotype JBT ON JBT.businessId = B.BusinessId
        INNER JOIN businesstype BT ON BT.businesstype_id = JBT.typeId
      WHERE
        1 = 1
        #local.condition#
      GROUP BY B.BusinessId
      order by JBT.typeId,sortbusinessname;
      ",{},{datasource: application.dsn}
    );
    if(val(arguments.businessId) > 0) {
      local.result['supplier'] = getSupplierDetails(businessId = local.BusinessDetails.BusinessId);
      local.result['list'] = getListDetails(businessId = local.BusinessDetails.BusinessId);
    }
    cfloop(query = "local.BusinessDetails" ) {
      local.details = {};
      local.details['BusinessId'] = local.BusinessDetails.BusinessId;
      local.details['BusinessName'] = local.BusinessDetails.BusinessName;
      local.details['businessTypeIds'] = local.BusinessDetails.businessTypeIds;
      local.details['businessTypes'] = local.BusinessDetails.businessTypes;
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
      local.details['active'] = local.BusinessDetails.active;
      local.details['sellers'] = getUserDetails(
        businessId = encrypt(local.BusinessDetails.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex"),
        includeSupplierOnly = 1).users;
      arrayAppend(local.business, local.details);
    }
    local.result['business'] = local.business;
    return local.result;
  }

  public any function getItems(
    numeric itemId = 0,
    numeric supplierId = 0
  ){
    local.result = {'error' : false};
    local.items = [];
    local.condition = "1 = 1";
    
    if(val(arguments.itemId) > 0) {
      local.condition &= " AND I.itemId = #arguments.itemId#";
    }
    if(val(arguments.supplierId) > 0) {
      local.condition &= " AND JSI.supplierId = #arguments.supplierId#";
    }
    local.itemDetails = queryExecute("
      SELECT
        I.Name,
        I.SKU,
        I.PhotoURL,
        I.ItemID as id,
        U.Name as unitname,
        U.UnitID,
        S.businessId AS SupplierID,
        S.BusinessName as suppliername
        FROM
          Item I
          INNER JOIN Units U ON U.UnitID = I.UnitID
          INNER JOIN JoinSupplierToItem JSI on JSI.ItemID = I.ItemID
          INNER JOIN business S ON S.businessId = JSI.SupplierID
        WHERE
          #local.condition#
        ORDER BY I.name asc
        ",{},{datasource: application.dsn}
    );
    cfloop(query = "local.itemDetails" ) {
      local.details = {};
      local.details['id'] = local.itemDetails.id;
      local.details['name'] = local.itemDetails.Name;
      local.details['SKU'] = local.itemDetails.SKU;
      local.details['PhotoURL'] = local.itemDetails.PhotoURL;
      local.details['unitname'] = local.itemDetails.unitname;
      local.details['UnitID'] = local.itemDetails.UnitID;
      local.details['SupplierID'] = local.itemDetails.SupplierID;
      local.details['suppliername'] = local.itemDetails.suppliername;
      arrayAppend(local.items, local.details);
    }
    local.result['items'] = local.items;
    return local.result;
  }

  public any function getBusinessnames(
  ){
    local.result = {'error' : false};
    local.business = [];
    local.types = [];
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
    local.BusinessTypes = queryExecute("
      SELECT
        businessType_Id,
        name
      FROM
        businesstype
      WHERE
        active =1
        ORDER BY name;
      ",{},{datasource: application.dsn}
    );
    cfloop(query = "local.BusinessTypes" ) {
      local.typeDetails = {};
      local.typeDetails['id'] = local.BusinessTypes.businessType_Id;
      local.typeDetails['name'] = local.BusinessTypes.name;
      arrayAppend(local.types, local.typeDetails);
    }
    cfloop(query = "local.BusinessNamesDetails" ) {
      local.details = {};
      local.details['BusinessId'] = local.BusinessNamesDetails.BusinessId;
      local.details['BusinessName'] = local.BusinessNamesDetails.BusinessName;
      local.details['parentBusinessId'] = local.BusinessNamesDetails.parentBusinessId;
      local.details['sortbusinessname'] = local.BusinessNamesDetails.sortbusinessname;
      arrayAppend(local.business, local.details);
    }
    local.result['business'] = local.business;
    local.result['types'] = local.types;
    return local.result;
  }

  remote any function addList(
    string name,
    numeric businessId
    numeric orderBy
  ){
    local.result = {'error' : false};
    try{
      local.qaddlist = queryExecute("
        INSERT INTO list (
          name,
          subAccountId,
          orderBy
        ) VALUES (
          :name,
          :businessId,
          :orderBy
        )
        ",{
          name = {cfsqltype = "varchar", value = arguments.name},
          businessId = {cfsqltype = "varchar", value = arguments.businessId},
          orderBy = {cfsqltype = "varchar", value = arguments.orderBy}
        },{datasource: application.dsn}
      );
    } catch (any e) {
      local.result['error'] = true;
      writeDump(e);abort;
    }
    return local.result;
  }

  remote any function deleteList(
    numeric listId
  ){
    local.result = {'error' : false};
    try{
      local.qaddlist = queryExecute("
        DELETE FROM joinitemtolist
        WHERE
          listId = :listId
        ",{
          listId = {cfsqltype = "varchar", value = arguments.listId}
        },{datasource: application.dsn}
      );
      local.qaddlist = queryExecute("
        DELETE FROM list
        WHERE
          listId = :listId
        ",{
          listId = {cfsqltype = "varchar", value = arguments.listId}
        },{datasource: application.dsn}
      );
    } catch (any e) {
      local.result['error'] = true;
      writeDump(e);abort;
    }
    return local.result;
  }

  remote any function updatelist(
    numeric listId,
    string listname
  ){
    local.result = {'error' : false};
    try{
      local.qaddlist = queryExecute("
        UPDATE
          list
        SET
          name = :listname
        WHERE
          listId = :listId
        ",{
          listname = {cfsqltype = "varchar", value = arguments.listname},
          listId = {cfsqltype = "varchar", value = arguments.listId}
        },{datasource: application.dsn}
      );
    } catch (any e) {
      local.result['error'] = true;
      writeDump(e);abort;
    }
    return local.result;
  }

  remote any function saveListItems(
    string listItems
  ){
    local.result = {'error' : false};
    try{
      local.counter = 1;
      for(local.item in arguments.listItems) {
        local.qaddlist = queryExecute("
          UPDATE
            JoinItemToList
          SET
            OrderBy = :counter
          WHERE
            id = :id
          ",{
            counter = {cfsqltype = "varchar", value = local.counter},
            id = {cfsqltype = "varchar", value = listGetAt(local.item,2,"_")}
          },{datasource: application.dsn}
        );
        local.counter += 1;
      }
    } catch (any e) {
      local.result['error'] = true;
      writeDump(e);abort;
    }
    return local.result;
  }

  remote any function manageItem(
    struct itemDetails,
    string action
  ){
    local.result = {'error' : false};
    transaction {
      try{
        if(arguments.action == 'add') {
          local.qaddlist = queryExecute("
            INSERT INTO item(
              Name,
              SKU,
              UnitID,
              PhotoURL
            ) VALUES (
              :name,
              :sku,
              :unitId,
              :photoUrl)
            ",{
              name = {cfsqltype = "varchar", value = arguments.itemDetails.name},
              SKU = {cfsqltype = "varchar", value = arguments.itemDetails.SKU},
              UnitID = {cfsqltype = "integer", value = arguments.itemDetails.UnitID},
              PhotoURL = {cfsqltype = "varchar", value = arguments.itemDetails.PhotoURL}
            },{datasource: application.dsn, result = "local.itemResult"}
          );
          local.qadditemtosupplier = queryExecute("
            INSERT INTO JoinSupplierToItem(
              ItemID,
              SupplierID
            ) VALUES (
              :itemId,
              :supplierId)
            ",{
              itemId = {cfsqltype = "integer", value = local.itemResult.generatedKey},
              supplierId = {cfsqltype = "integer", value = arguments.itemDetails.supplierId}
            },{datasource: application.dsn}
          );
        } else if(arguments.action == 'update') {
          local.qaddlist = queryExecute("
            UPDATE
              item
            SET
              Name = :name,
              SKU = :sku,
              UnitID = :unitId,
              PhotoURL = :photoUrl
            WHERE
              itemId = :itemId;
            ",{
              name = {cfsqltype = "varchar", value = arguments.itemDetails.name},
              SKU = {cfsqltype = "varchar", value = arguments.itemDetails.SKU},
              UnitID = {cfsqltype = "integer", value = arguments.itemDetails.UnitID},
              PhotoURL = {cfsqltype = "varchar", value = arguments.itemDetails.PhotoURL},
              itemId = {cfsqltype = "integer", value = arguments.itemDetails.itemId},
              supplierId = {cfsqltype = "integer", value = arguments.itemDetails.supplierId}
            },{datasource: application.dsn, result = "local.itemResult"}
          );
          local.qaddlist = queryExecute("
            UPDATE
              JoinSupplierToItem
            SET
              SupplierID = :supplierId
            WHERE
              itemID = :itemId
            ",{
              name = {cfsqltype = "varchar", value = arguments.itemDetails.name},
              SKU = {cfsqltype = "varchar", value = arguments.itemDetails.SKU},
              UnitID = {cfsqltype = "integer", value = arguments.itemDetails.UnitID},
              PhotoURL = {cfsqltype = "varchar", value = arguments.itemDetails.PhotoURL},
              itemId = {cfsqltype = "integer", value = arguments.itemDetails.itemId},
              supplierId = {cfsqltype = "integer", value = arguments.itemDetails.supplierId}
            },{datasource: application.dsn, result = "local.itemResult"}
          );
        }
        else if(arguments.action == 'delete') {
          local.qaddlist = queryExecute("
            DELETE FROM
              JoinSupplierToItem
            WHERE
              itemId = :itemId;
            ",{
              itemId = {cfsqltype = "integer", value = arguments.itemDetails.itemId}
            },{datasource: application.dsn, result = "local.itemResult"}
          );
          local.qaddlist = queryExecute("
            DELETE FROM
              item
            WHERE
              itemId = :itemId;
            ",{
              itemId = {cfsqltype = "integer", value = arguments.itemDetails.itemId}
            },{datasource: application.dsn, result = "local.itemResult"}
          );
        }
        transaction action="commit";
      } catch (any e) {
        transaction action="rollback";
        local.result['error'] = true;
        writeDump(e);abort;
      }
    } 
    return local.result;
  }

  remote any function manageSeller(
    struct sellers,
    struct suppliers,
    numeric businessId
  ){
    local.result = {'error' : false};
    try{
      for(local.supplier in arguments.suppliers) {
        local.supplierkey = local.supplier;
        local.supplierId = listgetat(local.supplierkey, 2, '_');
        local.supplier = arguments.suppliers[local.supplierkey];
        local.qGetsupplier = queryExecute("
          SELECT
            1
          FROM
            joinmasteraccounttosupplier
          WHERE
            SupplierID = :supplierId
            AND BusinessId = :businessId
          ",{
            supplierId = {cfsqltype = "integer", value = local.supplierId},
            businessId = {cfsqltype = "integer", value = arguments.businessId}
          },{datasource: application.dsn}
        );
        if(local.qGetsupplier.recordcount) {
          if(!local.supplier) {
            local.qGetseller = queryExecute("
              DELETE FROM  joinmasteraccounttosupplier
              WHERE
                SupplierID = :supplierId
                AND BusinessId = :businessId
              ",{
                supplierId = {cfsqltype = "integer", value = local.supplierId},
                businessId = {cfsqltype = "integer", value = arguments.businessId}
              },{datasource: application.dsn}
            );
          }
        } else {
          if(local.supplier) {
            local.qaddseller = queryExecute("
              INSERT INTO joinmasteraccounttosupplier (
                SupplierID,
                BusinessId
              ) VALUES (
                :supplierId,
                :businessId
              )
              ",{
                supplierId = {cfsqltype = "integer", value = local.supplierId},
                businessId = {cfsqltype = "integer", value = arguments.businessId}
              },{datasource: application.dsn}
            );
          }
        }

      }
      for(local.seller in arguments.sellers) {
        local.supplierkey = local.seller;
        local.supplierId = listgetat(local.supplierkey, 2, '_');
        local.personId = arguments.sellers[local.supplierkey];
        local.qGetseller = queryExecute("
          SELECT
            1
          FROM
            joinsuppliertoperson
          WHERE
            SupplierID = :supplierId
            AND BusinessId = :businessId
          ",{
            supplierId = {cfsqltype = "integer", value = local.supplierId},
            businessId = {cfsqltype = "integer", value = arguments.businessId}
          },{datasource: application.dsn}
        );
        if(local.qGetseller.recordcount) {
          if(!len(local.personId)) {
            local.qGetseller = queryExecute("
              DELETE FROM  joinsuppliertoperson
              WHERE
                SupplierID = :supplierId
                AND BusinessId = :businessId
              ",{
                supplierId = {cfsqltype = "integer", value = local.supplierId},
                personId = {cfsqltype = "integer", value = local.personId},
                businessId = {cfsqltype = "integer", value = arguments.businessId}
              },{datasource: application.dsn}
            );
          } else {
            local.qGetseller = queryExecute("
              UPDATE
                joinsuppliertoperson
              SET
                personId = :personId
              WHERE
                SupplierID = :supplierId
                AND BusinessId = :businessId
              ",{
                supplierId = {cfsqltype = "integer", value = local.supplierId},
                personId = {cfsqltype = "integer", value = local.personId},
                businessId = {cfsqltype = "integer", value = arguments.businessId}
              },{datasource: application.dsn}
            );
          }
        } else if(len(local.personId)) {
          local.qaddseller = queryExecute("
            INSERT INTO joinsuppliertoperson (
              SupplierID,
              PersonID,
              BusinessId
            ) VALUES (
              :supplierId,
              :personId,
              :businessId
            )
            ",{
              supplierId = {cfsqltype = "integer", value = local.supplierId},
              personId = {cfsqltype = "integer", value = local.personId},
              businessId = {cfsqltype = "integer", value = arguments.businessId}
            },{datasource: application.dsn}
          );
        }
      }
    } catch (any e) {
      local.result['error'] = true;
      writeDump(e);abort;
    }
    return local.result;
  }

  remote any function addSupplierSeller(
    numeric sellerid,
    numeric supplierid,
    numeric businessId
  ){
    local.result = {'error' : false};
    try{
      local.qaddseller = queryExecute("
        INSERT INTO joinmasteraccounttosupplier (
          SupplierID,
          BusinessId
        ) VALUES (
          :supplierId,
          :businessId
        )
        ",{
          supplierId = {cfsqltype = "integer", value = arguments.supplierId},
          businessId = {cfsqltype = "integer", value = arguments.businessId}
        },{datasource: application.dsn}
      );
      local.qaddseller = queryExecute("
        INSERT INTO joinsuppliertoperson (
          SupplierID,
          PersonID,
          BusinessId
        ) VALUES (
          :supplierId,
          :personId,
          :businessId
        )
        ",{
          supplierId = {cfsqltype = "integer", value = arguments.supplierId},
          personId = {cfsqltype = "integer", value = arguments.sellerId},
          businessId = {cfsqltype = "integer", value = arguments.businessId}
        },{datasource: application.dsn}
      );
    } catch (any e) {
      local.result['error'] = true;
      writeDump(e);abort;
    }
    return local.result;
  }

  remote any function deleteSupplier(
    numeric sellerid,
    numeric supplierid,
    numeric businessId
  ){
    local.result = {'error' : false};
    try{
      local.qaddseller = queryExecute("
        DELETE FROM
          joinmasteraccounttosupplier
        WHERE
          SupplierID = :supplierId
          AND BusinessId = :businessId
        ",{
          supplierId = {cfsqltype = "integer", value = arguments.supplierId},
          businessId = {cfsqltype = "integer", value = arguments.businessId}
        },{datasource: application.dsn}
      );
      local.qaddseller = queryExecute("
        DELETE FROM joinsuppliertoperson
        WHERE
          SupplierID = :supplierId
          AND BusinessId = :businessId
          AND personId = :personId
        ",{
          supplierId = {cfsqltype = "integer", value = arguments.supplierId},
          personId = {cfsqltype = "integer", value = arguments.sellerId},
          businessId = {cfsqltype = "integer", value = arguments.businessId}
        },{datasource: application.dsn}
      );
    } catch (any e) {
      local.result['error'] = true;
      writeDump(e);abort;
    }
    return local.result;
  }

  remote any function updateSeller(
    numeric sellerid,
    numeric supplierid,
    numeric businessId
  ){
    local.result = {'error' : false};
    try{
      local.qaddseller = queryExecute("
        UPDATE
          joinsuppliertoperson
        SET
          personId = :personId
        WHERE
          SupplierID = :supplierId
          AND BusinessId = :businessId
        ",{
          supplierId = {cfsqltype = "integer", value = arguments.supplierId},
          personId = {cfsqltype = "integer", value = arguments.sellerId},
          businessId = {cfsqltype = "integer", value = arguments.businessId}
        },{datasource: application.dsn}
      );
    } catch (any e) {
      local.result['error'] = true;
      writeDump(e);abort;
    }
    return local.result;
  }
}
