<cfoutput>
  <link rel="stylesheet" href="../v1/css/bootstrap.css" />
  <link rel="stylesheet" href="../v1/css/default.css?#rand()#" />
  <link rel="stylesheet" href="../v1/css/fontawesome/css/font-awesome.min.css" />
  <!--- Page Specific css Indlude --->
  <cfset viewsPath = expandPath('.') & '/views/'>
  <cfset cssView = replace(rc.action,'.','/css/css')>
  <cfset cssFile = viewsPath & cssView & '.cfm'>
  <cfif FileExists(cssFile)>
    <cfoutput>#view(cssView)#</cfoutput>
  </cfif>
</cfoutput>