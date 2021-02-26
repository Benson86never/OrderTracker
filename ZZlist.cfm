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
		<meta charset='UTF-8'/>
  		<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0' />
		<cfinclude template="includes/bootstrap_head.cfm" >
		<title>86Never.com OrderTracker Lists</title>
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
  		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 		<script src="https://www.86never.com/js/jquery.ui.touch-punch.min.js"></script>
	</head>
	<body>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfoutput>
			<cfform name="Order" action="cart_ctrl.cfm">
			
			<cfloop array="#Lists#" index="list" >
				<cfif not isDefined("url.ListID")>
				<div><a href="#cgi.script_name#?ListID=#list.getID()#">#list.getName()#</a></div>
				</cfif>
			<cfif isDefined("url.ListID")>
			<!---Order Form Begins--->	
			<cfloop array="#Lists#" index="list" >
				<cfloop array="#list.getitem()#" index="item" >
					<cfset supplierArray=#item.getsupplier()#>
					<cfinput type="text" name="#item.getid()#;#supplierArray[1].getid()#;ITEM" size="3" validate="integer" message="#item.getname()# Quantity must be an integer.">
					<cfif item.units.getid() eq 2><span class="text-danger"><cfelse><span class="text-success"></cfif>#item.units.getname()#</span> - #item.getname()# <span style="color:blue">#supplierArray[1].getname()#</span><br />
				</cfloop>
			</cfloop>
				<input type="submit" name="Submit" value="Add To Cart" class="btn btn-success" onclick="this.disabled=true;this.value='Sending, please wait...';this.form.submit();" />
			<cfelse>
			</cfif>
			</cfloop>
			</cfform>
		</cfoutput>
		
		</div>
		<cfinclude template="includes/bootstrap_js.cfm" >
		</body>
	
</html>