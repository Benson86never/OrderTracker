It worked
<cfif isDefined('url.action') and url.action is "addList">	
  <cfset CreateObject("Component","v1.model.services.order").addItemtoList(
    itemId = url.itemId,
    listId = url.listId)>
 <cflocation url="manageitem.cfm?page=listitems"  addtoken="false">
</cfif>
<cfif isDefined('url.action') and url.action is "removeList">	
	<cfscript>
	RemoveJoin = QueryExecute("delete from joinitemtolist where ID = :ID",
	{ID=url.JoinID});
	</cfscript>
 <cflocation url="manageitem.cfm?page=listitems" addtoken="false">
</cfif>
