component accessors="true" {
  property coreService;
  property adminService;

  public any function init( fw ) {
      variables.fw = fw;
      return this;
  }

  public void function setapplication( rc ) {

    /* Main DSN */
    application.dsn                 = "ordertracker";
  }

  public void function setSiteInternationalization( rc ) {

    

  }

  public void function setupApplicationDao( rc ) {

    application.URL = "/";
		application.ComPath = "com.";
		application.Key = "hayley";
		application.Datasource = "ordertracker";
  }

  public void function setRequest( rc ){
    rc.appVersion = "1.0";
    if(structKeyExists(session, 'secure')) {
      if(!structKeyExists(session.secure, 'loggedin')
          || !structKeyExists(session.secure, 'rolecode')
        ) {
        location("../index.cfm", false);
      }
    } else if(!listfindnocase(application.publicpages, url.action)) {
      location("../index.cfm", false);
    }
    
  };

  private boolean function isAJAXRequest( rc ){
    if (
      (
        structKeyExists(getHTTPRequestData().headers , "X-Requested-With")
        AND getHTTPRequestData().headers['X-Requested-With'] != 'com.duckduckgo.mobile.android'
      )
      OR (
        structKeyExists(url, 'action')
        AND Left(trim(url.action), 4) == 'ajax'
      )
    ) {
      return true;
    } else {
      return false;
    }
  }
}
