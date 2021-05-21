<component>
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
             FROM access WHERE active=1;
         </cfquery>
         <!---<cfif access.recordcount gt 0>--->
            <cfreturn access>
    </cffunction>
    <cffunction name="addAccess" access="remote" returntype="boolean" returnFormat="plain">
       <cfargument name="nameaccess" required="true">
        <cfquery name="addacs" datasource="ordertracker" result="res">
              INSERT INTO access (Name)
              VALUES (<cfqueryparam value='#arguments.nameaccess#' cfsqltype="cf_sql_varchar">)

        </cfquery>
        <cfif res.recordcount gt 0>
           <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="addRoles" access="remote" returntype="boolean" returnFormat="plain">
       <cfargument name="nameroles" required="true">
        <cfquery name="addrole" datasource="ordertracker" result="res">
              INSERT INTO roles (Name)
              VALUES (<cfqueryparam value='#arguments.nameroles#' cfsqltype="cf_sql_varchar">)

        </cfquery>
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
        <cfquery name="upaccess" datasource="ordertracker" result="res">
              UPDATE access
              set Name = <cfqueryparam value='#arguments.accessName#' cfsqltype="cf_sql_varchar">
              WHERE 0 = <cfqueryparam value='#arguments.accessId#' cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif res.recordcount gt 0>
           <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="updateroles" access="remote" returntype="boolean" returnFormat="plain" >
       <cfargument name="roleId" required="true">
       <cfargument name="roleName" required="true">
        <cfquery name="uproles" datasource="ordertracker" result="res">
              UPDATE roles
              set Name = <cfqueryparam value='#arguments.roleName#' cfsqltype="cf_sql_varchar">
              WHERE RoleID = <cfqueryparam value='#arguments.roleId#' cfsqltype="cf_sql_integer">
        </cfquery>
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
                    Role_ID,
                    Access_ID
                FROM accesspermission
            </cfquery>
            <cfloop query="local.accessrole">
                <cfloop list="#arguments.data#" index="local.item">
                    <cfset local.roleid = listfirst(local.item,'_')>
                    <cfset local.accessid = listlast(local.item,'_')>
                    <cfif local.accessrole.Access_ID EQ local.accessid
                        AND local.accessrole.Role_ID EQ local.roleid>

                    <cfelse>
                        <cfquery name="local.checkaccessrole" dbtype="query">
                            DELETE
                            FROM accesspermission
                            WHERE
                            Role_ID = <cfqueryparam value='#local.accessrole.Role_ID#' cfsqltype="integer">
                            AND Access_ID = <cfqueryparam value='#local.accessrole.Access_ID#' cfsqltype="integer">
                        </cfquery>
                    </cfif>
                </cfloop>
            </cfloop>
            <cfloop list="#arguments.data#" index="local.item">
                <cfset local.roleid = listfirst(local.item,'_')>
                <cfset local.accessid = listlast(local.item,'_')>
                <cfquery name="local.checkaccessrole" dbtype="query">
                    SELECT 1
                    FROM local.accessrole
                    WHERE
                    Role_ID = <cfqueryparam value='#local.roleId#' cfsqltype="integer">
                    AND Access_ID = <cfqueryparam value='#local.accessId#' cfsqltype="integer">
                </cfquery>
                <cfif NOT local.checkaccessrole.recordcount>
                    <cfquery name="addaccessrole" datasource="ordertracker">
                        INSERT INTO accesspermission (Role_ID,Access_ID)
                        VALUES (<cfqueryparam value='#local.roleId#' cfsqltype="integer">,
                                <cfqueryparam value='#local.accessId#' cfsqltype="integer">)
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
</component>