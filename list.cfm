<cfinclude template="includes/secure.cfm" >
<cfparam name="url.ListID" default="0">
<cfset listdetails = CreateObject("Component","v1.model.services.admin").getListDetails(
	businessId = session.secure.subaccount,
	includeItems = 1,
	listId = url.ListID)>
<style>
	.listItem{
		padding: 10px;
	}
	.page-content{
		padding-left: 20px;
	}
	.panel-default > .panel-heading {
    text-align: center;
    font-size: 24px;
}
    @media (max-width: 767px) {
     .panel-body {
       text-align: center !important;
      }
     .txtalign {
	   display: flex;
		margin: 10px;
		/*float: left;*/
       }
     .c1 {
	   margin:5px;
        }
	  .container {
         /*padding: 0 !important;*/
        padding: 0 !important;
		margin: 0 !important;
		margin-left: -8px !important;
		 margin-right: -13px !important;
       }
	}
</style>
<cfinclude template="includes/header.cfm" >
<cfoutput>
 <div class="container">
   <div class="panel panel-default">
      <div class="panel-heading">Lists</div>
      <div class="panel-body">
		<cfform name="Order" action="cart_ctrl.cfm">
			<cfloop array="#listdetails#" index="list" >
				<cfif NOT val(url.ListID)>
					<div class="listItem"><a href="#cgi.script_name#?ListID=#list.id#">#list.name#</a></div>
				</cfif>
				<cfif val(url.ListID)>
					<!---Order Form Begins--->
					<cfif arraylen(list.items)>
						<cfloop array="#list.items#" index="item" >
							<div class="listItem txtalign">
								<cfinput type="text" class="items" name="#item.itemId#;#item.SupplierID#;ITEM"
									size="3" validate="integer"
									message="#item.name# Quantity must be an integer.">
									<cfif item.unitId eq 2>
										<span class="text-danger">
									<cfelse>
										<span class="text-success">
									</cfif>
									<span class="c1">#item.unitName#</span>
									</span> - #item.name# <span style="color:blue">#item.supplierName#</span><br />
							</div>
						</cfloop>
						<input type="button" onclick="window.location.href='list.cfm'" class="btn btn-danger" class="btn btn-cancel" value="Cancel"/>
						<input type="submit" name="Submit" value="Add To Cart" class="btn btn-success" onclick="this.disabled=true;this.value='Sending, please wait...';this.form.submit();" />
					<cfelse>
						No items available.
					</cfif>
				</cfif>
			</cfloop>
		</cfform>
	</div>
		</div>
			</div>
				</div>
</cfoutput>
<cfinclude template="includes/footer.cfm" >
<script>
	$('.items').keypress(function(event){
       if(event.which > 57 || event.which <= 48){
           event.preventDefault();
       }
   });
</script>