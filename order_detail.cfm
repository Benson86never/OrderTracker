<cfinclude template="includes/secure.cfm" >
<cfscript>
// load open and non checked in orders
OrderDetail = EntityLoad( "JoinOrderToItem", { orderid = #url.orderid# } );
</cfscript>
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		
	</head>
	<body>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfoutput><h5>#url.supplier# #url.orderid#</h5></cfoutput>
		<cfform name="checkedin" action="order_ctrl.cfm?action=checkin&orderid=#url.orderid#&supplier=#url.supplier#" >
			<cfloop array="#OrderDetail#" index="item">
				<cfset orderitem = EntityLoad("item", {id = #item.getitemid()#})>
				<cfif item.getcheckedin() eq 0>
					<cfset OrderComplete = "no">
				</cfif>
				<cfoutput>
					Received Yes <input type="radio" name="#item.getid()#" value="yes" <cfif item.getcheckedin() eq 1>checked="yes"</cfif> >&nbsp
					No <input type="radio" name="#item.getid()#" value="No" <cfif item.getcheckedin() eq 0>checked="yes"</cfif>>
					(#item.getquantity()#) #orderitem[1].getName()#<br />
				</cfoutput>
			</cfloop>
			<cfinput name="submit" type="submit" Value="Check In" class="btn btn-primary">
			<cfif not isDefined('OrderComplete')>
			<cfinput name="Action" type="Button" value="Close Order" onclick="window.location.href = 'order_ctrl.cfm?orderid=#url.orderid#&action=close';" class="btn btn-success">
			</cfif>
		</cfform>
		<cfinclude template="includes/bootstrap_js.cfm" >	
		</div>
	</body>
	
</html>