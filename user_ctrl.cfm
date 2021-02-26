<cfif isDefined('form.Submit')>
	<cfset variables.salt = Hash(GenerateSecretKey("AES"), "SHA-512") /> 
	<cfset variables.hashedPassword = Hash(form.password & variables.salt, "SHA-512") />
	<cftry>
	<cfscript>
		NewUser = EntityNew("person");
	    NewUser.setfirstname("#form.firstname#");
	    NewUser.setlastname("#form.lastname#");
	    NewUser.setemail('#form.email#');
	    NewUser.setphone('#form.phone#');
	    NewUser.setcarrier('#form.carrier#');
	    NewUser.settype('#form.type#');
	    NewUser.setpassword('#variables.hashedPassword#');
	    NewUser.setsalt('#variables.salt#');
	    EntitySave(NewUser, true );
	    ThisUserID = NewUser.getid();
	    ThisUserPassword = NewUser.getpassword();
	</cfscript>
	<cfcatch>
		<cflocation url="error.cfm" >
	</cfcatch>
	</cftry>
	<cflocation url="user.cfm" >
</cfif>
