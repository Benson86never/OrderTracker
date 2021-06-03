
<style>  
/* BASIC */

body {
  font-family: "Poppins", sans-serif;
  height: 100vh;
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
  width: 100%;
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
  padding: 6px 12px;
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

  border: none;
  color: #0d0d0d;
  padding: 15px;
  text-align: left important!;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 5px;
  width: 73%;
  height: 20px;
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
  top:20%;

}
#login, #password, #cpassword
{
  border: 1px solid #C0C0C0;
  border-radius: 4px;
  
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
  font-weight: normal;
}

 #showPaasword {
        float: right;
        margin-right: 6px;
        margin-top: 15px;
        position: absolute;
        left:375px;
        z-index: 2;
        color: #807b7b;
        cursor:pointer;
    }
 @media (max-width: 992px) {
    #showPaasword {
      left:230px;


    }
 }

  </style>
   <cfset personid = decrypt(url.userid, application.uEncryptKey, "BLOWFISH", "Hex")>
    <cfquery name="qrySelectPerson" datasource="#application.dsn#">
    select * from person where personid = #personid#
    </cfquery>
  <cfif qrySelectPerson.account_active eq 1 and url.login neq 1>
    <cflocation url="../login_ctrl.cfm?action=logout">
  <cfelse>
  <cfif isdefined("url.login") and url.login eq 1>
    <cfscript>
        variables.email = "";      
        variables.personid = "";     
        variables.password = "";    
    </cfscript>  
  <cfelse> 
    <cfscript>
      if(structKeyExists(rc, "userDetails")){      
          variables.email = rc.userDetails[1]["email"];     
          variables.personid = rc.userDetails[1]["personid"];
          variables.password = "********";
      }
      else{    
        variables.email = "";      
        variables.personid = "";     
        variables.password = "";
      }
    </cfscript>
  </cfif>
  </cfif>
<cfoutput> 
<div class="container">
<div class="wrapper">
  <div id="formContent">
  <!-- Tabs Titles -->
  <!-- Icon -->
  <div class="first">    
  </div>
  <!-- Login Form -->
  <form method = "post" id="formSubmit" name="formSubmit" >
    <div style="font-size: 20px !important;padding: 30px;color:##767272">
    Change Password
    </div>     
    <div style="padding-top:20px;">
    <label>Email</label>
    <input type="text" id="Email" class="form-control inputelement" name="Email" readonly value="#qrySelectPerson.email#" style="border: 1px solid ##C0C0C0;">
    </div>
    <div style="padding-top:20px;">   
     <input type="password" class="form-control inputelement" id="password" placeholder="Password" name="password" value="" autocomplete="off" required  minlength="8" maxlength="16">
          <a id="showPaasword">
            <i class="fa fa-2x fa-eye" aria-hidden="true"></i>
          </a>
          <!--- <span style="margin-top: 1%;font-size: 10px;margin-left:35px;float:left;"><i>Password should contain Uppercase letters, Lowercase letters,Numbers and Symbol</i></span>  --->
           <label id="labelPassword" style="display:none;">Password</label>    
          <span id="errorPasswordText" style="display:none;margin-left:45px;font-size:12px;" align="left"><image src="/ordertracker/images/errorimage.PNG">Enter a Password</span>
    </div>
    <div style="padding-top:20px;">  
          <input type="password" class="form-control inputelement" id="cpassword" placeholder="Confirm Password" name="cpassword" value="" autocomplete="off" required minlength="8" maxlength="16">
          <label id="labelcPassword" style="display:none;">Confirm Password</label>    
          <span id="errorcPasswordText" style="display:none;margin-left:45px;font-size:12px;" align="left"><image src="/ordertracker/images/errorimage.PNG">Enter a Confirm Password</span>
          <span id="errorMessage" style="display:none;margin-left:45px;font-size:12px;" align="left"><image src="/ordertracker/images/errorimage.PNG">Password and Confirm Password should be same.</span>
          <span id="errorPasswordMessage" style="display:none;margin-left:45px;font-size:12px;" align="left"><image src="/ordertracker/images/errorimage.PNG">Password should contain Uppercase letters, Lowercase letters,<br/>Numbers and Symbol </span>
    </div> 
    <div style="padding-top:20px;">
    <a href="../index.cfm" type="Cancel" class="btn btn-info" value="CANCEL" name="cancel" id="cancel" style="background-color:##Be2528;margin-bottom: 34px;">CANCEL</a> <input type="button" class="btn btn-success" value="Submit" name="save" id="save" style="background-color:##1a73e8;margin-left:10px;">         
     </div>
  </form>
  </div>
</div>
</div>
</cfoutput>

    
