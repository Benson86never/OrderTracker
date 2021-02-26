<cfoutput>
	
<cfset orderdatetime=#CreateODBCDateTime(Now())#>

<cfdump var="#form#" >
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
</cfoutput>
<cfif form.submit is "Place Order">	
<cftransaction >
	<cfscript>
    Order = EntityNew("orders");
    Order.setdatetime("#orderdatetime#");
    Order.setSupplierID("#form.supplier#");
    Order.setsubaccountid('#session.secure.subaccount#');
    EntitySave(Order);
    ThisOrderID = Order.getid();
	</cfscript>
</cftransaction>

 	
	 OrderID = <cfoutput>#ThisOrderID#</cfoutput>
<cftransaction >	 
	 <cfloop index="i" list="#Form.FieldNames#" delimiters=",">
	    #i# = #Form[i]#<br>
	    <cfif isNumeric(i)>
	    <cfscript>
	    	Join = EntityNew("JoinOrderToItem");
	    	Join.setorderid("#ThisOrderID#");
	    	Join.setitemid("#i#");
	    	Join.setquantity("#Form[i]#");
	    	EntitySave(Join);
	    </cfscript>
	    </cfif>
	</cfloop>
</cftransaction>
	<cflocation url="order_complete.cfm?orderid=#ThisOrderID#&SupplierID=#form.supplier#" addtoken="yes">
</cfif>
