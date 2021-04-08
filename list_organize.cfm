<cfparam name="url.ListID" default="0">
<cfset Lists = CreateObject("Component","v1.model.services.admin").getListDetails(
    ListID = url.ListID,
    businessId = session.secure.subaccount,
    includeItems = 1)>
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
    .panel-default > .panel-heading {
  text-align: center;
  font-size: 24px;
}
}
.buttondiv{
  margin-bottom: 20px;
}
.itemelement span {
  position: relative;
  top: 8px;
}
</style>
<cfoutput>
  <div class="container">
    <cfloop array="#Lists#" index="list" >
      <div class="panel panel-default">
        <div class="panel-heading">#list.name#</div>
        <div class="panel-body">
          <div class="page-content">
            <!--- <div class="list-item"><a href="#cgi.script_name#?ListID=#list.id#">#list.name#</a></div>--->
            <cfif arraylen(list.items)>
              <ul id="sortable" class="sortable">
                <cfloop array="#list.items#" index="item" >
                  <li class="ui-state-default itemelement" id="item_#item.id#">
                    <span class="ui-icon ui-icon-arrowthick-2-n-s"></span>
                    <span >#item.name#</span>
                  </li>
                </cfloop>
              </ul>
            <cfelse>
              No items available.
            </cfif>
          </div>
        </div>
      </div>
    </cfloop>
    <div class="buttondiv pull-right">
      <input type="button" id="saveBtn" value="Save" class="btn btn-success" >
    </div>
  </div>
</cfoutput>
<script>
  function persist() {
    console.log('running persist....');
    $(".sortable").each(function(){
      var data = $(this).sortable('toArray');
      console.log(data)
      $.post('v1/model/services/business.cfc?method=saveListItems',{listItems:data},function(res,txtStatus) {
        console.log(txtStatus);
        $('#modal-showAlert').modal('show');
        $('.modal-header').css('background-color','white');
        $('#headerText').html('Organize List Items');
        $('.close').css('color','black');
        $('#modal-showAlert .modal-body').html(txtStatus);
        $('#modal-showAlert .modal-footer .ok').show();
        $('#modal-showAlert .modal-footer .yes').hide();
        $('#modal-showAlert .modal-footer .no').hide();
      });
    });
  }
  $(document).ready(function(){
    jQuery.ajaxSettings.traditional = true;
    $(".sortable").sortable();
    $("#saveBtn").click(persist)
  });
</script>