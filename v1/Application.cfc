component extends="framework.one" {
	
  this.name               = 'ordertracker';
  this.sessionManagement  = true;
  this.ApplicationTimeout = CreateTimeSpan(2,0,0,0);
  this.sessionTimeout     = CreateTimeSpan( 0, 2, 0, 0);
  this.ClientManagement   = false;
  this.SetClientCookies   = true;
  this.loginStorage       = "Session";
  this.scriptprotect      = "all";
  this.restsettings.skipcfcwitherror = true;

  variables.framework = {
    /*reloadApplicationOnEveryRequest = true,*/
    baseURL = "/index.cfm",
    applicationKey = 'Ordertracker-V1'
  };
  /*
		This is provided for illustration only - YOU SHOULD NOT USE THIS IN
		A REAL PROGRAM! ONLY SPECIFY THE DEFAULTS YOU NEED TO CHANGE!
	variables.framework = {
		// the name of the URL variable:
		action = 'action',
		// whether or not to use subsystems:
		usingSubsystems = false,
		// default subsystem name (if usingSubsystems == true):
		defaultSubsystem = 'home',
		// default section name:
		defaultSection = 'main',
		// default item name:
		defaultItem = 'default',
		// if using subsystems, the delimiter between the subsystem and the action:
		subsystemDelimiter = ':',
		// if using subsystems, the name of the subsystem containing the global layouts:
		siteWideLayoutSubsystem = 'common',
		// the default when no action is specified:
		home = defaultSubsystem & ':' & defaultSection & '.' & defaultItem,
		-- or --
		home = defaultSection & '.' & defaultItem,
		// the default error action when an exception is thrown:
		error = defaultSubsystem & ':' & defaultSection & '.error',
		-- or --
		error = defaultSection & '.error',
		// the URL variable to reload the controller/service cache:
		reload = 'reload',
		// the value of the reload variable that authorizes the reload:
		password = 'true',
		// debugging flag to force reload of cache on each request:
		reloadApplicationOnEveryRequest = false,
		// whether to force generation of SES URLs:
		generateSES = false,
		// whether to omit /index.cfm in SES URLs:
		SESOmitIndex = false,
		// location used to find layouts / views:
		base = ... relative path from Application.cfc to application files ...
		// either CGI.SCRIPT_NAME or a specified base URL path:
		baseURL = 'useCgiScriptName',
		// location used to find controllers / services:
		// cfcbase = essentially base with / replaced by .
		// list of file extensions that FW/1 should not handle:
		unhandledExtensions = 'cfc',
		// list of (partial) paths that FW/1 should not handle:
		unhandledPaths = '/flex2gateway',
		// flash scope magic key and how many concurrent requests are supported:
		preserveKeyURLKey = 'fw1pk',
		maxNumContextsPreserved = 10,
		// set this to true to cache the results of fileExists for performance:
		cacheFileExists = false,
		// change this if you need multiple FW/1 applications in a single CFML application:
		applicationKey = 'framework.one',
        // change this if you want a different dependency injection engine:
        diEngine = 'di1',
        // change this if you want different locations to be scanned by the D/I engine:
        diLocations = 'model,controllers',
        // optional configuration for your dependency injection engine:
        diConfig = { },
        // routes (for fancier SES URLs) - see the documentation for details:
        routes = [ ],
        routesCaseSensitive = true
	};
	*/
	function setupApplication() {
		// use setupApplication to do initialization per application
		include "../setappvariables.cfm"
	}

	function setupRequest() {
		// use setupRequest to do initialization per request
		request.context.startTime = getTickCount();
        session.startTime = getTickCount();
    // Reset application
    /* bock access to site for specific site */
    
    if(isDefined("url.reinit")){
      setupApplication();
    }
    //Fusion reactor transaction name
    if(len(trim(url?.action))){
      request["fr.transaction.name"] = 'v1-' & url.action;
    }
    // Security heck
    controller('auth.check');
    if(NOT(structKeyExists(url, 'action') AND url.action EQ 'ajax.checkLoggedIn')){
      // Setup Request
      controller('core.setRequest');
    }
  }
  function onRequestEnd() {
    trackRequest();
  }
  function trackRequest(){
   
  }
  function onSessionEnd(sessionScope, appScope) {
    
  }

  function onError(exception, eventname) {
    setting requesttimeout=0;
    request.context.exception=arguments.exception;
    request.context.eventname=arguments.eventname;
    savecontent variable="errorcontent" {
      writeoutput('Error Occurred at #now()#<br>');
      writeDump(var=arguments.exception);
    }
    mail=new mail();
    mail.setSubject( "System Error" );
    mail.setTo(application.erroremail);
    mail.setFrom("info@porthousegrill.com");
    mail.addPart( type="html", charset="utf-8", body="#errorcontent#" );
    mail.send();
	  location(url="../index.cfm?error=1", addtoken="false");
    
  }
  function onMissingView(){
    
  }
  function processException(exception) {
    
  }

}
