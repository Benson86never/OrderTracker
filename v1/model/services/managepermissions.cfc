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
</component>