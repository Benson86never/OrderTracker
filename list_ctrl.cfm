It worked
<cfif isDefined('url.action') and url.action is "addList">	
  <cfset CreateObject("Component","v1.model.services.order").addItemtoList(
    itemId = url.itemId,
    listId = url.listId)>
 <cflocation url="list_item.cfm?supplier=#URL.SupplierID#" >
</cfif>
<cfif isDefined('url.action') and url.action is "removeList">	
	<cfscript>
	RemoveJoin = QueryExecute("delete from joinitemtolist where ID = :ID",
	{ID=url.JoinID});
	</cfscript>
 <cflocation url="list_item.cfm?supplier=#URL.SupplierID#" >
</cfif>
