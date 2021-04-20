<!DOCTYPE html>
<html>
<head>
<title>Add Item Action</title> 
<cfif structKeyExists(form, "uploadfile")>
	<cffile action="upload" filefield="uploadfile" destination="#GetTempDirectory()#" nameConflict="makeUnique"  result="upload" >   
<cfif ListLast(upload.SERVERFILE,".") eq "xlsx"
  OR ListLast(upload.SERVERFILE,".") eq "xls">
<cftransaction> 
<cftry>
    <cfif upload.fileWasSaved>    
       <cfspreadsheet action="read" src="#GetTempDirectory()##upload.SERVERFILE#" query="qryItemData" headerrow="1">      
       <cfloop query="qryItemData">
         <cfquery name="qryCheckExistingItems" datasource="#application.datasource#">
            select itemid,name from item where name = <cfqueryparam value="#qryItemData.name#" cfsqltype="cf_sql_varchar">
         </cfquery>     
         <cfif qryItemData.name neq "name" and qryCheckExistingItems.recordCount eq 0>
	      <cfquery name="qryInsert" datasource="#application.datasource#" result="result">
              insert into item(name,sku,unitid,photourl) values(<cfqueryparam value="#qryItemData.name#" cfsqltype="cf_sql_varchar">,<cfqueryparam value="#qryItemData.sku#" cfsqltype="cf_sql_integer">,<cfqueryparam value="#qryItemData.unitid#" cfsqltype="cf_sql_integer">,<cfqueryparam value="#qryItemData.photourl#" cfsqltype="cf_sql_varchar">)
          </cfquery>
          <cfquery name="qryInsertSup" datasource="#application.datasource#">
              insert into joinsuppliertoitem(itemid,supplierid) values(<cfqueryparam value="#result.generatedkey#" cfsqltype="cf_sql_integer">,<cfqueryparam value="#qryItemData.supplierid#" cfsqltype="cf_sql_integer">)
          </cfquery>
        <cfelseif qryItemData.name neq "name" and qryCheckExistingItems.recordCount gt 0>
           <cfquery name="qryUpdateitem" datasource="#application.datasource#" result="result">
              update item set name=<cfqueryparam value="#qryItemData.name#" cfsqltype="cf_sql_varchar">,
              sku=<cfqueryparam value="#qryItemData.sku#" cfsqltype="cf_sql_integer">,
              unitid=<cfqueryparam value="#qryItemData.unitid#" cfsqltype="cf_sql_integer">,
              photourl=<cfqueryparam value="#qryItemData.photourl#" cfsqltype="cf_sql_varchar">
              where itemid = <cfqueryparam value="#qryCheckExistingItems.itemid#" cfsqltype="cf_sql_integer">
          </cfquery>
          <cfquery name="qryUpdatesup" datasource="#application.datasource#">
              update joinsuppliertoitem set itemid=<cfqueryparam value="#qryCheckExistingItems.itemid#" cfsqltype="cf_sql_integer">,
              supplierid=<cfqueryparam value="#qryItemData.supplierid#" cfsqltype="cf_sql_integer">
              where itemid = <cfqueryparam value="#qryCheckExistingItems.itemid#" cfsqltype="cf_sql_integer">            
          </cfquery>
         </cfif>
       </cfloop>        
    </cfif>
<cfcatch type="any">
       <cfoutput>
          Error occured....<br /><br />
        Message: <b>#cfcatch.Message#</b><br /> 
        Detail: <b>#cfcatch.Detail#</b><br />
        Type: <b>#cfcatch.Type#</b><br />
      </cfoutput>
  </cfcatch>
</cftry>
</cftransaction>
           <cflock name="releaselock" timeout="10">
              <cffile action = "delete" file = "#GetTempDirectory()##upload.SERVERFILE#">
          </cflock>
<cfelse>
<cflocation url="manageitem.cfm?err=1">
</cfif>
</cfif>
<cflocation url="manageitem.cfm">
</head>
<body>
</body>
</html>