<style>
  input, select{
    font-size: 12px !important;
  }
  .table-wrapper {
      background: #fff;
      padding: 20px;	
      box-shadow: 0 1px 1px rgba(0,0,0,.05);
      font-size: 12px !important;
  }
  .table-title {
    margin: 0 0 10px;
  }
  .table-title h2 {
      margin: 6px 0 0;
      font-size: 22px;
  }
  .table-title .add-new {
      float: right;
      height: 30px;
      font-weight: bold;
      font-size: 12px;
      text-shadow: none;
      min-width: 100px;
      border-radius: 4px;
      line-height: 13px;
  }
  .table-title .add-new i {
      margin-right: 4px;
  }
  table.table {
      table-layout: fixed;
  }
  table.table tr th, table.table tr td {
      border-color: #e9e9e9;
          overflow: hidden;
      text-overflow: ellipsis;
  }
  table.table th i {
      cursor: pointer;
  }
  table.table th:last-child {
      width: 100px;
  }
  table.table .form-control {
      height: 32px;
      line-height: 32px;
      box-shadow: none;
      border-radius: 2px;
  }
  table.table .form-control.error {
      border-color: #f50000;
  }
  .cancel, .add {
    display: none;
  }
  .list-wrapper {
    font-size: 12px;
  }

  .list-item {
    border: 1px solid #EEE;
    background: #FFF;
    margin-bottom: 10px;
    padding: 10px;
    box-shadow: 0px 0px 10px 0px #EEE;
  }

  .list-item h4 {
    color: #FF7182;
    font-size: 18px;
    margin: 0 0 5px;	
  }

  .list-item p {
    margin: 0;
  }

  .simple-pagination ul {
    margin: 0 0 20px;
    padding: 0;
    list-style: none;
    text-align: center;
  }

  .simple-pagination li {
    display: inline-block;
    margin-right: 5px;
  }

  .simple-pagination li a,
  .simple-pagination li span {
    color: #666;
    padding: 5px 10px;
    text-decoration: none;
    border: 1px solid #EEE;
    background-color: #FFF;
    box-shadow: 0px 0px 10px 0px #EEE;
  }

  .simple-pagination .current {
    color: #FFF;
    background-color: #FF7182;
    border-color: #FF7182;
  }

  .simple-pagination .prev.current,
  .simple-pagination .next.current {
    background: #e04e60;
  }

  .uploadfile
  {
    border:0;
  }
  #pagination-container{
    margin-bottom: 20px;
  }
  #submit3 {
          width:130px;
          display:inline-flex;
  }
  .padding0 {
    padding: 0px !important;
  }
  ul, li {
      list-style: none;
  }

  #wrapper {
      width: 900px;
      margin: 20px auto;
  }
  .data-container {
      margin-top: 20px;
  }

  .data-container ul {
      padding: 0;
      margin: 0;
  }

  .data-container li {
      margin-bottom: 5px;
      padding: 5px 10px;
      background: #eee;
      color: #666;
  }
  .paginationjs {
    position: relative;
    left: 110px;
    top: -32px;
  }
  @media (max-width: 767px) {
    #business {
      width: 30%;
    }
    .fsize {
      font-size: 12px !important;
    }
    #search {
      width: 50px !important;
      margin-left: -90px !important;
      padding: 0px !important;
    }
    .table-wrapper {
        padding: 0px !important;
    }
    .f1 {
      width: 50px !important;
      margin-left: -70px !important;

    }
    .t1 {
      margin-left: 0px !important;
      width: 10px !important;
    }
    .add-new {
      width: 10px !important;
    }
  }
</style>
<cfinclude template="includes/secure.cfm" >
<cfinclude template="includes/header.cfm" >
<cfparam  name="url.businessid" default="#session.secure.subaccount#">
<cfset businessid = url.businessid>
<cfif isdefined("url.err") and url.err eq 1>
  <div class="modal fade modal-warning" id="modal-showAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index: 9000;">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header alert alert-warning">
          <span id="headerText"></span>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">Upload Items</h4>
        </div>
        <div class="modal-body">Please Select Supplier and Upload only XLS,XLSX file types.</div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default ok" data-dismiss="modal"><cfoutput>OK</cfoutput></button>
        </div>
      </div>
    </div>
  </div>
</cfif>
<cfoutput>
  <cfparam name="url.supplierid" default="0">
  <cfparam name="url.noitems" default="10">
  <cfif listfind(session.secure.businessType, 2)
    AND session.secure.RoleCode NEQ 1>
    <cfset supplierid = session.secure.SubAccount>
  <cfelse>
    <cfset supplierId = isnumeric(url.supplierid)
      ? url.supplierid
      : 0>
  </cfif>
  <cfset items = CreateObject("Component","v1.model.services.admin").getItems(supplierId = supplierId,businessId = businessid).items>
  <cfset units = CreateObject("Component","v1.model.services.admin").getUnitDetails()>
  <cfset suppliers = CreateObject("Component","v1.model.services.admin").getSupplierDetails(businessId = session.secure.subaccount)>
  <div class="container">
    <div class="table-wrapper">
      <div class="table-title">
        <div class="row">
          <div class="col-xs-1"><h4 class="fsize">Item Details</h4></div>
          <cfif session.secure.RoleCode EQ 1>
            <div class="col-xs-4">
              <cfform id="addItem" action="add_item_action.cfm" method="post" enctype="multipart/form-data">
                <cfif session.secure.RoleCode eq 1>
                  <cfset local.accounts = CreateObject("Component","v1.model.services.admin").getSupplierDetails()>
                  <div style="padding-bottom:0px;" >
                    Supplier:&nbsp;
                    <select name="business" id="business" onchange="chgBusiness(this.value)" class="form-select form-select-lg mb-3" style="width:50%;height:30px;">
                      <option value="0">Select</option>
                      <cfloop array="#local.accounts#" item="account">
                        <option
                          <cfif isdefined("url.supplierid") and url.supplierid eq account.id>
                            selected
                          </cfif>
                          value="#account.id#">
                          #account.name#
                        </option>
                      </cfloop>
                    </select>
                  </div>
                </cfif>
              </cfform>
            </div>
          </cfif>
          <cfif ListFind(session.secure.access,'18')>
            <div class="col-xs-6 padding0">
              <div class="col-xs-2 pull-right t1">
                <button type="button" class="btn btn-info add-new">
                  <i class="fa fa-plus"></i>
                  <span class="hidden-xs">Add New</span>
                </button>
              </div>
              <div class="col-xs-4 pull-right" >
                <input type="search" id="search" name="search" class="form-control" onkeyup="searchTable();" placeholder="Search"/> 
              </div>
              <div class="col-xs-4">
                          <cfif session.secure.RoleCode eq 1>
                            <cfscript>
                              local.accountinfo = [];
                              local.accountDetails = queryExecute("
                              SELECT
                                B.businessId as businessId,
                                B.businessname as name
                              FROM
                                business B
                                INNER JOIN joinbusinesstotype JBT ON JBT.businessId = B.businessId AND JBT.typeId = 1
                              WHERE
                                B.Active = 1
                              ",{},{datasource: application.dsn}
                              );
                              cfloop(query = "local.accountDetails") {
                                local.details = {};
                                local.details['id'] = local.accountDetails.businessId;
                                local.details['name'] = local.accountDetails.name;
                                arrayAppend(local.accountinfo, local.details);
                              }
                            </cfscript>
                            Business: &nbsp;
                            <select name="business" onchange=getBusiness(this.value) class="form-select form-select-lg mb-3" style="width:65%;height:30px;">
                            <option value="0" id="allitemdropdown">All</option>
                            <cfloop array="#local.accountinfo#" item="account">
                                <option
                                  <cfif isdefined("url.businessid") and url.businessid eq account.id>
                                    selected
                                  </cfif>
                                  value="<cfoutput>#account.id#</cfoutput>">
                                  <cfoutput>#account.name#</cfoutput>
                                  <cfset session.secure.bid="#account.id#">
                                </option>
                              </cfloop>
                            </select>
                          </cfif>
              </div>
            </div>
          </cfif>
        </div>
        <div class="row">
          <cfif ListFind(session.secure.access,'20')>
            <div class="col-xs-5">
              <input type="file" name="uploadfile" required="yes" message="You must select a file." class="form-control f1" style="width:130px;display:inline-flex;">
              <input type="submit" name="Submit2" value="Upload" class="btn btn-info " style="width:60px;">
              <input type="hidden" name="hdnbusiness" id="hdnbusiness" value="#url.supplierid#">
              <input type="button" id="Submit3" name="Submit3" class="btn btn-info" value="Download Item List" onclick="downloadlist();">
              <a href="DownloadTemplate.cfm"  class="btn btn-info">Download Template</a>
            </div>
          </cfif>
          <div style="display:none;" id="disphid" class="col-xs-6 padding0">
            <cfscript> 
              local.accounts = [];
              local.accountDetails = queryExecute("
                SELECT
                  L.ListID,
                  L.Name,
                  B.BusinessName,
                  B.BusinessId
                FROM
                  LIST L
                  INNER JOIN business B ON B.BusinessId =  L.SubAccountID
                  Where B.BusinessId = #businessid#;
              ",{},{datasource: application.dsn}
              );
              cfloop(query = "local.accountDetails") {
                local.details = {};
                local.details['id'] = local.accountDetails.ListID;
                local.details['name'] = local.accountDetails.Name;
                local.details['businessname'] = local.accountDetails.BusinessName;
                local.details['businessid'] = local.accountDetails.BusinessId;
                arrayAppend(local.accounts, local.details);
              }
            </cfscript>
            <div class="col-xs-1 text-right">
              <h6>List:</h6>
            </div>
            <div class="col-xs-4">
              <select name="list" id="list" class="form-select-sm form-control">
                <cfloop array="#local.accounts#" item="account">
                  <option value="#account.id#">
                    #account.name#(#account.businessname#)
                  </option>
                </cfloop>
              </select>
            </div>
            <div class="col-xs-1">
                <input type="button" class="btn btn-info additem" value="Add To List" name="additem">
            </div>
          </div>
        </div>
        <div class="row">
          &nbsp;
        </div>
        <form action="" method="post">
          <div class="data-container">
            <table class="list-wrapper itemtable table table-bordered table-responsive-sm table-striped" cellspacing="0" cellpadding="0" id="searchTab">
              <thead>
                <tr>
                <th width="5%">
                    <input type="checkbox" 
                    id="id" 
                    name="itemcheck" 
                    class="item_header">
                    <i class="fa fa-info-circle" aria-hidden="true" style="color:dodgerblue;padding:1px;font-size:16px;" data-toggle="tooltip" data-original-title="Check the items to add to list"></i>
                </th>
                <th width="35%" style="text-align:center;">Name</th>
                <th width="10%" style="text-align:center;">SKU</th>
                <th width="10%" style="text-align:center;">Photo URL</th>
                <th width="10%" style="text-align:center;">Units</th>
                <th width="20%" style="text-align:center;">Supplier</th>
                <cfif session.secure.RoleCode EQ 1>
                  <th width="10%" style="text-align:center;">Actions</th>
                </cfif>
                </tr>
              </thead>
              <tbody>
                <cfloop array="#items#" item="item" index="arrindex">
                <tr class="list-item items itemrow#arrindex#" data-filter-item data-filter-name="#lcase(item.name)# #lcase(item.supplierName)#">
                  <td type="checkbox"><input type="checkbox"
                      id="id_#item.id#"
                      name="itemselect"
                      value="#item.id#"
                      class="checkitems">
                  </td>
                  <td fid="name">#item.name#</td>
                  <td fid="sku">#item.sku#</td>
                  <td fid="photourl" title="#item.photoUrl#">#item.photoUrl#</td>
                  <td fid="units" type="unit">#item.unitName#</td>
                  <td fid="supplier" type="supplier">#item.supplierName#</td>
                  <cfif session.secure.RoleCode EQ 1>
                    <td>
                      <button class="cancel btn btn-danger" title="cancel" style="display:none;">
                        <i class="fa fa-times" aria-hidden="true"></i>
                      </button>
                      <cfif ListFind(session.secure.access,'19')>
                        <button type="button" class="deleteitem btn btn-danger"  action = "delete" id="#item.id#" title="Delete">
                          <i class="fa fa-trash-alt" aria-hidden="true"></i>
                        </button>
                      </cfif>
                      <button class="add btn btn-success"  id="#item.id#" action = "add"  title="Add" style="display:none;">
                        <i class="fa fa-plus" aria-hidden="true"></i>
                      </button>
                      <cfif ListFind(session.secure.access,'2')>
                        <button class="edit btn btn-warning" title="Edit">
                          <i class="fas fa-pencil-alt"></i>
                        </button>
                      </cfif>
                      <button class="additemval save btn btn-success" action = "update" id="#item.id#" title="save" style="display:none;">
                        <i class="fa fa-save" aria-hidden="true"></i>
                      </button>
                    </td>
                  </cfif>
                </tr>
                </cfloop>
              </tbody>
            </table>
          </div>
          <div id="pagination-demo1">
            <select name="noofitems" id="noofitems" class="form-select-sm form-control" style="width:100px;">
              <cfloop from=10 to="#arrayLen(items)#" index="i" step="10">
                <option value="#i#"
                  <cfif url.noitems EQ i>selected</cfif>
                >#i#</option>
              </cfloop>
            </select>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="modal fade modal-warning" id="modal-showAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index: 9000;">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <span id="headerText"></span>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel"></h4>
        </div>
        <div class="modal-body"></div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default ok" data-dismiss="modal"><cfoutput>OK</cfoutput></button>
          <button type="button" class="btn btn-default no" data-dismiss="modal"><cfoutput>Cancel</cfoutput></button>
          <button type="button" class="btn btn-success yes" data-dismiss="modal"><cfoutput>Yes</cfoutput></button>
        </div>
      </div>
    </div>
  </div>
</cfoutput>
<cfinclude template="includes/footer.cfm" >
<script type="text/javascript" src="js/pagination.js"></script>
<link href = "js/pagination.css" rel = "stylesheet">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>
  $(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
    console.log(<cfoutput>#businessid#</cfoutput>)
    <cfif isdefined("url.err") and url.err eq 1>
      $('#modal-showAlert .modal-header').addClass('alert-danger');
      $('#modal-showAlert').modal('show');
    </cfif>
   // $('[data-toggle="tooltip"]').tooltip();
   var itemactions = '<button action = "delete" class="removeRow btn btn-danger" id="0" title="Delete" ><i class="fa fa-trash-alt"></i></button>'+
                     '<button action = "add" class="additemval btn btn-success" id="0" title="Add" style="margin-left: 8px !important;"><i class="fa fa-plus"></i></button>';
    var unithtml = "";
    var supplierhtml = "";
    <cfoutput>
      <cfloop array="#units#" index="unit">
        unithtml = unithtml + '<option value="#unit.id#">#unit.name#</option>';
      </cfloop>
      <cfif listfind(session.secure.businessType,'1') >
          <cfloop array="#suppliers#" index="supplier">
            supplierhtml = supplierhtml + '<option value="#supplier.id#" <cfif supplier.id EQ #supplierid#> selected</cfif>>#supplier.name#</option>';
          </cfloop>
      <cfelse>
          supplierhtml = supplierhtml + '<option value="#session.secure.SubAccount#">#session.secure.SubAccountName#</option>';
      </cfif>
    </cfoutput>
    // Append table with add row form on add new button click
    $(".add-new").click(function(){
      $(this).attr("disabled", "disabled");
      var index = $(".itemtable tbody tr:last-child").index();
      var row = '<tr>' +
        '<td></td>' +
        '<td><input type="text" class="form-control" name="name" id="name"></td>' +
        '<td><input type="text" class="form-control" name="sku" id="sku"></td>' +
        '<td><input type="text" class="form-control" name="photourl" id="photourl"></td>' +
        '<td><select class="form-control" name="units" id="units">'+unithtml+'</select></td>' +
        '<td><select class="form-control" name="supplier" id="supplier">'+supplierhtml+'</select></td>' +
        '<td>' + itemactions + '</td>' +
        '</tr>';
        $(".itemtable").append(row);
        $(".itemtable tbody tr").eq(index + 1).find(".add, .edit").toggle();
        $(".itemtable tbody tr").eq(index + 1).find(".save, .cancel").toggle();
        $(".itemtable tbody tr").eq(index + 1).find(".cancel").addClass('removeRow');
         // $('[data-toggle="tooltip"]').tooltip();
    });
    $(document).on("click", ".removeRow", function(){
      $(this).parents("tr").remove();
      $(".add-new").removeAttr("disabled");
    });
    // Add row on add button click
    $(document).on("click", ".additemval", function(){
      var empty = false;
      var input = $(this).parents("tr").find('input[type="text"]');
      var select = $(this).parents("tr").find('select');
      input.each(function(){
        if(!$(this).val() && $(this).attr('id') != 'photourl'){
          $(this).addClass("error");
          empty = true;
        } else{
                  $(this).removeClass("error");
              }
      });
      $(this).parents("tr").find(".error").first().focus();
      if(!empty){
        itemdetails = {
          name : $(this).parents("tr").find('#name').val(),
          sku : $(this).parents("tr").find('#sku').val(),
          photourl : $(this).parents("tr").find('#photourl').val(),
          unitid : $(this).parents("tr").find('#units').val(),
          supplierid : $(this).parents("tr").find('#supplier').val(),
          itemid : $(this).attr('id')
        };
        $(this).parents("tr").find(".save, .edit, .deleteitem, .cancel").toggle();
           caction = $(this).attr('action');
        $.ajax({
          url: 'v1/model/services/admin.cfc?method=manageItem',
          type: 'post',
          data: {
            itemDetails : JSON.stringify(itemdetails),
            action : $(this).attr('action')
          },
          success: function(data){
            input.each(function(){
              $(this).parent("td").html($(this).val());
            });
            select.each(function(){
              $(this).parent("td").html($(this).find('option:selected').text());
            });
            $(".add-new").removeAttr("disabled");
            if(caction == 'add') {
              location.href = "";
            } else {
              location.href = window.location.href;
            }
          }
        });
      }
    });
    // Edit row on edit button click
    $(document).on("click", ".edit", function(){
      $(this).parents("tr").find("td:not(:last-child)").each(function(){
        currentValue = $(this).text();
        id = $(this).attr('fid');
        if($(this).attr('type') == 'checkbox') {
        } else if($(this).attr('type') == 'unit') {
          $(this).html('<select class="form-control" id="'+id+'">'+ unithtml +'</select>');
          $("#units option").filter(function() {
              return this.text == currentValue; 
          }).attr('selected', true);
        } else if($(this).attr('type') == 'supplier') {
          $(this).html('<select class="form-control" id="'+id+'">'+ supplierhtml +'</select>');
          $("#supplier option").filter(function() {
              return this.text == currentValue; 
          }).attr('selected', true);
        } else {
          $(this).html('<input type="text" class="form-control" id="'+id+'" value="' + $(this).text() + '">');
        }
      });		
      $(this).parents("tr").find(".save, .edit, .deleteitem, .cancel").toggle();
      $(".add-new").attr("disabled", "disabled");
      return false;
    });
    $(document).on("click", ".cancel", function(){
      $(this).parents("tr").find("td:not(:last-child)").each(function(){
        if($(this).attr('type') == 'checkbox') {
        } else {
          currentValue = $(this).find('input').val();
          if(currentValue == undefined) {
            currentValue = $(this).find('select').find('option:selected').text();
          }
          $(this).html(currentValue);
        }
      });		
      $(this).parents("tr").find(".save, .edit, .deleteitem, .cancel").toggle();
      return false;
    });
    $(document).on("click", ".deleteitem", function(){
      eid = $(this).attr('id');
      action = $(this).attr('action');
      parenttr = $(this).closest("tr");
      $('#modal-showAlert').modal('show');
      $('.modal-header').css('background-color','white');
      $('#headerText').html('Delete Item');
      $('.close').css('color','black');
      $('#modal-showAlert .modal-body').html("Are you sure, you want to delete this item?");
      $('#modal-showAlert .modal-footer .ok').hide();
      $('#modal-showAlert .modal-footer .yes').show();
      $('#modal-showAlert .modal-footer .no').show();
      $('#modal-showAlert .modal-footer .yes').click(function(){
        itemdetails = {itemid : eid}
        console.log(itemdetails)
        $.ajax({
          url: 'v1/model/services/admin.cfc?method=manageItem',
          type: 'get',
          data: {
            itemDetails : JSON.stringify(itemdetails),
            action : action
          },
          success: function(data){
            parenttr.remove();
          }
        });
      });
    });
  });
  

  var items = $(".list-wrapper .list-item");
  var numItems = items.length;
  var perPage = 10;
  var noitems = "<cfoutput>#url.noitems#</cfoutput>";
  var showFrom,showTo;
  console.log(perPage)
  items.slice(perPage).hide();
  (function(name) {
    var container = $('#pagination-' + name);
    var sources = function () {
      var result = [];

      for (var i = 1; i < numItems; i++) {
        result.push(i);
      }

      return result;
    }();

    var options = {
      dataSource: sources,
      pageSize: noitems,
      callback: function (response, pagination) {
        window.console && console.log(response, pagination);
        $('.list-item').hide();
        $.each(response, function (index, item) {
          $('.itemrow'+item).show();
        });
      }
    };

    //$.pagination(container, options);

    container.addHook('beforeInit', function () {
      //window.console && console.log('beforeInit...');
    });
    container.pagination(options);

    container.addHook('beforePageOnClick', function () {
      //window.console && console.log('beforePageOnClick...');
      //return false
    });
  })('demo1');
  $('#noofitems').change(function(){
    items = $(this).val();
    location.href = "item.cfm?noitems="+items;
  });
  $(".item_header").click(function(){
    if($(this).is(':checked')) {
      var bid = "<cfoutput>#businessid#</cfoutput>";
      if(bid > 0){
        $('.checkitems:visible').prop('checked', true);
        $("#disphid").show();
        } else {
            $('#modal-showAlert').modal('show');
            $('.modal-header').css('background-color','white');
            $('#headerText').html('Business Alert');
            $('.close').css('color','black');
            $('#modal-showAlert .modal-body').html("Please select Business before adding item to list");
            $('#modal-showAlert .modal-footer .ok').show();
            $('#modal-showAlert .modal-footer .yes').hide();
            $('#modal-showAlert .modal-footer .no').hide();
            $('#modal-showAlert .modal-footer .ok').click(function(){
              $('.item_header').prop('checked', false);
            });
          }
    }else {
      $('.checkitems').prop('checked', false);
      $("#disphid").hide();
    }
  });  
  $(".checkitems").click(function(){
    if($(".checkitems:checked").length > 0) {
     var bid = "<cfoutput>#businessid#</cfoutput>";
      if(bid > 0){
        $("#disphid").show();
      } else {
          $('#modal-showAlert').modal('show');
          $('.modal-header').css('background-color','white');
          $('#headerText').html('Business Alert');
          $('.close').css('color','black');
          $('#modal-showAlert .modal-body').html("Please select Business before adding item to list");
          $('#modal-showAlert .modal-footer .ok').show();
          $('#modal-showAlert .modal-footer .yes').hide();
          $('#modal-showAlert .modal-footer .no').hide();
          $('#modal-showAlert .modal-footer .ok').click(function(){
              $('.checkitems').prop('checked', false);
            });
        }
      } else {
      $("#disphid").hide();
      }
  });
  $(".additem").click(function(){
    var itemIds = "";
    $(".checkitems:checked").each(function(){
      if(itemIds == "") {
        itemIds = $(this).val();
      } else {
        itemIds = itemIds + ',' + $(this).val();
      }
    });
    var listval = $('#list').val();
    $.ajax({
      url: 'v1/model/services/order.cfc?method=addItemtoList',
      type: 'get',
      data: {
        listId : listval,
        itemId : itemIds
      },
      success: function(data){
        location.href = 'item.cfm';
      }
    });
  });
  function searchTable() {
    // Declare variables
    var input, filter, tab, tr, a, i, txtValue;
    input = document.getElementById('search');
    filter = input.value.toUpperCase();
    tab = document.getElementById("searchTab");
    tr = $('.list-item');
    
    // Loop through all list items, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
      a = tr[i];
      txtValue = a.textContent || a.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
      if(filter == "")
      {
      window.location.reload();    
      } else {
        var items = $(".list-wrapper .list-item:visible");     
        var numItems = items.length;
        var perPage = 10;
        items.slice(perPage).hide();
      }
    }  
  }
  function chgBusiness(businessid)
  {
    document.getElementById('hdnbusiness').value = businessid;
    location.href = 'item.cfm?supplierid=' + businessid;
  }

	function downloadlist() { 
    if(document.getElementById('business').value == 0)
    {
      $('#modal-showAlert').modal('show');
      $('.modal-header').css('background-color','white');
      $('#headerText').html('Download Item');
      $('.close').css('color','black');
      $('#modal-showAlert .modal-body').html("Please select a supplier.");
      $('#modal-showAlert .modal-footer .ok').show();
       $('#modal-showAlert .modal-footer .yes').hide();
      $('#modal-showAlert .modal-footer .no').hide();
    }
    else
    {
    var businessid = document.getElementById('hdnbusiness').value;
		location.href = 'downloaditem.cfm?businessid=' + businessid
    }

	}
  function getBusiness(businessId) {
    var businessid = businessId;
      location.href = 'item.cfm?businessid=' + businessId
    }
</script>