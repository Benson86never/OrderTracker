<cfinclude template="includes/secure.cfm" >
<cfscript>
// load open and non checked in orders
OrderDetail = EntityLoad( "JoinOrderToItem", { orderid = #url.orderid# } );
</cfscript>
<style>
	.order-detail,.orderItem{
		padding: 10px;
	}
	.page-content{
		padding-left: 20px;
	}
</style>
<cfinclude template="includes/header.cfm" >
<div class = "col-xs-12 sectionHeader">
	Order Details
</div>
<div class="page-content">
	<div class="order-detail">
		<cfoutput><strong>#url.supplier# #url.orderid#</strong></cfoutput>
		<cfform name="checkedin" action="order_ctrl.cfm?action=checkin&orderid=#url.orderid#&supplier=#url.supplier#" >
			<cfloop array="#OrderDetail#" index="item">
				<div class="orderItem">
					<cfset orderitem = EntityLoad("item", {id = #item.getitemid()#})>
					<cfif item.getcheckedin() eq 0>
						<cfset OrderComplete = "no">
					</cfif>
					<cfoutput>
						Received Yes <input type="radio" name="#item.getid()#" value="yes" <cfif item.getcheckedin() eq 1>checked="yes"</cfif> >&nbsp
						No <input type="radio" name="#item.getid()#" value="No" <cfif item.getcheckedin() eq 0>checked="yes"</cfif>>
						(#item.getquantity()#) #orderitem[1].getName()#<br />
					</cfoutput>
				</div>
			</cfloop>
			<cfinput name="submit" type="submit" Value="Check In" class="btn btn-primary">
			<cfif not isDefined('OrderComplete')>
			<cfinput name="Action" type="Button" value="Close Order" onclick="window.location.href = 'order_ctrl.cfm?orderid=#url.orderid#&action=close';" class="btn btn-success">
			</cfif>
		</cfform>
	</div>
</div>
<cfinclude template="includes/footer.cfm" >