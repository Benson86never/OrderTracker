<cfcomponent displayname="address" hint="manages addresses">
	<cffunction name="init" access="public" output="false">
	<cfscript>
		variables.instance.FirstName="";
		variables.instance.MiddleName="";
		variables.instance.LastName="";
		variables.instance.PersonID=0;
	</cfscript>
	</cffunction>
	<cffunction name="GetPersonID" access="public" returntype="string" output="No">
		<cfreturn variables.instance.PersonID>
	</cffunction>
	<cffunction name="SetPersonID" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.PersonID=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetFirstName" access="public" returntype="string" output="No">
		<cfreturn variables.instance.FirstName>
	</cffunction>
	<cffunction name="SetFirstName" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.FirstName=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetMiddleName" access="public" returntype="string" output="No">
		<cfreturn variables.instance.MiddleName>
	</cffunction>
	<cffunction name="SetMiddleName" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.MiddleName=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetLastName" access="public" returntype="string" output="No">
		<cfreturn variables.instance.LastName>
	</cffunction>
	<cffunction name="SetLastName" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.LastName=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetThisPerson" access="public" returntype="numeric" output="No">
		<cfargument name="table" required="Yes" type="string">
		<cfargument name="PersonID" required="Yes" type="string">
		<cfargument name="dsn" required="Yes" type="string">
		<cfset var GetPerson="">
		<cfquery name="GetPerson" datasource="#dsn#">
		select FirstName, MiddleName, LastName, PersonID
		from #arguments.table#
		where PersonID = #arguments.PersonID#
		</cfquery>
		<cfscript>
			variables.instance.FirstName=GetPerson.FirstName;
			variables.instance.MiddleName=GetPerson.MiddleName;
			variables.instance.LastName=GetPerson.LastName;
			variables.instance.PersonID=GetPerson.PersonID;
		</cfscript>
		<cfreturn true>
	</cffunction>
	<cffunction name="CommitPerson" access="public" returntype="boolean" output="No">
		<cfargument name="table" required="Yes" type="string">
		<cfargument name="dsn" required="Yes" type="string">
		<cfset var CreatePerson="">
		<cfif variables.instance.PersonID gt 0>
			<cfquery name="CreatePerson" datasource="#dsn#">
			update #table#
			set FirstName='#variables.instance.FirstName#',
			MiddleName='#variables.instance.MiddleName#',
			LastName='#variables.instance.LastName#'
			where PersonID=#variables.instance.PersonID#
			</cfquery>
		<cfelse>
		<cftry>
			<cfquery name="CreatePerson" datasource="#dsn#">
			insert into #table#(FirstName,MiddleName,LastName)
			values('#variables.instance.FirstName#','#variables.instance.MiddleName#','#variables.instance.LastName#')
			SELECT IDENT_CURRENT('#table#') as ID
			</cfquery>
			<cfset variables.instance.PersonID=CreatePerson.ID>
			<cfcatch><cflocation url="#cgi.http_referer#?error=#CFCATCH.Detail#" addtoken="Yes"></cfcatch>
		</cftry>
		</cfif>
		<cfreturn true>
	</cffunction>
	<cffunction name="DeletePerson" access="public" returntype="boolean" output="No">
		<cfargument name="table" required="Yes" type="string">
		<cfargument name="dsn" required="Yes" type="string">
		<cfset var DeletePerson="">
			<cfquery name="DeletePerson" datasource="#dsn#">
			delete from #table#
			where PersonID=#variables.instance.PersonID#
			</cfquery>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetPeople" access="public" returntype="query" output="false">
		<cfargument name="table" required="Yes" type="string">
		<cfargument name="dsn" required="Yes" type="string">
		<cfset var GetPeople="">
			<cfquery name="GetPeople" datasource="#dsn#">
			Select *
			from #table#
			</cfquery>
		<cfreturn GetPeople>
	</cffunction>
</cfcomponent>