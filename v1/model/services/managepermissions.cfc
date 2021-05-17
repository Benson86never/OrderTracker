<component>
    <cffunction name="getRoles" access="remote">
        <cfquery name="role" datasource="ordertracker">
             SELECT  RoleID,Name
             FROM roles
        </cfquery>
             <cfreturn role>
    </cffunction>
    <cffunction name="getAccess" access="remote">
         <cfquery name="access" datasource="ordertracker">
             SELECT AccessID,Name 
             FROM access
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
              DELETE FROM access
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
              DELETE FROM roles
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
              WHERE AccessID = <cfqueryparam value='#arguments.accessId#' cfsqltype="cf_sql_integer">
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
</component>