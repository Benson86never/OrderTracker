<component>
    <cffunction name="checkAccess" access="public" returntype="boolean">
        <!---Server is set to redirect to https.  Don't add redirect code here.--->
        <cfif not isDefined('Session.secure.loggedin') and cgi.script_name does not contain "index.cfm">
            <cflocation url="index.cfm" addtoken="no">
        </cfif>
        <cfif isDefined('session.secure.rolecode') and session.secure.rolecode neq 1 and cgi.script_name contains "user.cfm">
        <cflocation url="index.cfm" addtoken="no">
        </cfif>
        <cfif find('v1', cgi.script_name)>
            <cfset local.querystring = listfirst(cgi.query_string, '&')>
            <cfset local.expression = listlast(local.querystring, '=')>
        <cfelse>
            <cfset local.expression = listlast(cgi.script_name, '/')>
        </cfif>
        <cfswitch expression="#local.expression#">
            <cfcase value="list.cfm">
                <cfif NOT ListFind(session.secure.access,'15')>
                    <cflocation url="noaccess.cfm" addtoken="no">
                </cfif>
            </cfcase>
            <cfcase value="orders_open.cfm">
                <cfif NOT ListFind(session.secure.access,'16')>
                    <cflocation url="noaccess.cfm" addtoken="no">
                </cfif>
            </cfcase>
            <cfcase value="order_email.cfm">
                <cfif NOT ListFind(session.secure.access,'17')>
                    <cflocation url="noaccess.cfm" addtoken="no">
                </cfif>
            </cfcase>
            <cfcase value="manageaccess.cfm">
                <cfif NOT ListFind(session.secure.access,'12')>
                    <cflocation url="noaccess.cfm" addtoken="no">
                </cfif>
            </cfcase>
            <cfcase value="manageitem.cfm">
                <cfif NOT ListFind(session.secure.access,'7')>
                    <cflocation url="noaccess.cfm" addtoken="no">
                </cfif>
            </cfcase>
            <cfcase value="admin.manageBusiness">
                <cfif NOT ListFind(session.secure.access,'11')>
                    <cflocation url="../noaccess.cfm" addtoken="no">
                </cfif>
            </cfcase>
            <cfcase value="admin.manageUsers">
                <cfif NOT ListFind(session.secure.access,'8')>
                    <cflocation url="../noaccess.cfm" addtoken="no">
                </cfif>
            </cfcase>
        </cfswitch>
        <cfreturn true>
    </cffunction>
    <cffunction name="getRoles" access="remote">
        <cfquery name="role" datasource="ordertracker">
             SELECT  RoleID,Name
             FROM roles WHERE active=1;
        </cfquery>
             <cfreturn role>
    </cffunction>
    <cffunction name="getAccess" access="remote">
         <cfquery name="access" datasource="ordertracker">
             SELECT AccessID,Name 
             FROM access WHERE active=1
             order by name;
         </cfquery>
         <!---<cfif access.recordcount gt 0>--->
            <cfreturn access>
    </cffunction>
    <cffunction name="addAccess" access="remote" returntype="boolean" returnFormat="plain">
       <cfargument name="nameaccess" required="true">
        <cfquery name="checkaccess" datasource="ordertracker">
               SELECT 1
               FROM access
               WHERE Name=<cfqueryparam value='#arguments.nameaccess#' cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif NOT checkaccess.recordcount>
            <cfquery name="addacs" datasource="ordertracker" result="res">
                INSERT INTO access (Name)
                VALUES (<cfqueryparam value='#arguments.nameaccess#' cfsqltype="cf_sql_varchar">)
            </cfquery>
        </cfif>
        <cfif res.recordcount gt 0>
           <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="addRoles" access="remote" returntype="boolean" returnFormat="plain">
       <cfargument name="nameroles" required="true">
       <cfquery name="checkroles" datasource="ordertracker">
            SELECT 1
            FROM roles
            WHERE Name=<cfqueryparam value='#arguments.nameroles#' cfsqltype="cf_sql_varchar">
       </cfquery>
       <cfif NOT checkroles.recordcount>
            <cfquery name="addrole" datasource="ordertracker" result="res">
                INSERT INTO roles (Name)
                VALUES (<cfqueryparam value='#arguments.nameroles#' cfsqltype="cf_sql_varchar">)
            </cfquery>
        </cfif>
        <cfif res.recordcount gt 0>
           <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="deleteAccess" access="remote" returntype="boolean" returnFormat="plain" >
       <cfargument name="accessId" required="true">
        <cfquery name="delacs" datasource="ordertracker" result="res">
              UPDATE access 
              SET active = 0
              WHERE AccessID = <cfqueryparam value='#arguments.accessId#' cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif res.recordcount gt 0>
           <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="deleteRoles" access="remote" returntype="boolean" returnFormat="plain" >
       <cfargument name="roleId" required="true">
        <cfquery name="delrole" datasource="ordertracker" result="res">
              UPDATE roles 
              SET active = 0
              WHERE RoleID = <cfqueryparam value='#arguments.roleId#' cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif res.recordcount gt 0>
           <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="updateaccess" access="remote" returntype="boolean" returnFormat="plain" >
       <cfargument name="accessId" required="true">
       <cfargument name="accessName" required="true">
       <cfquery name="checkaccessupdate" datasource="ordertracker">
            SELECT 1
            FROM access
            WHERE Name=<cfqueryparam value='#arguments.accessName#' cfsqltype="cf_sql_varchar">
            AND AccessID != <cfqueryparam value='#arguments.accessId#' cfsqltype="cf_sql_integer">
       </cfquery>
       <cfif NOT checkaccessupdate.recordcount>
       <cfquery name="upaccess" datasource="ordertracker" result="res">
            UPDATE access
            set Name = <cfqueryparam value='#arguments.accessName#' cfsqltype="cf_sql_varchar">
            WHERE AccessID = <cfqueryparam value='#arguments.accessId#' cfsqltype="cf_sql_integer">
        </cfquery>
        </cfif>
        <cfif res.recordcount gt 0>
           <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="updateroles" access="remote" returntype="boolean" returnFormat="plain" >
       <cfargument name="roleId" required="true">
       <cfargument name="roleName" required="true">
       <cfquery name="checkrolesupdate" datasource="ordertracker">
           SELECT 1 
           FROM roles
           WHERE Name=<cfqueryparam value='#arguments.roleName#' cfsqltype="cf_sql_varchar"> 
           AND RoleID != <cfqueryparam value='#arguments.roleId#' cfsqltype="integer">
       </cfquery>
        <cfif NOT checkrolesupdate.recordcount>
            <cfquery name="uproles" datasource="ordertracker" result="res">
                UPDATE roles
                set Name = <cfqueryparam value='#arguments.roleName#' cfsqltype="cf_sql_varchar">
                WHERE RoleID = <cfqueryparam value='#arguments.roleId#' cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>
        <cfif res.recordcount gt 0>
           <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="addAccessRoles" access="remote" returntype="boolean" returnFormat="plain">
       <cfargument name="data" required="true">
       <cftry>
            <cfquery name="local.accessrole" datasource="ordertracker">
                SELECT
                   Role_ID,Access_ID,
                   CONCAT(Role_ID,'_',
                    Access_ID) AS result
                FROM accesspermission
            </cfquery>
            <cfset local.permissionlist = valuelist(local.accessrole.result)>
            <cfloop list="#local.permissionlist#" index="local.item">
                <cfif NOT listfind(arguments.data, local.item)>
                        <cfquery name="local.checkaccessrole" datasource="ordertracker">
                            DELETE
                            FROM accesspermission
                            WHERE
                            Role_ID = <cfqueryparam value='#listfirst(local.item,'_')#' cfsqltype="integer">
                            AND Access_ID = <cfqueryparam value='#listlast(local.item,'_')#' cfsqltype="integer">
                        </cfquery>
                </cfif>
            </cfloop>
            <cfloop list="#arguments.data#" index="local.item">
                <cfset local.roleid = listfirst(local.item,'_')>
                <cfset local.accessid = listlast(local.item,'_')>
                <cfdump var="#local.accessrole#">
                <cfquery name="local.checkaccessrole1" datasource="ordertracker">
                    SELECT 1
                    FROM accesspermission
                    WHERE
                    Role_ID = <cfqueryparam value='#local.roleid#' cfsqltype="integer">
                    AND Access_ID = <cfqueryparam value='#local.accessid#' cfsqltype="integer">
                </cfquery>
                <cfif NOT local.checkaccessrole1.recordcount>
                    <cfquery name="addaccessrole" datasource="ordertracker">
                        INSERT INTO accesspermission (Role_ID,Access_ID)
                        VALUES (<cfqueryparam value='#local.roleid#' cfsqltype="integer">,
                                <cfqueryparam value='#local.accessid#' cfsqltype="integer">)
                    </cfquery>
                </cfif>
            </cfloop>
            <cfreturn true>
        <cfcatch>
            <cfreturn false>
        </cfcatch>
        </cftry>
    </cffunction>
    <cffunction name="getAccessRoles" access="remote" returnFormat="JSON">
        <cfset local.result = {}>
        <cfquery name="getdata" datasource="ordertracker">
            SELECT
                access_Id,
                role_Id
            FROM
                accesspermission
            order by access_Id
        </cfquery>
        <cfloop query="getdata" group="access_Id">
            <cfset local.result['#getdata.access_Id#'] = {}>
            <cfloop>
                <cfset local.result['#getdata.access_Id#']['#getdata.role_Id#'] = true>
            </cfloop>
        </cfloop>
        <cfreturn local.result>
    </cffunction>
    <cffunction name="getAccessId" access="remote">
        <cfquery name="local.getMngId" datasource="ordertracker">
              SELECT 
              Access_ID 
              FROM accesspermission
              WHERE Role_ID = #session.secure.RoleCode# 
        </cfquery>
         <cfset local.getvalue = valuelist(local.getMngId.Access_ID)>
        <cfreturn local.getvalue>
    </cffunction>
</component>