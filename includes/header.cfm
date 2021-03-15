<cfif isDefined('session.secure.loggedin')>
  <div class="dropdown">
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
  </div>
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