<cfif isDefined('session.secure.loggedin')>
  <!DOCTYPE html>
  <html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
      <meta charset='UTF-8'/>
      <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0' />
      <title>86Never.com OrderTracker Lists</title>
      <link rel="stylesheet" href="v1/css/bootstrap.css" />
      <link rel="stylesheet" href="v1/css/default.css?<cfoutput>#rand()#</cfoutput>" />
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
      <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
      <style>
        .nav .nav-item .dropdown-menu{ display: none; }
        .nav .nav-item:hover .nav-link{ color: #337ab7;  }
        .nav .nav-item:hover .dropdown-menu{ display: block; }
        .nav .nav-item .dropdown-menu{ margin-top:0; }
         
          /*a .fa {
            font-size: 2em;
          }*/
         }
  </style>
    </head>
    <body>
      <div>
        <!--- Main Nav --->
        <div class="pageHeader">
        <div class="row">
          <span>Order Tracker</span>
          <cfif structKeyExists(session, 'secure') AND session.secure.loggedin>
            <a href="login_ctrl.cfm?action=logout" class="logOut mt-5">
              <i class="fa fa-power-off fa-fw" aria-hidden="true"></i>
              <abbr class="hidden-xs">LogOut</abbr>
            </a>
            <cfoutput>
            <a href="v1/index.cfm?action=user.viewHelp&userid=#encrypt(session.secure.personId, application.uEncryptKey, "BLOWFISH", "Hex")#" class="logOut mt-5"><i class="fa fa-phone fa-fw" aria-hidden="true"></i><abbr class="hidden-xs"> Help</abbr></a>
            <a href="v1/index.cfm?action=user.viewProfile&userid=#encrypt(session.secure.personId, application.uEncryptKey, "BLOWFISH", "Hex")#" class="logOut mt-5">
              <font><abbr class="hidden-xs">#session.secure.firstname# #session.secure.lastname# </abbr></font>
               <i class="fa fa-user fa-fw" aria-hidden="true"></i>
            </a>
            </cfoutput>
          </cfif>
          </div>
        </div>
        <div class="row">
        <cfif structKeyExists(session, 'secure')
          AND session.secure.loggedin>
          <div class="tabbar">
            <ul class="nav nav-tabs">
              <!---<li class="nav-item">
                <a class="nav-link 
                <cfif cgi.script_name contains "list.cfm">
                 active
                </cfif>" href="list.cfm">List</a>
              </li>--->
              <li class="nav-item">
                <a class="nav-link
                  <cfif cgi.script_name contains "list.cfm"
                    OR cgi.script_name contains "orders_open.cfm"
                    OR cgi.script_name contains "order_email.cfm"
                    OR cgi.script_name contains "cart.cfm">
                    active
                  </cfif>" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                  Orders <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="order_email.cfm">Create New Order</a></li>
                  <li><a class="dropdown-item" href="orders_open.cfm">Open Orders</a></li>
                  <li><a class="dropdown-item" href="order_email.cfm">Send Orders</a></li>
                  <cfif isDefined('session.cart')>
                    <li><a class="dropdown-item" href="cart.cfm">View Cart</a></li>
                  </cfif>
                </ul>
              </li>
              <cfif structKeyExists(session, 'secure')
                and ListFind('1,4',session.secure.RoleCode)>
                <li class="nav-item">
                  <a class="nav-link
                  <cfif cgi.script_name contains "item.cfm"
                  OR cgi.script_name contains "list_organize.cfm"
                  OR cgi.script_name contains "list_item.cfm">
                    active
                  </cfif>" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    Admin <span class="caret"></span>
                  </a>
                  <ul class="dropdown-menu">
                    <!---<cfif session.secure.RoleCode EQ 1
                    OR listfind(session.secure.businessType, 2)>
                      <li><a class="dropdown-item" href="item.cfm">Edit Items</a></li>
                      <li><a class="dropdown-item" href="list_organize.cfm">Organize Lists</a></li>
                      <li><a class="dropdown-item" href="list_item.cfm">Manage List Items</a></li>
                    <cfelseif session.secure.RoleCode eq 4>
                        <li><a class="dropdown-item" href="list_organize.cfm">Organize Lists</a></li>
                        <li><a class="dropdown-item" href="list_item.cfm">Manage List Items</a></li>
                    </cfif>--->
                    <li><a class="dropdown-item" href="manageitem.cfm">Manage Items</a></li>
                    <li><a class="dropdown-item" href="v1/index.cfm?action=admin.manageUsers">Manage Users</a></li>
                    <li><a class="dropdown-item" href="v1/index.cfm?action=admin.manageBusiness">Manage Business</a></li>
                  </ul>
                </li>
              </cfif>
            </ul>
          </div>
        </cfif>
        </div>
      </div>
      <div class="main-content">
        <div class="">
          <div class="col-sm-12 content_sec">
            <div class="fw1-body-wrapper">    
</cfif>