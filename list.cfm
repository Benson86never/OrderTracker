<cfinclude template="includes/secure.cfm" >
<cfscript>	
	if (isDefined("url.ListID")) {
	Lists = EntityLoad( "list", { id=#url.ListID# }, "Orderby Asc" );
	}
	else {
	Lists = EntityLoad( "list", { }, "Orderby Asc" );
	}
	ListsQuery = EntityToQuery(Lists, "item");
</cfscript>

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
			<cfloop array="#Lists#" index="list" >
				<cfif not isDefined("url.ListID")>
					<div class="listItem"><a href="#cgi.script_name#?ListID=#list.getID()#">#list.getName()#</a></div>
				</cfif>
			<cfif isDefined("url.ListID")>
				<!---Order Form Begins--->	
				<cfloop array="#Lists#" index="list" >
					<cfloop array="#list.getitem()#" index="item" >
						<cfset supplierArray=#item.getsupplier()#>
						<div class="listItem">
							<cfinput type="text" name="#item.getid()#;#supplierArray[1].getid()#;ITEM" size="3" validate="integer" message="#item.getname()# Quantity must be an integer.">
							<cfif isDefined('item.units')><cfif item.units.getid() eq 2><span class="text-danger"><cfelse><span class="text-success"></cfif>#item.units.getname()#</span> - </cfif>#item.getname()# <span style="color:blue">#supplierArray[1].getname()#</span><br />
						</div>
					</cfloop>
				</cfloop>
				<input type="submit" name="Submit" value="Add To Cart" class="btn btn-success" onclick="this.disabled=true;this.value='Sending, please wait...';this.form.submit();" />
			</cfif>
			</cfloop>
		</cfform>
	</div>
</cfoutput>
<cfinclude template="includes/footer.cfm" >