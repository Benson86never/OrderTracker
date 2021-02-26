<cfinclude template="includes/secure.cfm" >
<cfscript>
	myarray = #application.orderform.getform()#;
	OrderSupplier = EntityLoad( "supplier", { id=#form.supplier# } );
	n=arraylen(OrderSupplier);
	for (i=1;i<=n;i++){
        	ThisSupplier = OrderSupplier[i].getname();
        	ThisSupplierID = OrderSupplier[i].getid();
        	}
</cfscript>
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		<title>86Never.com OrderTracker Order Confirm.</title>
	</head>
	<body>
		<cfoutput>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfform name="Order" action="order_ctrl.cfm">
			<!--- confirm form --->
			Supplier: #ThisSupplier#
			<input type="hidden" name="supplier" value="#ThisSupplierID#">
				<cfset l = 1>
			<cfloop from="1" to="#ArrayLen(myarray)#" index="y">
		        <cfloop from="0" to="#ArrayLen(myarray[i])#" index="z">
		        	<cfset ItemName = #myarray[y][1]#>
		            <cfset ItemID = #myarray[y][2]#>
		            <cfset ItemQuantity = #myarray[y][3]#>
		    	</cfloop>
		    	<ul>
		    	<li />#ItemName# #ItemQuantity#
		    	<input type="hidden" name="#ItemID#" value="#ItemQuantity#">
		    	</ul>
			</cfloop>
			<input type="submit" name="Submit" value="Place Order">
			<!--- end confirm form --->
		</cfform>
		
		</div>
		<cfinclude template="includes/bootstrap_js.cfm" >
		</cfoutput>
		</body>
	
</html>

