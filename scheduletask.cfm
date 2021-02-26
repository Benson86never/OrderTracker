<cftry>
<cfschedule action = "update"
task = "OrdertrackerEmailOrders"
operation = "HTTPRequest"
url = "https://www.86never.com/scheduletask.cfm"
startDate = "7/11/2019"
startTime = "6:00 PM"
interval = "daily"
resolveURL = "No"
publish = "No"
path = "D:\home\86never.com\wwwroot\order_email.cfm"
>
<cfcatch>
	<cfoutput>
		#Cfcatch.Message#
	</cfoutput>
</cfcatch>
</cftry>
Task Scheduled
