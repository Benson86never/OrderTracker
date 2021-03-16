<cfinclude template="includes/secure.cfm" >
<cfscript>
// load open and non checked in orders
Orders = EntityLoad( "orders", { checkedin = 0 }, "datetime desc" );
</cfscript>
<style>
	.orders{
		padding: 10px;
	}
	.page-content{
		padding-left: 20px;
	}
</style>
<cfinclude template="includes/header.cfm" >
<div class = "col-xs-12 sectionHeader">
	Open Orders
</div>
<div class="page-content">
	<cfloop array="#Orders#" index="order">
		<cfset Supplier = EntityLoad("supplier", {id=#order.getsupplierid()#})>
		<cfset Person = EntityLoad("person", {id=#order.getpersonid()#})>
		<cfoutput>
			<cfif order.getClosed() eq 1>
				<div class="orders">
					#order.getid()#-<a href="order_detail.cfm?orderid=#order.getid()#&supplier=#Supplier[1].getname()#" class="text-success">#Supplier[1].getname()# - #dateTimeFormat(order.getdatetime(),"m/d/y h:nn:ss tt")# - #Person[1].getemail()#</a>
				</div>
			<cfelse>
				<div class="orders">
					#order.getid()#-<a href="order_detail.cfm?orderid=#order.getid()#&supplier=#Supplier[1].getname()#" class="text-danger">#Supplier[1].getname()# - #dateTimeFormat(order.getdatetime(),"m/d/y h:nn:ss tt")# - #Person[1].getemail()#</a><br />
				</div>
			</cfif>
		</cfoutput>
	</cfloop>
</div>
<cfinclude template="includes/footer.cfm" >