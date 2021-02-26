<cfinclude template="includes/secure.cfm" >
<cfset cartdatetime=#CreateODBCDateTime(Now())#>

	<cfparam name = "session.cart.time" default = "#cartdatetime#">

<cfscript>
	transaction {
    Cart = EntityNew("carts");
    Cart.setdatetime("#cartdatetime#");
    Cart.setsubaccountid('#session.secure.subaccount#');
    Cart.setclosed(0);
    EntitySave(Cart);
    ThisCartID = Cart.getid();
    transaction action="commit";
    }
	</cfscript>


<cfparam name = "session.cart.id" default = "#ThisCartID#">

 
	 <cfloop index="i" list="#Form.FieldNames#" delimiters=",">
	    <cfif i contains "ITEM" and len(Form[i])>
	    <cfset LoopItemID = #ListGetAt(i,1,";")#>
	    <cfset LoopSupplierID = #ListGetAt(i,2,";")#>
	    <cfscript>
	    	transaction {
	    	Join = EntityNew("JoinCartToItem");
	    	Join.setcartid("#session.cart.id#");
	    	Join.setitemid("#LoopItemID#");
	    	Join.setsupplierid("#LoopSupplierID#");
	    	Join.setquantity("#Form[i]#");
	    	EntitySave(Join);
	    	transaction action="commit";
	    	}
	    </cfscript>
	    </cfif>
	</cfloop>
	<cflocation url="cart.cfm" addtoken="no">

<!--- Code below is depreciated and new code is in order_ctrl
<cfif isDefined('url.cartitemid') and url.action is "deleteitem">
	<cfscript>
 	application.carts_np.SetItemID(url.cartitemid);
    DeleteItem=application.carts_np.DeleteCartItem(Application.Datasource);
	</cfscript>
	<cflocation url="cart.cfm" addtoken="no">
</cfif>--->

