<cfinclude template="includes/secure.cfm" >
<style>
	.order-item{
		padding: 10px 0px;
	}
	.page-content{
		padding-left: 20px;
	}
</style>
<cfinclude template="includes/header.cfm" >
<cfoutput>
	<div class = "col-xs-12 sectionHeader">
		Complete Order
	</div>
	<div class="page-content">
		<div class="order-item"> 
			Your order is now listed in open orders.
		</div> 
		<div class="order-item">
			To complete your order click <a href="order_email.cfm">Send Orders</a>
		</div>
		<div class="order-item">
			To view in open orders click <a href="orders_open.cfm">Open Orders</a>
		</div>
	</div>
</cfoutput>