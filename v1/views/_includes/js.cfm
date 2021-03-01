<script type="text/javascript" src="../v1/scripts/jquery.min.js"></script>
<script type="text/javascript" src="../v1/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="../v1/scripts//bootstrap-toggle.js"></script>
<script type="text/javascript" src="../v1/scripts//jquery-ui.min.js"></script>
<!--- Page Specific JS Indlude --->
<cfset viewsPath = expandPath('.') & '/views/'>
<cfset jsView = replace(rc.action,'.','/js/js')>
<cfset jsFile = viewsPath & jsView & '.cfm'>
<cfif FileExists(jsFile)>
  <cfoutput>#view(jsView)#</cfoutput>
</cfif>