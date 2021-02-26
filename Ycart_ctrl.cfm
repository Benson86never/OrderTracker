<cfinclude template="includes/secure.cfm" >
<cfset cartdatetime=#CreateODBCDateTime(Now())#>
	<cfdump var="#form#">
	<cfparam name = "session.cart.time" default = "#cartdatetime#">
	
<cfif isDefined('form.submit') and form.submit is "Add To Cart">
<cfoutput>
	Cart Time = #cartdatetime#
	<cfloop list="#form.fieldnames#" index="ThisField">
		#ThisField#
		
	</cfloop>
	<div>
	<cfloop index="i" list="#Form.FieldNames#" delimiters=",">
	    #i# = #Form[i]#<br>
	</cfloop>End Form Rows<br><br>
	</div>
</cfoutput>	
<cftransaction >
	<cfscript>
    Cart = EntityNew("carts");
    Cart.setdatetime("#cartdatetime#");
    Cart.setsubaccountid('#session.secure.subaccount#');
    Cart.setclosed(0);
    EntitySave(Cart);
    ThisCartID = Cart.getid();
	</cfscript>
</cftransaction>

<cfparam name = "session.cart.id" default = "#ThisCartID#">

CartID = <cfoutput>#ThisCartID#<br></cfoutput>
<cftransaction >	 
	 <cfloop index="i" list="#Form.FieldNames#" delimiters=",">
	    <cfif i contains "ITEM" and len(Form[i])>
	    	<cfoutput> #i# = #Form[i]#<br></cfoutput>
	    <cfset LoopItemID = #ListGetAt(i,1,";")#>
	    <cfset LoopSupplierID = #ListGetAt(i,2,";")#>
	    <cfoutput><br>Supplier = #LoopSupplierID#<br></cfoutput>
	    <cfscript>
	    	Join = EntityNew("JoinCartToItem");
	    	Join.setcartid("#session.cart.id#");
	    	Join.setitemid("#LoopItemID#");
	    	Join.setsupplierid("#LoopSupplierID#");
	    	Join.setquantity("#Form[i]#");
	    	EntitySave(Join);
	    </cfscript>
	    </cfif>
	</cfloop>
</cftransaction>
	<cflocation url="cart.cfm" addtoken="no">
</cfif>

<cfif isDefined('url.cartitemid') and url.action is "deleteitem">
	<cfscript>
 	application.carts_np.SetItemID(url.cartitemid);
    DeleteItem=application.carts_np.DeleteCartItem(Application.Datasource);
	</cfscript>
	<cflocation url="cart.cfm" addtoken="no">
</cfif>

