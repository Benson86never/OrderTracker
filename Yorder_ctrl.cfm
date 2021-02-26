<cfset orderdatetime=#CreateODBCDateTime(Now())#>

<!---<cfdump var="#form#" >
Order Placed = #orderdatetime#
<cfloop list="#form.fieldnames#" index="ThisField">
	#ThisField#
	
</cfloop>
<div>
<cfloop index="i" list="#Form.FieldNames#" delimiters=",">
    #i# = #Form[i]#<br>
</cfloop>
</div>
<cfset Supplier=#Form.Supplier#>
This Supplier=#Supplier#
</cfoutput>--->
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
<cfif form.submit is "Place Order">	
	<cfset FirstLoop = 1>
<cftransaction >
	<cfloop query="CartItems">
		<cfif not isDefined('LastSupplierID') or (LastSupplierID neq SupplierID)>
		<cfscript>
	    Order = EntityNew("orders");
	    Order.setdatetime("#orderdatetime#");
	    Order.setsupplierid("#SupplierID#");
	    Order.setsubaccountid('#session.secure.subaccount#');
	    Order.setclosed(0);
	    EntitySave(Order);
	    ThisOrderID = Order.getid();
		</cfscript>
		</cfif>

 	
	 OrderID = <cfoutput>#ThisOrderID#</cfoutput>	 
	 
	    <cfscript>
	    	Join = EntityNew("JoinOrderToItem");
	    	Join.setorderid("#ThisOrderID#");
	    	Join.setitemid("#ItemID#");
	    	Join.setquantity("#Quantity#");
	    	Join.setsupplierid("#SupplierID#");
	    	EntitySave(Join);
	    </cfscript>
	    <cfset LastSupplierID = "#SupplierID#">
	</cfloop>


	
		<cfscript>
			CloseCart = EntityLoadByPK( "carts", #session.cart.id# );
			StructDelete(Session, "cart");
			CloseCart.setClosed( "1" );
		</cfscript>
		
</cftransaction>

	<cflocation url="order_complete.cfm" addtoken="yes">
</cfif>
