<cfinclude template="includes/secure.cfm" >
<cfinclude template="includes/header.cfm" >
<cfparam  name="url.businessid" default="#session.secure.subaccount#">
<cfset orders = CreateObject("Component","v1.model.services.order").getOpenOrders(
		checkedIn = 0,
		businessId = url.businessid).openOrders>
<style>
input, select{
  font-size: 12px !important;
  height: 30px;
    width: 300px;
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
    border-radius: 50px;
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
.delete {
  display: inline-block;
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
</style>
<cfoutput>
  <div class="container table-responsive">
    <div class="table-wrapper">
      <div class="table-title">
        <div class="row">
          <div class="col-xs-6"><h2>Open Orders</h2></div>
          <div class="col-xs-2">
            <!---<div class="search">
              <input type="text" placeholder="search" data-search ="" class="form-control"/>
            </div>--->
          </div>
          <div class="col-xs-3 text-right">
            <!---<button type="button" class="btn btn-info add-new"><i class="fa fa-plus"></i> Add New</button>--->
          </div>
          </div>
        </div>
		    <cfif session.secure.RoleCode eq 1>
          <cfscript>
            local.accounts = [];
            local.accountDetails = queryExecute("
              SELECT
              businessId as businessId,
              businessname as name
              FROM
              business
              WHERE
              Active = 1
            ",{},{datasource: application.dsn}
            );
            cfloop(query = "local.accountDetails") {
              local.details = {};
              local.details['id'] = local.accountDetails.businessId;
              local.details['name'] = local.accountDetails.name;
              arrayAppend(local.accounts, local.details);
            }
          </cfscript>
          <div style="padding-bottom:20px;" >
          Business:&nbsp;
          <select name="business" onchange="changeBusiness(this.value)" class="form-select form-select-lg mb-3" >
            <cfloop array="#local.accounts#" item="account">
              <option
              <cfif isdefined("url.businessid") and url.businessid eq account.id>
                selected
              </cfif>
              value="#account.id#">
              #account.name#
              </option>
            </cfloop>
          </select>
          </div>
			  </cfif>
        <table class="list-wrapper table table-bordered table-responsive-md table-striped" cellspacing="0" cellpadding="0">
          <thead>
            <tr>
            <th width="2%" style="text-align:center;">Order ID</th>
            <th  width="98%" style="text-align:center;">Order Details</th>
            </tr>
          </thead>
          <tbody>
            <cfif arraylen(orders)>
			<cfloop array="#Orders#" index="order">			   
				<cfoutput>
				<tr class="list-item items" data-filter-item data-filter-name="#order.id#">
					<cfif order.closed eq 1>					
							<td>#order.id#</td>
							<td><a href="order_detail.cfm?orderid=#order.id#&supplier=#order.supplierName#" class="text-success">
								#order.supplierName# - #dateTimeFormat(order.dateTime,"m/d/y h:nn:ss tt")# - #order.email#</a></td>						
					<cfelse>					
							<td>#order.id#</td>
							<td><a href="order_detail.cfm?orderid=#order.id#&supplier=#order.supplierName#" class="text-danger">
								#order.supplierName# - #dateTimeFormat(order.dateTime,"m/d/y h:nn:ss tt")# - #order.email#</a></td>						
					</cfif>
					 </tr>
				</cfoutput>			  
			</cfloop>
		<cfelse>
			<div class="orders" style="padding-bottom:20px;">
				No orders.
			</div>
		</cfif>
          </tbody>
        </table>
      </div>
      <div id="pagination-container"></div>
    </div>
  </div>
</cfoutput>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/simplePagination.js/1.6/jquery.simplePagination.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script>
  $(document).ready(function(){
   // $('[data-toggle="tooltip"]').tooltip();    
  });
  
  var items = $(".list-wrapper .list-item");
  var numItems = items.length;
  var perPage = 15;
  items.slice(perPage).hide();
  $('#pagination-container').pagination({
        items: numItems,
        itemsOnPage: perPage,
        prevText: "&laquo;",
        nextText: "&raquo;",
        onPageClick: function (pageNumber) {
            var showFrom = perPage * (pageNumber - 1);
            var showTo = showFrom + perPage;
            items.hide().slice(showFrom, showTo).show();
        }
    });
    $('[data-search]').on('keyup', function() {
    var searchVal = $(this).val();
    var filterItems = $('[data-filter-item]');

    if ( searchVal != '' ) {
      filterItems.addClass('hidden');
      console.log('[data-filter-item][data-filter-name*="' + searchVal.toLowerCase() + '"]');
      $('[data-filter-item][data-filter-name*="' + searchVal.toLowerCase() + '"]').removeClass('hidden');
    } else {
      filterItems.removeClass('hidden');
    }
  });
  </script>
  
<cfinclude template="includes/footer.cfm" >
<script>
	function changeBusiness(businessId) {
		location.href = 'orders_open.cfm?businessid=' + businessId
	}
</script>