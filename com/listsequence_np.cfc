<cfcomponent output="false">

<cffunction name="getData" returnType="query" output="false">
	<cfset var x = "">
	<cfif not structKeyExists(session,"data") or structKeyExists(url,"reinit")>
		<cfset session.data = queryNew("id,title","integer,varchar")>
		<cfloop index="x" from="1" to="5">
			<cfset queryAddRow(session.data)>
			<cfset querySetCell(session.data, "id", x)>
			<cfset querySetCell(session.data, "title", "Title #x#")>
		</cfloop>
	</cfif>
	<cfreturn session.data>
</cffunction>

<cffunction name="saveData" access="remote" returnType="void" output="false">
	<cfargument name="order" type="any" required="true">
	<cfset var x = "">
	<cfset var id = "">
	<cfset var item = "">
	
	<!--- loop through and make a new order --->
	<cfloop index="x" from="1" to="#listLen(arguments.order)#">
		<cfset item = listGetAt(arguments.order, x)>
		<cfset id = listGetAt(item,2,"_")>
		<cflog file="ajax" text="setting id #id# to position #x#" >
		<cftry>
		<cfquery name="ListReorder" datasource="#application.datasource#">
		update JoinItemToList set
		OrderBy = #x#
		where id = #id#
		</cfquery>
		<cfcatch>
			<cflog file="ajax" text="#cfcatch.message#" >
		</cfcatch>
		</cftry>
	
	</cfloop>

</cffunction>

</cfcomponent>