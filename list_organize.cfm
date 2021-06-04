<!---<cfinclude template="includes/header.cfm" >
<cfinclude template="includes/secure.cfm" >
<cfinclude template="inclludes/footer.cfm" >--->
<cfparam name="url.ListID" default="0">
<cfset ListItemobj = CreateObject("Component","v1.model.services.admin")>
    <cfset Lists=ListItemobj.getListDetails(
    ListID = url.ListID,
    businessId = url.businessid,
    includeItems = 1)>
  <cfset getItem = ListItemobj.getItemByBusiness(
    businessId = url.businessid)>
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
      display: block;
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
  .action-buttons {
    position: relative;
    top: 6px !important;
    right: 4px;
    float: right;
    text-align: center;
  }
  .action-buttons button {
    font-size: 10px !important;
    padding: 6px 8px !important;
  }
</style>
<cfoutput>
  <div class="container">
  <div class="row">
    <cfif arraylen(lists)>
      <cfloop array="#Lists#" index="list" >
        <div class="panel panel-default">
          <div class="panel-heading">#list.name# (#list.businessname#)</div>
          <div class="panel-body">
            
              <!--- <div class="list-item"><a href="#cgi.script_name#?ListID=#list.id#">#list.name#</a></div>--->
              <cfif arraylen(list.items)>
                <ul id="sortable" class="sortable">
                  <cfloop array="#list.items#" index="item" >
                    <li class="ui-state-default itemelement" id="item_#item.id#">
                      <span class="ui-icon ui-icon-arrowthick-2-n-s"></span>
                      <span >#item.name# (#item.supplierName#)</span>
                      <span class="action-buttons">
                        <button class="deleteListItem btn btn-danger" id="#item.id#" title="Delete" >
                          <i class="fa fa-trash-alt"></i>
                        </button>
                        <button class="btn btn-primary addListItem" id="#item.id#" title="Add" >
                          <i class="fa fa-plus"></i>
                        </button>
                      </span>
                    </li>
                  </cfloop>
                </ul>
              <cfelse>
                No items available.
              </cfif>
              <input type="hidden" name="itemid" id="itemid" value="0">
              <input type="hidden" name="itemname" id="itemname" value="">
              <input type="hidden" name="lisid" id="listid" value="#url.ListID#">
            </div>
          </div>
        </div>
      </cfloop>
      <div class="buttondiv pull-right">
        <input type="button" id="backBtn" value="Back to Lists" class="btn btn-danger" >
        <input type="button" id="saveBtn" value="Save" class="btn btn-success" >
      </div>
    <cfelse>
      <div class="panel panel-default">
        <div class="panel-heading">No lists available</div>
      </div>
    </cfif>
  </div>
  </div>
</cfoutput>
<script>
  $('#backBtn').click(function(){
    listid = $(this).attr('id');
    location.href = 'manageitem.cfm?page=lists&businessid=<cfoutput>#url.businessid#</cfoutput>';
  });
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
    $("#saveBtn").click(persist);
  });
  //delete a row 
  $(document).on("click", ".deleteListItem", function(){
    console.log($(this).attr('id'));
    $(this).parents("li").remove();
    $.ajax({
      url: 'v1/model/services/business.cfc?method=deleteListitem',
      type: 'get',
      data: {
            listId : $(this).attr('id')
          },
      success: function(data){
            console.log(data)
      }
    });
  });
  //add items to list
  $(document).ready(function(){
    var btnvalue;
    $('[data-toggle="tooltip"]').tooltip();
      var actions = '<button class="saveListnew btn btn-success" id="0" title="save" ><i class="fa fa-save"></i></button>'+
                   '<button class="cancelList btn btn-danger" id="0" title="cancel" style="margin-left: 8px !important;"><i class="fa fa-times"></i></button>' ;
  $(document).on("click", ".addListItem", function(){
     $(this).attr("disabled", "disabled");
     btnvalue=$(this).parents("li").index();
     console.log(btnvalue)
     var index = $(".sortable li").length;
     console.log($(this).attr('id'));
    /* var row = '<li><input type="text" class="form-control listdetails" name="listdetails" id="listdetails" style="width : 90% !important;"></li>' +
              '<li>' + actions + '</li>' ;*/
    var row = '<li>' + '<tr>' +
              '<td><input type="text" class="form-control listdetails" name="listdetails" id="listdetails"></td>' +
              '<td>' + actions + '</td>' +
              '</tr> '+ '</li>';
    $(".sortable").append(row);
    $(".sortable li .action-buttons").eq(index).find("cancelList, .saveListnew").toggle();
    <cfoutput>
      $('.listdetails').autocomplete({
      source: [
        <cfloop array="#getItem#" index="i" item="gitem">
          { label: "#gitem.iname#(#gitem.sname#)", value: "#gitem.iid#" }
          <cfif i NEQ arraylen(getItem)>,</cfif>
        </cfloop>
          ],
      select: function (event, ui) {
      // Set selection
      $('##listdetails').val(ui.item.label); // display the selected text
      $('##itemid').val(ui.item.value); // save selected id to input
      $('##itemname').val(ui.item.label);
      console.log($('##itemid').val())
      console.log($('##itemname').val())
      return false;
      }
      });
    </cfoutput>
  });  
  $(document).on("click", ".saveListnew", function(){
  console.log($('#itemid').val())
  console.log($('#listid').val())
  $.ajax({
    url: 'v1/model/services/order.cfc?method=addItemtoList',
    type: 'get',
    data: {
      listId : $('#listid').val(),
      itemId : $('#itemid').val()
    },
    returntype:'string',
    success: function(data){
      console.log(data)
      var newrow='<li class="ui-state-default itemelement ui-sortable-handle" id="item_#item.id#">' +
                      '<span class="ui-icon ui-icon-arrowthick-2-n-s"></span>' + '<span >' + $('#itemname').val() + '</span>' + 
                      '<span class="action-buttons">' +
                        '<button class="deleteListItem btn btn-danger" id="#item.id#" title="Delete" > <i class="fa fa-trash-alt"></i></button>'+
                        '<button class="btn btn-primary addListItem" id="#item.id#" style="margin-left: 5px !important;" title="Add" ><i class="fa fa-plus"></i></button>'+
                      '</span>' + '</li>';
      //var btnvalue=$(this).parents("li").index();
      console.log(btnvalue)
      $(".sortable li").eq(btnvalue).after(newrow);
      //$(this).parent("li").html($(this).val());
      //add li next to element for which the plus button is clicked
      //sortable.each(function()) call savelistitems
      //location.href = 'manageitem.cfm?page=listorganize&businessid=<cfoutput>#variables.businessid#</cfoutput>&ListID=<cfoutput>#url.ListID#</cfoutput>'   
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
    $(".listdetails").remove();
    $(".cancelList, .saveListnew").remove();
    $(".addListItem").removeAttr("disabled");
    }
  });
  });
  $(document).on("click", ".cancelList", function(){		
    $(this).parents("li").remove();
    $(".addListItem").removeAttr("disabled");
  });
});
</script>