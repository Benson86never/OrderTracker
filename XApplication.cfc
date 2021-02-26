<cfcomponent>
	
	<cfinclude template="/includes/useragent.cfm">
	<cfclientsettings
	enableDeviceAPI = "true"
	detectDevice = "true"
	deviceTimeout = 10>
	
	<cfscript>
		this.sessionManagement="Yes";
		this.sessionTimeout=CreateTimeSpan(0, 1, 0, 0);
		this.mailserver="smtp.zoominternet.net";
		this.datasource = "ordertracker";
		this.ormEnabled = true;
		this.ormSettings = { logsql : true, cflocatiuon="com"};
		this.ormsettings.flushAtRequestEnd = false;
		this.invokeImplicitAccessor = true;
		this.name="ordertracker";
	//this.name = "ORM_Search";
	//this.ormSettings.datasource = "ordertracker";
	//this.ormSettings.dbcreate = "none";
	//this.ormsettings.searchenabled = "true";
	//this.ormSettings.search.autoindex = "true";
	//this.ormSettings.search.indexDir = "Applications/ColdFusionBuilder2018⁩/⁨ColdFusion⁩/cfusion/ormcollections⁩";
	//this.ormSettings.search.language = "English";
	</cfscript>
	
	<cfset This.applicationtimeout="#createtimespan(0,0,0,1)#">
	<!---<cferror type="exception" mailto="hud@zoominternet.net" template="exception.cfm" exception="any">
	<cferror type="request" mailto="hud@zoominternet.net" template="exception.cfm">--->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfscript>
		Application.URL = "/";
		Application.ComPath = "com.";
		Application.Key="hayley";
		</cfscript>
		<cfreturn true />
	</cffunction>
	
	<cffunction name="OnRequestStart">
	    <cfargument name = "request" required="true"/>
		<cflock scope="application" type="exclusive" timeout="10">
		<cfscript>
		application.orderform=CreateObject("Component","com.orderform");
		//application.secure=CreateObject("Component","#Application.ComPath#secure");
		//application.user=CreateObject("Component","#Application.ComPath#user");
		//application.userRoles=CreateObject("Component","#Application.ComPath#userRoles");
		//application.address=CreateObject("Component","#Application.ComPath#address");
		//application.blurb=CreateObject("Component","#Application.ComPath#blurb");
		//application.join=CreateObject("Component","#Application.ComPath#join");
		</cfscript>
		</cflock>
	</cffunction>
	
	

</cfcomponent>