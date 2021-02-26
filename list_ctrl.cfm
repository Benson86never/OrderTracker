It worked
<cfscript>
	//ListLinked = EntityLoad( "JoinMasterAccountToSupplier", { SupplierID=#url.SupplierID#, MasterID=#session.masteraccount# }, True );
</cfscript>
<cfif isDefined('url.action') and url.action is "addList">	
	<cfscript>
    Join = EntityNew("joinitemtolist");
    Join.setlistid("#url.ListID#");
    Join.setitemid("#url.ItemID#");
    Join.setsequence(1);
    EntitySave(Join);
	</cfscript>
 <cflocation url="list_item.cfm?supplier=#URL.SupplierID#" >
</cfif>
<cfif isDefined('url.action') and url.action is "removeList">	
	<cfscript>
	RemoveJoin = QueryExecute("delete from joinitemtolist where ID = :ID",
	{ID=url.JoinID});
	</cfscript>
 <cflocation url="list_item.cfm?supplier=#URL.SupplierID#" >
</cfif>
<!---
<cfif not SupplierLinked.MasterID>
<cfif url.action is "LinkSupplier">	
	<cfscript>
    Join = EntityNew("JoinMasterAccountToSupplier");
    Join.setmasterid("#session.secure.masteraccount#");
    Join.setsupplierid("#url.SupplierID#");
    EntitySave(Join);
	</cfscript>
</cfif>
</cfif>--->
