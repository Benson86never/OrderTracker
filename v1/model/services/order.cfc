component  {
  public any function getCartDetails(
    integer cartId
  ){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : '',
        'cartItems' : []
      }
      local.cartDetails = queryExecute("
        SELECT
          S.Name AS SupplierName, 
          I.Name AS ItemName, 
          U.Name AS UnitName, 
          JCI.CartQuantity AS Quantity,
          JCI.ID AS CartItemID,
          I.ItemID,
          S.SupplierID,
          C.DateTime,
          C.cartId,
          C.SubaccountID AS businessId
          FROM
            JoinCartToItem JCI
            INNER JOIN Carts C ON C.CartID = JCI.CartID
            INNER JOIN Item I ON I.ItemID = JCI.ItemID
            INNER JOIN Supplier S ON S.SupplierID = JCI.SupplierID
            INNER JOIN Units U ON U.UnitID = I.UnitID
          WHERE
            C.CartID = :cartId
          ORDER BY S.SupplierID, I.ItemID
      ",{
          cartId = {cfsqltype = "integer", value = arguments.cartId}
        },{datasource: application.dsn}
      );
      cfloop(query = "local.cartDetails" ) {
        local.details = {};
        local.details['SupplierName'] = local.cartDetails.SupplierName;
        local.details['ItemName'] = local.cartDetails.ItemName;
        local.details['UnitName'] = local.cartDetails.UnitName;
        local.details['Quantity'] = local.cartDetails.Quantity;
        local.details['CartItemID'] = local.cartDetails.CartItemID;
        local.details['ItemID'] = local.cartDetails.ItemID;
        local.details['SupplierID'] = local.cartDetails.SupplierID;
        local.details['DateTime'] = local.cartDetails.DateTime;
        local.details['businessId'] = local.cartDetails.businessId;
        local.details['cartId'] = local.cartDetails.cartId;
        arrayAppend(local.result.cartItems, local.details);
      }
      return local.result;
    } catch (any e){
      writeDump(e);abort;
    }
  }
  public any function createEmptyCart(){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : ''
      }
      local.insertcartDetails = queryExecute("
        INSERT INTO carts(
          `dateTime`,
          subAccountId,
          closed
        ) VALUES (
          NOW(),
          :businessId,
          0
        )
      ",{
          businessId = {cfsqltype = "integer", value = session.secure.subaccount}
        },{datasource: application.dsn, result = "local.cartResult"}
      );
      return local.cartResult.generatedkey;
    } catch (any e){
      writeDump(e);abort;
    }
  }
  public any function updateCart(){
    transaction {
      try {
        local.result = {
          'error' : false,
          'errorMsg' : ''
        }
        for(cart in arguments.cartArray){
          local.insertcartDetails = queryExecute("
            INSERT INTO joincarttoitem(
              ItemID,
              CartID,
              CartQuantity,
              SupplierID
            ) VALUES (
              :itemId,
              :cartId,
              :quantity,
              :supplierId
            )
          ",{
              itemId = {cfsqltype = "integer", value = cart.itemId},
              cartId = {cfsqltype = "integer", value = cart.cartId},
              quantity = {cfsqltype = "integer", value = cart.quantity},
              supplierId = {cfsqltype = "integer", value = cart.supplierId}
            },{datasource: application.dsn, result = "local.cartResult"}
          );
        }
        transaction action="commit";
      } catch (any e){
        transaction action="rollback"; 
        writeDump(e);abort;
      }
    }
    
  }
  public any function getOpenOrders(
    integer checkedin = 0
  ){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : '',
        'openOrders' : []
      }
      local.getOpenOrders = queryExecute("
        SELECT
          O.orderId,
          O.dateTime,
          O.closed,
          S.supplierId,
          S.name AS supplierName,
          P.email
          FROM
            orders O
            INNER JOIN supplier S ON S.supplierId = O.supplierId
            INNER JOIN person P ON P.personId = O.personId
          WHERE
            O.checkedin = :checkedin
          ORDER BY dateTime DESC
      ",{
          checkedin = {cfsqltype = "integer", value = arguments.checkedin}
        },{datasource: application.dsn}
      );
      cfloop(query = "local.getOpenOrders" ) {
        local.details = {};
        local.details['Id'] = local.getOpenOrders.orderId;
        local.details['dateTime'] = local.getOpenOrders.dateTime;
        local.details['closed'] = local.getOpenOrders.closed;
        local.details['supplierId'] = local.getOpenOrders.supplierId;
        local.details['supplierName'] = local.getOpenOrders.supplierName;
        local.details['email'] = local.getOpenOrders.email;
        arrayAppend(local.result.openOrders, local.details);
        
      }
      return local.result;
    } catch (any e){
      writeDump(e);abort;
    }
  }

  
  public any function getOrderDetails(
    integer orderId
  ){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : '',
        'items' : []
      }
      local.getOrders = queryExecute("
        SELECT
          O.orderId,
          JOI.id,
          JOI.itemId,
          JOI.CheckedIn,
          JOI.SupplierID,
          JOI.QuantityOrdered,
          I.name AS itemName
          FROM
            orders O
            INNER JOIN joinordertoitem JOI ON JOI.OrderID = O.OrderID
            INNER JOIN item I ON I.itemId = JOI.itemId
          WHERE
            O.orderId = :orderId
          ORDER BY dateTime DESC
      ",{
          orderId = {cfsqltype = "integer", value = arguments.orderId}
        },{datasource: application.dsn}
      );
      cfloop(query = "local.getOrders" ) {
        local.details = {};
        local.details['orderId'] = local.getOrders.orderId;
        local.details['id'] = local.getOrders.id;
        local.details['itemId'] = local.getOrders.itemId;
        local.details['CheckedIn'] = local.getOrders.CheckedIn;
        local.details['supplierId'] = local.getOrders.supplierId;
        local.details['quantity'] = local.getOrders.QuantityOrdered;
        local.details['itemName'] = local.getOrders.itemName;
        arrayAppend(local.result.items, local.details);
      }
      return local.result;
    } catch (any e){
      writeDump(e);abort;
    }
  }
  
  public any function placeOrder(
    array cartItems
  ){
    transaction {
      try {
        local.result = {
          'error' : false,
          'errorMsg' : ''
        }
        local.supplierId = "";
        for(cart in arguments.cartItems){
          if(local.supplierId != cart.supplierId) {
            local.supplierId = cart.supplierId;
            local.insertOrderDetails = queryExecute("
              INSERT INTO orders(
                DateTime,
                SubAccountID,
                SupplierID,
                Closed,
                CheckedIn,
                PersonID
              ) VALUES (
                NOW(),
                :businessId,
                :SupplierID,
                0,
                0,
                :personId
              )
            ",{
                businessId = {cfsqltype = "integer", value = cart.businessId},
                SupplierID = {cfsqltype = "integer", value = cart.SupplierID},
                personId = {cfsqltype = "integer", value = session.secure.personId}
              },{datasource: application.dsn, result = "local.orderResult"}
            );
          }
          local.insertOrderItemDetails = queryExecute("
            INSERT INTO JoinOrderToItem(
              ItemID,
              OrderID,
              QuantityOrdered,
              SupplierID,
              CheckedIn
            ) VALUES (
              :itemId,
              :orderId,
              :quantity,
              :supplierId,
              0
            );
          ",{
              itemId = {cfsqltype = "integer", value = cart.itemId},
              orderId = {cfsqltype = "integer", value = local.orderResult.generatedkey},
              quantity = {cfsqltype = "integer", value = cart.quantity},
              cartId = {cfsqltype = "integer", value = cart.cartId},
              supplierId = {cfsqltype = "integer", value = cart.supplierId}
            },{datasource: application.dsn, result = "local.cartResult"}
          );
          local.insertOrderItemDetails = queryExecute("
            UPDATE
              carts
            SET
              Closed = 1
            WHERE
              cartId = :cartId;
          ",{
              itemId = {cfsqltype = "integer", value = cart.itemId},
              orderId = {cfsqltype = "integer", value = local.orderResult.generatedkey},
              quantity = {cfsqltype = "integer", value = cart.quantity},
              cartId = {cfsqltype = "integer", value = cart.cartId},
              supplierId = {cfsqltype = "integer", value = cart.supplierId}
            },{datasource: application.dsn, result = "local.cartResult"}
          );
          StructDelete(Session, "cart");
        }
        transaction action="commit";
      } catch (any e){
        transaction action="rollback"; 
        writeDump(e);abort;
      }
    }
  }

  public any function checkInOrder(
    struct formdetails
  ){
    transaction {
      try {
        local.result = {
          'error' : false,
          'errorMsg' : ''
        }
        for(field in arguments.formdetails.fieldnames){
          if(isNumeric(field)){
            local.checkedin = structKeyExists(arguments.formdetails, '#field#')
              && arguments.formdetails['#field#']
              ? 1 : 0;
            local.updateCheckin = queryExecute("
              UPDATE
                joinordertoitem
              SET
                CheckedIn = :checkedin
              WHERE
                id = :id;
            ",{
                id = {cfsqltype = "integer", value = field},
                checkedin = {cfsqltype = "integer", value = local.checkedin}
              },{datasource: application.dsn}
            );
          }
        }
        transaction action="commit";
      } catch (any e){
        transaction action="rollback"; 
        writeDump(e);abort;
      }
    }
  }

  public any function closeOrder(
    integer orderId
  ){
    transaction {
      try {
        local.result = {
          'error' : false,
          'errorMsg' : ''
        }
        local.updateCheckin = queryExecute("
          UPDATE
            orders
          SET
            CheckedIn = 1
          WHERE
            orderId = :orderId;
        ",{
            orderId = {cfsqltype = "integer", value = arguments.orderId}
          },{datasource: application.dsn}
        );
        transaction action="commit";
      } catch (any e){
        transaction action="rollback"; 
        writeDump(e);abort;
      }
    }
    
  }

  public any function completeOrder(
    integer orderId
  ){
    transaction {
      try {
        local.result = {
          'error' : false,
          'errorMsg' : ''
        }
        local.updateCheckin = queryExecute("
          UPDATE
            orders
          SET
            closed = 1
          WHERE
            orderId = :orderId;
        ",{
            orderId = {cfsqltype = "integer", value = arguments.orderId}
          },{datasource: application.dsn}
        );
        transaction action="commit";
      } catch (any e){
        transaction action="rollback"; 
        writeDump(e);abort;
      }
    }
    
  }

  public any function sendOrders(){
    try {
      local.result = {
        'error' : false,
        'errorMsg' : '',
        'orders' : []
      }
      local.getOrders = queryExecute("
        SELECT
          O.orderId,
          JOI.orderId,
          JOI.itemId,
          JOI.CheckedIn,
          JOI.SupplierID,
          JOI.QuantityOrdered,
          I.name AS itemName,
          I.sku AS sku,
          U.name AS unitName,
          S.name AS supplierName,
          B.businessName,
          Rep.firstname,
          Rep.lastname,
          Rep.email
          FROM
            orders O
            INNER JOIN supplier S ON S.supplierId = O.supplierId
            INNER JOIN joinsuppliertoperson JSP ON JSP.supplierId = S.supplierId
            INNER JOIN person Rep ON Rep.personId = JSP.personId
            INNER JOIN person P ON P.personId = O.personId
            INNER JOIN business B ON B.businessId = P.businessId
            INNER JOIN joinordertoitem JOI ON JOI.OrderID = O.OrderID
            INNER JOIN item I ON I.itemId = JOI.itemId
            INNER JOIN Units U ON U.UnitID = I.UnitID
          WHERE
            O.closed = 0
          ORDER BY supplierId DESC
      ",{},{datasource: application.dsn}
      );
      cfloop(query = "local.getOrders", group="SupplierID") {
        local.details = {};
        local.details['orderId'] = local.getOrders.orderId;
        local.details['supplierId'] = local.getOrders.supplierId;
        local.details['supplierName'] = local.getOrders.supplierName;
        local.details['firstname'] = local.getOrders.firstname;
        local.details['lastname'] = local.getOrders.lastname;
        local.details['email'] = local.getOrders.email;
        local.details['items'] = [];
        cfloop() { 
          local.itemDetails = {};
          local.itemDetails['id'] = local.getOrders.orderId;
          local.itemDetails['itemId'] = local.getOrders.itemId;
          local.itemDetails['sku'] = local.getOrders.sku;
          local.itemDetails['CheckedIn'] = local.getOrders.CheckedIn;
          local.itemDetails['quantity'] = local.getOrders.QuantityOrdered;
          local.itemDetails['itemName'] = local.getOrders.itemName;
          local.itemDetails['unitName'] = local.getOrders.unitName;
          local.itemDetails['businessName'] = local.getOrders.businessName;
          arrayAppend(local.details['items'], local.itemDetails)
        }
        arrayAppend(local.result.orders, local.details);
      }
      return local.result;
    } catch (any e){
      writeDump(e);abort;
    }
  }

  public any function addItemtoList(
    integer itemId,
    integer listId
  ){
    transaction {
      try {
        local.result = {
          'error' : false,
          'errorMsg' : ''
        }
        local.updateCheckin = queryExecute("
          INSERT INTO joinitemtolist(
            ItemID,
            ListID,
            OrderBy
          ) VALUES (
            :itemId,
            :listId,
            1
          );
        ",{
            itemId = {cfsqltype = "integer", value = arguments.itemId},
            listId = {cfsqltype = "integer", value = arguments.listId}
          },{datasource: application.dsn}
        );
        transaction action="commit";
      } catch (any e){
        transaction action="rollback"; 
        writeDump(e);abort;
      }
    }
  }
}
