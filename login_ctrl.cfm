<cfset variables.numIterarions = 0 />

<cfif isDefined('form.Submit') and form.submit is "login">
	<cfquery name="qrySelectUser" datasource="ordertracker">
		select * from person where email='#form.username#'
	</cfquery>
	<cfif qrySelectUser.recordCount eq 0>
		<cflocation url="index.cfm" addtoken="no">
	<cfelseif qrySelectUser.password EQ Hash(form.password & qrySelectUser.salt, "SHA-512", "utf-8", variables.numIterarions)>
		<cfset session.secure.loggedin="yes">
		<cfset session.secure.MasterAccount="1">
		<cfquery name="qrySelectBusinessname" datasource="#application.datasource#">
			select * from business where businessid = #qrySelectUser.subaccountid#
		</cfquery>
		<cfset session.secure.SubAccount="#qrySelectBusinessname.businessid#">
		<cfset session.secure.SubAccountName="#qrySelectBusinessname.businessname#">
		<cfset session.secure.PersonID="#qrySelectUser.personid#">
		<cfset session.secure.RoleCode="#qrySelectUser.type#">
		<cflocation url="list.cfm" addtoken="no">
	</cfif>
<cfelseif isDefined('url.action') and url.action is "logout">
	<cfset StructDelete(Session, "secure")>
	<cfset StructDelete(Session, "cart")>
	<cflocation url="index.cfm" addtoken="no">
</cfif>