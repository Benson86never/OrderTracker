<cfinclude template="includes/secure.cfm" >
<cfscript>
// load open and non checked in orders
Orders = EntityLoad( "orders", { checkedin = 0 }, "datetime desc" );
</cfscript>
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		
	</head>
	<body>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfloop array="#Orders#" index="order">
			<cfset Supplier = EntityLoad("supplier", {id=#order.getsupplierid()#})>
			<cfset Person = EntityLoad("person", {id=#order.getpersonid()#})>
			<cfoutput>
				<cfif order.getClosed() eq 1>
					#order.getid()#-<a href="order_detail.cfm?orderid=#order.getid()#&supplier=#Supplier[1].getname()#" class="text-success">#Supplier[1].getname()# - #dateTimeFormat(order.getdatetime(),"m/d/y h:nn:ss tt")# - #Person[1].getemail()#</a><br />
				<cfelse>
					#order.getid()#-<a href="order_detail.cfm?orderid=#order.getid()#&supplier=#Supplier[1].getname()#" class="text-danger">#Supplier[1].getname()# - #dateTimeFormat(order.getdatetime(),"m/d/y h:nn:ss tt")# - #Person[1].getemail()#</a><br />
				</cfif>
			</cfoutput>
		</cfloop>
		<cfinclude template="includes/bootstrap_js.cfm" >	
		</div>
	</body>
	
</html>