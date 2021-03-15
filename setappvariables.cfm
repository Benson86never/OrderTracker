<cfscript>
    application.dsn = "ordertracker";
    application.datasource = "ordertracker";
    application.ComPath = "com.";
    application.orderform = CreateObject("Component","com.orderform");
		application.carts_np=CreateObject("Component","com.carts_np");
		application.item_np=CreateObject("Component","#Application.ComPath#item_np");
		application.listsequence_np=CreateObject("Component","#Application.ComPath#listsequence_np");
    application.uEncryptKey = "password";
    application.publicpages = "admin.adduser,user.login"
		//application.adminobj =CreateObject("Component","v1/model/services.admin");
</cfscript>