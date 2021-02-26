<cfset variables.numIterarions = 0 />
<cfif isDefined('form.Submit') and form.submit is "login">
<cfscript>
Users = EntityLoad( "person", { email=#form.username# } );
</cfscript>
<cfif arrayLen(Users) is 0>
	<cflocation url="index.cfm" addtoken="no">
<cfelseif Users[1].getpassword() EQ Hash(form.password & Users[1].getsalt(), "SHA-512", "utf-8", variables.numIterarions)>
<cfset SubAccount = EntityLoad( "JoinPersonToSubaccount", {personid=#Users[1].getid()#} )>
<cfset session.secure.loggedin="yes">
<cfset session.secure.MasterAccount="1">
<cfset session.secure.SubAccount="#SubAccount[1].getsubaccountid()#">
<cfset session.secure.SubAccountName="#SubAccount[1].subaccount.getname()#">
<cfset session.secure.PersonID="#Users[1].getid()#">
<cfset session.secure.RoleCode="#Users[1].gettype()#">
<cflocation url="list.cfm" addtoken="no">
</cfif>
<cfelseif isDefined('url.action') and url.action is "logout">
<cfset StructDelete(Session, "secure")>
<cfset StructDelete(Session, "cart")>
<cflocation url="index.cfm" addtoken="no">
</cfif>