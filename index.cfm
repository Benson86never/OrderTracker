<!---<cfinclude template="includes/secure.cfm" >
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
</html>--->

<style>
    
	/* BASIC */
	
	
	body {
	  font-family: "Poppins", sans-serif;
	  height: 82vh;
	}
	
	a {
	  color: #92badd;
	  display:inline-block;
	  text-decoration: none;
	  font-weight: 400;
	}
	
	h2 {
	  text-align: center;
	  font-size: 16px;
	  font-weight: 600;
	  text-transform: uppercase;
	  display:inline-block;
	  margin: 40px 8px 10px 8px; 
	  color: #cccccc;
	}
	
	
	
	/* STRUCTURE */
	
	.wrapper {
	  display: flex;
	  align-items: center;
	  flex-direction: column; 
	  justify-content: center;
	  width: 98%;
	  min-height: 100%;
	  padding: 20px;
	}
	
	#formContent {
	  -webkit-border-radius: 10px 10px 10px 10px;
	  border-radius: 10px 10px 10px 10px;
	  background: #fff;
	  padding: 30px;
	  width: 90%;
	  max-width: 450px;
	  position: relative;
	  padding: 0px;
	  -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	  text-align: center;
	}
	
	#formFooter {
	  background-color: #f6f6f6;
	  border-top: 1px solid #dce8f1;
	  padding: 25px;
	  text-align: center;
	  -webkit-border-radius: 0 0 10px 10px;
	  border-radius: 0 0 10px 10px;
	}
	
	
	
	/* TABS */
	
	h2.inactive {
	  color: #cccccc;
	}
	
	h2.active {
	  color: #0d0d0d;
	  border-bottom: 2px solid #5fbae9;
	}
	
	
	
	/* FORM TYPOGRAPHY*/
	
	input[type=button], input[type=submit], input[type=reset]  {
	  background-color: #56baed;
	  border: none;
	  color: white;
	  padding: 15px 80px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  text-transform: uppercase;
	  font-size: 13px;
	  -webkit-box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
	  box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
	  -webkit-border-radius: 5px 5px 5px 5px;
	  border-radius: 5px 5px 5px 5px;
	  margin: 5px 20px 40px 20px;
	  -webkit-transition: all 0.3s ease-in-out;
	  -moz-transition: all 0.3s ease-in-out;
	  -ms-transition: all 0.3s ease-in-out;
	  -o-transition: all 0.3s ease-in-out;
	  transition: all 0.3s ease-in-out;
	  cursor:pointer;
	}
	
	input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover  {
	  background-color: #39ace7;
	}
	
	input[type=button]:active, input[type=submit]:active, input[type=reset]:active  {
	  -moz-transform: scale(0.95);
	  -webkit-transform: scale(0.95);
	  -o-transform: scale(0.95);
	  -ms-transform: scale(0.95);
	  transform: scale(0.95);
	}
	
	input[type=text],input[type=password] {
	 /* background-color: #f6f6f6;*/
	  border: none;
	  color: #0d0d0d;
	  padding: 15px 32px;
	  text-align: left;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  margin: 5px;
	  width: 80%;
	  border: 2px solid #f6f6f6;
	  -webkit-transition: all 0.5s ease-in-out;
	  -moz-transition: all 0.5s ease-in-out;
	  -ms-transition: all 0.5s ease-in-out;
	  -o-transition: all 0.5s ease-in-out;
	  transition: all 0.5s ease-in-out;
	  -webkit-border-radius: 5px 5px 5px 5px;
	  border-radius: 5px 5px 5px 5px;
	  
	}
	
	input[type=text],input[type=password]:focus {
	  background-color: #fff;
	  border-bottom: 2px solid #5fbae9;
	}
	
	input[type=text],input[type=password]:placeholder {
	  color: #cccccc;
	}
	
	
	
	/* ANIMATIONS */
	
	/* Simple CSS3 Fade-in-down Animation */
	.fadeInDown {
	  -webkit-animation-name: fadeInDown;
	  animation-name: fadeInDown;
	  -webkit-animation-duration: 1s;
	  animation-duration: 1s;
	  -webkit-animation-fill-mode: both;
	  animation-fill-mode: both;
	}
	
	@-webkit-keyframes fadeInDown {
	  0% {
		opacity: 0;
		-webkit-transform: translate3d(0, -100%, 0);
		transform: translate3d(0, -100%, 0);
	  }
	  100% {
		opacity: 1;
		-webkit-transform: none;
		transform: none;
	  }
	}
	
	@keyframes fadeInDown {
	  0% {
		opacity: 0;
		-webkit-transform: translate3d(0, -100%, 0);
		transform: translate3d(0, -100%, 0);
	  }
	  100% {
		opacity: 1;
		-webkit-transform: none;
		transform: none;
	  }
	}
	
	/* Simple CSS3 Fade-in Animation */
	@-webkit-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
	@-moz-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
	@keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
	
	.fadeIn {
	  opacity:0;
	  -webkit-animation:fadeIn ease-in 1;
	  -moz-animation:fadeIn ease-in 1;
	  animation:fadeIn ease-in 1;
	
	  -webkit-animation-fill-mode:forwards;
	  -moz-animation-fill-mode:forwards;
	  animation-fill-mode:forwards;
	
	  -webkit-animation-duration:1s;
	  -moz-animation-duration:1s;
	  animation-duration:1s;
	}
	
	.fadeIn.first {
	  -webkit-animation-delay: 0.4s;
	  -moz-animation-delay: 0.4s;
	  animation-delay: 0.4s;
	}
	
	.fadeIn.second {
	  -webkit-animation-delay: 0.6s;
	  -moz-animation-delay: 0.6s;
	  animation-delay: 0.6s;
	}
	
	.fadeIn.third {
	  -webkit-animation-delay: 0.8s;
	  -moz-animation-delay: 0.8s;
	  animation-delay: 0.8s;
	}
	
	.fadeIn.fourth {
	  -webkit-animation-delay: 1s;
	  -moz-animation-delay: 1s;
	  animation-delay: 1s;
	}
	
	/* Simple CSS3 Fade-in Animation */
	.underlineHover:after {
	  display: block;
	  left: 0;
	  bottom: -10px;
	  width: 0;
	  height: 2px;
	  background-color: #56baed;
	  content: "";
	  transition: width 0.2s;
	}
	
	.underlineHover:hover {
	  color: #0d0d0d;
	}
	
	.underlineHover:hover:after{
	  width: 100%;
	}
	
	
	
	/* OTHERS */
	
	*:focus {
		outline: none;
	} 
	
	#icon {
	  width:60%;
	}
	div
	{
		position:relative;
	}
	#login, #password
	{
		border: 1px solid #0095ff;
		border-radius: 4px;
		padding: 15px;
	}
	label
	{
		position: absolute;
		top: -3px;
		font-size: 15px;
		left: 50px;
		background: white;
		margin-top: 20px;
		color: #0095ff;
		padding-left: 3px;
		padding-right: 3px;
		font-weight: normal;
	}
</style>
 
      <link rel="stylesheet" href="v1/css/bootstrap.css" />
     <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="v1/scripts/bootstrap.min.js"></script>
	<cfinclude template="v1/views/_includes/modals.cfm">
 <cfoutput>
	<div class="wrapper">
	  <div id="formContent">
		<!-- Tabs Titles -->
		<!-- Icon -->
		<div class="first">		  
		</div>	
		<!-- Login Form -->
			<form action="login_ctrl.cfm" method="post" id="formSubmit" name="formSubmit">
		
		  <div style="font-size: 20px !important;padding: 30px;color:##767272">
			Sign in with your Email Address
		  </div>
		  <div style="padding-top:20px;">
			<label>Email</label>
			<input type="text" id="userName" class="second" name="userName">
		  </div>
		  <div style="padding-top:20px;">
			<label>Password</label>
			<input type="password" id="password" class="second" name="password">
		  </div>
		  <input type="button" class="fourth" value="Login" name="btnsubmit"  id="btnsubmit" >
		  <input type="submit" value="Login" name="submit"  id="submit" style="display:none;">
		</form>
		<!-- Remind Passowrd -->
		<div id="formFooter">
		  <a class="underlineHover" href="v1/index.cfm?action=admin.forgotpassword">Forgot Password?</a>
		</div>
	  </div>
	</div>
</cfoutput>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<script>
   $(document).ready(function(){       
           $('#btnsubmit').click(function(){			
			if( $("#password").val() == "" || $("#userName").val() == "")
			{ 
				$('#modal-showAlert').modal('show');             
				$('.modal-header').css('background-color','white');
				$('#headerText').html('Login Information');
				$('.close').css('color','black');
				$('#modal-showAlert .modal-body').html("Please Fill Username and Password");       
				$('#modal-showAlert .modal-footer .ok').show();    
				$('#modal-showAlert .modal-footer .yes').hide();
				$('#modal-showAlert .modal-footer .no').hide();   			
			}
			else
			{			
					$('#submit').click();				
			}               
    });	 
});
</script> 
