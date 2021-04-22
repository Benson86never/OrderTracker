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
   @media (max-width: 767px) {
      .container {
         /*padding: 0 !important;*/
         padding: 0 !important;
		 margin: 0 !important;
		 margin-left: -8px !important;
		 margin-right: -13px !important;
        }
		.page-content {
			text-align: center !important;
		}
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