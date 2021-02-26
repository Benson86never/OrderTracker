<cfset Today=#Now()#>
<cfset Yesterday=#DateAdd("d",-1,Today)#>
<cfset ORMToday = #DateTimeFormat(Today,"yyyy-mm-dd HH:nn:ss")#>
<cfset ORMYesterday = #DateTimeFormat(Yesterday,"yyyy-mm-dd HH:nn:ss")#>
<cfset CCEmail = "info@porthousegrill.com">
<cftry>
<cfscript>
//TodayOrders = ORMExecuteQuery( "from orders where datetime <= '2019-06-21 02:33:19' and datetime > '2019-06-19 02:33:19'" );
//TodayOrders = ORMExecuteQuery( "from orders where datetime <= '#ORMToday#' and datetime > '#ORMYesterday#'" );
//AllOrders = ORMExecuteQuery( "from orders where datetime = '2019-06-21 12:20:38'" );
TodayOrders = ORMExecuteQuery( "from orders where closed = 0" );

</cfscript>

<cfoutput>
#ORMToday#
#ORMYesterday#<br />
<cfset itemArray=ArrayNew(2)>
<cfloop array="#TodayOrders#" index="orders">
	<cfset LoopSupplier = #orders.getsupplierid()#>
	<cfset OrderID = #orders.getid()#>
	#OrderID#
	<cfset SupplierID = #orders.getsupplierid()#>
	#SupplierID#
	<!---<cfdump var="#orders.getitem()#" label="Query Items">--->
	<cfset o = 1>
	<cfloop array="#orders.getitem()#" index="item" >
		Loop number #o# Item = #item.getname()# #item.getid()#
		<cfset loopunits = #item.getunits()#>
		<cfset itemArray[o][1] = #item.id#>
		<cfset itemArray[o][2] = #item.sku#>
		<cfset itemArray[o][3] = #item.name#>
		<cfset Quantity = EntityLoad( "JoinOrderToItem", { itemid=#item.getid()#, orderid=#orders.getid()# } )>
		<cfloop array="#Quantity#" index="quantity" >
		<cfset itemArray[o][4] = #quantity.getquantity()#>
		</cfloop>
		<cfset itemArray[o][5] = #item.units.name#>
		<cfset o = o + 1>
	</cfloop>
	<cfdump var="#itemArray#" label="Array Items">
	<cfset Supplier = EntityLoad( "supplier", { id=#orders.getsupplierid()# } )>
		<cfset FirstNameList = "">
		<cfset EmailList = "">
		<cfloop array="#Supplier#" index="supplier">
			<cfset SupplierName = #supplier.getname()#>
			<cfloop array="#Supplier.getPerson()#" index="rep">
			<cfset RepFirstName = #rep.getfirstname()#>
			<cfset RepEmail = #rep.getemail()#>
			<cfset FirstNameList = ListAppend(FirstNameList, RepFirstName)>
			<cfset EmailList = ListAppend(EmailList, RepEmail)>
			</cfloop>
		</cfloop>
		#FirstNameList#
		#EmailList#
<cfif isDefined("EmailList") and EmailList is not "">
<cfmail from="info@porthousegrill.com" subject="Port House Grill order #OrderID# mail test" to="#EmailList#" cc="#CCEmail#" type="text/html">
<cfmailpart type="text" wraptext="72">
---------------------------------------------------------
OrderID is #OrderID#
Supplier is #SupplierName#
Hi #FirstNameList#,
Please deliver the following tomorrow.

Quantity--Units--Name

<cfloop from="1" to="#ArrayLen(itemArray)#" index="i">
#itemArray[i][4]#--#itemArray[i][5]#--<cfif itemArray[i][2] is not 1>(#itemArray[i][2]#)</cfif>#itemArray[i][3]#
-----
</cfloop>

Thank you from the Port House Grill team.

POWERED BY ORDERTRACKER(tm)
</cfmailpart>
<cfmailpart type="html">
<table>
<tr>
<td colspan="4">
OrderID is #OrderID#
</td>
</tr>
<tr>
<td colspan="4">
Supplier is #SupplierName#
</td>
</tr>
<tr>
<td colspan="4">
Dear #FirstNameList#,
</td>
</tr>
<tr>
<td colspan="4">
Please deliver the following tomorrow.
</td>
</tr> 
<tr>
	<td style="text-align:center";>
Quantity
	</td>
	<td style="text-align:center";>
Units
	</td>
	<td style="text-align:center";>
	SKU
	</td>
	<td style="text-align:center";>
Name
	</td>
</tr>
<cfloop from="1" to="#ArrayLen(itemArray)#" index="i">
	
<tr style="border-left:1pt solid black;">
	<td style="text-align:center";>
#itemArray[i][4]#
	</td>
	<td style="text-align:center";>
#itemArray[i][5]#
	</td>
	<td style="text-align:center";>
	<cfif itemArray[i][2] is not 1> #itemArray[i][2]#</cfif>
	</td>
	<td style="text-align:left";>
#itemArray[i][3]#
	</td>
</tr>
	
</cfloop>
<tr>
<td colspan="4">
Thank you from the Port House Grill team.
</td>
</tr> 
<tr>
<td colspan="4">
POWERED BY ORDERTRACKER&trade;
</td>
</tr>
</table>
</cfmailpart>
</cfmail>

---Mail Sent---<br />

<cfquery datasource="#application.datasource#">
	Update Orders
	Set Closed = 1
	where OrderID = "#OrderID#"
</cfquery>

</cfif>
<cfset ArrayClear(itemArray)>
<cfset EmailList = "">
<cfset FirstNameList = "">

</cfloop>

</cfoutput>
<cfcatch>
 <cfmail from="info@porthousegrill.com" subject="Port House Grill order mail error" to="#CCEmail#" type="text/html">
 	An error sending the order email occurred:
    <cfoutput>#cfcatch.message# - #cfcatch.detail#</cfoutput>
 </cfmail>
</cfcatch>
</cftry>
