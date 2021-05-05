<cfoutput>
    <cfmail from="info@porthousegrill.com"
        subject="System Error"
        to="#error.mailto#"
        type="text/html">
        Error Occurred at #now()#<br>
        <cfdump var="#error.rootcause#">
    </cfmail>
    <cflocation url="index.cfm?error=1" addtoken="false">
</cfoutput>