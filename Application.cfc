<cfcomponent>
	
	<cfinclude template="includes/useragent.cfm">
	<cfset this.name = "ordertracker" />
	<cfset this.applicationtimeout="#createtimespan(7,0,0,0)#">
	
	<cfclientsettings
	enableDeviceAPI = "true"
	detectDevice = "true"
	deviceTimeout = 10>
	
	<cfscript>
		this.sessionManagement="Yes";
		this.sessionTimeout=CreateTimeSpan(0, 8, 0, 0);
		this.mailserver="smtp.zoominternet.net";
		this.datasource = "ordertracker";
		this.dsn = "ordertracker";
		this.ormEnabled = true;
		this.ormSettings = { logsql : true, cflocatiuon="com"};
		this.ormsettings.flushAtRequestEnd = false;
		this.invokeImplicitAccessor = true;
		this.uEncryptKey = "password";
	//this.name = "ORM_Search";
	//this.ormSettings.datasource = "ordertracker";
	//this.ormSettings.dbcreate = "none";
	//this.ormsettings.searchenabled = "true";
	//this.ormSettings.search.autoindex = "true";
	//this.ormSettings.search.indexDir = "Applications/ColdFusionBuilder2018⁩/⁨ColdFusion⁩/cfusion/ormcollections⁩";
	//this.ormSettings.search.language = "English";
	</cfscript>
	
	<!---<cferror type="exception" mailto="hud@zoominternet.net" template="exception.cfm" exception="any">
	<cferror type="request" mailto="hud@zoominternet.net" template="exception.cfm">--->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfscript>
		Application.URL = "/";
		Application.ComPath = "com.";
		Application.Key="hayley";
		Application.Datasource="ordertracker";
		application.orderform=CreateObject("Component","com.orderform");
		application.carts_np=CreateObject("Component","#Application.ComPath#carts_np");
		application.item_np=CreateObject("Component","#Application.ComPath#item_np");
		application.listsequence_np=CreateObject("Component","#Application.ComPath#listsequence_np");
		</cfscript>
		<cfreturn true />
	</cffunction>
	
	

</cfcomponent>