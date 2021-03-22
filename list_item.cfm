<cfinclude template="includes/secure.cfm" >
<cfscript>
// load Account Suppliers
Suppliers = CreateObject("Component","v1.model.services.admin").getSupplierDetails(
	businessId = session.secure.subaccount,
	includeItems = 1);
listdetails = CreateObject("Component","v1.model.services.admin").getListDetails(
		businessId = session.secure.subaccount,
		includeItems = 1);
</cfscript>
<cfparam name="listLinked" default="none">
<style>
	ul{
		padding-top: 10px;
	}
	.page-content{
		padding-left: 20px;
	}
</style>
<cfinclude template="includes/header.cfm" >
<div class = "col-xs-12 sectionHeader">
	Manage List Items
</div>
<div class="page-content">
	<cfoutput >
		<cfform name="LinkLists" action="list_ctrl.cfm">
			<cfloop array="#Suppliers#" index="supplier" >
				<ul>
					<li>#supplier.name#</li>
					<cfloop array="#supplier.items#" index="item">
						<ul>
							<li>#item.name# (#item.unitName#)</li>
							<cfloop array="#listdetails#" index="list">
								<cfset joinItemtoListId = 0>
								<cfloop array="#list.items#" index="listItem">
									<cfif listItem.itemId EQ item.id>
										<cfset joinItemtoListId = listItem.Id>
									</cfif>
								</cfloop>
								<cfif joinItemtoListId>
									<span style="color:green">#list.name#</span>
									<a href="list_ctrl.cfm?action=removeList&JoinID=#joinItemtoListId#&ItemID=#item.id#&SupplierID=#supplier.id#">(Remove)</a>
								<cfelse>
									<span style="color:##c0c0c0">#list.name#</span>
									<a href="list_ctrl.cfm?action=addList&ListID=#List.id#&ItemID=#item.id#&SupplierID=#supplier.id#">(Add)</a>
								</cfif>
								&nbsp|&nbsp
							</cfloop> 
						</ul>
					</cfloop>
				</ul>
			</cfloop>
		</cfform>
	</cfoutput>
</div>
<cfinclude template="includes/footer.cfm" >