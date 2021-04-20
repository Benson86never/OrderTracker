
<cfset theSheet = spreadsheetNew("Item Template")>
<cfset rowNum = 1>
<cfset colNum = 0>
<cfset spreadsheetSetCellValue(theSheet, "Name", rowNum, ++colNum)>
<cfset spreadsheetSetCellValue(theSheet, "SKU", rowNum, ++colNum)>
<cfset spreadsheetSetCellValue(theSheet, "UnitId", rowNum, ++colNum)>
<cfset spreadsheetSetCellValue(theSheet, "PhotoUrl", rowNum, ++colNum)>
<cfheader name="Content-Disposition" value="attachment;filename=Item Template.xls">
<cfcontent variable="#spreadsheetReadBinary(theSheet)#" type="application/msexcel">

