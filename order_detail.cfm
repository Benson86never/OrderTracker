<cfinclude template="includes/secure.cfm" >
<cfset orderItems = CreateObject("Component","v1.model.services.order").getOrderDetails(
			orderId = url.orderid).items>
<style>
	.order-detail,.orderItem{
		padding: 10px;
	}
	.page-content{
		padding-left: 20px;
	}
	.panel-default > .panel-heading {
  text-align: center;
  font-size: 24px;
}
</style>
<cfinclude template="includes/header.cfm" >
<div class="container">
    <div class="panel panel-default">
      <div class="panel-heading">Order Details</div>
      <div class="panel-body">
<div class="page-content">
	<div class="order-detail">
		<cfoutput><strong>#url.supplier# #url.orderid#</strong></cfoutput>
		<cfform name="checkedin" action="order_ctrl.cfm?action=checkin&orderid=#url.orderid#&supplier=#url.supplier#" >
			<cfloop array="#orderItems#" index="item">
				<div class="orderItem">
					<cfif item.checkedIn eq 0>
						<cfset OrderComplete = "no">
					</cfif>
					<cfoutput>
						Received Yes <input type="radio" name="#item.id#" value="yes" <cfif item.checkedIn eq 1>checked="yes"</cfif> >&nbsp
						No <input type="radio" name="#item.id#" value="No" <cfif item.checkedIn eq 0>checked="yes"</cfif>>
						(#item.quantity#) #item.itemName#<br />
					</cfoutput>
				</div>
			</cfloop>
			<input type="button" onclick="window.location.href='orders_open.cfm'" class="btn btn-danger" class="btn btn-cancel" value="Cancel"/>
			<cfinput name="submit" type="submit" Value="Check In" class="btn btn-primary">
			<cfif not isDefined('OrderComplete')>
				&nbsp;<cfinput name="Action" type="Button" value="Close Order" onclick="window.location.href = 'order_ctrl.cfm?orderid=#url.orderid#&action=close';" class="btn btn-success">
			</cfif>
		</cfform>
	</div>
</div>
</div>
</div>
</div>
</div>
<cfinclude template="includes/footer.cfm" >