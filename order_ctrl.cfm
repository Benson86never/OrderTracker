<cfset orderdatetime=#CreateODBCDateTime(Now())#>
<cfif isDefined('form.submit') and form.submit is "Place Order">
	<cfif isDefined("Session.cart.id")>
		<cfset CartItems = CreateObject("Component","v1.model.services.order").getCartDetails(
			cartId = Session.cart.id).cartItems>
		<cfset CreateObject("Component","v1.model.services.order").placeOrder(
			CartItems = CartItems)>
		<cflocation url="order_complete.cfm" addtoken="no">
 	<cfelse>
		<cfinclude template="includes/header.cfm" >
		<cfoutput>
			<div class = "col-xs-12 sectionHeader">
				Order
			</div>
			<div>No items in the Cart</div>
		</cfoutput>
	</cfif>
</cfif>

<cfif isDefined('form.submit') and form.submit is "Delete Items">
	<cfloop index="i" list="#Form.FieldNames#" delimiters=",">
		<cfoutput>#i# = #form[i]#</cfoutput>
		<cfif isNumeric('#form[i]#')>
			<cfscript>
				application.carts_np.SetItemID("#form[i]#");
					DeleteItem=application.carts_np.DeleteCartItem(Application.Datasource);
			</cfscript>
		</cfif>
	</cfloop>
	<cflocation url="cart.cfm" addtoken="no">
</cfif>

<cfif isDefined('url.action') and url.action is "checkin">
	<cfset CreateObject("Component","v1.model.services.order").checkinOrder(
		formdetails = form)>
	<cflocation url="order_detail.cfm?orderid=#url.orderid#&supplier=#url.supplier#" addtoken="no">
</cfif>


<cfif isDefined('url.action') and url.action is "close">
	<cfset CreateObject("Component","v1.model.services.order").closeOrder(
		orderId = url.orderid)>
	<cflocation url="orders_open.cfm" addtoken="no">
</cfif>

<cfinclude template="includes/footer.cfm" >