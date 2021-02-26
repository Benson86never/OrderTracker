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
<cfif isDefined('form.submit') and form.submit is "Place Order">	
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
	<cfset FirstLoop = 1>
<cftransaction >
	<cfloop query="CartItems">
		<cfif not isDefined('LastSupplierID') or (LastSupplierID neq SupplierID)>
		<cfscript>
	    Order = EntityNew("orders");
	    Order.setdatetime("#orderdatetime#");
	    Order.setsupplierid("#SupplierID#");
	    Order.setsubaccountid('#session.secure.subaccount#');
	    Order.setpersonid('#session.secure.personid#');
	    Order.setclosed(0);
	    Order.setcheckedin(0);
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
	    	Join.setcheckedin(0);
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

	<cflocation url="order_complete.cfm" addtoken="no">
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
	<cftransaction >	 
	 <cfloop index="i" list="#Form.FieldNames#" delimiters=",">
	 	<cfif isNumeric(i)>
	    <cfscript>
	    	CheckIn = EntityLoadByPK( "JoinOrderToItem", #i# );
			CheckIn.setcheckedin( "#Form[i]#" );
	    </cfscript>
	    </cfif>
	</cfloop>
	</cftransaction>
	<cflocation url="order_detail.cfm?orderid=#url.orderid#&supplier=#url.supplier#" addtoken="no">
</cfif>


<cfif isDefined('url.action') and url.action is "close">
	<cftransaction >	 
	    <cfscript>
	    	CheckIn = EntityLoadByPK( "orders", #url.orderid# );
			CheckIn.setcheckedin(1);
	    </cfscript>
	</cftransaction>
	<cflocation url="orders_open.cfm" addtoken="no">
</cfif>
