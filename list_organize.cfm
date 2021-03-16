<cfinclude template="includes/secure.cfm" >
<cfscript>
  if (isDefined("url.ListID")) {
    Lists = EntityLoad( "list", { id=#url.ListID# }, "Orderby Asc" );
  }
  else {
    Lists = EntityLoad( "list", { }, "Orderby Asc" );
  }
  ListsQuery = EntityToQuery(Lists, "item");
</cfscript>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
  .page-content{
    padding-left: 20px;
  }
  .list-item{
    padding: 10px;
  }
  @media (orientation: portrait) {
    /* For vertical viewports */
    #sortable { 
      list-style-type: none;
      padding: 1%;
      width: 90%;
    }
    #sortable li {font-size: 1.0em; height: 35px; margin: 10px;}
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
    #sortable { 
      list-style-type: none;
      padding: 1%;
      width: 90%;
    }
    #sortable li { font-size: 1.3em; height: 35px; margin: 10px;}

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
<cfoutput>
  <cfinclude template="includes/header.cfm" >
  <div class = "col-xs-12 sectionHeader">
    Organize List Items
  </div>
  <div class="page-content">
    <cfif isDefined("url.ListID")>
      <a href="#cgi.script_name#" class="btn btn-success"> <-return to lists</a>
    </cfif>
    <cfloop array="#Lists#" index="list" >
      <cfif not isDefined("url.ListID")>
        <div class="list-item"><a href="#cgi.script_name#?ListID=#list.getID()#">#list.getName()#</a></div>
      </cfif>
    </cfloop>
    <cfif isDefined("url.ListID")>
      <ul id="sortable">
        <cfloop array="#Lists#" index="list" >
          <cfloop array="#list.getitem()#" index="item" >
            <cfset OrderBy = EntityLoad( "joinitemtolist", { itemid=#item.getid()#, listid=#url.listid# })>
            <li class="ui-state-default" id="item_#Orderby[1].getid()#">
              <span class="ui-icon ui-icon-arrowthick-2-n-s"></span>
              <span>#item.getname()#</span>
            </li>
          </cfloop>
        </cfloop>
      </ul> 
      <input type="button" id="saveBtn" value="Save" class="btn btn-success">
    </cfif>
  </div>
</cfoutput>
<cfinclude template="includes/footer.cfm" >
<script>
  function persist() {
    console.log('running persist....')
    var data = $("#sortable").sortable('toArray')
    console.dir(data)
    $.post('com/listsequence_np.cfc?method=saveData',{order:data},function(res,txtStatus) {
      console.log(txtStatus);
      $('#modal-showAlert').modal('show');
      $('.modal-header').css('background-color','white');
      $('#headerText').html('Organize List Items');
      $('.close').css('color','black');
      $('#modal-showAlert .modal-body').html(txtStatus);
      $('#modal-showAlert .modal-footer .ok').show();
      $('#modal-showAlert .modal-footer .yes').hide();
      $('#modal-showAlert .modal-footer .no').hide();
    })
  }
  $(document).ready(function(){
    jQuery.ajaxSettings.traditional = true;
    $("#sortable").sortable();
    $("#saveBtn").click(persist)
  });
</script>