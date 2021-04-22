<cfinclude template="includes/secure.cfm" >
<style>
	.order-item{
		padding: 10px 0px;
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
      <div class="panel-heading">Complete Order</div>
      <div class="panel-body">
<cfoutput>
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
</div>
</div>
</div>
</div>