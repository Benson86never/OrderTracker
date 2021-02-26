<cfinclude template="includes/secure.cfm" >
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		<title>86Never.com OrderTracker User Creator.</title>
	</head>
	<body>
		<div class="container-fluid">
			<cfinclude template="includes/header.cfm" >
			<cfform name="createuser" action="user_ctrl.cfm" >
				First Name: <cfinput type="text" name="firstname" /><br />
				Last Name: <cfinput type="text" name="lastname" /><br />
				Email: <cfinput type="text" name="email" /><br />
				Phone: <cfinput type="text" name="phone" /><br />
				Carrier: <cfselect name="carrier">
				<option value="vzwpix.com">Verizon</option>
				<option value="mms.att.net">AT&T</option>
				<option value="tmomail.net">T-Mobile</option>
				<option value="pm.sprint.com">Sprint</option>
				</option>
				</cfselect>
				<br />
				User Type: <cfinput type="text" name="type" /><br />
				Password: <cfinput type="text" name="password" /><br />
				<cfinput type="submit" name="Submit" value="submit">
			</cfform>
		<cfinclude template="includes/bootstrap_js.cfm" >
		</div>
	</body>
	
</html>