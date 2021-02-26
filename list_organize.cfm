<cfinclude template="includes/secure.cfm" >

<cfscript>
	
	if (isDefined("url.ListID")) {
	Lists = EntityLoad( "list", { id=#url.ListID# }, "Orderby Asc" );
	}
	else {
	Lists = EntityLoad( "list", { subaccountid=#session.secure.subaccount# }, "Orderby Asc" );
	}
	ListsQuery = EntityToQuery(Lists, "item");
</cfscript>

<html>
<head>
	<cfif not isDefined("url.ListID")>
	<cfinclude template="includes/bootstrap_head.cfm" >
	</cfif>
  <meta charset='UTF-8'/>
  <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0' />
  <title>Ordertracker list order test</title>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<style>
		@media (orientation: portrait) {
  		/* For vertical viewports */
  		#sortable { list-style-type: none; margin: 5%; padding: 0; width: 90%; }
	  	#sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.0em; height: 30px; }
	  	#sortable li span { position: absolute; margin-left: -1.3em; }
		
		body {
		  background-color: #add8e6;
		}
		
		.button {
		  background-color: #4CAF50; /* Green */
		  border: none;
		  color: black;
		  padding: 15px 32px;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 1.2em;
		}
		.button:hover {
		  background-color: #308530; /* Green */
		} 
		.button:active {
		  background-color: #ff0000; /* Green */
		}
		}

		@media (orientation: landscape) {
 		 /* For horizontal viewports */
 		#sortable { list-style-type: none; margin: 5%; padding: 0; width: 90%; }
	  	#sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.3em; height: 25px; }
	  	#sortable li span { position: absolute; margin-left: -1.3em; }
		
		body {
		  background-color: #add8e6;
		}
		
		.button {
		  background-color: #4CAF50; /* Green */
		  border: none;
		  color: black;
		  padding: 15px 32px;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 1.5em;
		}
		.button:hover {
		  background-color: #308530; /* Green */
		}
		.button:active {
		  background-color: #ff0000; /* Green */
		}
		}
	  
	</style>
  <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src="https://www.86never.com/js/jquery.ui.touch-punch.min.js"></script>
	<script>
	function persist() {
		console.log('running persist....')
		var data = $("#sortable").sortable('toArray')
		console.dir(data)
		$.post('com/listsequence_np.cfc?method=saveData',{order:data},function(res,txtStatus) {
			console.log(txtStatus)
		})
	}
	
	$(document).ready(function(){
	    jQuery.ajaxSettings.traditional = true;
	    $("#sortable").sortable();
	    $("#saveBtn").click(persist)
	  });
	</script>
</head>
<body>
	<cfoutput>
		<cfif not isDefined("url.ListID")>
		<div class="container-fluid">
		<cfinclude template="includes/header.cfm" >
		<cfelse>
		<div>
		</cfif>
		<cfif isDefined("url.ListID")>
			<a href="#cgi.script_name#" class="button"> <-return to lists</a>
		</cfif>
		<cfloop array="#Lists#" index="list" >
		<cfif not isDefined("url.ListID")>
			<div><a href="#cgi.script_name#?ListID=#list.getID()#">#list.getName()#</a></div>
		</cfif>
		</cfloop>
		<cfif isDefined("url.ListID")>
			<ul id="sortable">
			<cfloop array="#Lists#" index="list" >
				<cfloop array="#list.getitem()#" index="item" >
					<cfset OrderBy = EntityLoad( "joinitemtolist", { itemid=#item.getid()#, listid=#url.listid# })>
			  <li class="ui-state-default" id="item_#Orderby[1].getid()#"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>#item.getname()#</li>
				</cfloop>
			</cfloop>
			</ul> 
			<input type="button" id="saveBtn" value="Save" class="button">
		</cfif>
	 </cfoutput>
	 </div>
	 <cfif not isDefined("url.ListID")>
	 <cfinclude template="includes/bootstrap_js.cfm" >
	 </cfif>
</body>
</html>