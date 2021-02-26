<cfinclude template="includes/secure.cfm" >
<cfscript>
// load Account Suppliers
Suppliers = EntityLoad( "masteraccount", { id=#session.secure.masteraccount# } );
Subaccounts = EntityLoad( "subaccount", { id=#session.secure.subaccount# } );
</cfscript>
<cfparam name="listLinked" default="none">
<!---<cfdump var="#linkedSupplier#" >
<cfdump var="#Suppliers#" >--->
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		
	</head>
	<body>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfoutput >
			
			<cfloop array="#Suppliers#" index="masteraccount" >
			<cfloop array="#masteraccount.getSupplier()#" index="supplier">
			<ul>
				<li>#supplier.getName()#</li>
				<cfform name="Order" action="order_ctrl.cfm">
					<input type="hidden" name="Supplier" value="#supplier.getID()#">
				<cfloop array="#supplier.getItem()#" index="item">
				<ul>
					<li><input  type="text" name="#item.getID()#" size="3">#item.getName()# (#item.units.getName()#)</li>
					<cfloop array="#Subaccounts#" index="subaccount">
						<cfloop array="#subaccount.getList()#" index="list">
							<cfscript>
							//listItems = EntityLoad( "list", {id=#list.getID()#} );
							listLinked = EntityLoad( "joinitemtolist", { ListID=#list.getID()#, ItemID=#item.getID()# } );
							</cfscript>
						</cfloop>
					</cfloop>
				</ul>
				</cfloop>
				<input type="submit" name="Submit" value="Place Order">
				</cfform>
			</ul>
			</cfloop>
			</cfloop>
			
		</cfoutput>
		<cfinclude template="includes/bootstrap_js.cfm" >	
		</div>
	</body>
	
</html>