<cfset variables.numIterarions = 0 />
<cfif isDefined('form.Submit') and form.submit is "login">
	<cfquery name="qrySelectUser" datasource="ordertracker">
		select * from person where email='#form.username#'
	</cfquery>
	<cfif qrySelectUser.recordCount eq 0>
		<cflocation url="index.cfm?err=2" addtoken="no">
	<cfelseif qrySelectUser.password EQ Hash(form.password & qrySelectUser.salt, "SHA-512", "utf-8", variables.numIterarions)>
    	 <cfif isdefined("form.rememberme")>
           <cfcookie name="rememberme" value="#form.rememberme#" expires="never">
           <cfcookie name="userName" value="#form.userName#" expires="never">
           <cfcookie name="password" value="#form.password#" expires="never">
         <cfelse>
         	<cfcookie name="rememberme" value="No" expires="never">
         </cfif> 
		<cfset session.secure.loggedin="yes">
		<cfset session.secure.MasterAccount="1">
		<cfquery name="qrySelectBusinessname" datasource="#application.datasource#">
			SELECT
				B.businessid,
				B.businessname,
				GROUP_CONCAT(JBT.typeid) AS businessType
			FROM
				business B
				INNER JOIN joinbusinesstotype JBT ON JBT.businessid = B.businessid
			WHERE
				B.businessid = #qrySelectUser.businessId#
		</cfquery>
		<cfset session.secure.businessType="#qrySelectBusinessname.businessType#">
		<cfset session.secure.SubAccount="#qrySelectBusinessname.businessid#">
		<cfset session.secure.SubAccountName="#qrySelectBusinessname.businessname#">
		<cfset session.secure.PersonID="#qrySelectUser.personid#">
		<cfset session.secure.RoleCode="#qrySelectUser.type#">
		<cflocation url="list.cfm" addtoken="no">
	<cfelse>
	 <cfcookie name="hdnUserName" value="#form.userName#" expires="never">
		<cflocation url="index.cfm?err=1" addtoken="no">
	</cfif>
<cfelseif isDefined('url.action') and url.action is "logout">
	<cfset StructDelete(Session, "secure")>
	<cfset StructDelete(Session, "cart")>
	<cflocation url="index.cfm" addtoken="no">
</cfif>