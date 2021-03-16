<cfinclude template="includes/secure.cfm" >
<html>
	<head>
		<cfinclude template="includes/bootstrap_head.cfm" >
		<title>86Never.com OrderTracker login.</title>
		<style>
			#signup {
				border: 1px solid #888;
				padding: 3px;
				border-radius: 3px;
				color: black;
				background-color: #efefef;
			}
			.succesMsg{
				color: green;
				margin-top: 0.5%;
				font-weight: bold;
			}
		</style>
	</head>
	<body>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfform name="login" action="login_ctrl.cfm">
			<div><cfinput type="text" name="username" required="true" message="You must provide a username" /></div>
			<div><cfinput type="password" name="password" required="true"message="You must provide a password" /></div>
			<div style="display:inline"><cfinput type="submit" name="Submit" value="login" /></div>
			<!---<div style="display:inline">
				<a id="signup" href="v1/index.cfm?action=admin.adduser"> Sign Up</a>
			</div>--->
			<cfif structKeyExists(session, 'userResult')
				AND structKeyExists(session.userResult, 'message')>
				<div class="succesMsg">
					<cfoutput>#session.userResult.message#</cfoutput>
				</div>
				<cfset structDelete(session.userResult, 'message')>
			</cfif>
			<!---<div><cfinput type="button" name="login" value="login" onclick="window.location='login_ctrl.cfm';" /></div>
			<div style="display:inline"></div>--->			
			<br><br><a href='http://localhost:8500/ordertracker/v1/index.cfm?action=admin.forgotpassword' >Forgot Password</a>
		</cfform>
		<cfinclude template="includes/bootstrap_js.cfm" >
		</div>
	</body>
</html>	