<cfparam name="url.page" default="1">
<cfparam name="url.pagesize" default="30">
<cfif url.sort is "">
	<cfset url.sort = "name">
</cfif>
<cfparam name="url.sort" default="name">
<cfparam name="url.dir" default="asc">
<cfscript>
	Items=application.item_np.GetItems("#application.datasource#","#url.page#","#url.pagesize#","#url.sort#","#url.dir#");
</cfscript>
<cfsetting showDebugOutput="No">
<cfcontent type="application/x-javascript">

<cfoutput>
	#serializeJSON(QueryConvertForGrid(Items, page, pageSize))#
</cfoutput>