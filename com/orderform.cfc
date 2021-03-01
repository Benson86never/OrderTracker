<cfcomponent>
	
	<cffunction name="getform" output="false">
		<cfset myarray=arraynew(2)>
		<cfset y = 1> 
		<cfloop index="x" list="#Form.FieldNames#" delimiters=",">
			<cfset formlist = #x#>
			<cfdump var="#formlist#">
		    <cfif x contains "ITEM">
		    <cfscript>
		    	LoopItemID = #ListGetAt(x,2,";")#;
		    	LoopSupplierID = #ListGetAt(x,3,";")#;
		    	Items = EntityLoad("item", { id=#LoopItemID# } );
		    	LoopQuantity = Form[x];
		    	n=arraylen(Items);
		    	for (i=1;i<=n;i++){
	        	LoopItemName = Items[i].getname();
	        	LoopItemID = Items[i].getid();
	   				 }
		    </cfscript>
		    <cfset myarray[y][1]=LoopItemName>
			<cfset myarray[y][2]=LoopItemID>
			<cfset myarray[y][3]=LoopQuantity>
			<cfset myarray[y][4]=LoopSupplierID>
			<cfset y = y + 1>
		    <cfoutput>#LoopItemName# #LoopItemID# #LoopQuantity#</cfoutput>
		    </cfif>
		</cfloop>
	
	<cfreturn myarray> 
	</cffunction> 

</cfcomponent>