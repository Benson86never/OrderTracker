<style>
  body {
      color: #404E67;
      background: #F5F7FA;
      font-family: 'Open Sans', sans-serif;
  }
  .table-wrapper {
      width: 97%;
  }
  .table-title {
      padding-bottom: 10px;
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
  }
  table.table th:last-child {
      width: 100px;
  }
  table.table td a {
      cursor: pointer;
      display: inline-block;
      margin: 0 5px;
      min-width: 24px;
  }
  table.table td a.edit {
      color: #FFC107;
  }
  table.table td a.delete {
      color: #E34724;
  }
  table.table td i {
      font-size: 19px;
  }
  table.table .form-control.error {
      border-color: #f50000;
  }
  table.table td .add, table.listtable td .addlist {
      display: none;
  }
  .save, .cancel {
    display: none;
  }
  .addlist {
      display: none;
      margin-left: 8px;
  }
  input[type="text"] {
    width: 90%;
  }
  table.table td {
    font-weight: normal;
  }
  .ui-menu .ui-menu-item{
    padding: 2px !important;
  }
  .ui-state-focus{
    background-color : #efefef !important;
  }
  .editlist {
    margin-left: 5px;
  }
  .switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<cfif listfind(variables.businessType,1)>
  <div class="panel panel-default">
    <div class="panel-heading">Supplier Details</div>
    <div class="panel-body">
      <div class="container-lg">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-8"></div>
                        <div class="col-sm-4">
                            <!---<button type="button" class="btn btn-info add-new"><i class="fa fa-plus"></i> Add New</button>--->
                        </div>
                    </div>
                </div>
                <table class="table table-bordered" cellspacing="0">
                    <thead>
                        <tr>
                            <th style="width:60%">Name</th>
                            <th style="width:40%">
                              <div class="col-md-8">Seller</div>
                              <div class="col-md-2 text-right">
                                <a class="saveseller btn btn-success" title="Save" >
                                  <i class="fa fa-save"></i>
                                </a>
                              </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                      <cfoutput>
                        <cfloop array="#rc.supplierDetails#" item="supplier">
                          <tr>
                              <td>
                                <label class="switch">
                                  <input type="checkbox" id="supplier_#supplier.id#" <cfif val(supplier.businessId)>checked</cfif>>
                                  <span class="slider round"></span>
                                </label>
                                #supplier.name#
                              </td>
                              <td>
                                <cfif arraylen(supplier.seller)>
                                  <cfloop array="#supplier.seller#" index="sellerindex" item="seller">
                                    <input type="text" class="form-control inputelement seller" target="sellerid_#supplier.id#_#sellerindex#" id="seller_#supplier.id#" value="#seller.name#"/>
                                    <input type="hidden" name="sellerid_#supplier.id#_#sellerindex#" id="sellerid_#supplier.id#_#sellerindex#" value="#seller.id#">
                                  </cfloop>
                                <cfelse>
                                  <input type="text" class="form-control inputelement seller" target="sellerid_#supplier.id#_1" 
                                      id="seller_#supplier.id#_1" />
                                  <input type="hidden" name="sellerid_#supplier.id#_1" id="sellerid_#supplier.id#_1" value="">
                                </cfif>
                              </td>
                          </tr>
                        </cfloop>
                      </cfoutput>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
  </div>
</cfif>
