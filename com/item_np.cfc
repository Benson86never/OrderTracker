<cfcomponent displayname="Item Non Persistent" hint="manages item cfqueries">
	<cffunction name="GetItems" access="remote">
	    <cfargument name="datasource">
	    <cfargument name="page">
	    <cfargument name="pagesize">
	    <cfargument name="sort">
	    <cfargument name="dir">
	    <!---<cfmail from="hud@zoominternet.net" subject="item form submission" to="hud@zoominternet.net" type="text/html">
        	<cfdump var="#arguments#">
        </cfmail>--->
		<cfquery name="Items" datasource="#arguments.datasource#">
			select Item.Name as name, 
			Item.SKU as sku,
			Item.PhotoURL as photourl,
			Item.ItemID as id,
			Units.Name as unitname,
			Units.UnitID as unitid,
			Supplier.SupplierID as supplierid,
			Supplier.Name as suppliername
			from Item
			inner join Units on Units.UnitID = Item.UnitID
			inner join JoinSupplierToItem on Item.ItemID = JoinSupplierToItem.ItemID
			inner join Supplier on JoinSupplierToItem.SupplierID = Supplier.SupplierID
			<cfif arguments.sort is "">
			order by name asc
			<cfelse>
			order by #arguments.sort# #arguments.dir#
			</cfif>
		</cfquery>
		<cfreturn Items>
	</cffunction>
	<cffunction name="editItem" access="remote">
		<cfargument name="gridaction">
	    <cfargument name="gridrow">
	    <cfargument name="gridchanged">
	    <!--- Local variables --->
	    <cfmail from="hud@zoominternet.net" subject="item form submission" to="hud@zoominternet.net" type="text/html">
        	<cfdump var="#arguments#">
        </cfmail>
      <cfset var colname="">
      <cfset var value="">

      <!--- Process gridaction --->
      <cfswitch expression="#ARGUMENTS.gridaction#">
         <!--- Process inserts finish this tomorrow--->
         <cfcase value="I">
         	<cftry>
         	<cfquery datasource="#application.datasource#" result="result" >
            INSERT INTO item (Name,SKU,UnitID,PhotoURL)
            VALUES ('#ARGUMENTS.gridrow.NAME#','#ARGUMENTS.gridrow.SKU#','#ARGUMENTS.gridrow.UNITNAME#','#ARGUMENTS.gridrow.PHOTOURL#')
         	</cfquery>
         	<cfset NewPrimaryKey = result.generatedkey>
         	<cfquery  datasource="#application.datasource#"> 
         	INSERT INTO JoinSupplierToItem (ItemID,SupplierID)
         	VALUES ('#NewPrimaryKey#','#ARGUMENTS.gridrow.SUPPLIERNAME#')
         	</cfquery>
         	<cfcatch>
         	<cfmail from="hud@zoominternet.net" subject="item form submission" to="hud@zoominternet.net" type="text/html">
        	#cfcatch.message# #cfcatch.detail#
        	</cfmail>
         	</cfcatch>
         	</cftry>
         	<cfmail from="hud@zoominternet.net" subject="item form submission" to="hud@zoominternet.net" type="text/html">
        	#Arguments.gridrow.NAME#
        	item may be inserted
        	</cfmail>
         </cfcase>
         <!--- Process updates --->
         <cfcase value="U">
            <!--- Get column name and value --->
            <cfset colname=StructKeyList(ARGUMENTS.gridchanged)>
            <cfset value=ARGUMENTS.gridchanged[colname]>
            <!--- Perform actual update --->
            <cfif colname is "SUPPLIERNAME">
            <cfquery datasource="#application.datasource#">
            UPDATE JoinSupplierToItem
            SET SupplierID = '#value#'
            WHERE ItemID = #ARGUMENTS.gridrow.ID#
            </cfquery>	
            <cfelseif colname is "UNITNAME">
            <cfquery datasource="#application.datasource#">
            UPDATE item
            SET UnitID = '#value#'
            WHERE ItemID = #ARGUMENTS.gridrow.ID#
            </cfquery>
            <cfelse>
            <cfquery datasource="#application.datasource#">
            UPDATE item
            SET #colname# = '#value#'
            WHERE ItemID = #ARGUMENTS.gridrow.ID#
            </cfquery>
            </cfif>
         </cfcase>
         <!--- Process deletes --->
         <cfcase value="D">
            <!--- Perform actual delete --->
            <cfquery datasource="#application.datasource#">
            DELETE FROM item
            where ItemID = #ARGUMENTS.gridrow.ID#
            </cfquery>
         </cfcase>
      </cfswitch>
	</cffunction>
</cfcomponent>