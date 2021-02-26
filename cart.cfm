<cfinclude template="includes/secure.cfm" >
<cfscript>
	Cart = EntityLoad( "carts", { id=#session.cart.id# } );
</cfscript>
<cfif isDefined("Session.cart.id")>
 <cfscript>
 	application.carts_np.SetCartID(Session.cart.id);
    getCart=application.carts_np.GetCartItems(Application.Datasource);
 </cfscript>
 <cfelse>
 No Cart
 <cfabort>
 </cfif>
 <cfset CartItems = deserializeJSON(getCart, false)>
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		
	</head>
	<body>
		<div class="container-fluid">
		<cfoutput>
		<cfinclude template="includes/header.cfm" >
		<!---<cfloop array="#Cart#" index="cart">
			#cart.getDateTime()#<br />
			<cfloop array="#Cart.getitem()#" index="items">
				<cfset SupplierID = EntityLoad( "JoinCartToItem", { itemid=#items.getid()#, cartid=#cart.getid()# } )>
				#items.getName()# #items.getID()# 
				<cfloop array="#SupplierID#" index="supplierid">
				Quantity = #supplierid.getquantity()#
				Supplier = #supplierid.getsupplierid()#
				<cfset Supplier = EntityLoad( "Supplier", { id=#supplierid.getsupplierid()# } )>
				<cfloop array="#Supplier#" index="supplier">
				 #supplier.getname()#
				<br />	
				</cfloop>
				</cfloop>
			</cfloop>
		</cfloop>--->
		<div>#CartItems.DateTime#</div>
		<div style="margin-bottom:1em;">Check items if you want to delete them. <strong>You are not required to check items to order them.</strong></div>
		<cfform action="order_ctrl.cfm">
		<cfloop query="CartItems" >
			<div>
				<input type="checkbox" name="CartItemID#CartItemID#" value="#CartItemID#">
				#Quantity# - #ItemName#, (#UnitName#) from #SupplierName#
			</div>
		</cfloop>
		<input type="Submit" name="Submit" value="Place Order" class="btn btn-success" />
		<input type="Submit" name="Submit" value="Delete Items" class="btn btn-danger" />
		</cfform>
		<cfinclude template="includes/bootstrap_js.cfm" >
		</cfoutput>	
		</div>
	</body>
	
</html>