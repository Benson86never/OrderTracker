<!---Server is set to redirect to https.  Don't add redirect code here.--->
<cfif not isDefined('Session.secure.loggedin') and cgi.script_name does not contain "index.cfm">
 	<cflocation url="index.cfm" addtoken="no">
</cfif>
<cfif isDefined('session.secure.rolecode') and session.secure.rolecode neq 1 and cgi.script_name contains "user.cfm">
	<cflocation url="index.cfm" addtoken="no">
</cfif>
<cfif not(cgi.script_name EQ 'manageaccess.cfm' and ListFind(session.secure.access,'12'))>
 <cflocation url="index.cfm" addtoken="no">
</cfif>