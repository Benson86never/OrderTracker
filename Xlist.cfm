<cfinclude template="includes/secure.cfm" >

<cfscript>
	
	if (isDefined("url.ListID")) {
	Lists = EntityLoad( "list", { id=#url.ListID# }, "Orderby Asc" );
	}
	else {
	Lists = EntityLoad( "list", { subaccountid=#session.secure.subaccount# }, "Orderby Asc" );
	}
	ListsQuery = EntityToQuery(Lists, "item");
</cfscript>
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		<title>86Never.com OrderTracker Lists</title>
	</head>
	<body>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfoutput>
			<cfform name="Order" action="order_confirm.cfm">
			<ul>
			<cfloop array="#Lists#" index="list" >
				<li />#list.getName()#<!---<a href="#cgi.script_name#?ListID=#list.getID()#">#list.getName()#/a>--->
				<cfif isDefined("url.ListID")>
					<input type="hidden" name="Supplier" value="#url.SupplierID#">
				<ul>
				<cfloop array="#list.getitem()#" index="item" >
					
				<cfloop array="#item.supplier#" index="supplier">
					
					<cfif url.SupplierID is supplier.getid()>
						<li /><input type="text" name="#item.getid()#" size="3"> #item.getname()# (#item.units.getname()#) 
						<!---#item.getid()# #supplier.getname()# #supplier.getid()#--->
					</cfif>
				</cfloop>
				</cfloop>
				</ul>
				<input type="submit" name="Submit" value="Review Order">
				<cfelse>
				<ul>
				<cfloop array="#list.getitem()#" index="item" >
					<ul>
				<cfloop array="#item.supplier#" index="supplier">
					<cfparam name="LoopSupplier" default="">
					<cfif not listContains(LoopSupplier, "#supplier.getid()#")>
					<cfset LoopSupplier = ListAppend(LoopSupplier, #supplier.getid()#)>
					<!---List = <cfdump var="#LoopSupplier#">--->
					<li /><a href="#cgi.script_name#?ListID=#list.getID()#&SupplierID=#supplier.getid()#">#supplier.getname()#</a><br />
					</cfif>
				</cfloop>
					</ul>
				</cfloop>
				<cfset LoopSupplier = "">
				</ul>
				</cfif>
		
			</cfloop>
			</ul>
			</cfform>
		</cfoutput>
		
		</div>
		<cfinclude template="includes/bootstrap_js.cfm" >
		</body>
	
</html>