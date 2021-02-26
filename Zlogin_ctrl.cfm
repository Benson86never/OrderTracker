<cfif isDefined('form.Submit') and form.submit is "login">
<cfscript>
Users = EntityLoad( "person", { email=#form.username#, password=#form.password# } );
if (arrayLen(Users)) {
SubAccount = EntityLoad( "JoinPersonToSubaccount", {personid=#Users[1].getid()#} ) ;
}
</cfscript>
<cfif arrayLen(Users) is 0>
	<cflocation url="index.cfm" >
<cfelse>
<cfset session.secure.loggedin="yes">
<cfset session.secure.MasterAccount="1">
<cfset session.secure.SubAccount="#SubAccount[1].getsubaccountid()#">
<cfset session.secure.SubAccountName="#SubAccount[1].subaccount.getname()#">
<cfset session.secure.PersonID="#Users[1].getid()#">
<cflocation url="list.cfm" >
</cfif>
<cfelseif isDefined('url.action') and url.action is "logout">
<cfset StructDelete(Session, "secure")>
<cfset StructDelete(Session, "cart")>
<cflocation url="index.cfm" >
</cfif>