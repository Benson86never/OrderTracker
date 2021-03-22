<cfinclude template="includes/secure.cfm" >
<cfset cartdatetime = #CreateODBCDateTime(Now())#>
<cfparam name = "session.cart.time" default = "#cartdatetime#">
<cfif not isDefined('session.cart.id')>
	<cfset session.cart.id = CreateObject("Component","v1.model.services.order").createemptyCart(
		businessId = session.secure.subaccount)>
</cfif>
 <cfif isDefined('session.cart.id')>
	<cfset cartArray = []>
	 <cfloop index="i" list="#Form.FieldNames#" delimiters=",">
	    <cfif i contains "ITEM" and len(Form[i])>
	    <cfset LoopItemID = #ListGetAt(i,1,";")#>
	    <cfset LoopSupplierID = #ListGetAt(i,2,";")#>
		<cfset cartDetails = {}>
		<cfset cartDetails['cartId'] = session.cart.id>
		<cfset cartDetails['itemId'] = LoopItemID>
		<cfset cartDetails['supplierId'] = LoopSupplierID>
		<cfset cartDetails['quantity'] = Form[i]>
		<cfset arrayAppend(cartArray, cartDetails)>
		</cfif>
	</cfloop>
	<cfif arrayLen(cartArray)>
		<cfset CreateObject("Component","v1.model.services.order").updateCart(
			cartArray = cartArray)>
	</cfif>
</cfif>
<cflocation url="cart.cfm" addtoken="no">

