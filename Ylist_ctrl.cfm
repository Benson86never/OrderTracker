It worked
<cfscript>
	//ListLinked = EntityLoad( "JoinMasterAccountToSupplier", { SupplierID=#url.SupplierID#, MasterID=#session.masteraccount# }, True );
</cfscript>
<cfif isDefined('url.action') and url.action is "addList">	
	<cfscript>
    Join = EntityNew("joinitemtolist");
    Join.setlistid("#url.ListID#");
    Join.setitemid("#url.ItemID#");
    EntitySave(Join);
	</cfscript>
 <cflocation url="supplier.cfm?supplier=#URL.SupplierID#" >
</cfif>
<cfif isDefined('url.action') and url.action is "removeList">	
	<cfscript>
	RemoveJoin = EntityLoadByPK( "joinitemtolist", #url.JoinID# );
	EntityDelete( RemoveJoin );
	</cfscript>
 <cflocation url="supplier.cfm?supplier=#URL.SupplierID#" >
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
