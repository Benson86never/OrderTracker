<cfcomponent output="true">
	
	<cfinclude template="includes/useragent.cfm">
	<cfinclude template="setappvariables.cfm">
	<cfset this.name = "ordertracker" />
	
	<cfset this.dsn = "ordertracker" />
	<cfset this.applicationtimeout="#createtimespan(7,0,0,0)#">
	
	<cfset this.testvar = "ordertracker">
	<cfclientsettings
	enableDeviceAPI = "true"
	detectDevice = "true"
	deviceTimeout = 10>
	<cfif structKeyexists(url, 'reinit')>
		<cfset this.onApplicationStart() />
	</cfif>
	<cfscript>
		this.sessionManagement="Yes";
		this.sessionTimeout=CreateTimeSpan(0, 8, 0, 0);
		this.mailserver="smtp.zoominternet.net";
		this.datasource = "ordertracker";
		this.dsn = "ordertracker";
		this.publicpages = "admin.adduser,user.login,admin.changepassword,admin.forgotpassword,user.viewTroubleHelp";
		this.erroremail = "anagarajan@infoane.com";
		this.uEncryptKey = "password";
	//this.name = "ORM_Search";
	//this.ormSettings.datasource = "ordertracker";
	//this.ormSettings.dbcreate = "none";
	//this.ormsettings.searchenabled = "true";
	//this.ormSettings.search.autoindex = "true";
	//this.ormSettings.search.indexDir = "Applications/ColdFusionBuilder2018⁩/⁨ColdFusion⁩/cfusion/ormcollections⁩";
	//this.ormSettings.search.language = "English";
	</cfscript>
	
	<cferror type="exception" mailto="#application.erroremail#" template="exception.cfm" exception="any">
	<cferror type="request" mailto="#application.erroremail#" template="exception.cfm">
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfscript>
		Application.URL = "/";
		Application.ComPath = "com.";
		application.dsn = "ordertracker";
		Application.Key="hayley";
		Application.Datasource="ordertracker";
		application.uEncryptKey = "password";
		application.orderform=CreateObject("Component","com.orderform");
		application.carts_np=CreateObject("Component","#Application.ComPath#carts_np");
		application.item_np=CreateObject("Component","#Application.ComPath#item_np");
		application.listsequence_np=CreateObject("Component","#Application.ComPath#listsequence_np");
		application.publicpages = "admin.adduser,user.login,admin.changepassword,admin.forgotpassword,user.viewTroubleHelp";

		</cfscript>
		<cfreturn true />
	</cffunction>
	<cffunction name="onError" returnType="boolean">
		<cfargument type="String" name="exception" required=true/>
		<cfdump var="#arguments#" abort>
		<cfreturn Boolean>
	</cffunction>
	
	

</cfcomponent>