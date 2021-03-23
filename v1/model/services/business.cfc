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

          update business set parentbusinessid = 0 where parentbusinessid = :businessid;
      ",{
          businessId = {cfsqltype = "integer", value = arguments.businessId},
          active = {cfsqltype = "integer", value = arguments.active}
        },{datasource: application.dsn}
      );
    } catch(any e) {
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
              Zip = {cfsqltype = "integer", value =  arguments.businessDetails.Zip},
              City = {cfsqltype = "varchar", value = arguments.businessDetails.City},
              State = {cfsqltype = "varchar", value = arguments.businessDetails.State},
              Country = {cfsqltype = "varchar", value = arguments.businessDetails.Country},
              parentBusinessId = {cfsqltype = "varchar", value = arguments.businessDetails.parentBusinessId},
              active = {cfsqltype = "integer", value = "1" }
            },{datasource: application.dsn, result="local.userresult"}
          );
          local.getSupplier = queryExecute("
            SELECT
              SupplierID
            FROM 
              supplier
            ",{},{datasource: application.dsn}
          );
          cfloop(query="local.getSupplier") {
            local.businessSupplierDetails = queryExecute("
              INSERT INTO joinmasteraccounttosupplier
              (
                BusinessId,
                SupplierID
              ) VALUES (
                :businessId,
                :supplierId
              )
            ",{
                businessId = {cfsqltype = "varchar", value = local.userresult.generatedkey},
                supplierId = {cfsqltype = "varchar", value = local.getSupplier.SupplierID}
              }, {datasource: application.dsn}
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

  public any function getSupplierDetails(
    numeric businessId = 0,
    numeric includeItems = 0
  ) {
    local.supplier = []
    local.supplierDetails = queryExecute("
      SELECT
        S.SupplierID,
        S.NAME
      FROM 
        joinmasteraccounttosupplier JS
        INNER JOIN supplier S ON S.SupplierID = JS.SupplierID
      WHERE
        js.BusinessId = :businessId
      ",{
        businessId = {cfsqltype = "integer", value = arguments.BusinessId}
      },{datasource: application.dsn}
    );
    cfloop(query = "local.supplierDetails" ) {
      local.details = {};
      local.details['id'] = local.supplierDetails.SupplierID;
      local.details['name'] = local.supplierDetails.name;
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
            S.SupplierID,
            S.name AS supplierName
          FROM 
            joinitemtolist JIL
            INNER JOIN item I ON I.itemId = JIL.itemId
            INNER JOIN joinsuppliertoitem JSI ON JSI.itemId = I.itemId
            INNER JOIN supplier S ON S.SupplierID = JSI.SupplierID
            INNER JOIN units U ON U.unitId = I.unitId
          WHERE
            JIL.listId = :listId
          ORDER BY JIL.orderby
          ",{
            listId = {cfsqltype = "integer", value = local.listDetails.listId}
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
    numeric businessId = 0
  ){
    local.result = {'error' : false};
    local.business = [];
    local.condition = "";
    
    if(val(arguments.businessId) > 0) {
      local.condition &= "AND BusinessId = #arguments.businessId#";
    }
    local.result['supplier'] = [];
    local.result['list'] = [];
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
    if(val(arguments.businessId) > 0) {
      local.result['supplier'] = getSupplierDetails(businessId = local.BusinessDetails.BusinessId);
      local.result['list'] = getListDetails(businessId = local.BusinessDetails.BusinessId);
    }
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

  public any function getItems(
    numeric itemId = 0
  ){
    local.result = {'error' : false};
    local.items = [];
    local.condition = "";
    
    if(val(arguments.itemId) > 0) {
      local.condition &= "AND itemId = #arguments.itemId#";
    }
    local.itemDetails = queryExecute("
      SELECT
        I.Name,
        I.SKU,
        I.PhotoURL,
        I.ItemID as id,
        U.Name as unitname,
        U.UnitID,
        S.SupplierID,
        S.Name as suppliername
        FROM
          Item I
          INNER JOIN Units U ON U.UnitID = I.UnitID
          INNER JOIN JoinSupplierToItem JSI on JSI.ItemID = I.ItemID
          INNER JOIN Supplier S ON S.SupplierID = JSI.SupplierID
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
}
