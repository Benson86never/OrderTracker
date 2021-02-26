<cfinclude template="includes/secure.cfm" >
<cfscript>
// load Account Suppliers
Suppliers = EntityLoad( "masteraccount", { id=#session.secure.masteraccount# } );
Subaccounts = EntityLoad( "subaccount", { id=#session.secure.subaccount# } );
</cfscript>
<cfparam name="listLinked" default="none">

<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		
	</head>
	<body>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfoutput >
			<cfform name="LinkLists" action="list_ctrl.cfm">
			<cfloop array="#Suppliers#" index="masteraccount" >
			<cfloop array="#masteraccount.getSupplier()#" index="supplier">
			<ul>
				<li>#supplier.getName()#</li>
				<cfloop array="#supplier.getItem()#" index="item">
				<ul>
					<li>#item.getName()# (#item.units.getName()#)</li>
					<cfloop array="#Subaccounts#" index="subaccount">
						<cfloop array="#subaccount.getList()#" index="list">
							<cfscript>
							//listItems = EntityLoad( "list", {id=#list.getID()#} );
							listLinked = EntityLoad( "joinitemtolist", { ListID=#list.getID()#, ItemID=#item.getID()# } );
							</cfscript>
							<cfloop array="#listLinked#" index="joinitemtolist">
							</cfloop>
							
							<cfif not ArrayIsEmpty(listLinked)> 
							<span style="color:green">#list.getName()#</span>
							<a href="list_ctrl.cfm?action=removeList&JoinID=#joinitemtolist.getID()#&ItemID=#item.getID()#&SupplierID=#supplier.getID()#">(Remove)</a>
							<cfelse>
							<span style="color:##c0c0c0">#list.getName()#</span>
							<a href="list_ctrl.cfm?action=addList&ListID=#List.getID()#&ItemID=#item.getID()#&SupplierID=#supplier.getID()#">(Add)</a>
							</cfif>
							&nbsp|&nbsp
						</cfloop>
					</cfloop>
				</ul>
				</cfloop>
			</ul>
			</cfloop>
			</cfloop>
			</cfform>
		</cfoutput>	
		<cfinclude template="includes/bootstrap_js.cfm" >
		</div>
	</body>
	
</html>