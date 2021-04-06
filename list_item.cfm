<cfinclude template="includes/secure.cfm" >
<cfparam  name="url.businessid" default="#session.secure.subaccount#">
<cfscript>
// load Account Suppliers
Suppliers = CreateObject("Component","v1.model.services.admin").getSupplierDetails(
	businessId = url.businessid,
	includeItems = 1,
	linked = 1);
listdetails = CreateObject("Component","v1.model.services.admin").getListDetails(
		businessId = url.businessid,
		includeItems = 1);
</cfscript>
<cfparam name="listLinked" default="none">
<style>
	ul{
		padding-top: 10px;
	}
	.page-content{
		padding-left: 20px;
	}
</style>
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
<cfinclude template="includes/header.cfm" >
<div class="page-content">
	<cfoutput >
	<div class="container table-responsive">
    <div class="table-wrapper">
      <div class="table-title">
        <div class="row">
          <div class="col-xs-6"><h2>Manage List Items</h2></div>
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
				arrayAppend(local.accounts, local.details);
			  }
			</cfscript>
			<div style="padding-bottom:20px;" >
			Business: &nbsp;
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
		<cfform name="LinkLists" action="list_ctrl.cfm">
		 <table class="list-wrapper table table-bordered table-responsive-md table-striped" cellspacing="0" cellpadding="0" >
          <thead>
            <tr>
            <th  style="text-align:center;">List Items</th>
            </tr>
          </thead>
          <tbody>		 
			<cfloop array="#Suppliers#" index="supplier" >
			    <tr>
		            <td style="font-size:24;">
					   #supplier.name#
					</td>
			    </tr>	
				<tr><td>	
					<cfif 	ArrayLen(supplier.items) gt 0>
					 <table class="list-wrapper table table-bordered table-responsive-md table-striped" cellspacing="0" cellpadding="0" >									 					 			 
					<cfloop array="#supplier.items#" index="item">		
					 <tr>
		               <td>#item.name# (#item.unitName#)</td>
							<cfloop array="#listdetails#" index="list">
								<cfset joinItemtoListId = 0>
								<cfloop array="#list.items#" index="listItem">
									<cfif listItem.itemId EQ item.id>
										<cfset joinItemtoListId = listItem.Id>
									</cfif>
								</cfloop>
								<td>
								<cfif joinItemtoListId>
									<span style="color:green">#list.name#</span>
									<a href="list_ctrl.cfm?action=removeList&JoinID=#joinItemtoListId#&ItemID=#item.id#&SupplierID=#supplier.id#">(Remove)</a>
								<cfelse>
									<span style="color:##c0c0c0">#list.name#</span>
									<a href="list_ctrl.cfm?action=addList&ListID=#List.id#&ItemID=#item.id#&SupplierID=#supplier.id#">(Add)</a>
								</cfif>
								</td>							
							</cfloop> 	
							</td>
			         </tr>					
					</cfloop>	
					</table>	
					</cfif>
					</td></tr>		
			</cfloop>			
			</tbody>
			</table>
		</cfform>
		</div>
      <div id="pagination-container"></div>
    </div>
  </div>
	</cfoutput>
</div>
<cfinclude template="includes/footer.cfm" >
<script>
	function changeBusiness(businessId) {
		location.href = 'list_item.cfm?businessid=' + businessId
	}
</script>