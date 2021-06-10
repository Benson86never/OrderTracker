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
    businessId = url.businessid,
    listId = url.ListID)>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
  .page-content{
    padding-left: 20px;
  }
  .list-item{
    padding: 10px;
  }
  input[type="text"]{
    width: 600% !important;
    height: 35px !important;
    margin-left: 10px !important;
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
                        <button class="btn btn-primary addListItem" id="#item.id#" title="Add" addvalue="item_#item.id#">
                          <i class="fa fa-plus"></i>
                        </button>
                      </span>
                    </li>
                  </cfloop>
                </ul>
              <cfelse>
                  No items available.
              </cfif>
              <input type="hidden" name="itemid" id="itemid" class="itemid_class">
              <input type="hidden" name="itemname" id="itemname" value="">
              <input type="hidden" name="previtemval" id="previtemval" value="">
              <input type="hidden" name="lisid" id="listid" value="#url.ListID#">
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
            //console.log(data)
      }
    });
  });
  //add items to list
  $(document).ready(function(){
    var btnvalue,previousitem,itemarrayval;
    $('[data-toggle="tooltip"]').tooltip();
    var actions = '<button class="saveListnew btn btn-success" title="save" ><i class="fa fa-save"></i></button>'+
                  '<button class="cancelListItem btn btn-danger" itemidval="0" title="cancel" style="margin-left: 8px !important;"><i class="fa fa-times"></i></button>' ;
    $(document).on("click", ".addListItem", function(){
    $(this).attr("disabled", "disabled");
    btnvalue = $(this).attr('addvalue');
    console.log(btnvalue)
    var index = $(".sortable li").length;
    console.log(index)
    console.log($(this).attr('id'));
    var row = '<tr>' + 
            '<td><input type="text" class="listdetails" name="listdetails" id="listdetails_'+btnvalue+'" addvalue1="'+btnvalue+'"></td>' +
            '<td class="action-buttons" style="padding-left:810px !important;">' + actions + '</td>' +
            '</tr>';
    $("#"+btnvalue).after(row);
    $(".sortable li .action-buttons").eq(index).find("cancelListItem, .saveListnew").toggle();
    <cfoutput>
    previousitem = $('##itemid').val();
    itemarrayval = previousitem.split(',');
    var sourcearray = [];
    <cfloop array="#getItem#" index="i" item="gitem">
      if(itemarrayval.indexOf('#gitem.iid#') == -1) {
        sourcearray.push({ label: "#gitem.iname#(#gitem.sname#)", value: "#gitem.iid#" });
      }
    </cfloop>
      $('.listdetails').autocomplete({
        source: sourcearray,
        select: function (event, ui) {
          // Set selection
          elem=event.target.id;
           itemval = $('##itemid').val();
          $('##'+elem).val(ui.item.label); // display the selected text
          if(itemval == ""){
            $('##itemid').val(ui.item.value); // save selected id to input
            $('##itemname').val(ui.item.label);
            itemvalnew = $(this).attr('addvalue1') +'_'+ ui.item.value;
            $('##previtemval').val(itemvalnew);
          } else{
            newvalue = itemval + ',' + ui.item.value;
            $('##itemid').val(newvalue);
            itemtextidval = $('##previtemval').val();
            newitemid = $(this).attr('addvalue1') + '_' + ui.item.value;
            itemidmultiple = itemtextidval +','+ newitemid;
            $('##previtemval').val(itemidmultiple);
          }
          $('##'+elem).parents('.cancelListItem').attr('itemidval', ui.item.value);
          console.log($('##'+elem).parents('.cancelListItem').attr('itemidval', ui.item.value));
          console.log($(this).attr('addvalue1'),ui);
          return false;
        }
      });
    </cfoutput>
  });  
  $(document).on("click", ".saveListnew", function(){
  //console.log($('#itemid').val())
  var itemvalue = $('#itemid').val();
  var listvalue = $('#listid').val();
  var previtemids = $('#previtemval').val();
  var arr = previtemids.split(",");
  var curelem;
  console.log(arr);
  $.ajax({
    url: 'v1/model/services/order.cfc?method=addItemtoList',
    type: 'get',
    data: {
      listId : listvalue,
      itemId : itemvalue
    },
    success: function(data){
      console.log(data)
      var json_obj = $.parseJSON(data);
      for(var i=0;i<json_obj.length;i++) {
        var newrow='<li class="ui-state-default itemelement ui-sortable-handle" id="item_'+ json_obj[i].id +'">' +
                    '<span class="ui-icon ui-icon-arrowthick-2-n-s"></span>' + '<span >' + json_obj[i].name+ '</span>' + 
                    '<span class="action-buttons">' +
                      '<button class="deleteListItem btn btn-danger" id="'+ json_obj[i].id +'" title="Delete" > <i class="fa fa-trash-alt"></i></button>'+
                      '<button class="btn btn-primary addListItem" id="'+ json_obj[i].id +'" style="margin-left: 5px !important;" title="Add" addvalue="item_'+ json_obj[i].id +'"><i class="fa fa-plus"></i></button>'+
                    '</span>' + 
                  '</li>';
        var itemidval = json_obj[i].itemid;
        for(let j=0; j<arr.length; ++j){
          console.log(arr[j]);
          var item = arr[j];
          var idarrayval = item.split("_");
          if(idarrayval[2] == itemidval){
              curelem = $('#item_'+idarrayval[1]);
              console.log(curelem);
          }
        }
        $(curelem).after(newrow);
        //$("#"+btnvalue).after(newrow);
        $(".sortable").each(function(){
          var data = $(this).sortable('toArray');
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
    $("tr").remove();
    //$(".cancelList, .saveListnew").remove();
    $(".addListItem").removeAttr("disabled");
    }
  });
  });
  $(document).on("click", ".cancelListItem", function(){		
    $(this).parents("tr").remove();
    $(".addListItem").removeAttr("disabled");
      var itemid = $(this).attr('itemidval');
      console.log(itemid)
      itemidlist = $('#itemid').val();
      itemidlist.replace(itemid,'');
      itemidlist.replace(',,',',');
      console.log(itemidlist);
  });
});
</script>