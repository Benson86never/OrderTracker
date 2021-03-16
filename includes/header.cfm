<cfif isDefined('session.secure.loggedin')>
  <!DOCTYPE html>
  <html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
      <meta charset='UTF-8'/>
      <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0' />
      <title>86Never.com OrderTracker Lists</title>
      <link rel="stylesheet" href="v1/css/bootstrap.css" />
      <link rel="stylesheet" href="v1/css/default.css?<cfoutput>#rand()#</cfoutput>" />
      <link rel="stylesheet" href="v1/css/fontawesome/css/font-awesome.min.css" />
    </head>
    <body>
      <!---<div class="dropdown">
        <button class="btn btn-secondary dropdown-toggle"
          type="button" id="dropdownMenuButton"
          data-toggle="dropdown"
          aria-haspopup="true" aria-expanded="false">
          Nav
      </button>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
          <a class="dropdown-item" href="list.cfm">List</a>
          <a class="dropdown-item" href="orders_open.cfm">Open Orders</a>
          <cfif isDefined('session.cart')>
            <a class="dropdown-item" href="cart.cfm">View Cart</a>
          </cfif>
          <a class="dropdown-item" href="order_email.cfm">Send Orders</a>
          <cfif isDefined('session.secure.RoleCode')>
            <cfif session.secure.RoleCode eq 1>
              <a class="dropdown-item" href="item.cfm">Edit Items</a>
              <a class="dropdown-item" href="list_organize.cfm">Organize Lists</a>
              <a class="dropdown-item" href="list_item.cfm">Manage List Items</a>
          </cfif>
          <cfif ListFind('1,4',session.secure.RoleCode)>
              <a class="dropdown-item" href="v1/index.cfm?action=admin.manageUsers">Manage Users</a>
              <a class="dropdown-item" href="v1/index.cfm?action=admin.manageBusiness">Manage Business</a>
            </cfif>
          </cfif>
          <a href="v1/index.cfm?action=admin.changepassword&login=1&userid=<cfoutput>#encrypt(session.secure.personId, application.uEncryptKey, "BLOWFISH", "Hex")#</cfoutput>" class="dropdown-item">Change Password</a>
          <br />
          <a class="dropdown-item" href="login_ctrl.cfm?action=logout">Logout</a>
        </div>
      </div>--->
      <div>
        <!--- Main Nav --->
        <div class="pageHeader">
          <span>Order Tracker</span>
          <cfif structKeyExists(session, 'secure') AND session.secure.loggedin>
            
            <a href="login_ctrl.cfm?action=logout" class="logOut mt-5">
              <i class="fa fa-power-off" aria-hidden="true"></i>
              LogOut
            </a>
            <cfoutput>
              <a href="v1/index.cfm?action=user.viewProfile&userid=#encrypt(session.secure.personId, application.uEncryptKey, "BLOWFISH", "Hex")#" class="logOut">
                <i class="fa fa-2x fa-user-circle" aria-hidden="true"></i>
              </a>
            </cfoutput>
          </cfif>
        </div>
        <cfif structKeyExists(session, 'secure')
          AND session.secure.loggedin>
          <div class="tabbar">
            <ul class="nav nav-tabs">
              <li class="nav-item">
                <a class="nav-link active" href="list.cfm">List</a>
              </li>
              <li role="presentation" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                  Orders <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="orders_open.cfm">Open Orders</a></li>
                  <li><a class="dropdown-item" href="order_email.cfm">Send Orders</a></li>
                  <cfif isDefined('session.cart')>
                    <li><a class="dropdown-item" href="cart.cfm">View Cart</a></li>
                  </cfif>
                </ul>
              </li>
              <cfif structKeyExists(session, 'secure')
                and ListFind('1,4',session.secure.RoleCode)>
                <li role="presentation" class="dropdown">
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    Admin <span class="caret"></span>
                  </a>
                  <ul class="dropdown-menu">
                    <cfif session.secure.RoleCode eq 1>
                    <li><a class="dropdown-item" href="item.cfm">Edit Items</a></li>
                    <li><a class="dropdown-item" href="list_organize.cfm">Organize Lists</a></li>
                    <li><a class="dropdown-item" href="list_item.cfm">Manage List Items</a></li>
                    </cfif>
                    <li><a class="dropdown-item" href="v1/index.cfm?action=admin.manageUsers">Manage Users</a></li>
                    <li><a class="dropdown-item" href="v1/index.cfm?action=admin.manageBusiness">Manage Business</a></li>
                  </ul>
                </li>
              </cfif>
            </ul>
          </div>
        </cfif>
      </div>
      <div class="main-content">
        <div class="row row-padding">
          <div class="col-sm-12 content_sec">
            <div class="fw1-body-wrapper">
      <!---<div>
      <a href="list.cfm">List</a><br />
      <a href="order.cfm">Order</a><br />
      <a href="supplier.cfm">Suppliers</a>
      <a href="vendors.cfm">Vendors</a><br />
      <a href="login_ctrl.cfm?action=logout">Logout</a
      <input type="button" onclick="location.href='list.cfm';" value="List" />
      <input type="button" onclick="location.href='orders_open.cfm';" value="Open Orders" />
      <cfif isDefined('session.cart')>
      <input type="button" onclick="location.href='cart.cfm';" value="View Cart" /><br />
      </cfif>
      <input type="button" onclick="location.href='order_email.cfm';" value="Send Orders" />
      <input type="button" onclick="location.href='login_ctrl.cfm?action=logout';" value="Logout" /><br />

      </div>>--->
</cfif>