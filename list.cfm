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
</style>
<cfinclude template="includes/header.cfm" >
<cfoutput>
	<div class = "col-xs-12 sectionHeader">
		Lists
	</div>
	<div class="page-content">
		<cfform name="Order" action="cart_ctrl.cfm">
			<cfloop array="#listdetails#" index="list" >
				<cfif NOT val(url.ListID)>
					<div class="listItem"><a href="#cgi.script_name#?ListID=#list.id#">#list.name#</a></div>
				</cfif>
				<cfif val(url.ListID)>
					<!---Order Form Begins--->
					<cfif arraylen(list.items)>
						<cfloop array="#list.items#" index="item" >
							<div class="listItem">
								<cfinput type="text" name="#item.itemId#;#item.SupplierID#;ITEM"
									size="3" validate="integer"
									message="#item.name# Quantity must be an integer.">
									<cfif item.unitId eq 2>
										<span class="text-danger">
									<cfelse>
										<span class="text-success">
									</cfif>
									#item.unitName#
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
</cfoutput>
<cfinclude template="includes/footer.cfm" >