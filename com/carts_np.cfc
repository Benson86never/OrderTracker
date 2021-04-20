<cfcomponent displayname="Cart Non Persistent" hint="manages cart cfqueries">
	<cffunction name="init" access="public" output="false">
	<cfscript>
		variables.instance.SupplierName="";
		variables.instance.ItemName="";
		variables.instance.UnitName="";
		variables.instance.Quantity=0;
		variables.instance.ItemID="";
		variables.instance.SupplierID="";
		variables.instance.DateTime="";
		variables.instance.CartID=0;
	</cfscript>
	</cffunction>
	<cffunction name="GetCartID" access="public" returntype="numeric" output="No">
		<cfreturn variables.instance.CartID>
	</cffunction>
	<cffunction name="SetCartID" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="numeric">
		<cfset variables.instance.CartID=arguments.data>
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
	<cffunction name="GetItemID" access="public" returntype="string" output="No">
		<cfreturn variables.instance.ItemID>
	</cffunction>
	<cffunction name="SetItemID" access="public" returntype="boolean" output="No">
		<cfargument name="data" required="Yes" type="string">
		<cfset variables.instance.ItemID=arguments.data>
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
	<cffunction name="GetCartItems" access="public" output="No">
		<cfargument name="dsn" required="Yes" type="string">
		<cfset var GetPerson="">
		<cfquery name="CartQuery" datasource="#dsn#">
			select business.businessName as SupplierName, 
			Item.Name as ItemName, 
			Units.Name as UnitName, 
			JoinCartToItem.CartQuantity as Quantity,
			JoinCartToItem.ID as CartItemID,
			Item.ItemID as ItemID, 
			business.businessID as SupplierID,
			Carts.DateTime as DateTime
			from JoinCartToItem
			join Carts on JoinCartToItem.CartID = Carts.CartID
			join Item on JoinCartToItem.ItemID = Item.ItemID
			join business on JoinCartToItem.SupplierID = business.businessId
			join Units on Item.UnitID = Units.UnitID
			Where Carts.CartID = <cfqueryparam value="#variables.instance.CartID#" CFSQLType="CF_SQL_INTEGER">
			Order By business.businessId asc, Item.ItemID asc
		</cfquery>
		<cfset cartJSON = serializeJSON(CartQuery)>
		<cfreturn CartJSON>
	</cffunction>
	<cffunction name="DeleteCartItem" access="public" output="No">
		<cfargument name="dsn" required="Yes" type="string">
		<cfquery name="CartQuery" datasource="#dsn#">
			delete from JoinCartToItem
			where ID=<cfqueryparam value="#variables.instance.ItemID#" CFSQLType="CF_SQL_INTEGER">
		</cfquery>
	</cffunction>
</cfcomponent>