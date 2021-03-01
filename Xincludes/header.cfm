<cfif isDefined('session.secure.loggedin')>
<div>
	<!---<a href="list.cfm">List</a><br />
	<a href="order.cfm">Order</a><br />
	<a href="supplier.cfm">Suppliers</a>
	<a href="vendors.cfm">Vendors</a><br />
	<a href="login_ctrl.cfm?action=logout">Logout</a>--->
	<input type="button" onclick="location.href='login_ctrl.cfm?action=logout';" value="Logout" />
</div>
</cfif>