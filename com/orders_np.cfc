<cfcomponent displayname="Order Non Persistent" hint="manages Order cfqueries">
	<cffunction name="init" access="public" output="false">
	<cfscript>
		variables.instance.SupplierName="";
		variables.instance.ItemName="";
		variables.instance.UnitName="";
		variables.instance.Quantity=0;
		variables.instance.ItemID="";
		variables.instance.SupplierID="";
		variables.instance.DateTime="";
		variables.instance.OrderID=0;
	</cfscript>
	</cffunction>
	<cffunction name="GetOrderID" access="public" returntype="numeric" output="No">
		<cfreturn variables.instance.OrderID>
	</cffunction>
	<cffunction name="SetOrderID" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="numeric">
		<cfset variables.instance.OrderID=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetSupplierName" access="public" returntype="string" output="No">
		<cfreturn variables.instance.SupplierName>
	</cffunction>
	<cffunction name="SetSupplierName" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.SupplierName=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetItemName" access="public" returntype="string" output="No">
		<cfreturn variables.instance.ItemName>
	</cffunction>
	<cffunction name="SetItemName" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.ItemName=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetUnitName" access="public" returntype="string" output="No">
		<cfreturn variables.instance.UnitName>
	</cffunction>
	<cffunction name="SetUnitName" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.UnitName=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetQuantity" access="public" returntype="numeric" output="No">
		<cfreturn variables.instance.Quantity>
	</cffunction>
	<cffunction name="SetQuantity" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.Quantity=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetDateTime" access="public" returntype="numeric" output="No">
		<cfreturn variables.instance.DateTime>
	</cffunction>
	<cffunction name="SetDateTime" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.DateTime=arguments.data>
		<cfreturn true>
	</cffunction>
	<cffunction name="GetOrderItems" access="public" output="No">
		<cfargument name="dsn" required="Yes" type="string">
		<cfset var GetPerson="">
		<cfquery name="OrderQuery" datasource="#dsn#">
			select Supplier.Name as SupplierName, 
			Item.Name as ItemName, 
			Units.Name as UnitName, 
			JoinOrderToItem.OrderQuantity as Quantity, 
			Item.ItemID as ItemID, 
			Supplier.SupplierID as SupplierID,
			Orders.DateTime as DateTime
			from JoinOrderToItem
			join Orders on JoinOrderToItem.OrderID = Orders.OrderID
			join Item on JoinOrderToItem.ItemID = Item.ItemID
			join Supplier on JoinOrderToItem.SupplierID = Supplier.SupplierID
			join Units on Item.UnitID = Units.UnitID
			Where Orders.OrderID = <cfqueryparam value="#variables.instance.OrderID#" CFSQLType="CF_SQL_INTEGER">
			Order By Supplier.Name, Item.Name
		</cfquery>
		<cfset OrderJSON = serializeJSON(OrderQuery)>
		<cfreturn OrderJSON>
	</cffunction>
</cfcomponent>