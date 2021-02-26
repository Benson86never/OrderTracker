<cfinclude template="includes/secure.cfm" >

<cfscript>
	Units = entityLoad("units");
	Suppliers = entityLoad("supplier");
</cfscript>
<cfsetting showDebugOutput="No">
<html>
	<head>
		<meta charset='UTF-8'/>
  		<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0' />	
		<title>86Never.com OrderTracker login.</title>
	</head>
	<body>
		<cfset UnitIDList = "">
		<cfset UnitNameList = "">
		<cfset SupplierIDList = "">
		<cfset SupplierNameList = "">
		<cfloop array="#Units#" index="unit">
			<cfset UnitIDList = ListAppend(UnitIDList, unit.id)>
			<cfset UnitNameList = ListAppend(UnitNameList, unit.name)>
		</cfloop>
		<cfloop array="#Suppliers#" index="supplier">
			<cfset SupplierIDList = ListAppend(SupplierIDList, supplier.id)>
			<cfset SupplierNameList = ListAppend(SupplierNameList, supplier.name)>
		</cfloop>
		<cfset Uid = "#UnitIDList#">
    	<cfset Uname = "#UnitNameList#">
		<cfset Sid = "#SupplierIDList#">
    	<cfset Sname = "#SupplierNameList#">
		<cfform name="form01">
			<cfgrid format="html" preservepageonsort="yes" name="grid01" pagesize=30 selectmode="edit" delete="yes" insert="yes" bindOnLoad="yes"
			bind="url:getData.cfm?page={cfgridpage}&pagesize={cfgridpagesize}&sort={cfgridsortcolumn}&dir={cfgridsortdirection}" 
			onchange="cfc:com.item_np.editItem({cfgridaction},{cfgridrow},{cfgridchanged})">                         
			<cfgridcolumn name="NAME" display=true header="Name"/> 
			<cfgridcolumn name="SKU" display=true header="SKU"/> 
			<cfgridcolumn name="PHOTOURL" display=true header="PhotoURL"/> 
			<cfgridcolumn name="ID" display=false header="ID"/> 
			<cfgridcolumn name="UNITNAME" display=true header="Units" width="125" select="true" values="#Uid#" valuesdisplay="#Uname#"/> 
			<cfgridcolumn name="SUPPLIERNAME" header="Supplier" width="125" select="true" values="#Sid#" valuesdisplay="#Sname#"/> 
			</cfgrid>
		</cfform>
	</body>
	
</html>
