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
  <cfif listfind(session.secure.businessType, 2)
    AND session.secure.RoleCode NEQ 1>
    <cfset supplierid = session.secure.SubAccount>
  <cfelse>
    <cfset supplierId = isnumeric(url.supplierid)
      ? url.supplierid
      : 0>
  </cfif>
  <cfset items = CreateObject("Component","v1.model.services.admin").getItems(supplierId = supplierId).items>
  <cfset units = CreateObject("Component","v1.model.services.admin").getUnitDetails()>
  <cfset suppliers = CreateObject("Component","v1.model.services.admin").getSupplierDetails(businessId = session.secure.subaccount)>
  <div class="container">
  <div class="row">
    <div class="table-wrapper">
      <div class="table-title">
         <div class="row">
            <div class="col-xs-1"><h4 class="fsize">Item Details</h4></div>
            <cfif session.secure.RoleCode EQ 1>
            <div class="col-xs-5">
                 <div id="dialog-form" title="Add Items">
                    <cfform id="addItem" action="add_item_action.cfm" method="post" enctype="multipart/form-data">
                        <cfif session.secure.RoleCode eq 1>
                          <cfset local.accounts = CreateObject("Component","v1.model.services.admin").getSupplierDetails()>
                          <div style="padding-bottom:20px;" >
                            Supplier:&nbsp;
                            <select name="business" id="business" onchange="chgBusiness(this.value)" class="form-select form-select-sm mb-3" >
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
                      <cfif ListFind(session.secure.access,'20')>
                        <cfinput type="file" name="uploadfile" required="yes" message="You must select a file." class="form-control f1" style="width:130px;display:inline-flex;">
                        <input type="submit" name="Submit2" value="Upload" class="btn btn-info " style="width:60px;display:inline-flex;">                        
                        <input type="hidden" name="hdnbusiness" id="hdnbusiness" value="#url.supplierid#">
                        <input type="button" id="Submit3" name="Submit3" class="btn btn-info" value="Download Item List" onclick="downloadlist();">                          
                        <a href="DownloadTemplate.cfm"  class="btn btn-info" style="width:100px;display:inline-flex;" >Download Template</a>
                      </cfif>
                    </cfform>
                 </div>
              </div>
            </cfif>
            <span style="display:none;" id="disphid">
          <div class="col-xs-1 text-right"><h6>List:</h6></div>
          <cfscript> 
            local.accounts = [];
            local.accountDetails = queryExecute("
            SELECT
              list.ListID,
              list.Name,
              business.BusinessName,
              business.BusinessId
            FROM
              list INNER JOIN business WHERE list.SubAccountID=business.BusinessId
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
          <div class="col-xs-1">
                      <select name="noofitems" id="noofitems1" class="form-select-sm form-control subval">
                       <cfloop array="#local.accounts#" item="account">
                                <option value="#account.id#">
                                  #account.name#(#account.businessname#)
                                </option>
                       </cfloop>
                      </select>
            </div> 
          <div class="col-xs-1">
              <input type="submit" class="btn btn-info sub1" value="Add To List" name="submit1">
          </div>
          </span>
            <div class="col-xs-1 text-right" >
              <input type="search" id="search" name="search" class="form-control" onkeyup="searchTable();" placeholder="Search" style="width:100px;"/> 
            </div>
            <cfif session.secure.RoleCode EQ 1 and ListFind(session.secure.access,'18')>
            <div class="col-xs-1 text-right t1"><button type="button" class="btn btn-info add-new"><i class="fa fa-plus"></i> <span class="hidden-xs">Add New</span></button></div>
            </cfif>
          </div>                
        </div>
          
        <form action="" method="post">
        <table class="list-wrapper itemtable table table-bordered table-responsive-sm table-striped" cellspacing="0" cellpadding="0" id="searchTab">
          <thead>
            <tr>
            <th width="5%">
                 <input type="checkbox" 
                 id="id" 
                 name="itemcheck" 
                 class="item_header">
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
            <cfloop array="#items#" item="item">
            <tr class="list-item items" data-filter-item data-filter-name="#lcase(item.name)# #lcase(item.supplierName)#">
              <td><input type="checkbox"
                  id="id_#item.id#"
                  name="itemselect"
                  value="#item.id#"
                  class="c1">
              </td>
              <td fid="name">#item.name#</td>
              <td fid="sku">#item.sku#</td>
              <td fid="photourl" title="#item.photoUrl#">#item.photoUrl#</td>
              <td fid="units" type="unit">#item.unitName#</td>
              <td fid="supplier" type="supplier">#item.supplierName#</td>
              <cfif session.secure.RoleCode EQ 1>
                <td>
                  <button class="cancel btn btn-danger" title="cancel">
                    <i class="fa fa-times" aria-hidden="true"></i>
                  </button>
                  <cfif ListFind(session.secure.access,'19')>
                    <button class="deleteitem btn btn-danger"  action = "delete" id="#item.id#" title="Delete">
                      <i class="fa fa-trash-alt" aria-hidden="true"></i>
                    </button>
                  </cfif>
                  <button class="add btn btn-success"  id="#item.id#" action = "add"  title="Add">
                    <i class="fa fa-plus" aria-hidden="true"></i>
                  </button>
                  <cfif ListFind(session.secure.access,'2')>
                    <button class="edit btn btn-warning" title="Edit">
                      <i class="fas fa-pencil-alt"></i>
                    </button>
                  </cfif>
                  <button class="add save btn btn-success" action = "update" id="#item.id#" title="save">
                    <i class="fa fa-save" aria-hidden="true"></i>
                  </button>
                </td>
              </cfif>
            </tr>
            </cfloop>
          </tbody>
        </table>
        </form>
      </div>
      <div class="col-xs-1 text-right"><h6>Items:</h6></div>
            <div class="col-xs-1 text-right">
                      <select name="noofitems" id="noofitems1" class="form-select-sm form-control c_value">
                       <!---<cfloop array="#items#" item="item">--->
                       <cfloop from=10 to="#arrayLen(items)#" index="i" step="10">
                              <option value="#i#">#i#</option>
                       </cfloop>
                      </select>
    </div>
      <div id="pagination-container">
  </div>
  </div>
  </div>
  </div>
</cfoutput>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!---<script src="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/jquery.simplePagination.js"></script>--->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script type="text/javascript" src="js/px-pagination.js"></script>
<link href = "js/px-pagination.css" rel = "stylesheet">
<script>
  $(document).ready(function(){
    <cfif isdefined("url.err") and url.err eq 1>
      $('#modal-showAlert .modal-header').addClass('alert-danger');
      $('#modal-showAlert').modal('show');
    </cfif>
   // $('[data-toggle="tooltip"]').tooltip();
   var itemactions = '<button action = "delete" class="removeRow btn btn-danger" id="0" title="Delete" ><i class="fa fa-trash-alt"></i></button>'+
                  '<button action = "add" class="add btn btn-success" id="0" title="Add" ><i class="fa fa-plus"></i></button>';
    var unithtml = "";
    var supplierhtml = "";
    <cfoutput>
      <cfloop array="#units#" index="unit">
        unithtml = unithtml + '<option value="#unit.id#">#unit.name#</option>';
      </cfloop>
      <cfloop array="#suppliers#" index="supplier">
        supplierhtml = supplierhtml + '<option value="#supplier.id#" <cfif supplier.id EQ #supplierid#> selected</cfif>>#supplier.name#</option>';
      </cfloop>
    </cfoutput>
    // Append table with add row form on add new button click
    $(".add-new").click(function(){
      $(this).attr("disabled", "disabled");
      var index = $(".itemtable tbody tr:last-child").index();
      var row = '<tr>' +
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
    $(document).on("click", ".add", function(){
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
        if($(this).attr('type') == 'unit') {
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
    });
    $(document).on("click", ".cancel", function(){
      $(this).parents("tr").find("td:not(:last-child)").each(function(){
        currentValue = $(this).find('input').val();
        if(currentValue == undefined) {
          currentValue = $(this).find('select').find('option:selected').text();
        }
        $(this).html(currentValue);
      });		
      $(this).parents("tr").find(".save, .edit, .deleteitem, .cancel").toggle();
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
        $.ajax({
          url: 'v1/model/services/admin.cfc?method=manageItem',
          type: 'post',
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
  var showFrom,showTo;
  console.log(perPage)
  items.slice(perPage).hide();
    $("#pagination-container").pxpaginate({
      currentpage: 1,
      totalPageCount: items.length/10,
      maxBtnCount: 5,
      align: 'center',
      nextPrevBtnShow: true,
      firstLastBtnShow: true,
      prevPageName: '<',
      nextPageName: '>',
      lastPageName: '<<',
      firstPageName: '>>',
      callback: function(pagenumber){
         showFrom = perPage * (pagenumber - 1);
         showTo = showFrom + perPage;
        items.hide().slice(showFrom, showTo).show();
      }
    });
    //list of items on click
    /*var items = $(".list-wrapper .list-item");
    var numItems = items.length;
    $(".c_value").click(function(){
        var perPage = $('.c_value').val();
        console.log(perPage)
        var showFrom,showTo;
        items.slice(perPage).hide();
       $("#pagination-container").pxpaginate({
      currentpage: 1,
      totalPageCount: items.length/perPage,
      maxBtnCount: 5,
      align: 'center',
      nextPrevBtnShow: true,
      firstLastBtnShow: true,
      prevPageName: '<',
      nextPageName: '>',
      lastPageName: '<<',
      firstPageName: '>>',
      callback: function(pagenumber){
         showFrom = perPage * (pagenumber - 1);
         showTo = showFrom + perPage;
        items.hide().slice(showFrom, showTo).show();
      }
    });
    });*/
     var arr=[];
     $(".item_header").click(function(){
    var id_val=$(this).attr("id");
     var value=$('.c1');
    //console.log(showTo)
    console.log(value.length)
    if($('#'+id_val).is(':checked')) {
    for (let i = 0; i < perPage; ++i) {
         value[i].checked = true;
          arr.push(value[i].value);
          $("#disphid").css("display", "block");
    }
    }else {
      for (let i = 0; i < perPage; i++) {
         value[i].checked = false;
         arr=[];
          $("#disphid").css("display", "none");
    }
    }
 });  
 $(".c1").click(function(){
   arr=[];
   var val1=$('.c1');
     if($('.c1').is(':checked')){
       for(let i=0;i<val1.length;i++){
       $("#disphid").css("display", "block");
       var v1=$(val1[i]).attr('id');
         if($('#'+v1).is(':checked')) {
            arr.push($(val1[i]).val());
            console.log($(val1[i]).val())
            console.log($('.subval').val())
          }
        }
      }
    else{
      $("#disphid").css("display", "none");
    }
 });
 $(".sub1").click(function(){
          console.log(arr)
          //var myval=[];
           var listitemval=$('.subval').val();
          /* myval.push(listitemval);
          var list=myval.slice(0,1);
          var busid=myval.slice(1,2);
          console.log(busid);*/

           $.ajax({
          url: 'v1/model/services/order.cfc?method=addItemtoList',
          type: 'get',
          data: {
            listId : listitemval,
            itemId : arr
          },
          success: function(data){
            //location.href="list_organize.cfm?url.page=listorganize";
            location.href = 'manageitem.cfm?page=items';
            console.log(data)
          }
        });
  });
    $('#search').on('keyup', function() {
    var searchVal = $(this).val();
    var filterItems = $('[data-filter-item]');
    console.log(filterItems);
    if ( searchVal != '' ) {
      filterItems.addClass('hidden');
      console.log('[data-filter-item][data-filter-name*="' + searchVal.toLowerCase() + '"]');
      $('[data-filter-item][data-filter-name*="' + searchVal.toLowerCase() + '"]').removeClass('hidden');
    } else {
      filterItems.removeClass('hidden');
    }
  });*/
  </script>
  <script>
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
</script>
<script>
function chgBusiness(businessid)
{ 
 document.getElementById('hdnbusiness').value = businessid;
 location.href = 'manageitem.cfm?supplierid=' + businessid;
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
</script>