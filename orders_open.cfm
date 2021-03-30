<cfinclude template="includes/secure.cfm" >
<cfparam  name="url.businessid" default="#session.secure.subaccount#">
<cfset orders = CreateObject("Component","v1.model.services.order").getOpenOrders(
		checkedIn = 0,
		businessId = url.businessid).openOrders>
<style>
	.orders{
		padding: 10px;
	}
	.page-content{
		padding-left: 20px;
	}
</style>
<cfinclude template="includes/header.cfm" >
<cfoutput>
	<div class = "col-xs-12 sectionHeader">
		Open Orders
	</div>
	<div class="page-content">
		<div class="orders">
			<cfif session.secure.RoleCode eq 1>
				<cfscript>
					local.accounts = [];
					local.accountDetails = queryExecute("
						SELECT
						businessId as businessId,
						businessname as name
						FROM
						business
						WHERE
						Active = 1
					",{},{datasource: application.dsn}
					);
					cfloop(query = "local.accountDetails") {
						local.details = {};
						local.details['id'] = local.accountDetails.businessId;
						local.details['name'] = local.accountDetails.name;
						arrayAppend(local.accounts, local.details);
					}
				</cfscript>
			</cfif>
			Orders from business: 
			<select name="business" onchange="changeBusiness(this.value)">
				<cfloop array="#local.accounts#" item="account">
					<option
					<cfif isdefined("url.businessid") and url.businessid eq account.id>
						selected
					</cfif>
					value="#account.id#">
					#account.name#
					</option>
				</cfloop>
			</select>
		</div>
		<cfif arraylen(orders)>
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
		<cfelse>
			<div class="orders">
				No orders.
			</div>
		</cfif>
	</div>
</cfoutput>
<cfinclude template="includes/footer.cfm" >
<script>
	function changeBusiness(businessId) {
		location.href = 'orders_open.cfm?businessid=' + businessId
	}
</script>