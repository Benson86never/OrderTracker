<cfinclude template="includes/secure.cfm" >
<style>
	.cartItem{
		padding: 10px;
	}
	.page-content{
		padding-left: 20px;
	}
	.panel-body {
		margin-left: 200px;
	}
	.panel-default > .panel-heading {
    text-align: center;
    font-size: 24px;
}
    @media (max-width: 767px) {
	.panel-body {
		/*text-align: center !important;*/
		margin-left: 20px;
      }
	}
</style>
<cfinclude template="includes/header.cfm" >
<cfoutput>
	<div class="container">
   <div class="panel panel-default">
      <div class="panel-heading">Cart</div>
      <div class="panel-body">
	<div class="page-content">
		<cfif isDefined("Session.cart.id")>
			<cfscript>
				application.carts_np.SetCartID(Session.cart.id);
			   	getCart=application.carts_np.GetCartItems(Application.Datasource);
				CartItems = deserializeJSON(getCart, false);
			</cfscript>
		<cfelse>
			No Items in Cart
		</cfif>
		<cfif NOT CartItems.recordcount>
			No Items in Cart
		<cfelse>
			<div>#CartItems.DateTime#</div>
			<div style="margin-bottom:1em;">Check items if you want to delete them. <strong>You are not required to check items to order them.</strong></div>
			<cfform action="order_ctrl.cfm">
			<cfloop query="CartItems" >
				<div class="cartItem">
					<input type="checkbox" name="CartItemID#CartItemID#" value="#CartItemID#">
					#Quantity# - #ItemName#, (#UnitName#) from #SupplierName#
				</div>
			</cfloop>
			<input type="Submit" name="Submit" value="Place Order" class="btn btn-success" />
			<input type="Submit" name="Submit" value="Delete Items" class="btn btn-danger" />
			</cfform>	
		</cfif>
		<cfinclude template="includes/bootstrap_js.cfm" >
	</div>
	</div>
	</div>
	</div>
	</div>
</cfoutput>
<cfinclude template="includes/footer.cfm" >