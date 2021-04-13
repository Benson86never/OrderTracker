<cftry>
<cfquery name="qryRecords">
	select 
    i.name,
    i.sku,
    i.unitid,
    i.photourl
  from
    item i
    inner join joinsuppliertoitem j on i.itemid = j.itemid
  where
  j.supplierid = <cfqueryparam value="#url.businessId#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="getBusinessName">
  SELECT
    B.businessName
  FROM
    business B
  WHERE
    B.businessId = <cfqueryparam value="#url.businessId#" cfsqltype="cf_sql_integer">
</cfquery>
<cfset theSheet = spreadsheetNew("#getBusinessName.businessName#")>
<cfset rowNum = 1>
<cfset colNum = 0>
<cfset spreadsheetSetCellValue(theSheet, "Name", rowNum, ++colNum)>
<cfset spreadsheetSetCellValue(theSheet, "SKU", rowNum, ++colNum)>
<cfset spreadsheetSetCellValue(theSheet, "UnitId", rowNum, ++colNum)>
<cfset spreadsheetSetCellValue(theSheet, "PhotoUrl", rowNum, ++colNum)>
<cfloop query="qryRecords">
  <cfset rowNum = rowNum + 1>
  <cfset colNum = 0>
  <cfset spreadsheetSetCellValue(theSheet, "#qryRecords.name#", rowNum, ++colNum)>
  <cfset spreadsheetSetCellValue(theSheet, "#qryRecords.sku#", rowNum, ++colNum)>
  <cfset spreadsheetSetCellValue(theSheet, "#qryRecords.unitid#", rowNum, ++colNum)>
  <cfset spreadsheetSetCellValue(theSheet, "#qryRecords.photourl#", rowNum, ++colNum)>
</cfloop>
<cfheader name="Content-Disposition" value="attachment;filename=#getBusinessName.businessName#.xls">
<cfcontent variable="#spreadsheetReadBinary(theSheet)#" type="application/msexcel">
<cfcatch>
  <cfdump  var="#cfcatch#"><cfabort>
</cfcatch>
</cftry>

