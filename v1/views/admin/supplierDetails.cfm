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
      font-size: 12px;
      text-shadow: none;
      border-radius: 3px;
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
  .save, .cancel {
    display: none;
  }
  .savesupplier, .cancelsupplier {
    display: none;
  }
  .addlist, .addsupplier {
      display: none;
      margin-left: 8px;
  }
  input[type="text"] {
    width: 90% !important;
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
  .editlist, .editsupplier {
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
                        <div class="col-sm-3 text-right">
                            <button type="button" class="btn btn-info add-newsupplier"><i class="fa fa-plus"></i> Add New</button>
                        </div>
                    </div>
                </div>
                <table class="suppliertable table table-bordered">
                  <thead>
                      <tr>
                          <th>Supplier</th>
                          <th>Seller</th>
                          <th>Actions</th>
                      </tr>
                  </thead>
                  <tbody>
                    <cfoutput>
                      <cfset rc.newsupplierDetails = []>
                      <cfset rc.suppliernames = []>
                      <cfloop array="#rc.supplierDetails#" item="supplier">
                        <cfif val(supplier.businessId)>
                          <tr>
                              <cfset sellerid = 0>
                              <td element="supplier">#supplier.name#</td>
                              <td element="seller">
                                <cfloop array="#supplier.seller#" index="sellerindex" item="seller">
                                  #seller.name#
                                  <cfset sellerid = seller.id>
                                </cfloop>
                              </td>
                              <td>
                                  <button class="deletesupplier btn btn-danger" supplierid="#supplier.id#"
                                    sellerid ="#sellerid#" title="Delete" >
                                    <i class="fa fa-trash"></i>
                                  </button>
                                  <button class="addsupplier btn btn-success" supplierid="#supplier.id#" title="Add" >
                                    <i class="fa fa-plus"></i>
                                  </button>
                                  <button class="editsupplier btn btn-success" supplierid="#supplier.id#"
                                  sellerid ="#sellerid#" title="Edit" >
                                    <i class="fa fa-pencil"></i>
                                  </button>
                                  <button class="cancelsupplier btn btn-danger" supplierid="#supplier.id#" title="Cancel" >
                                    <i class="fa fa-times"></i>
                                  </button>
                                  <button class="savesupplier btn btn-success" supplierid="#supplier.id#" title="Save" >
                                    <i class="fa fa-save"></i>
                                  </button>
                              </td>
                          </tr>
                        <cfelse>
                          <cfset arrayappend(rc.newsupplierDetails, supplier)>
                          <cfset arrayappend(rc.suppliernames, supplier.name)>
                        </cfif>
                      </cfloop>
                    </cfoutput>
                    <input type="hidden" name="sellerid" id="sellerid" value="0">
                    <input type="hidden" name="supplierid" id="supplierid" value="0">
                  </tbody>
              </table>
            </div>
        </div>
    </div>
  </div>
</cfif>
