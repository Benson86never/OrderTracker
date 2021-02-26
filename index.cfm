<cfinclude template="includes/secure.cfm" >
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		<title>86Never.com OrderTracker login.</title>
	</head>
	<body>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfform name="login" action="login_ctrl.cfm">
			<div><cfinput type="text" name="username" required="true" message="You must provide a username" /></div>
			<div><cfinput type="password" name="password" required="true"message="You must provide a password" /></div>
			<div><cfinput type="submit" name="Submit" value="login" /></div>
			<!---<div><cfinput type="button" name="login" value="login" onclick="window.location='login_ctrl.cfm';" /></div>
			<div><cfinput type="button" name="sign-up" value="sign-up" onclick="window.location='regiser_ctrl.cfm';" /></div>--->
		</cfform>
		<cfinclude template="includes/bootstrap_js.cfm" >
		</div>
	</body>
</html>	