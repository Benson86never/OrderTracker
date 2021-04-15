<cfoutput>
  <link rel="stylesheet" href="../v1/css/bootstrap.css" />
  <link rel="stylesheet" href="../v1/css/default.css?#rand()#" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
  <!--- Page Specific css Indlude --->
  <cfset viewsPath = expandPath('.') & '/views/'>
  <cfset cssView = replace(rc.action,'.','/css/css')>
  <cfset cssFile = viewsPath & cssView & '.cfm'>
  <cfif FileExists(cssFile)>
    <cfoutput>#view(cssView)#</cfoutput>
  </cfif>
</cfoutput>