<cfset Today=#Now()#>
<cfset Yesterday=#DateAdd("d",-1,Today)#>
<cfset ORMToday = #DateTimeFormat(Today,"yyyy-mm-dd HH:nn:ss")#>
<cfset ORMYesterday = #DateTimeFormat(Yesterday,"yyyy-mm-dd HH:nn:ss")#>
<cfquery name="qryGetBusinessMail" datasource="#application.datasource#">
select email from business where businessid = <cfqueryparam value="#session.secure.subaccount#" cfsqltype="cf_sql_integer">
</cfquery>
<cfset CCEmail = "#qryGetBusinessMail.email#">
<cfset FromEmail = "orders@porthousegrill.com">
<cfoutput>
	<cftry>
		<cfset TodayOrders = CreateObject("Component","v1.model.services.order").sendOrders(
			businessId = session.secure.subaccount
		).orders>
		#ORMToday#
		#ORMYesterday#<br />
		<cfset itemArray=ArrayNew(2)>
		<cfloop array="#TodayOrders#" index="orders">
			<cfloop array="#orders.reps#" index="rep">
				<cfif len(trim(rep.email)) >
					<!---<cfmail from="#FromEmail#" subject="#orders.supplierName# order #orders.OrderID#" to="#rep.email#" cc="#CCEmail#" type="text/html">
						
						<cfmailpart type="html">--->
							<table cellpadding="5" cellspacing="5">
								<tr>
									<td colspan="4" style="padding: 5px;">
										Supplier is #orders.SupplierName#
									</td>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;">
										Dear #rep.FirstName#,
									</td>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;">
										Please deliver the following tomorrow.
									</td>
								</tr>
							</table>
							<table cellpadding="5" cellspacing="5">
								<tr>
									<th colspan="4" style="padding: 5px;text-align:left;">
										Business Information
									</th>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;">
										#orders.businessName#,
									</td>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;">
										<cfif len(trim(orders.StreetAddress1))>
											#orders.StreetAddress1#,
										</cfif>
										<cfif len(trim(orders.StreetAddress2))>
											#orders.StreetAddress2#,
										</cfif>
									</td>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;">
										#orders.City#,#orders.State#,#orders.Country#
									</td>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;">
										#orders.businessEmail#
									</td>
								</tr>
							</table>
							<table cellpadding="5" cellspacing="5">
								<tr>
									<th colspan="4" style="padding: 5px;text-align:left;">
										Customer Information
									</th>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;">
										#orders.firstName# #orders.lastName#
									</td>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;">
										<cfif len(trim(orders.email))>
											#orders.email#
										</cfif>
										<cfif len(trim(orders.phone))>
											,#orders.phone#
										</cfif>
									</td>
								</tr>
								<tr>
									<th colspan="4" style="padding: 5px;text-align:left;">
										Order Information
									</th>
								</tr>
								<tr>
									<td colspan="4" style="padding: 5px;text-align:left;">
										Ordered on #dateformat(orders.orderedDate, 'dd mmm yyyy')#
									</td>
								</tr>
							</table>
							<table border="1" cellpadding="5" cellspacing="0">
								<tr>
									<td style="text-align:center;padding: 5px;">
										Name
									</td>
									<td style="text-align:center;padding: 5px;">
										Quantity
									</td>
									<td style="text-align:center;padding: 5px;">
										Units
									</td>
									<td style="text-align:center;padding: 5px;">
										SKU
									</td>
								</tr>
								<cfloop array="#orders.items#" index="item">
									<tr style="border-left:1pt solid black;">
										<td style="text-align:center;padding: 5px;">
											#item.itemname#
										</td>
										<td style="text-align:center;padding: 5px;">
											#item.quantity#
										</td>
										<td style="text-align:center;padding: 5px;">
											#item.unitname#
										</td>
										<td style="text-align:center;padding: 5px;">
											<cfif item.sku is not 1> #item.sku#</cfif>
										</td>
									</tr>
									<!---<cfquery datasource="#application.datasource#">
										Update Orders
										Set Closed = 1
										where OrderID = "#item.id#"
									</cfquery>--->
								</cfloop>
							</table>
							<table cellpadding="5" cellspacing="5">
								<tr>
									<td colspan="4" style="padding: 5px;">
										Thank you from the Port House Grill team.
									</td>
								</tr> 
								<tr>
									<td colspan="4" style="padding: 5px;">
										Please reply RECEIVED to this note to confirm your receipt.
									</td>
								</tr> 
								<tr>
									<td colspan="4" style="padding: 5px;">
										POWERED BY ORDERTRACKER&trade;
									</td>
								</tr>
							</table>
						<!---</cfmailpart>
					</cfmail>--->
					---Mail Sent to #rep.email#---<br />
					
				</cfif>
			</cfloop>
		</cfloop>
		<cfcatch>
			<cfmail from="#FromEmail#" subject="Port House Grill order mail error" to="#CCEmail#" type="text/html">
				An error sending the order email occurred:
				<cfoutput>#cfcatch.message# - #cfcatch.detail#</cfoutput>
			</cfmail>
		</cfcatch>
	</cftry>
	<!---<cflocation url="list.cfm" addtoken="no">--->
</cfoutput>