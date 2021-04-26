
<style>
	/* BASIC */
	body {
	  font-family: "Poppins", sans-serif;
	  height: 82vh;
	}
	
	a {
	  color: #1a73e8;
	  display:inline-block;
	  text-decoration: none;
	  font-weight: normal;
	  font-size:14px;
	  font-family:roboto,'Noto Sans Myanmar UI',arial,sans-serif;
	}

	#rememberme {
	  color: #1a73e8;
	  display:inline-block;
	  text-decoration: none;
	  font-weight: normal;
	  font-size:14px;
	  font-family:roboto,'Noto Sans Myanmar UI',arial,sans-serif;
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
	  color: #92badd;
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

	.underlineHover {
	  margin-left:25px;
	  	 
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

	#userName, #password
	{
		border: 1px solid #C0C0C0;
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
		color: #C0C0C0;
		padding-left: 3px;
		padding-right: 3px;
		font-weight: normal !important;
	}
	.r1 {
		margin-left:35px;
	}
	.text-right {
		margin-left:15px;

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
		<cfform action="login_ctrl.cfm" method="post" id="formSubmit" name="formSubmit">		
		  <div style="font-size: 20px !important;padding: 30px;color:##767272">
			Sign in
		  </div>
		  <div style="padding-top:20px;">
			<label id="labelEmail" style="display: none;">Email</label>
			 <cfif isdefined("cookie.rememberme") and cookie.rememberme eq "Yes">
				<cfinput type="text" id="userName" class="second" name="userName" value="#cookie.userName#" placeholder="Email" autocomplete="off">			
			<cfelse> 
			   <cfif isdefined("url.err") and url.err eq 1>
				<cfinput type="text" id="userName" class="second" name="userName" value="#cookie.hdnUserName#" required="yes" placeholder="Email" autocomplete="off">	
				<cfelse>
				<cfinput type="text" id="userName" class="second" name="userName" value="" required="yes" placeholder="Email" autocomplete="off">
				</cfif>			
			</cfif> 
			<span id="errorEmailText" style="display:none;margin-left:45;font-size:12px;" align="left"><image src="images/errorimage.PNG">Enter a valid email</span>
		  </div> 
		  <div style="padding-top:20px;">
			<label id="labelpassword" style="display: none;">Password</label>
			 <cfif IsDefined("cookie.rememberme") and cookie.rememberme eq "Yes">
				<cfinput type="password" id="password" class="second" name="password" value="#cookie.password#" placeholder="Password" >
			<cfelse>
				<cfinput type="password" id="password" class="second" name="password" required="yes" placeholder="Password" >
			 </cfif>
			 <span id="errorPasswordText" style="display:none;margin-left:45;font-size:12px;" align="left"><image src="images/errorimage.PNG">Enter a password</span>
		  </div>
		  <div  class="row" style="padding-top:4px;margin-left:20px;margin-left:-110px;">	
			<cfif isdefined("url.err") and url.err eq 1>
				<image src="images/errorimage.PNG" id="errimage"><font color="red" size="2px;" ><span id="errmessage">Please enter valid email and password   </span></font>
			<cfelseif isdefined("url.err") and url.err eq 2>
				<image src="images/errorimage.PNG" id="errimage"><font color="red" size="2px;" ><span id="errmessage">Couldn't find your Order Tracker Account</span></font>
			</cfif>	
		  </div>	 
		<div  class="row" style="padding-top:5px;">		 
				<div class="col-xs-4 r1">
				<input type="checkbox" name="rememberme" id="rememberme" value="Yes" <cfif IsDefined("cookie.rememberme") and cookie.rememberme eq "Yes">CHECKED</cfif> ><span id="rememberme" style="margin-right: 20px;" >&nbsp;Remember Me</span> 					
				</div>
				<div class="col-xs-4 text-right">
				<a class="underlineHover" href="v1/index.cfm?action=admin.forgotpassword" >Forgot Password?</a>					
				</div>
		</div>
		<div  class="row" style="padding-top:25px;">
			<input type="button" class="btn btn-info" value="Submit" name="btnsubmit" id="btnsubmit" style="background-color:##1a73e8;">
		  	<input type="submit" value="Login" name="submit"  id="submit" style="display:none;">
		</div>
		</cfform>
		<!-- Remind Passowrd -->
		<div id="formFooter">
		   <a class="underlineHover" href="v1/index.cfm?action=user.viewTroubleHelp">Trouble Logging in?</a>
		</div>
	  </div>
	</div>
</cfoutput>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<script>
   $(document).ready(function(){ 	  
	  $("#userName").focus();
	  $("#labelEmail").css({'color':'#0095ff','display':'block'});
	  $("#userName").attr("placeholder",'');
	  $("#userName").css('border','1px solid #0095ff');

	   if($("#errmessage").is(":visible") === true)      
	   {
		   $("#userName").css('border','1px solid red');
			$("#userName").attr("placeholder",'');
			$("#labelEmail").css({'color':'red','display':'block'});
			$("#password").css('border','1px solid red');
			$("#password").attr("placeholder",'');
			$("#labelpassword").css({'color':'red','display':'block'});
	   }	  

    $('#btnsubmit').click(function(){	
			 if ($("#password").val() == "" && 	$("#userName").val() == "")
			 {
				  $("#errmessage").css({'color':'red','display':'none'});	
                  $("#errimage").css({'color':'red','display':'none'});
				 $("#password").css('border-color', 'red');		
				 $("#userName").css('border-color', 'red');		
				 $("#errorPasswordText").css({'color':'red','display':'block'});	
				 $("#errorEmailText").css({'color':'red','display':'block'});	
				 $("#userName").focus();
			}			 			
			else if ($("#userName").val() == "")
			{			$("#errmessage").css({'color':'red','display':'none'});	
                  $("#errimage").css({'color':'red','display':'none'});
				 $("#userName").css('border-color', 'red');	
			     $("#errorEmailText").css({'color':'red','display':'block'});
				  $("#userName").focus();	
			}  
			else if( $("#password").val() == "" )
			{ 
				
				 $("#password").css('border-color', 'red');	
				 $("#errorPasswordText").css({'color':'red','display':'block'});
				 $("#password").focus();	
				 $("#errmessage").css({'color':'red','display':'none'});	
                 $("#errimage").css({'color':'red','display':'none'});
				 	
			}
			else
		   {
			   
			   	$('#submit').click();	
		   }             
    });	 

	$("#userName").focusin(function(){  
		if($("#errorEmailText").is(":visible") === true || $("#errmessage").is(":visible") === true)
		{
			$("#userName").css('border','1px solid red');
			$("#userName").attr("placeholder",'');
			$("#labelEmail").css({'color':'red','display':'block'});
		}	
		else
		{
			$("#userName").css('border','1px solid #0095ff');
			$("#userName").attr("placeholder",'');
			$("#labelEmail").css({'color':'#0095ff','display':'block'});
		}		
	});

	$("#password").focusin(function(){  
		if($("#errorPasswordText").is(":visible") === true || $("#errmessage").is(":visible") === true)
		{
			$("#password").css('border','1px solid red');
			$("#password").attr("placeholder",'');
			$("#labelpassword").css({'color':'red','display':'block'});
		}
		else
		{
			$("#password").css('border','1px solid #0095ff');
			$("#password").attr("placeholder",'');
			$("#labelpassword").css({'color':'#0095ff','display':'block'});
		}		
	});

	$("#userName").focusout(function(){  
		if($("#errorEmailText").is(":visible") === true || $("#errmessage").is(":visible") === true)
		{
			$("#userName").css('border','1px solid red');
			if($("#userName").val() === ''){
				$("#labelEmail").css({'color':'red','display':'none'});
			}
			else{
				$("#labelEmail").css({'color':'red','display':'block'});
			}
			$("#userName").attr("placeholder",'Email');	
		}
		else
		{
			$("#userName").css('border','1px solid #C0C0C0');
			if($("#userName").val() === ''){
				$("#labelEmail").css({'color':'#C0C0C0','display':'none'});
			}
			else{
				$("#labelEmail").css({'color':'#C0C0C0','display':'block'});
			}
			$("#userName").attr("placeholder",'Email');	
		}	
	});

	$("#password").focusout(function(){  
		if($("#errorPasswordText").is(":visible") === true || $("#errmessage").is(":visible") === true)
		{
			$("#password").css('border','1px solid red');
			if($("#password").val() === '')
			{
				$("#labelpassword").css({'color':'red','display':'none'});
			}
			else
			{
				$("#labelpassword").css({'color':'red','display':'block'});
			}
			$("#password").attr("placeholder",'Password');
		}
		else
		{
			$("#password").css('border','1px solid #C0C0C0');
			if($("#password").val() === '')
			{
				$("#labelpassword").css({'color':'#C0C0C0','display':'none'});
			}
			else
			{
				$("#labelpassword").css({'color':'#C0C0C0','display':'block'});
			}
			$("#password").attr("placeholder",'Password');
		}		
	});

	$("#rememberme").click(function(){
		if($("#rememberme").prop('checked') === false){
			$("#password").val('');
			$("#userName").val('');
		}
	});   
});
</script> 

