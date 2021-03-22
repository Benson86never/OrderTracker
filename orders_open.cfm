<cfinclude template="includes/secure.cfm" >
<cfset orders = CreateObject("Component","v1.model.services.order").getOpenOrders(
		checkedIn = 0).openOrders>
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
		<cfoutput>
			<cfif order.closed eq 1>
				<div class="orders">
					#order.id#-<a href="order_detail.cfm?orderid=#order.id#&supplier=#order.supplierName#" class="text-success">
						#order.supplierName# - #dateTimeFormat(order.dateTime,"m/d/y h:nn:ss tt")# - #order.email#</a>
				</div>
			<cfelse>
				<div class="orders">
					#order.id#-<a href="order_detail.cfm?orderid=#order.id#&supplier=#order.supplierName#" class="text-danger">
						#order.supplierName# - #dateTimeFormat(order.dateTime,"m/d/y h:nn:ss tt")# - #order.email#</a><br />
				</div>
			</cfif>
		</cfoutput>
	</cfloop>
</div>
<cfinclude template="includes/footer.cfm" >