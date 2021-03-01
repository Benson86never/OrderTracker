<!---Server is set to redirect to https.  Don't add redirect code here.--->
<cfif not isDefined('Session.secure.loggedin') and cgi.script_name does not contain "index.cfm">
 <cflocation url="index.cfm" addtoken="no">
</cfif>